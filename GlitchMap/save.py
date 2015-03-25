#!/usr/bin/env python

import inspect, os, sys, json, cgi, re

#############################################################
#############        Save Functions        ##################
#############################################################

#to update the pointer to point to a new file:
#if match is included, then we are just moving the pointer name to directly above the matching pointer name
def updatePointer(type,name,path,match = ''):
  path = path.replace("../","")
  sources = file_locations[type]
  match_search = (match != '')
  cont = True
  for src in sources:
    if cont or match_search:
      #load the sources
      obj = openFile(src)
      save = False
      #loop until we reach the end or the pointer and matching pointer
      while(len(obj["original"]) > 0 and (cont or match_search)):
        line = getNextLine(obj)
        #if we found the pointer line:
        if cont and line.startswith(name + ":"):
          #remove this line and the line above
          obj["output"].pop()
          if len(obj["output"]) == 0:
            prev_line = ''
          else:
            prev_line = obj["output"].pop()
          #if INCBIN is not in the previous line (but its still a pointer), then we have to rearrange
          if ":" in prev_line and "INCBIN" not in prev_line:
            #if INCBIN is in the current line, then shift the file name up to the previous line
            if "INCBIN" in line:
              prev_path = line.split("INCBIN")[-1]
              prev_line = prev_line.strip("\n") + '\tINCBIN  ' + prev_path + '\n'
              obj["output"].append(prev_line)
              #get the new name
              new_name = line.split("INCBIN")[0]
              addLine(obj,new_name + '\tINCBIN  "' + path + '"')
            #if INCBIN is not in the current line, then continue until we reach a line with INCBIN
            else:
              while("INCBIN" not in line):
                line = getNextLine(obj)
              addLine(obj,name + ':\tINCBIN  "' + path + '"')
          else:
            obj["output"].append(prev_line)
            #if we aren't moving this to a matching pointer, then add this line with the appropriate incbin
            if match == '':
              addLine(obj,name + ':\tINCBIN  "' + path + '"')
          cont = False
          save = True
        #if we found the matching line:
        elif match_search and line.startswith(match + ":"):
          prev_line = obj["output"].pop()
          addLine(obj,name + ":")
          obj["output"].append(prev_line)
          match_search = False
          save = True
      #if we found a pointer or the match, then save
      if save:
          if(len(obj["original"]) > 0 ):
            copyRemaining(obj)
          saveFile(obj["output"],src)

def saveMapPokemon(input,obj):

  #if we have to delete old data, then do that here
  if input["data"]["delete_info"]["delete_check"]:
    poke_obj = openFile(input["data"]["delete_info"]["path"])
    
    line = getNextLine(poke_obj)

    #find the pointer we are looking for
    while(line != input["data"]["delete_info"]["pointer"] + ":"):
      line = getNextLine(poke_obj)
    
    #remove the old pointer
    poke_obj["output"].pop()
    #remove the pokemon data
    extractWildPokemonData(poke_obj)
    copyRemaining(poke_obj)
    saveFile(poke_obj["output"],input["data"]["delete_info"]["path"])

  line = getNextLine(obj)
  id = int(input["data"]["id"])
  
  #find the correct line
  while(id > 0):
    line = getNextLine(obj)
    id -= 1
    
  #remove this maps line from the output
  obj["output"].pop()
  
  #add the new name
  addLine(obj,"\tdw " + input["data"]["name"])
  
#to extract wild pokemon data
def extractWildPokemonData(obj): 
  content = obj["original"]
  
  #to initialize the wild data
  wild_data = {
    "grass_rate" : {},
    "grass_mons_GREEN" : [],
    "grass_mons_RED" : [],
    "grass_mons_YELLOW" : [],
    "grass_mons_BLUE" : [],
    "grass_mons_JAPAN" : [],
    "water_rate" : {},
    "water_mons_GREEN" : [],
    "water_mons_RED" : [],
    "water_mons_YELLOW" : [],
    "water_mons_BLUE" : [],
    "water_mons_JAPAN" : [],
		}
  
  #to parse an IF statement to see which versions these following data applies to
  def parseIF(statement,name):
    all = ["_YELLOW","_RED","_BLUE","_GREEN","_JAPAN"]
    versions = ["_YELLOW","_RED","_BLUE","_GREEN"]
        
    if statement == "ELSE":
      return all
      
    #to split at a ||
    statement = statement.split("||")
    
    #to see what versions these apply to
    for i in range(len(statement)):
      #check to see what versions exist in the statement
      for version in versions:
        #when we find a version match:
        if version in statement[i]:
          #this defines if we also include Japan (only matters for blue)
          japan = True
          #if "not japan" is in the statement, then remove it
          if "!DEF(_JAPAN)" in statement[i]:
            statement[i] = statement[i].replace("!DEF(_JAPAN)","")
            japan = False
          #see if Blue is actually referring to Japan Blue
          if "_JAPAN" in statement[i]:
            version = "_JAPAN"
        
          #if an exclamation point exists, then remove the version from the all list
          if "!" in statement[i]:
            all.pop(all.index(version))
            #if it was simply blue, then also remove japan blue
            if version == "_BLUE":
              all.pop(all.index("_JAPAN"))
            
            #also remove lists that already have 10 pokemon
            for version in all:
              if len(wild_data[name + version]) == 10:
                all.pop(all.index(version))
            
            #then return the all list
            return all
          #otherwise, replace the 
          else:
            #if the version was Blue and did not include !Japan, then also add Japan Blue
            if version == "_BLUE" and japan:
              statement.append("_JAPAN")
            statement[i] = version
    return statement
  
  #to check to see if we are done with each version in the given version list (for the given location name)
  def doneWithEachVersion(name,version_list):
    ret = True
    for version in version_list:
      #if the size of the list is not ten and the catch rate is not zero, then set to false
      if len(wild_data[name + "_mons" + version]) != 10:
        if version not in wild_data[name + "_rate"]:
          ret = False
        elif wild_data[name + "_rate"][version] != 0:
          ret = False
    return ret
  
  #to add wild pokemon (level and name) to the given versions for the given location name
  def addWildMons(name,version_list):
    poke_data = getNextLine(obj,False,False)
    #ignore empty lines
    while(removeAll(poke_data) == ''):
      poke_data = getNextLine(obj,False,False)
    poke_data = poke_data.replace("\t","").split(",")
    
    for version in version_list:
      wild_data[name + version].append([convertHex(poke_data[0]),poke_data[1]])
  
  #to get the catch rate for the given versions (if it doesn't have one get)
  def getRate(name,version_list):
    value = removeAll(content[0])
    added_rate = False
    #check each version
    for version in version_list:
      #check to see if this rate has already been added to the rate array
      if version not in wild_data[name + "_rate"]:
        #if so, then add the value to the rate
        wild_data[name + "_rate"][version] = convertHex(value)
        added_rate = True
    
    #if we have added the catch rate, then remove the first byte
    if added_rate:
      removed_line = content.pop(0)
      #if its empty, then keep going until we get non empty one
      if(removeAll(removed_line) == ''):
        removed_line = content.pop(0)
      return value
    else:
      return False
  
  #to parse the wild mons of the given versions in the given location name
  def parseWildMons(name,version_list):
    cont = True
    #while we haven't reached 10 pokemon in the array for the given versions:
    while(cont and len(content) > 0):
    
      first_line = removeAll(content[0])
      
      #if its empty, then keep going until we get non empty one
      while(first_line == '' and len(content) > 0):
        content.pop(0)
        if(len(content) > 0):
          first_line = removeAll(content[0])
      
      if(len(content) > 0):
        #if the first line is an IF, then parse it
        if "DEF(" in first_line.upper():
          new_versions = parseIF(removeAll(content.pop(0)),name + "_mons")
          parseWildMons(name,new_versions)
        #if there is an else, then continue parsing for all versions except the current versions (and set cont to false)
        elif "ELSE" in first_line.upper():
          new_versions = ["_YELLOW","_RED","_BLUE","_GREEN","_JAPAN"]
          #remove the current versions from the new_versions
          for version in version_list:
            new_versions.pop(new_versions.index(version))
            
          #remove the finished versions from the new_versions
          for version in new_versions:
            if len(wild_data[name + "_mons" + version]) == 10:
              new_versions.pop(new_versions.index(version))
          
          content.pop(0)
          parseWildMons(name,new_versions)
          cont = False
        #if there is an ENDC, then stop parsing
        elif "ENDC" in first_line.upper():
          content.pop(0)
          cont = False
        else:
          #if we are done, set cont to false
          if doneWithEachVersion(name,version_list):
            #if we are done with grass, then check water
            if name == "grass":
              parseWildMons("water",version_list)
            cont = False
          else:
            #get the rate if we haven't already
            rate = getRate(name,version_list)
            #if there was a rate:
            if rate:
              #if the rate was zero, set cont to false
              if convertHex(rate) == 0:
                #if we're in the grass list, then parse the water list
                if len(content) > 0 and "ENDC" in content[0].upper():
                  content.pop(0)
                  cont = False
                elif name == "grass":
                  parseWildMons("water",version_list)
            #if there wasn't a rate to get, then add the pokemon:
            else:
              addWildMons(name + "_mons",version_list)
  
  parseWildMons("grass",["_YELLOW","_RED","_BLUE","_GREEN","_JAPAN"])
  
def saveWildPokemon(input):
  obj = openFile(input["path"])
  
  line = getNextLine(obj)

  #find the pointer we are looking for
  while(line != input["pointer"] + ":"):
    line = getNextLine(obj)
  
  #if we need to save this as a new file
  if input["data"]["save_as_new"]:
    #add the title back to the original data
    obj["original"].insert(0,line + "\n")
    #remove the prev title and insert new title
    obj["output"].pop()
    addLine(obj,input["data"]["new_name"] + ":")
  else:
    #remove the old pokemon data
    extractWildPokemonData(obj)
  
  wild_pokes = input["data"]["pokemon"]
  
  #to create an if string from the given versions
  def createIfString(array):
    #create the if statement
    s = "\tIF "
    if "blue" in array:
      #japan and non-japan blue
      if "japan" in array:
        s += "DEF(_BLUE)"
      #non-japan blue only
      else:
        s += "(!DEF(_JAPAN) && DEF(_BLUE))"
    #japan blue only
    elif "japan" in array:
      s += "(DEF(_JAPAN) && DEF(_BLUE))"
    
    for version in array:
      if version != "blue" and version != "japan":
        #add the dividers if this isnt the first DEF statement
        if s != "\tIF ":
          s += " || "
        s += "DEF(_" + version.upper() + ")"
        
    return s
  
  #to add the output data to the
  def placeData(loc):
    data_arr = []
    version_arr = []
    
    #to get the data for each version:
    for version in wild_pokes:
      current_arr = []
      rate = wild_pokes[version][loc + "_rate"]
      current_arr.append(rate)
      
      if rate == 0:
        current_arr.append([])
      else:
        #add the wild pokemon data to the current_arr
        current_arr.append(wild_pokes[version][loc + "_pokemon"])
        
      unique = True
      #check to see if the current array matches any in the data_arr
      for i in range(len(data_arr)):
        if unique:
          #if the rates match, continue
          if data_arr[i][0] == current_arr[0]:
            #if the pokemon data lengths match, then continue checking
            if len(data_arr[i][1]) == len(current_arr[1]):
              #check each in the pokemon array to see if they match
              match = True
              for j in range(len(current_arr[1])):
                #check to see if the pokemon level and names match. If not, set match to false
                if data_arr[i][1][j][0] != current_arr[1][j][0] or data_arr[i][1][j][1] != current_arr[1][j][1]:
                  match = False
              if match:
                unique = False
                list_index = i
                
      if unique:
        data_arr.append(current_arr)
        version_arr.append([version])
      else:
        version_arr[list_index].append(version)
          
    #if they all have the same data, then no need to add if statement
    if len(data_arr) == 1:
      addLine(obj,"\tdb " + str(data_arr[0][0]))
      #if the rate wasn't zero, add the info
      if data_arr[0][0] != 0:
        for i in range(10):
          addLine(obj,"\tdb " + str(data_arr[0][1][i][0]) + "," + data_arr[0][1][i][1])
    else:
      zero_rate = False
      #otherwise, add an if statement for each rate
      for i in range(len(data_arr)):
        #if its zero, then save for last
        if data_arr[i][0] == 0:
          zero_rate = True
          zero_rate_index = i
        else:
          s = createIfString(version_arr[i])
          addLine(obj,s)
          addLine(obj,"\t\tdb " + str(data_arr[i][0]))
          for j in range(10):
            addLine(obj,"\t\tdb " + str(data_arr[i][1][j][0]) + "," + data_arr[i][1][j][1])
          addLine(obj,"\tENDC")
          
      if zero_rate:
        s = createIfString(version_arr[zero_rate_index])
        addLine(obj,s)
        addLine(obj,"\t\tdb 0")
        addLine(obj,"\tENDC")
          
      
  placeData("grass")
  placeData("water")      
  
  copyRemaining(obj)
  saveFile(obj["output"],input["path"])
          
def saveMapBlocks(input):
  saveBinary(input["data"],input["path"])
  #if we need to save this as a new file
  if input["save_as_new"]:
    name = input["data_names"][0].replace(" (Map Blocks)","")
    updatePointer("Map Blocks",name,input["path"])
  
def saveTilesetCollision(input):
  arr = input["data"]
  #add the 255
  arr.append(255)
  saveBinary(arr,input["path"])
  #if we need to save this as a new file
  if input["save_as_new"]:
    name = input["data_names"][0].replace(" (Collision)","")
    updatePointer("Collisions",name,input["path"])

def saveTilesetWarps(input,obj):
  name_arr = []
  #to extract the previous list from the data
  line = getNextLine(obj,False)
  #loop until we begin to read the data (to erase the table)
  while(line.replace(":","") not in name_arr): 
      name_arr.append(line)
      line = getNextLine(obj,False)
  #to remove the data
  while(len(name_arr) > 0):
    #if the line is a name array, then remove
    if line.replace(":","") in name_arr:
      list_index = name_arr.index(line.replace(":",""))
      name_arr.pop(list_index)
    else:
      line = getNextLine(obj,False)
  #then, for the last one, just remove to FF
  removeToX(obj,255)
  
  #to add the data:
  #the table
  for i in range(len(input["data"]["tilesets"])):
    addLine(obj,"\tdw " + input["data"]["tilesets"][i])
  #the tiles
  for arr in input["data"]["warps"]:
    #add the appropriate tileset names
    for name in arr[0]:
      addLine(obj,name + ":")
    #add the tiles
    s = '\tdb '
    for tile in arr[1]:
      s += str(tile) + ","
    s += "$FF"
    addLine(obj,s)

def saveTilesetDoors(input,obj):
  map_arr = []
  name_arr = []
  #to extract the previous list from the data
  line = getNextLine(obj,False)
  #loop until we begin to read the data (to erase the table)
  while(255 not in map_arr):
    line = convertHex(line)
    map_arr.append(line)
     #if we didnt reach the end, then get the data name
    if(line != 255):
      line = getNextLine(obj,False)
      if(line not in name_arr):
        name_arr.append(line)
    line = getNextLine(obj,False)
  #to remove the data
  while(len(name_arr) > 0):
    #if the line is a name array, then remove
    if line.replace(":","") in name_arr:
      list_index = name_arr.index(line.replace(":",""))
      name_arr.pop(list_index)
    else:
      line = getNextLine(obj,False)
  #then, for the last one, just remove to 00
  removeToX(obj,0)
  
  data_obj = { "output" : [] }
  
  #to add the data:
  #the tiles
  for arr in input["data"]:
    #add each map:
    for map in arr[0]:
      addLine(obj,"\tdb " + map)
      addLine(obj,"\tdw " + arr[1])
      
    #add the tiles to a different array (to be appended later)
    addLine(data_obj,arr[1] + ":")
    s = '\tdb '
    for tile in arr[2]:
      s += str(tile) + ","
    s += "$00"
    addLine(data_obj,s)
  
  addLine(obj,"\tdb $FF")
  
  #add the data_obj output to the end of the actual obj output
  obj["output"] += data_obj["output"]

def saveTilesetHeader(input,obj):
  #get the prefix of the tileset macro
  line = obj["original"][0].replace("\t","")
  prefix = line.split(" ")[0]

  tset = input["data"]
  index = tset["id"]
  #to go up to the line that we are looking for:
  while(index > 0):
    getNextLine(obj)
    index -= 1
  #remove the line corresponding to the current tileset
  getNextLine(obj,False)
  #convert the location to an index value (so we dont have to worry about whether they have the constants or not)
  locs = ["INDOOR","CAVE","OUTDOOR"]
  location = locs.index(tset["location"])
  
  s = "\t" + prefix + " " + tset["blocks"] + ",\t" + tset["gfx"] + ",\t" + tset["collision"] + ",\t" + str(tset["counter1"]) + "," + str(tset["counter2"]) + "," + str(tset["counter3"]) + ", " + str(tset["grass"]) + ", " + str(location)
  addLine(obj,s)

def saveTilesetGFX(input):
  path = input["data"]["image_path"].replace(".png",".2bpp")
  arr = input["data"]["shared_pointers"]
  ptr = input["data"]["pointer"]
  #if we are just updating this pointer to a new path:
  if len(arr) == 0:
    updatePointer("Tileset GFX",ptr,path)
  #otherwise, add in the other pointer are looking for
  else:
    updatePointer("Tileset GFX",ptr,path,arr[0])
    
def saveTilesetBlocks(input):
  arr = input["data"]
  
  new_arr = []
  #move all of the data into a single array
  while(len(arr) > 0):
    inner_arr = arr.pop(0)
    while(len(inner_arr)>0):
      new_arr.append(inner_arr.pop(0))
      
  saveBinary(new_arr,input["path"])
  #if we need to save this as a new file
  if input["save_as_new"]:
    name = input["data_names"][0].replace(" (Tileset Blocks)","")
    updatePointer("Tileset Blocks",name,input["path"])

def saveMapHeader(input,obj):
  #remove the lines up to the "connections"
  getNextLine(obj,False)
  getNextLine(obj,False)
  getNextLine(obj,False)
  connections = getNextLine(obj,False)
  #if there are connections
  if convertHex(connections) != 0:
    connections = connections.split("|")
    #remove the number of lines based upon the number of connections
    for each in connections:
      getNextLine(obj,False)
  #remove the object pointer
  getNextLine(obj,False)
  addLine(obj,"\tdb " + input["tileset"])
  addLine(obj,"\tdb " + input["height"] + ", " + input["width"])
  addLine(obj,"\tdw " + input["blocks"] + ", " + input["texts"] + ", " + input["scripts"]["name"])
  
  #if there are no connections:
  if not input["connections"]:
    addLine(obj,"\tdb 0")
  else:
    arr = ["NORTH","SOUTH","WEST","EAST"]
    dir_arr = []
    #see that directions exist in the connection
    for dir in arr:
      if dir in input["connections"]:
        dir_arr.append(dir)
    addLine(obj,"\tdb " + " | ".join(dir_arr))
    for dir in dir_arr:
      con = input["connections"][dir]
      s = "\t" + dir + "_MAP_CONNECTION " + con["map"] + ", "
      if dir == "NORTH":
        s += con["map_width"] + ", " + con["map_height"] + ", " + str(con["movement"]) + ", " + str(con["offset"]) + ", " + str(con["width"]) + ", " + con["blocks"]
      elif dir == "SOUTH":
        s += con["map_width"] + ", " + str(con["movement"]) + ", " + str(con["offset"]) + ", " + str(con["width"]) + ", " + con["blocks"] + ", " + input["width"] + ", " + input["height"]
      elif dir == "WEST":
        s += con["map_width"] + ", " + str(con["movement"]) + ", " + str(con["offset"]) + ", " + str(con["height"]) + ", " + con["blocks"] + ", " + input["width"]
      else:
        s += con["map_width"] + ", " + str(con["movement"]) + ", " + str(con["offset"]) + ", " + str(con["height"]) + ", " + con["blocks"] + ", " + input["width"]
      addLine(obj,s)
  addLine(obj,"\tdw " + input ["objects"]["name"])
  
def saveMapDimensions(input):
  obj = openFile(input["path"])
  data = input["data"]
  #go until we reach the end of the file
  while(len(obj["original"]) > 0):
    #get the next line
    line = getNextLine(obj)
    #check each element in the input array:
    for name in data:
      #if we reached the line that had the name, then save new
      if name + "EQU" in line:
        #remove that line from the output
        obj["output"].pop()
        addLine(obj,name + " EQU " + str(data[name]))
  saveFile(obj["output"],input["path"])

#to remove all files until we find FF
def removeToX(obj,num):
  line = getNextLine(obj,False).split(",")
  #keep removing lines until we reach the number
  while(num not in convertHex(line)):
    line = getNextLine(obj,False).split(",")

def saveTilesetLedges(input,obj):
  removeToX(obj,255)
    #modify code here
  for tset in input["data"]:
    for each in input["data"][tset]:
      s = '\tdb ' + tset + ", SPRITE_FACING_" + each[2] + ", " + str(each[0]) + ", " + str(each[1]) + ", D_" + each[2]
      addLine(obj,s)
  addLine(obj,"\tdb $FF")  

#to update the script for ledges to include multiple tilesets
def saveLedgesScript(input,obj):
  #go to the line we want
  for i in range(4):
    line = getNextLine(obj)
  line = getNextLine(obj,False)
  #if we haven't already added our code:
  if(line != "pushaf"):
    addLine(obj,"\tpush af")
    #remove the line we don't want
    line = getNextLine(obj,False)
    #find the loop pointer:
    while(not line.startswith(".")):
      line = getNextLine(obj)
    #temporarily remove the pointer
    ptr = obj["output"].pop()
    #add the lines
    addLine(obj,"\tpop af")
    addLine(obj,"\tld e, a")
    #restore the pointer
    obj["output"].append(ptr)
    #to go to the next set of lines we want
    while(line != "retz"):
      line = getNextLine(obj)
      
    #save the cp b line and the jr z for it
    line = getNextLine(obj)
    line = getNextLine(obj)
    line2 = obj["output"].pop()
    line1 = obj["output"].pop()
    
    #get the pointer from line2
    ptr = line2.split(".")[-1]
    
    addLine(obj,"\tcp e")
    addLine(obj,"\tld a, [hli]")
    addLine(obj,"\tjr nz,." + ptr)
    obj["output"].append(line1)
    obj["output"].append(line2)
  else:
    addLine(obj,"\tpush af")

    
def saveTilePairCommon(input,obj):
  removeToX(obj,255)
  for tset in input["data"]:
    for each in input["data"][tset]:
      s = '\tdb ' + tset + ',' + str(each[0]) + ',' + str(each[1])
      addLine(obj,s)
  addLine(obj,"\tdb $FF")  

def saveTilesetListCommon(input,obj):
  removeToX(obj,255)
  s = '\tdb '
  for name in input["data"]:
    s += name + ","
  s += "$FF"
  addLine(obj,s)
  
def saveBinary(arr,path):
  #add the ../ if it doesn't exist
  if not path.startswith("../"):
    path = "../" + path
  #write the file to the given path
  filename = os.path.join(os.path.dirname(__file__), path)
  with open(filename, "wb") as f:
    f.write(bytes(arr))

#to save text in an array to the file in the give path
def saveFile(arr,path):
  #add the ../ if it doesn't exist
  if not path.startswith("../"):
    path = "../" + path
  #write the file to the given path
  filename = os.path.join(os.path.dirname(__file__), path)
  with open(filename, 'w+', encoding="utf8") as f:
    while(len(arr) > 0):
      f.write(arr.pop(0))

#to update the JSON file
def saveJSON(input):
  def createOutputString(s):
    if type(s) is str and not (s.startswith('-') and s[1:].isdigit()):
      s = s.replace("\n","\\n")
      return '"' + s + '"'
    elif type(s) is bool:
      return str(s).lower()
    else:
      return str(s)
      
  def nestedObjs(obj,indent):
    s = "\t" * indent
    for each in obj:
      if type(obj[each]) is dict:
        f.write(s + each + " : {\n")
        nestedObjs(obj[each],indent + 1)
        f.write(s + "},\n")
      else:
        f.write(s + each + " : " + createOutputString(obj[each]) + ",\n")
        
  with open(input["path"],"w+") as f:
    f.write("data = {\n")
    nestedObjs(input["data"],1)
    f.write("};")
      
#############################################################
#############   Which Save Functions to Run   ###############
#############################################################
save_functions = {
  "json" : {
    "save" : saveJSON,
  },
  "map_dimensions" : {
    "save" : saveMapDimensions,
    "file" : "Map Dimensions"
  },
  "map_blocks" : {
    "save" : saveMapBlocks,
   },
  "tileset_blocks" : {
    "save" : saveTilesetBlocks,
  },
  "tileset_gfx" : {
    "save" : saveTilesetGFX,
  },
  "tileset_collision" : {
    "save" : saveTilesetCollision,
  },
  "tileset_list_water" : {
    "save" : saveTilesetListCommon,
    "file" : "Water Tilesets",
  },
  "tileset_list_bike_riding" : {
    "save" : saveTilesetListCommon,
    "file" : "Bike Riding Tilesets",
  },
  "tileset_list_dungeon" : {
    "save" : saveTilesetListCommon,
    "file" : "Dungeon Tilesets",
  },
  "tileset_list_escape_rope" : {
    "save" : saveTilesetListCommon,
    "file" : "Escape Rope Tilesets",
  },
  "tileset_bookshelves" : {
    "save" : saveTilePairCommon,
    "file" : "Bookshelf Tiles",
  },
  "tileset_water_pairs" : {
    "save" : saveTilePairCommon,
    "file" : "Water Tile Pair Collisions",
  },
  "tileset_land_pairs" : {
    "save" : saveTilePairCommon,
    "file" : "Land Tile Pair Collisions",
  },
  "tileset_ledges" : {
    "save" : saveTilesetLedges,
    "file" : "Ledge Tiles",
    "include" : ["ledges_script"]
  },
  "ledges_script" : {
    "save" : saveLedgesScript,
    "file" : "Ledges Script",
  },
  "map_header" : {
    "save" : saveMapHeader,
    "suffix" : " (Map Header)",
  },
  "tileset_warp_tiles" : {
    "save" : saveTilesetWarps,
    "file" : "Warp Tiles",
  },
  "tileset_door_tiles" : {
    "save" : saveTilesetDoors,
    "file" : "Door Tiles",
  },
  "tileset_header" : {
    "save" : saveTilesetHeader,
    "file" : "Tileset Headers",
  },
  "map_pokemon" : {
    "save" : saveMapPokemon,
    "file" : "Wild Pokemon Names",
  },
  "wild_pokemon" : {
    "save" : saveWildPokemon,
  },
}
'''
  "map_objects" : {
    "save" : saveMapObjects,
  },
  "hide_show_data" : {
    "save" : saveMapHideShow,
    "file" : "Hide Or Show Data",
  },
  "trainer_parties" : {
    "save" : saveTrainerParties,
    "file" : "Trainer Party Data",
  },
  "trainer_headers" : {
    "save" : saveTrainerHeaders,
  },
  "coordinates" : {
    "save" : saveCoordinates,
  },
  "map_text_pointers" : {
    "save" : saveMapTextPointers,
  },
  "text_data" : {
    "save" : saveTextData,
  },
  "super_rod_data" : {
    "save" : saveSuperRodData,
    "file" : "Super Rod Data",
  },
  "hidden_objects" : {
    "save" : saveHiddenObjects,
    "file" : "Hidden Object Data",
  },
  "map_sprite_sets" : {
    "save" : saveMapSpriteSets,
    "file" : "Sprite Sets",
  },
  "fly_warps" : {
    "save" : saveFlyWarps,
    "file" : "Fly Warp Data",
  },
  "special_warps" : {
    "save" : saveSpecialWarps,
    "file" : "Special Warps",
  },
  "dungeon_warps" : {
    "save" : saveDungeonWarps,
    "file" : "Dungeon Warp Data",
  },
}
'''

#these are the files where the path will be submitted along with the data (so don't read from files.txt)
multiple_files = ["Map Header Data","Map Object Data","Wild Pokemon Data","Map Text Pointers","Map Scripts","Collisions","Map Blocks","Tileset Blocks","Tileset GFX","Sprite GFX","Text Data","Wild Pokemon Data"]

#these are the files where we run the "save" function separately (as opposed to whenveer we reach the pointer)
single_files = ["map_dimensions","map_blocks","tileset_blocks","tileset_collision","tileset_gfx","wild_pokemon","json"]

#these inputs can have multiple inputs, so a different function is needed to extract the pointers and file names
multiple_inputs = ["map_header"]

#this object holds the file locations for certain datatypes (whatever is not in the ignore array). data is extracted from files.txt
file_locations = {}

#this object holds the pointer names for certain datatypes (whatever is not in the ignore array). data is extracted from files.txt
file_pointers = {}

#############################################################
#############        Reading a File        ##################
#############################################################
def openFile(path):
  #remove the ../ if it exists
  if path.startswith("../"):
    path = path[3:]
  with open(path, encoding="utf-8") as f:
    original = f.readlines()

  obj = {
    "original" : original,
    "output" : []
  }
  
  return obj

#to get the next line
def getNextLine(obj,save = True,remove = True):
  line = obj["original"].pop(0)
  
  #if its empty, then repeat
  while(line == ''):
    obj["output"].append(line)
    line = obj["original"].pop(0)
  
  #if we are saving this line, then add it to the output array
  if save:
    obj["output"].append(line)
  
  #if we remove spaces and size, then remove
  if remove:
    line = removeAll(line)
  
  #return the line without any comments or line breaks
  return line.split(";")[0].replace("\n","")

#to add a line to the output of the given obj
def addLine(obj,line):
  obj["output"].append(line + "\n")
  
#to copy the remaining data to the output:
def copyRemaining(obj):
  while(len(obj["original"]) > 0):
    obj["output"].append(obj["original"].pop(0))
    
#to remove tabs and spaces
def removeSpaces(str):
  return re.sub(r"\t? ?\r?\n?","",str)
  
#to remove db, dw, dwb
def removeSize(str):
  return re.sub(r"db |dw |dbw ","",str)

  #to remove the space and size for every line in the given content (or line)
def removeAll(content,path = ''):
  if type(content) is str:
    return removeSpaces(removeSize(content))
  else:
    arr = []
    for line in content:
      arr.append(removeSpaces(removeSize(line)))
    return arr
    
#to convert a str to decimal if its hex
def convertHex(s):
  if s == "$":
    s = 0
  elif isinstance(s,list):
    for i in range(len(s)):
      s[i] = convertHex(s[i])
    return s
  elif s.startswith("$"):
    s = int(s.replace("$",""),16)
  elif s.isdigit():
    s = int(s)
  return s
#############################################################
#############         Main Function        ##################
#############################################################
def main():
  input = json.load(sys.stdin)
  
  response = {}
  
  dir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
  
  #to load the file locations for most data structures (all but the ones in the ignore array)
    #to extract the file sources
  with open(dir + "/files.txt") as f:
    lines = f.readlines()
  for line in lines:
    line = line.replace("\n","").split(",")
    file = line.pop(0)
    #ignore lines that are in the multiple_files array
    if file not in multiple_files:
      #save the src file location
      src = line.pop(0)
      file_locations[file] = src
      #save the ptr name
      ptr = line.pop()
      file_pointers[file] = ptr
    else:
      #remove empty strings
      for i in range(len(line)):
        if line[i] == '':
          line.pop(i)
      file_locations[file] = line
  print('Content-Type: application/json\n\n')
  
  types = []
  paths = []
  pointers = []
  inputs = []
  
  #to combine files that belong in the same path together
  for type in input:
    #if the input is in the "multiple_inputs" array, then get the path from each of the inputs
    if type in multiple_inputs:
      #add each input to the input arrays
      for each in input[type]["data"]:
        each = input[type]["data"][each]
        
        name = each["name"] + save_functions[type]["suffix"]
        response[name] = each["path"].strip("../")
        if each["path"] not in paths:
          paths.append(each["path"])
          types.append([type])
          inputs.append([each])
          pointers.append([each["name"] + ":"])
        else:
          list_index = paths.index(each["path"])
          types[list_index].append(type)
          inputs[list_index].append(each)
          pointers[list_index].append(each["name"] + ":")
    #otherwise, if a path was not delivered with the data, then load it from the files.txt
    elif "path" not in input[type]:
      input[type]["path"] = file_locations[save_functions[type]["file"]]
        
    
    #if the type is in the "single_files" array,, run this save function associated with this type
    if type in single_files:
      #save the data using the correct function
      save_functions[type]["save"](input[type])
      name = input[type]["data_names"][0]
      response[name] = input[type]["path"].strip("../")
    #if this type is not in the multiple_inputs array or single_files array, then create new arrays that combine the types that share the same file
    elif type not in multiple_inputs:
      def addToArrays(type,pointer,path,data):
        #if this path already exists in the paths array, then add the type to the associated types array
        if path in paths:
          list_index = paths.index(path)
          types[list_index].append(type)
          inputs[list_index].append(data)
          pointers[list_index].append(pointer)
        else:
          paths.append(path)
          types.append([type])
          inputs.append([data])
          pointers.append([pointer])
      
      #if a pointer was not delivered, then load it from the files.txt
      if "pointer" not in input[type]:
        input[type]["pointer"] = file_pointers[save_functions[type]["file"]]
      
      name = input[type]["data_names"][0]
      response[name] = input[type]["path"].strip("../")
      
      #add the info for this type to the arrays
      addToArrays(type,input[type]["pointer"],input[type]["path"],input[type])
      
      #if this type has additional functions to run, then add each to the arrays
      if "include" in save_functions[type]:
        for each in save_functions[type]["include"]:
          addToArrays(each,file_pointers[save_functions[each]["file"]],file_locations[save_functions[each]["file"]],input[type])
    
  #for each file that we will be saving to
  for i in range(len(paths)):
    path = paths[i]
    obj = openFile(path)
    #continue until we reach the end of file or every type
    while(len(obj["original"]) > 0 and len (types[i]) > 0):
      line = getNextLine(obj)
      #search the types array until we find the pointer name we need
      for j in range(len(types[i])):
        type = types[i][j]
        pointer = pointers[i][j]
        #if this line matches the pointer we are looking for:
        if(line == pointer):
          #save the data using the correct function
          save_functions[type]["save"](inputs[i][j],obj)
        
    #copy the remaining data to the output and save the output
    copyRemaining(obj)
    saveFile(obj["output"],path)
  #Finish Saving
  print(json.dumps(response))
  
main()