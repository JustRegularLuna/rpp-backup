#!/usr/bin/python
import webbrowser, subprocess, glob, re, os, sys, time, struct
from http.server import HTTPServer, CGIHTTPRequestHandler
from threading import Thread

#####################
###   Data Sets   ###
#####################
class Map:  
  def __init__(self, name, id):
    self.name = name
    self.id = id

class Tileset:
  def __init__(self, name, id):
    self.name = name
    self.id = id

class MapHeader:
  def __init__(self, name):
    self.name = name

class WildPokemon:
  def __init__(self, name):
    self.name = name

############################
###   Global variables   ###
############################

tab_count = 0
const_count = 0
data_file = ''

params = {
  'directory' : os.getcwd().split("\\")[-1].strip("\\")
}

reference = {
  "tilesets" : [],
  "pokemon" : [],
  "sprites" : [],
  "items" : [],
  "maps" : [],
  "dungeon_warps" : [],
  "wild_pokemon" : {},
}

lists = {
  "items" : [],
  "pokemon" : [],
  "tilesets" : [],
  "maps" : [],
  "trainers" : [],
  "sprites" : [],
  "map_dimensions" : [],
  "tileset_gfx" : [],
}
 
datasets = {
  "maps" : [],
  "tilesets" : [],
  "ledges" : [],
  "trainers" : {},
  "map_headers" : {},
  "tile_pair_collision" : {},
  "map_objects" : {},
  "wild_pokemon" : {},
  "super_rod_data" : {},
  "tileset_lists" : {},
  "bookshelf_tiles" : {},
  "sprite_sets" : {},
  "dungeon_warps" : {},
  "map_scripts" : {},
  "map_texts" : {},
  "text" : {},
}

tables = {
  "map_headers" : [],
  "wild_pokemon" : [],
  "trainers" : [],
  "sprite_sets" : [],
  "hidden_object_maps" : [],
}

pointers = {
  "tileset_collision" : [],
  "tileset_blocks" : [],
  "tileset_gfx" : [],
  "map_blocks" : [],
  "tileset_warp_tiles" : [],
  "tileset_door_tiles" : [],
  "sprites" : [],
  "trainers" : [],
  "hidden_objects" : [],
  "super_rod_data" : [],
  "special_warps" : [],
  "map_text_list" : [],
}

########################
###   Writing Data   ###
########################
#To add a data line to the file and then increase or decrease the tab count
def dataLine(str):
  global tab_count
  
  if "}" in str or str == "],":
    if "{" not in str:
      tab_count -= 1
  
  tabs = ""
  
  for i in range(tab_count):
    tabs += "\t"
  data_file.write(tabs + str + "\n")
  
  if "{" in str or str.endswith("["):
    if "}" not in str:
      tab_count += 1

#to write nested objects:
def nestedObjs(parent):
  for key in parent:
    if isinstance(parent[key],dict):
      dataLine(key + " :  {")
      nestedObjs(parent[key])
      dataLine("},")
    else:
      dataLine(key + " : " + createOutputString(parent[key]) + ",")
    
#to write the data to the data.js file
def writeData():
  
  #Begin the Data
  dataLine("var data = {")
  
  #to add some Params
  dataLine("params : {")
  for key in params:
    dataLine(key + " : " + createOutputString(params[key]) + ",")
  #To end the Params
  dataLine("},")
  
  #Beginning of Maps Data
  dataLine("maps : {")
  
  for map in datasets["maps"]:
    dataLine(map.name + " : {")
    header = datasets["map_headers"][map.header]
    for key1 in map.__dict__.keys():
      if key1 is "header":
        #Beginning of Header Data
        dataLine("header : {")
        
        for key in header.__dict__.keys():
            if isinstance(header.__dict__[key],dict):
              dataLine(key + " :  {")
              nestedObjs(header.__dict__[key])
              dataLine("},")
            elif key is "scripts":
              #Beginning of Scripts Data
              dataLine("scripts : {")
              scripts = datasets["map_scripts"][header.scripts]
              dataLine("name : " + createOutputString(header.scripts) + ",")
              dataLine("path : " + createOutputString(scripts["path"]) + ",")
              #Beginning of Coords Data
              dataLine("coords : {")
              for key in scripts["coords"]:
                cont = True
                height = findNameInList("map_dimensions",header.height)
                width = findNameInList("map_dimensions",header.width)
                #check each coord in the array to make sure its within the bounds of the map
                for i in range(len(scripts["coords"][key])):
                  #check to make sure each coord is an actual coord for this map (x < width, y < height)
                  y = scripts["coords"][key][i][0]
                  x = scripts["coords"][key][i][1]
                  #if the coord is outside the size of the map, then set continue to False (its not a true coord list)
                  if y > height and x > width:
                    cont = False
                if(cont):
                  dataLine(key + " : " + createOutputString(scripts["coords"][key]) + ",")
              #End of Coords Data
              dataLine("},")
              
              #Beginning of Trainer Header Data
              dataLine("trainer_headers : [")
              for arr in scripts["trainer_headers"]:
                dataLine(createOutputString(arr) + ",")
              #End of Trainer Header Data
              dataLine("],")
              
              #End of Scripts Data
              dataLine("},")
            elif key is "objects":
              #Beginning of Objects Data
              dataLine("objects : {")
                
              objects = datasets["map_objects"][header.objects]
              #to output the objects:
              for key in objects:
                #the sprites needs to be printed separately because it contains an Object
                if key is "sprites":
                  dataLine(key + " : [")
                  #print each sprite line
                  for sprite in objects["sprites"]:
                    string = ''
                    for i in range(5):
                      string += createOutputString(sprite[i]) + ","
                    dataLine("[" + string + "{")
                    for key in sprite[5]:
                      dataLine(key + " : " + createOutputString(sprite[5][key]) + ",")
                    dataLine("}],")
                  dataLine("],")
                else:
                  dataLine(key + " : " + createOutputString(objects[key]) + ",")
                
              #End of Objects Data
              dataLine("},")
            else:
              dataLine(key + " : " + createOutputString(header.__dict__[key]) + ",")
        
        #End of Header Data
        dataLine("},")
      elif key1 is not "name":
        dataLine(key1 + " : " + createOutputString(map.__dict__[key1]) + ",")
    
    #End of Map Data
    dataLine("},")    
    
  #End of Maps Data
  dataLine("},")
  
  #Beginning of Tileset Data
  dataLine("tilesets : {")
  
  for tset in datasets["tilesets"]:
    dataLine(tset.name + " : {")
    for key in tset.__dict__.keys():
      #ignore the name
      if key is not "name":
        dataLine(key + " : " + createOutputString(tset.__dict__[key]) + ",")
    #print the bookshelf tile pairs
    if(tset.name in datasets["bookshelf_tiles"]):
      dataLine("bookshelf_tiles : " + createOutputString(datasets["bookshelf_tiles"][tset.name]) + ",")
    else:
      dataLine("bookshelf_tiles : [],")
    #print if it exists in each tileset list
    for tset_list in datasets["tileset_lists"]:
      if(tset.name in datasets["tileset_lists"][tset_list]):
        dataLine(tset_list + " : true,")
      else:
        dataLine(tset_list + " : false,")
    #print what the tile pair collisions are:
    for loc in datasets["tile_pair_collision"]:
      if(tset.name in datasets["tile_pair_collision"][loc]):
        dataLine("tile_pair_collision_" + loc + " : " + createOutputString(datasets["tile_pair_collision"][loc][tset.name]) + ",")
      else:
        dataLine("tile_pair_collision_" + loc + " : [],")
    #print the ledges, if they exist
    if(tset.name in datasets["ledges"]):
      dataLine("ledges : " + createOutputString(datasets["ledges"][tset.name]) + ",")
    else:
      dataLine("ledges : [],")
    dataLine("},")
  
  #End of Tileset Data
  dataLine("},")
  
  
  
  #Beginning of Texts Data
  dataLine("texts : {")
  texts = datasets["text"]
  nestedObjs(texts)
  #End of Texts Data
  dataLine("},")
  
  
  #Beginning of Trainer Data
  dataLine("trainers : {")
  
  trainers = datasets["trainers"]
  #parse the trainers
  for name in trainers:    
    dataLine(name + " : [")
    for i in range(len(trainers[name])):
      dataLine(createOutputString(trainers[name][i]) + ",")
    dataLine("],")
  
  #End of Trainer Data
  dataLine("},")
  
  #Beginning of Wild Pokemon Data
  dataLine("wild_pokemon : {")
  
  for wild_pk in datasets["wild_pokemon"]:
    obj = {
      "yellow" : {},
      "blue" : {},
      "red" : {},
      "green" : {},
      "japan" : {},
    }
    for version in obj:
      water_rate = getattr(datasets["wild_pokemon"][wild_pk],"water_rate")
      obj[version]["water_rate"] = water_rate["_" + version.upper()]
      grass_rate = getattr(datasets["wild_pokemon"][wild_pk],"grass_rate")
      obj[version]["grass_rate"] = grass_rate["_" + version.upper()]
      obj[version]["water_pokemon"] = getattr(datasets["wild_pokemon"][wild_pk],"water_mons_" + version.upper())
      obj[version]["grass_pokemon"] = getattr(datasets["wild_pokemon"][wild_pk],"grass_mons_" + version.upper())
    
    dataLine(wild_pk + " : {")
    nestedObjs(obj)
    dataLine("},")
   
  #End of Wild Pokemon Data
  dataLine("},")
  
  #beginning of super rod data
  dataLine("super_rod_data : {")
  nestedObjs(datasets["super_rod_data"])  
  #End of Super Rod Data
  dataLine("},")
  
  
  #Beginning of Lists Data
  dataLine("lists : {")
    
  #Parse the lists
  for id in lists:    
    dataLine(id + " : [")
    for each in lists[id]:
      dataLine(createOutputString(each) + ",")
    dataLine("],")
  
  #End of Lists Data
  dataLine("},")
  '''
  #This isn't necessary, the tables can be recreated by parsing the "Lists"
  
  #Beginning of Tables Data
  dataLine("tables : {")
    
  #Parse the Tables
  for id in tables:    
    dataLine(id + " : [")
    for each in tables[id]:
      dataLine("'" + each + "',")
    dataLine("],")  
  
  #End of Tables Data
  dataLine("},")
  
  '''
  
  #Beginning of Pointers Data
  dataLine("pointers : {")
    
  #Parse the Pointers
  for id in pointers:    
    dataLine(id + " : [")
    for el in pointers[id]:
        dataLine(createOutputString(el) + ",")
    dataLine("],")
  
  #Add Wild Pokemon as pointers
  dataLine("wild_pokemon : [")
  for wild_pk in datasets["wild_pokemon"]:
    dataLine("[" + createOutputString(reference["wild_pokemon"][wild_pk]) + ",")
    dataLine(createOutputString(wild_pk) + ",")
    dataLine(createOutputString(datasets["wild_pokemon"][wild_pk].path) + "],")
  #End of Wild Pokemon data
  dataLine("],")
  
  #Add spritesets as pointers
  dataLine("sprite_sets : [")
  for ss in datasets["sprite_sets"]:
    arr = [datasets["sprite_sets"][ss][0],ss,datasets["sprite_sets"][ss][1]]
    dataLine(createOutputString(arr) + ",")
  #End of spritesets data
  dataLine("],")
  
  #End of Pointers Data
  dataLine("},")
  
  #End of Data
  dataLine("};")  
  
###############################################
###  Functions to run when files get parsed ###
###############################################
#to go through the content until you reach a match
def findPointer(content,comp):
  while(len(content) > 0 and comp not in content[0]):
    content.pop(0)
  return content
  
#to go through the given list to find the given index, then return what name that index refers to
def findIndexInList(list,index):
  for arr in lists[list]:
    if arr[1] == index:
      return arr[0]
  return False

#to go throug the given list until you find the name, then return the index
def findNameInList(list,name):
  for arr in lists[list]:
    if arr[0] == name:
      return arr[1]
  return False
  
#the common functions for parsing constants
def extractConstantsCommon(line):
  global const_count
  ret = {
    "success" : False,
    "name" : "",
    "id" : "",
  }
  if re.compile("[ \t]EQU[ \t]",re.IGNORECASE).search(line):
    #to split at the EQU
    line = re.compile("[ \t]EQU[ \t]",re.IGNORECASE).split(line)
    #to remove the tabs and spaces for the name and id
    ret["name"] = removeSpaces(line[0])
    ret["id"] = convertHex(removeSpaces(line[1]))
    ret["success"] = True
  elif re.compile("const[ \t]",re.IGNORECASE).search(line) and removeSpaces(line).startswith("const"):
    #to remove the const
    line = re.compile("const[ \t]",re.IGNORECASE).split(line)[-1]
    const_count += 1
    ret["name"] = removeSpaces(line)
    ret["id"] = const_count
    ret["success"] = True
  return ret

def extractConstants(content,name):
  global lists
  global const_count
  const_count = 0
  while(len(content) > 0):
    line = getNextLine(content,False)
    ret = extractConstantsCommon(line)
    if ret["success"]:
      lists[name].append([ret["name"],ret["id"]])

def extractMaps(content):
  extractConstants(content,"maps")
  global lists
  global datasets
  for map in lists["maps"]:
    datasets["maps"].append(Map(map[0],map[1]))
    reference["maps"].append(map[0])

def extractTilesets(content):
  extractConstants(content,"tilesets")
  global lists
  global datasets
  for tset in lists["tilesets"]:
    reference["tilesets"].append(tset[0])
    datasets["tilesets"].append(Tileset(tset[0],tset[1]))

def extractItems(content):
  extractConstants(content,"items")
  for i in range(len(lists["items"])):
    reference["items"].append(lists["items"][i][0])
      
def extractPokemon(content):
  extractConstants(content,"pokemon")
  for i in range(len(lists["pokemon"])):
    reference["pokemon"].append(lists["pokemon"][i][0])
  
def extractTrainers(content):
  extractConstants(content,"trainers")
  
def extractSprites(content):
  extractConstants(content,"sprites")
  for i in range(len(lists["sprites"])):
    reference["sprites"].append(lists["sprites"][i][0])
  
def extractMapDimensions(content):
  extractConstants(content,"map_dimensions")

#To return an array of name/index (while modifying the given content)
def createPointerListArray(content,name,size = 0):
  arr = []
  if(size == 0):
    size = len(content) - 1
  i = 0
  while(len(content) > 0 and i <= size):
    line = content.pop(0)
    #ignore lines that don't contain db, dw, dwb and ones that contain $FFFF and i is less than or equal to size
    if ("dwb " in line or "db " in line or "dw " in line) and ("$FFFF" not in line):
      line = removeSpaces(removeSize(line))
      tables[name].append(line)
      i += 1

def extractForceBikeSurf(content):
  line = getNextLine(content).split(",")
  arr = {}
  while(convertHex(line[0]) is not 255):
    map = line[0]
    if map not in reference["maps"]:
      index = convertHex(line[0])
      map = findIndexInList("maps",index)
      if not map:
        map = index
    values = [convertHex(line[1]),convertHex(line[2])]
    #if there is a fourth byte, then it means we already edited it (to include BIKE or SURF)
    if len(line) == 4:
      values.append(convertHex(line[3]))
    if map not in arr:
      arr[map] = [values]
    else:
      arr[map].append(values)
    line = getNextLine(content).split(",")
    
  for map in datasets["maps"]:
    if map.name in arr:
      map.force_bike_surf = arr[map.name]
    else:
      map.force_bike_surf = []

def extractMapHeaderNames(content):
  #get the size of the list
  size = lists["maps"][-1][1]
  createPointerListArray(content,"map_headers",size)
  for map in datasets["maps"]:
    index = map.id
    header = tables["map_headers"][index]
    #to create the new map header
    datasets["map_headers"][header] = MapHeader(header)
    map.header = header

def extractSpecialWarps(content):
  prev_content = []
  
  #read the line XX up
  def getPrev(index,prev_content):
    index = len(prev_content) - index - 1
    if(index < 0):
      index = 0
    return prev_content[index]
    
  
  line = getNextLine(content)
  prev_content.append(line)
  
  obj = {}
  
  #search through the entire file
  while(len(content) > 1): 
    #go until we reach a FLYWARP (or we reach the end of the file)
    while("FLYWARP_DATA" not in line and len(content) > 1): 
      line = getNextLine(content)
      prev_content.append(line)
    
    map = getPrev(1,prev_content)
    cont = False
    #if the previous content is a map (or the index of a map) then set the continue value to true
    if map in reference["maps"]:
      cont = True
    else:
      index = convertHex(map)
      map = findIndexInList("maps",index)
      if map:
        cont = True
    
    data = line.split(",")
    
    #if the line above is a map, continue:
    if cont:
      line = getNextLine(content)
      prev_content.append(line)
      tset = getTilesetName(line)
      #if the next line is not a tset
      if not tset:
        cont = False
    
    #if the line below was a tileset, continue
    if cont:
      title = getPrev(3,prev_content)
      #if the line before the map is a title, then we save
      if title.endswith(":"):
        obj[title.replace(":","")] = [map,convertHex(data[1]),convertHex(data[2])]
      
    #if there is more content, then read
    if(len(content) > 1):
      line = getNextLine(content)
      prev_content.append(line)

  for map in obj:
    pointers["special_warps"].append([[map],obj[map]])
  
def extractFlyWarpData(content):
  maps = []
  pointers = []
  line = getNextLine(content)
  #keep going until we reach the pointers
  while(line.replace(":","") not in pointers):
    map = line.split(",")[0]
    #if the map is an index, convert to map name
    if map not in reference["maps"]:
      index = convertHex(map)
      map =  findIndexInList("maps",index)
      #if a map wasn't found, just save the index
      if not map:
        map = index
    pointer = getNextLine(content)
    maps.append(map)
    pointers.append(pointer)
    line = getNextLine(content)
  
  obj = {}
  
  #now parse the data
  while(line.replace(":","") in pointers):
    index = pointers.index(line.replace(":",""))
    map = maps[index]
    data = getNextLine(content).split(",")
    obj[map] = [convertHex(data[1]),convertHex(data[2])]
    line = getNextLine(content)
    
  #now save to the maps
  for map in datasets["maps"]:
    if map.name in obj:
      map.fly_warp = obj[map.name]
    else:
      map.fly_warp = []
    
def extractDungeonWarpList(content):
  line = getNextLine(content).split(",")
  while(convertHex(line[0]) != 255):
    map = line[0]
    
    #convert map from index to name (if its the index)
    if map not in reference["maps"]:
      index = convertHex(map)
      map = findIndexInList("maps",index)
      if not map:
        map = index
    
    reference["dungeon_warps"].append([map,convertHex(line[1])])
    line = getNextLine(content).split(",")
  
def extractDungeonWarpData(content):
  obj = {}
  for i in range(len(reference["dungeon_warps"])):
    line = getNextLine(content).split(",")
    data = reference["dungeon_warps"][i]
    map = data[0]
    warp_id = data[1]
    arr = [warp_id,convertHex(line[1]),convertHex(line[2])]
    if map not in obj:
      obj[map] = [arr]
    else:
      obj[map].append(arr)
      
  for map in datasets["maps"]:
    if map.name in obj:
      map.dungeon_warps = obj[map.name]
    else:
      map.dungeon_warps = []
    
def extractHiddenObjectMaps(content):
  arr = []
  cont = True
  while(cont):
    line = getNextLine(content)
    #if the line is not a map, then convert to index and get map name
    if line not in reference["maps"]:
      index = convertHex(line)
      #if we've reached the end, stop
      if index == 255:
        cont = False
      else:
        convert = findIndexInList("maps",index)
        #if the index was not in the list, then just save the index
        if not convert:
          arr.append(index)
        #otherwise, save the name
        else:
          arr.append(convert)
    else:
      arr.append(line)
  
  tables["hidden_object_maps"] = arr

def extractSuperRodData(content):
  line = getNextLine(content).split(",")
  maps = []
  ptrs = []
  pointer_names = []
  #loop through the table
  while(convertHex(line[0]) is not 255):
    map = line[0]
    #see if the map is a map id, if not, then convert it to one
    if map not in reference["maps"]:
      index = convertHex(map)
      map = findIndexInList("maps",index)
      
      #if there is no map, just use the index
      if not map:
        map = index
      
    #if the index is a map, then add the pointer to the map
    if map:
      maps.append(map)
      ptrs.append(line[1])
    if line[1] not in pointer_names:
      pointer_names.append(line[1])
      
    line = getNextLine(content).split(",")

  new_arr = []
  new_obj = {}
  for i in range(len(pointer_names)):
    title = getNextLine(content).replace(":","")
    size = convertHex(getNextLine(content))
    poke_list = []
    for j in range(size):
      line = getNextLine(content).split(",")
      level = convertHex(line[0])
      pokemon = convertHex(line[1])
      poke_list.append([level,pokemon])
    map_list = []
    while(title in ptrs):
      index = ptrs.index(title)
      ptrs.pop(index)
      map_list.append(maps.pop(index))
    new_arr.append([map_list,title])
    new_obj[title] = poke_list
  
  pointers["super_rod_data"] = new_arr
  datasets["super_rod_data"] = new_obj
  
def extractHiddenObjectPointers(content):
  arr = []
  #get the pointers
  for i in range(len(tables["hidden_object_maps"])):
    arr.append(getNextLine(content))
  map_list = {}
  for map in datasets["maps"]:
    #if the map has hidden objects, then add
    if map.name in tables["hidden_object_maps"]:
      index = tables["hidden_object_maps"].index(map.name)
      name = arr[index]
      if name not in map_list:
        map_list[name] = [map.name]
      else:
        map_list[name].append(map.name)
  
  #to extract each
  for i in range(len(arr)):
    objects = []
    title = getNextLine(content).replace(":","")
    
    line = getNextLine(content).split(",")
    
    while(convertHex(line[0]) is not 255):
      for each in line:
        objects.append(convertHex(each))
      line = getNextLine(content).split(",")
      
    final_objects = []
        
    #to extract the necessary data from this array and place into separate arrays
    while(len(objects) > 0):
      new_arr = []
      new_arr.append(objects.pop(0))
      new_arr.append(objects.pop(0))
      new_arr.append(objects.pop(0))
      objects.pop(0)
      new_arr.append(objects.pop(0))
      final_objects.append(new_arr)
    if title in map_list:
      pointers["hidden_objects"].append([map_list[title],title,final_objects])
  
def extractMapSpriteSets(content):
  size = 36
  createPointerListArray(content,"sprite_sets",size)
  
  for i in range(len(tables["sprite_sets"])):
    value = convertHex(tables["sprite_sets"][i])
    tables["sprite_sets"][i] = str(value)
    if value not in datasets["sprite_sets"]:
      datasets["sprite_sets"][value] = [[]]

  for map in datasets["maps"]:
    index = map.id
    if index <= size:
      sprite_set = convertHex(tables["sprite_sets"][index])
      datasets["sprite_sets"][sprite_set][0].append(map.name)
  
def extractSplitMapSpriteSets(content):
  size = 0
  
  for value in datasets["sprite_sets"]:
    if value >= 241 and value > size:
      size = value
  
  for i in range(size-240):
    arr = getNextLine(content).split(',')
    for j in range(len(arr)):
      arr[j] = convertHex(arr[j])
    if (i+241) in datasets["sprite_sets"]:
      datasets["sprite_sets"][241 + i].append(arr)
  
def extractSpriteSets(content):
  size = 0
  
  for value in datasets["sprite_sets"]:
    if value < 241 and value > size:
      size = value
  
  for i in range(size):
    arr = []
    for j in range(11):
      arr.append(getNextLine(content))
    if (i+1) in datasets["sprite_sets"]:
      datasets["sprite_sets"][i + 1].append(arr)
    
def extractSpriteData(content):
  arr = []
  size = lists["sprites"][-1][1]
  for i in range(size):
    arr.append(getNextLine(content))
    content.pop(0)
    content.pop(0)
  
  pointer_arr = []
  used_pointers = []
  #to add the sprite picture ID to the pointer
  for i in range(len(lists["sprites"])):
    index = lists["sprites"][i][1] - 1
    pointer = arr[index]
    name = lists["sprites"][i][0]
    if pointer not in used_pointers:
      used_pointers.append(pointer)
      pointer_arr.append([[name],pointer])
    else:
      list_index = used_pointers.index(pointer)
      pointer_arr[list_index][0].append(name)
  pointers["sprites"] = pointer_arr
  
def extractWildPokemonNames(content):
  #get the size of the list
  size = lists["maps"][-1][1]
  createPointerListArray(content,"wild_pokemon",size)
  
  obj = {}
  for i in range(len(tables["wild_pokemon"])):
    name = tables["wild_pokemon"][i]
    map = findIndexInList("maps",i)
    map_names = []
    #if the map name exists
    if map:
      if name not in obj:
        obj[name] = [map]
        datasets["wild_pokemon"][name] = WildPokemon(name)
      else:
        obj[name].append(map)
      
  reference["wild_pokemon"] = obj
    
def extractTilesetHeaders(content):
  tset_index = 0
  size = lists["tilesets"][-1][1]
  while(tset_index <= size):
    line = content.pop(0)
     #to only keep the lines that contains "tileset " or "TSETHEAD "
    if "tileset " in line or "TSETHEAD " in line:
      line = removeSpaces(line.replace("tileset ","").replace("TSETHEAD ",""))
      line = line.split(",")
      index = lists["tilesets"][tset_index][1]
      tset = datasets["tilesets"][index]
      
      
      tset.blocks = line[0]
      tset.gfx = line[1]
      tset.collision = line[2]
      tset.counter1 = convertHex(line[3])
      tset.counter2 = convertHex(line[4])
      tset.counter3 = convertHex(line[5])
      tset.grass = convertHex(line[6])
      tset.location = line[7]
      
      tset_index += 1
    
#to extract info from a pointers file
def extractPointersCommon(content):
  def addName():
    name = removeSpaces(line.split("INCBIN")[0].replace(":",""))
    #if the name is not an empty string, then add it
    if name:
      names.append(name)
  
  arr = []
  while (len(content) > 0):
    line = getNextLine(content)
    #get the name of the pointer (without any ":")
    names = []
    addName()
    #if line doesnt have include or incbin, then keep checking until it does
    while "INCBIN" not in line:
      line = getNextLine(content)
      addName()
      
    path = "../" + line.split("INCBIN")[1].replace('"','')
    arr.append([names,removeSpaces(path)])
  return arr

#to extract collisions from the pointer file
def extractCollisions(content,path):
  collisions = extractPointersCommon(content)
  for arr in collisions:
    data = loadBinary(arr[1])
    #remove the 255
    data.pop()
    arr.append(data)
    pointers["tileset_collision"].append(arr)
    
#to extract map blocks from the given content
def extractMapBlocks(content,path):
  blocks = extractPointersCommon(content)
  for arr in blocks:
    data = loadBinary(arr[1])
    arr.append(data)
    pointers["map_blocks"].append(arr)

#to extract the tileset blocks
def extractTilesetBlocks(content,path):
  blocks = extractPointersCommon(content)
  for arr in blocks:
    data = loadBinary(arr[1])
    i = 0
    blockset = []
    while (len(data) - i > 15):
      block = []
      for j in range(16):
        block.append(data[i])
        i += 1
      blockset.append(block)
    arr.append(blockset)
    pointers["tileset_blocks"].append(arr)
  
#to extract the tileset gfx
def extractTilesetGFX(content,path):
  gfx_list = extractPointersCommon(content)
  #tileset directories
  dirs = []
  for arr in gfx_list:
    arr[1] = arr[1].replace(".2bpp",".png")
    arr.append(path)
    pointers["tileset_gfx"].append(arr)
    dir = arr[1].split("/")
    #remove the name of the image
    dir.pop()
    dir = "/".join(dir)
    if dir not in dirs:
      dirs.append(dir)
    
  #to go through every tileset directory to find the .pngs
  for dir in dirs:
    arr = glob.glob(dir + "/*.png")
    #check each PNG to see if the dimensions match a potential tileset
    for fname in arr:
      fname = fname.replace("\\","/")
      with open(fname, 'rb') as f:
        data = f.read()
      w, h = struct.unpack('>LL', data[16:24])
      width = int(w)
      height = int(h)
      #only load the images where the width and height are multiples of 8
      if width%8 == 0 and height%8 == 0:
        lists["tileset_gfx"].append([fname.split("/")[-1],fname])
  
#to extract the sprites
def extractSpriteGFX(content,path):
  gfx_list = extractPointersCommon(content)
  obj = {}
  for arr in gfx_list:
    obj[arr[0][0]] = arr[1].replace(".2bpp",".png")
  for each in pointers["sprites"]:
    each.append(obj[each[1]])
    
def extractHideShowData(content):
  #to ignore the table and jump directly to the start of data:
  line = convertHex(getNextLine(content))
  while(line != 255 and line != 65535):
    line = convertHex(getNextLine(content))
    
  #remove the end of the line
  content.pop(0)
  
  #to get the next and ignore labels
  def next():
    line = getNextLine(content)
    while(":" in line):
      line = getNextLine(content)
    return line.split(",")
  
  line = getNextLine(content)
  
  #ignore any constants if they exist
  while(re.compile("[ \t]EQU[ \t]",re.IGNORECASE).search(line)):
    line = getNextLine(content)
  
  line = next()
  #if the first line has FF, then we have not modified it yet (so skip to the next)
  if(convertHex(line[0]) == 255):
    line = next()
    
  obj = {}
  i = 0
  #loop through the list
  while(convertHex(line[0]) != 255):
    map = line[0]
    #if the map is not a known map name, then convert to id
    if map not in reference["maps"]:
      index = convertHex(map)
      map = findIndexInList("maps",index)
    
    which = line[2]
    #if its not hide/show, then its a number, so convert
    if line[2].lower() != "hide" and line[2].lower() != "show":
      which = convertHex(which)
      if which == 11:
        which = "Hide"
      elif which == 15:
        which = "Show"
    
    #only run if the map id is a known map
    if map:
      sprite_data = [i,convertHex(line[1]),which]
      if map not in obj:
        obj[map] = [sprite_data]
      else:
        obj[map].append(sprite_data)
      
    line = next()
    i += 1
  #to append the data to the correct map
  for map in datasets["maps"]:
    if map.name in obj:
      map.hide_show_data = obj[map.name]
    else:
      map.hide_show_data = []

#to remove the lines inside an IFDEF(
def removeIfDef(content):
  arr = []
  cont = True
  for line in content:
    if "IFDEF(" not in line.upper():
      #if cont is set to false
      if not cont:
        #if we reach the ELSE or ENDC, then continue adding
        if line.upper() == "ELSE" or line.upper() == "ENDC":
          cont = True
      #if the cont variable is true, then add the line (as long as it isnt else or endc)
      elif line.upper() != "ELSE" and line.upper() != "ENDC":
        arr.append(line)
    #if there is an IFDEF(, then sent cont to false
    else:
      cont = False
  return arr

#to get the next line in the content (without spaces, size, and ignoring any If Def)
def getNextLine(content,remove = True):
  def newLine():
    if(len(content) == 0):
      ret_line = ''
    else:
      ret_line = content.pop(0)
    line = removeAll(ret_line)
    #remove if the remove input is true
    if remove:
      ret_line = line
    return {
      "ret_line" : ret_line,
      "line" : line
    }
  
  #get the new line
  lines = newLine()
  
  #if there is an IFDEF or IF_in this line, then we have to adjust
  if "IFDEF(" in lines["line"].upper() or "IF_" in lines["line"].upper():
    #skip until we reach an else or endc
    while(lines["line"].upper() != "ELSE" and lines["line"].upper() != "ENDC"):
      lines = newLine()
    
    #save what the line was
    prev_line = lines["line"]
    
    #save the next line
    lines = newLine()
    
    i = 0
    if(prev_line.upper() == "ELSE"):
      #remove the ENDC line
      while(removeAll(content[i]).upper() != "ENDC"):
        i += 1
      content.pop(i)
  return lines["ret_line"]

#to extract wild pokemon data
def extractWildPokemonData(content,path):
  title = getNextLine(content).replace(":","")
  obj = datasets["wild_pokemon"][title]
  obj.path = path
  
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
    poke_data = getNextLine(content).split(",")
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
      content.pop(0)
      return value
    else:
      return False
  
  #to parse the wild mons of the given versions in the given location name
  def parseWildMons(name,version_list):
    cont = True
    #while we haven't reached 10 pokemon in the array for the given versions:
    while(cont and len(content) > 0):
      #if the first line is an IF, then parse it
      if "DEF(" in content[0].upper():
        new_versions = parseIF(content.pop(0),name + "_mons")
        parseWildMons(name,new_versions)
      #if there is an else, then continue parsing for all versions except the current versions (and set cont to false)
      elif "ELSE" in content[0].upper():
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
      elif "ENDC" in content[0].upper():
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
  
  #save the data to the wild pokemon object
  for each in wild_data:
    setattr(obj,each,wild_data[each])
  
#to extract the map object data
def extractMapObjectData(content,path):
  title = getNextLine(content).replace(":","")
  #if the title for these objects has been initialized in the map header function:
  if title in datasets["map_objects"]:            
    object_data = {
      "border" : convertHex(getNextLine(content)),
      "name" : title,
      "path" : path,
      "signs" : [],
      "warps" : [],
      "sprites" : [],
      "warp_tos" : []
    }
    
    #to extract an array of arrays and save it to the given name in the object data
    #X is the # of lines
    def extract(x,name):
      for i in range(convertHex(x)):
        arr = []
        line = getNextLine(content).split(",")
        for j in range(len(line)):
          arr.append(line.pop(0))
        object_data[name].append(arr)
    
    #to convert the first X (num) array elements to ints in the given array
    def convertValuesToInt(name,num):
      arr = object_data[name]
      for i in range(len(arr)):
        for j in range(num):
          arr[i][j] = convertHex(arr[i][j])
    
    num_warps = getNextLine(content)
    extract(num_warps,"warps")
    convertValuesToInt("warps",3)
    
    num_signs = getNextLine(content)
    extract(num_signs,"signs")
    convertValuesToInt("signs",3)
    
    num_sprites = getNextLine(content)
    extract(num_sprites,"sprites")
    
    arr = object_data["sprites"]
    for i in range(len(arr)):
    
      #if the input is not a sprite, then convert the id to a sprite name
      if arr[i][0] not in reference["sprites"]:
        index = convertHex(arr[i][0])
        arr[i][0] = findIndexInList("sprites",index)
    
      arr[i][1] = convertHex(arr[i][1].split("+")[0])
      arr[i][2] = convertHex(arr[i][2].split("+")[0])
      arr[i][3] = convertHex(arr[i][3])
      arr[i][4] = convertHex(arr[i][4])
      
      type = "NPC"
      if "|" in arr[i][5]:
        split = removeSpaces(arr[i][5]).split("|")
        type = split[0]
        text = convertHex(split[1])
      else:
        text = convertHex(arr[i][5])
        #if the text >= $80, then its an item
        if text >= 128:
          type = "ITEM"
          text -= 128
        #if the text >= $40, then its a trainer (or pokemon)
        elif text >= 64:
          type = "TRAINER"
          text -= 64
        
      obj = {
        "text" : text
      }
      
      #if it is not an NPC:
      if type != "NPC":
        which = arr[i][6]
        #if its a trainer:
        if "+" in which:
          which = removeSpaces(which).split("+")[0]
          obj["index"] = convertHex(arr[i][7])
          arr[i].pop(6)
        #otherwise, it is actually a pokemon
        elif type == "TRAINER":
          type = "POKEMON"
          obj["level"] = convertHex(arr[i][7])
          arr[i].pop(6)
          
        arr[i].pop(5)
        obj["which"] = which
      
      obj["type"] = type
      
      arr[i][5] = obj
      
    extract(num_warps,"warp_tos")
    
    #to remove the "width" variable from each warp_to
    for i in range(len(object_data["warp_tos"])):
      object_data["warp_tos"][i].pop(0)
    
    convertValuesToInt("warp_tos",2)
  
    datasets["map_objects"][title] = object_data
    
#to remove the space and size for every line in the given content (or line)
def removeAll(content,path = ''):
  if type(content) is str:
    return removeSpaces(removeSize(content))
  else:
    arr = []
    for line in content:
      arr.append(removeSpaces(removeSize(line)))
    return arr

#to extract the text pointers
def extractTextPointers(content,path):
  title = getNextLine(content).replace(":","")
  arr = []
  if title in datasets["map_texts"]:
    line = getNextLine(content)
    #go until we reach the end of the file or a new pointer/label
    while(len(content)>0 and not line.endswith(":") and not line.startswith(".")):
      #ignore ones that are simply "@"
      if line != '"@"':
        arr.append(line)
      line = getNextLine(content)
    datasets["map_texts"][title] = arr
    
  pointers["map_text_list"].append([[title],path,arr])

#to extract the map scripts
def extractMapScripts(content,path):
  title = getNextLine(content).replace(":","")
  
  #only run if this title is in the map scripts dataset
  if title in datasets["map_scripts"]:
    #save the path
    datasets["map_scripts"][title]["path"] = path
    #initialize the coords and trainer pointers
    datasets["map_scripts"][title]["coords"] = {}
    datasets["map_scripts"][title]["trainer_headers"] = []
    cont = True
    line = getNextLine(content)
    #loop
    while(cont and len(content) > 0):
      #if the next line is another script, then exit
      if(removeSpaces(content[0]).replace(":","") in datasets["map_scripts"]):
        cont = False
      #if its a pointer that includes "coords" in the title,then parse coords
      elif "coords" in line.lower() and ":" in line:
        coords_title = line.replace(":","").replace(".","")
        arr = []
        line = getNextLine(content)
        #stop when we reach 255 or a new pointer
        while(255 not in arr and ":" not in line):
          coords_data = line.split(",")
          for coord in coords_data:
            arr.append(convertHex(coord))
          line = getNextLine(content)
          
        new_arr = []
        true_coords = True
        #create new array from this array
        while(len(arr) > 1 and true_coords):
          coord1 = arr.pop(0)
          coord2 = arr.pop(0)
          #if any of the coords is not an int, then this isnt a true coords list, so exit
          if(not isinstance(coord1,int) or not isinstance(coord2,int)):
            true_coords = False
          else:
            new_arr.append([coord1,coord2])
        
        #if these are true coords, then save
        if true_coords:
          datasets["map_scripts"][title]["coords"][coords_title] = new_arr
      #if its a trainer header, then parse
      elif "TrainerHeader" in line and ":" in line:
        #go until we reach the end of the list
        while(convertHex(line) is not 255):
          #find the start of the data
          while(":" in line):
            line = getNextLine(content)
          
          arr = []
          #add data to array until we reach the next info or "ff"
          while(":" not in line and convertHex(line) is not 255):
            trainer_data = line.split(",")
            for each in trainer_data:
              arr.append(each)
            line = getNextLine(content)
          
          arr[0] = convertHex(arr[0])
          arr[1] = convertHex(arr[1].split("<<")[0].replace("(",""))
          
          datasets["map_scripts"][title]["trainer_headers"].append(arr)
          
        line = getNextLine(content)
      else:
        line = getNextLine(content)
      
#to extract the map header data
def extractMapHeaderData(content,path):
  title = getNextLine(content).replace(":","")
  
  #see if the title is in the map headers list:
  if title in datasets["map_headers"]:
    
    header = datasets["map_headers"][title]
    header.tileset = getTilesetName(getNextLine(content))
       
    line = getNextLine(content).split(",")
    header.height = removeSpaces(line[0])
    header.width = removeSpaces(line[1])
        
    line = getNextLine(content).split(",")
    header.blocks = removeSpaces(line[0])
    
    texts = removeSpaces(line[1])
    header.texts = texts
    #add this to the map_texts dataset
    datasets["map_texts"][texts] = []
    
    scripts = removeSpaces(line[2])
    header.scripts = scripts
    #add this to the map_scripts dataset
    datasets["map_scripts"][scripts] = {}
    
    #to get the size as either a string or int
    def getSize(s):
      #if the size does not include a map dimension (ignoring any calculations), then parse it as an int
      if s.split("-")[0] not in lists["map_dimensions"]:
        s = convertHex(s)
      return s
      
    line = convertHex(getNextLine(content))
    connections = {}
    if type(line) is str:
      dirs = line.split("|")
      for dir in dirs:
        dir = removeSpaces(dir)
        line = getNextLine(content).split(",")
        line[0] = line[0].replace(dir + "_MAP_CONNECTION","")
        if "NORTH" in dir:
          connections["NORTH"] = {}
          connections["NORTH"]["map"] = line[0]
          connections["NORTH"]["map_width"] = line[1]
          connections["NORTH"]["map_height"] = line[2]
          connections["NORTH"]["movement"] = convertHex(line[3])
          connections["NORTH"]["offset"] = convertHex(line[4])
          connections["NORTH"]["width"] = getSize(line[5])
          connections["NORTH"]["blocks"] = line[6]
        elif "SOUTH" in dir:
          connections["SOUTH"] = {}
          connections["SOUTH"]["map"] = line[0]
          connections["SOUTH"]["map_width"] = line[1]
          connections["SOUTH"]["movement"] = convertHex(line[2])
          connections["SOUTH"]["offset"] = convertHex(line[3])
          connections["SOUTH"]["width"] = getSize(line[4])
          connections["SOUTH"]["blocks"] = line[5]
        elif "EAST" in dir:
          connections["EAST"] = {}
          connections["EAST"]["map"] = line[0]
          connections["EAST"]["map_width"] = line[1]
          connections["EAST"]["movement"] = convertHex(line[2])
          connections["EAST"]["offset"] = convertHex(line[3])
          connections["EAST"]["height"] = getSize(line[4])
          connections["EAST"]["blocks"] = line[5]
        elif "WEST" in dir:
          connections["WEST"] = {}
          connections["WEST"]["map"] = line[0]
          connections["WEST"]["map_width"] = line[1]
          connections["WEST"]["movement"] = convertHex(line[2])
          connections["WEST"]["offset"] = convertHex(line[3])
          connections["WEST"]["height"] = getSize(line[4])
          connections["WEST"]["blocks"] = line[5]
    
    header.connections = connections
      
    header.objects = getNextLine(content)
    
    header.path = path
    
    #initialize the objects data
    datasets["map_objects"][header.objects] = {}

#to extract the trainer party info
def extractTrainerPartyData(content):
  
  trainer_data = {}
  trainer_list = []
  
  line = getNextLine(content)
  
  #to extract the trainer list:
  while(line.replace(":","") not in trainer_list):
    line = line.split(",")
    for trainer in line:
      trainer_list.append(trainer)
      trainer_data[trainer] = []
    line = getNextLine(content)
    
  #to extract each trainer info:
  while(line.replace(":","") in trainer_data):
    cont = True
    trainer_name = line.replace(":","")
    #loop through each line while cont is True (and there are lines in the content
    while(cont and len(content) > 0):
      line = getNextLine(content)
      #if the next line is a trainer, then exit
      if(line.replace(":","") in trainer_data):
        cont = False
      else:
        #split the party data
        party = line.split(",")
        #if it doesn't end in 0, then its not a party data (so exit)
        if(convertHex(party.pop()) != 0):
          cont = False
        #otherwise, add the party
        else:
          for i in range(len(party)):
            #if this is not a wild pokemon, then its a number, so convert hex
            if party[i] not in reference["pokemon"]:
              party[i] = convertHex(party[i])
          trainer_data[trainer_name].append(party)
          
  tables["trainers"] = trainer_list
  datasets["trainers"] = trainer_data
  
  pointers_arr = []
  used_indices = []
  for i in range(len(lists["trainers"])):
    index = lists["trainers"][i][1] - 1
    trainer = lists["trainers"][i][0]
    if index not in used_indices:
      #if the index is longer than the trainer list, then ignore
      if index < len(trainer_list):
        used_indices.append(index)
        pointers_arr.append([[trainer],trainer_list[index]])
    else:
      list_index = used_indices.index(index)
      pointers_arr[list_index][0].append(trainer)
  pointers["trainers"] = pointers_arr

#to extract door tile ids
def extractDoorTileIDs(content):
  
  line = getNextLine(content)
  door_names = []
  tset_names = []
    
  #loop through the pointer list until reach the FF
  while(convertHex(line) != 255):
    tset = line
    #save the door tile list name
    line = getNextLine(content)
    
    #if this door name has not been used yet, add it to the list
    if(line not in door_names):
      door_names.append(line)
      tset_names.append([tset])
    else:
      index = door_names.index(line)
      tset_names[index].append(tset)
    
    line = getNextLine(content)
  
  door_tile_data = []
  #loop through the remaining info (until we've encountered every door name)
  while(len(door_tile_data) < len(door_names)):
    #create the new array to add to the pointers list
    name = getNextLine(content).replace(":","")
    index = door_names.index(name)
    new_arr = [tset_names[index],name,[]]
    tiles = getNextLine(content).split(",")
    #save the array (except the last one
    for i in range(len(tiles) - 1):
      new_arr[2].append(convertHex(tiles[i]))
    door_tile_data.append(new_arr)
  
  pointers["tileset_door_tiles"] = door_tile_data

#to extract warp tile id's
def extractWarpTileIDs(content):
  pointer_name_list = []
  data_list = []
  
  line = getNextLine(content).replace(":","")
  
  #extract the pointer name list
  while(len(pointer_name_list) < len(datasets["tilesets"])):
    pointer_name_list.append(line)
    line = getNextLine(content).replace(":","")
  
  #extract the data
  while(removeAll(line) in pointer_name_list):
    data_names = [removeAll(line)]
    
    line = getNextLine(content,False).replace(":","")
    #keep going until we find the data
    while(not removeSpaces(line).startswith("db")):
      data_names.append(removeAll(line))
      line = getNextLine(content,False).replace(":","")
      
    new_data_values = []
    
    j = 0
    #if this data set did not have an FF, then go to next
    while(255 not in new_data_values): 
      #skip the pointers
      while(not removeSpaces(line).startswith("db")):
        j += 1
        line = content[j].replace(":","")
        
      #split the values
      data_values = removeAll(line).split(",")
          
      #convert each value into ints
      for tile in data_values:
        new_data_values.append(convertHex(tile))

      j += 1
      #get next line
      if(j < len(content)):
        line = content[j].replace(":","")
      
        
    #now remove the 255
    new_data_values.pop()
    
    #add to data list
    data_list.append([data_names,new_data_values])
    
    #get next line
    if(len(content) > 0):
      line = getNextLine(content,False).replace(":","")
    else:
      line = ''
      
  pointers["tileset_warp_tiles"] = data_list
  
  for i in range(len(pointer_name_list)):
    tileset = datasets["tilesets"][i]
    tileset.warp_tiles = pointer_name_list[i]

#to extract ledge tiles
def extractLedgeTileIDs(content):
  
  line = getNextLine(content)
  
  ledges_list = {}
  
  #read until you reach ff
  while(isNotFF(line)):
    arr = line.split(",")
    #check to see if the first in the array is a tileset. if so, then we have already modified the table
    if(arr[0] in reference["tilesets"]):
      tset = arr.pop(0)
    #if not, then use tileset 0
    else:
      tset = reference["tilesets"][0]
    tile1 = convertHex(arr[1])
    tile2 = convertHex(arr[2])
    #to get the direction (if its hex, then convert the hex value)
    if "D_" in arr[3]:
      dir = arr[3].replace("D_","")
    else:
      dirs = {
        16 : "RIGHT",
        32 : "LEFT",
        64 : "UP",
        128 : "DOWN"
      }
      dir_index = convertHex(arr[3])
      dir = dirs[int(dir_index)]
    #if we already add this tset to the ledges list, then just append
    if(tset in ledges_list):
      ledges_list[tset].append([tile1,tile2,dir])
    #otherwise, create new
    else:
      ledges_list[tset] = [[tile1,tile2,dir]]
    line = getNextLine(content)
  datasets["ledges"] = ledges_list

#to check to see if the input is not FF
def isNotFF(s):
    return convertHex(s.split(",")[0]) != 255
    
#check to see if the tset is a name of a tileset, if not then it is a hex ID so convert
def getTilesetName(tset):
  if tset not in reference["tilesets"]:
    tset_index = convertHex(tset)
    #if a tset index was found, then return the tset. otherwise return false
    if tset_index < len(reference["tilesets"]):
      tset = reference["tilesets"][tset_index]
    else:
      tset = False
  return tset

#to extract the bookshelf tile ids
def extractBookshelfTileIDs(content):

  line = getNextLine(content)
  
  tset_list = {}
  
  #read until you reach ff
  while(isNotFF(line)):
    arr = line.split(",")
    tset = getTilesetName(arr.pop(0))
    
    new_arr = [convertHex(arr[0]),convertHex(arr[1])]
    #if this tileset already exists in the tileset list, then append the tileset pair
    if(tset in tset_list):
      tset_list[tset].append(new_arr)
    #otherwise, create a new dictionary line with an array containing this tileset pair
    else:
      tset_list[tset] = [new_arr]
    line = getNextLine(content)
  datasets["bookshelf_tiles"] = tset_list

#to extract a list of tilesets from the content (start at list name and go until an ff is reached)
def extractTilesetListCommon(content,list_name):
  tset_list = []
  line = getNextLine(content).split(",")
  list_el = line.pop(0)
  #go until we reach an FF
  while(isNotFF(list_el)):
    #ignore empty strings
    if(list_el != ''):
      tset = getTilesetName(list_el)
      tset_list.append(tset)
    if(len(line) == 0):
      line = getNextLine(content).split(",")
    list_el = line.pop(0)
  datasets["tileset_lists"][list_name] = tset_list

#to extract the dungeon tileset list
def extractDungeonTilesets(content):
  extractTilesetListCommon(content,"dungeon")
  
#to extract the bike riding tileset list
def extractBikeRidingTilesets(content):
  extractTilesetListCommon(content,"bike_riding")
  
#to extract the escape rope tileset list
def extractEscapeRopeTilesets(content):
  extractTilesetListCommon(list(content),"escape_rope")
  
#to extract the water tileset list
def extractWaterTilesets(content):
  extractTilesetListCommon(list(content),"water")

#to read through a list of tile pair collisions
def extractTilePairCollisionCommon(content,which):
  obj = {}
  line = getNextLine(content)
  #go until we reach FF
  while(isNotFF(line)):
    arr = line.split(",")
    tset = getTilesetName(arr.pop(0))
    #the next two create the pair
    pair = [convertHex(arr.pop(0)),convertHex(arr.pop(0))]
    #if this tileset already has a tile pair collision, then just append
    if(tset in obj):
      obj[tset].append(pair)
    #otherwise, create new
    else:
      obj[tset] = [pair]
    line = getNextLine(content)
  datasets["tile_pair_collision"][which] = obj

#to extract the tile pair collision lists
def extractLandTilePairs(content):
  extractTilePairCollisionCommon(content,"land")

#to extract the water tile pair collision:
def extractWaterTilePairs(content):
  extractTilePairCollisionCommon(content,"water")

def extractTextData(content,path,ptr_list):
  title = getNextLine(content).replace(":","")
    
  line = getNextLine(content,False)
  
  pointers = [title]
  
  #find all of the pointer that this refers to
  while(removeAll(line).endswith(":")):
    next_ptr = removeAll(line).replace(":","")
    #if the next pointer is in the ptr list, then remove it
    if next_ptr in ptr_list:
      list_index = ptr_list.index(next_ptr)
      ptr_list.pop(list_index)
    pointers.append(next_ptr)
    line = getNextLine(content,False)
  
  #if this is a pointer, then extract the new data
  if removeAll(line).startswith("TX_FAR"):
    new_ptr = removeAll(line).replace("TX_FAR","")
    
    text_only = True
    #if there is more code after this text, then text text_only to false
    if("@" not in removeAll(content[0])):
      text_only = False
      
    #for every pointer that we have found:
    for title in pointers:
      datasets["text"][title] = {
        "type" : "TX_FAR",
        "text_only" : text_only,
        "path" : path,
        "pointer" : new_ptr,
        "shared" : list(pointers),
      }
      #to remove this particular pointer from the shared array:
      list_index = pointers.index(title)
      datasets["text"][title]["shared"].pop(list_index)
    
    return new_ptr
  #if its a string, extract the string
  elif removeAll(line).startswith('text'):
    #get everything after the first instance of 'text '
    text = line.split("text ",1)[1].replace("\n","")
    line = getNextLine(content,False)
    prompt = False
    cont = True
    #to extract each line of text
    while(cont):
      #if its simply a new line:
      if(removeAll(line).startswith("line")):
        text += "\n" + line.split("line ",1)[1].replace("\n","")
      #if its a continue:
      elif(removeAll(line).startswith("cont")):
        text += "\n" + line.split("cont ",1)[1].replace("\n","")
      #if its a new paragraph:
      elif(removeAll(line).startswith("para")):
        text += "\n\n" + line.split("para ",1)[1].replace("\n","")
      else:
        cont = False
        #if its ends with a prompt, then set prompt to true
        if(removeAll(line).startswith("prompt")):
          prompt = True
        #reinsert the line incase its a pointer
        content.insert(0,line)
      
      #if there is an @ in the text, then don't continue
      if("@" in text):
        cont = False
      
      if cont:
        line = getNextLine(content,False)

    #to replace hex strings with new variables
    replace = {
      '"' : '',
      "@" : '',
      "$53," : "#RIVAL",
      "$52," : "#PLAYER",
      "$5A," : "#ENEMY ",
      "$5D," : "#TRAINER",
      "$5C," : "#TM",
      "$5B," : "#PC",
      "$5E," : "#ROCKET",
      "$54," : "#POKE",
      "$56," : "#..",
      "$4A," : "#PKMN",
    }
    
    #replace the # back with #POKE
    text = text.replace("#","#POKE")
    #remove the unneeded characters
    for key in replace:
      text = text.replace(key,replace[key])
    
    #for every pointer that we have found:
    for title in pointers:
      datasets["text"][title] = {
        "type" : "text",
        "path" : path,
        "text" : text,
        "shared" : list(pointers),
        "prompt" : prompt,
      }
      #to remove this particular pointer from the shared array:
      list_index = pointers.index(title)
      datasets["text"][title]["shared"].pop(list_index)
  #if its a mart inventory:
  elif removeAll(line).startswith("$FE") or removeAll(line).startswith('254'):
    arr = []
    
    line = removeAll(line).split(",")
    for each in line:
      arr.append(convertHex(each))
    
    while(255 not in arr):
      line = getNextLine(content).split(",")
      for each in line:
        arr.append(convertHex(each))

    items = []
    #add the items to the items array
    for each in arr:
      if each in reference["items"]:
        items.append(each)
    #for every pointer that we have found:
    for title in pointers:
      datasets["text"][title] = {
        "type" : "mart",
        "items" : items,
        "shared" : list(pointers),
      }
      #to remove this particular pointer from the shared array:
      list_index = pointers.index(title)
      datasets["text"][title]["shared"].pop(list_index)
  #otherwise, its a script (so don't extract)
  else:
    #for every pointer that we have found:
    for title in pointers:
      datasets["text"][title] = {
        "type" : "Script",
        "path" : path,
        "shared" : list(pointers),
      }
      #to remove this particular pointer from the shared array:
      list_index = pointers.index(title)
      datasets["text"][title]["shared"].pop(list_index)
  return False
  
#to load a binary file
def loadBinary(path):
  arr = []
  bytes_read = open(path, "rb").read()
  for b in bytes_read:
    arr.append(int(b))
  return arr
##############################################

###########################################
###   Functions to use to parse files   ###
###########################################
#to create a string for the data so it can be appear as int or string in the output file
def createOutputString(s):
  if type(s) is str and not (s.startswith('-') and s[1:].isdigit()):
    s = s.replace("\n","\\n")
    return '"' + s + '"'
  elif type(s) is bool:
    return str(s).lower()
  else:
    return str(s)

#To parse a file, remove comments and empty lines
def parseCommon(file):
  with open(file, encoding="utf-8") as f:
    lines = f.readlines()
  arr = []
  #to read each line from this file
  for line in lines:
    #to remove the comments
    str = line.split(";")[0]
    #to ignore blank lines
    if removeSpaces(str):
      arr.append(str)
  return arr

#To parse a constants file
def parseFile(fname):
  return parseCommon('../' + fname.replace("\\","/"))

#to parse a directory
def parseDirectory(dname):
  arr = glob.glob('../' + dname + "/*.asm")
  new_arr = []
  for fname in arr:
    new_arr.append(fname.replace("\\","/"))
  return new_arr  
  
#to parse the given content to find the given includes
def parseForIncludes(file_content,includes,path):

  print("\nParsing " + path + " for includes...")
  content = {}
  compare = {}
  #to create an empty array for each of the includes list and the list of things to compare
  for name in includes:
    content[name] = []
    compare[name] = []
    for each in eval(files[name]["list"]):
      compare[name].append(eval(files[name]["pointer"]) + ":")

  while(len(file_content) > 0):
    line = getNextLine(file_content)
    
    #to remove the comments
    str = line.split(";")[0]
    #to ignore blank lines
    if str:
      match = False
      #check each of the compare list
      for name in compare:
        #if we haven't found a match yet
        if not match:
          #check the list for each given pointer 
          for pointer in compare[name]:
            #check to see if the pointer exists in the string
            if pointer in str and not match:
              #go until incbin is found
              while "INCBIN" not in str:
                if str:
                  content[name].append(str)
                line = getNextLine(file_content)
                str = line.split(";")[0]
              content[name].append(str)
              match = True
  
  print("\tFinished Parsing " + path)
  #to extract each file
  for key in content:
    print("\nParsing " + key + "...")
    files[key]["extract"](content[key],path)
    print("\tFinished Parsing " + key)
  
def parseData():
  global maps
  global files
  print("Loading Data...")
  
  #to extract the file sources
  with open("files.txt") as f:
    lines = f.readlines()
  for line in lines:
    line = line.replace("\n","").split(",")
    #if the last element in the array is empty, then remove
    if line[len(line)-1] == '':
      line.pop(len(line)-1)
    
    file = line.pop(0)
    #ignore lines that don't exist in the "files" dictionary
    if file in files:
      #create the source array
      src = [line.pop(0)]
      
      #this determines how many elements in the array we leave when we extract sources (the last element is the pointer/label)
      limit = 1
      #if the file is "multiple sources" or "includes_files", then there is no pointer, so include the last element in the array as a source
      if file in multiple_sources or file in includes_files or file in text_data_files:
        limit = 0
      
      #add all other files to the source array
      while(len(line) > limit):
        src.append(line.pop(0))
      
      files[file]["src"] = src
      
      #copy the label if it exists
      if len(line) > 0:
        files[file]["label"] = line.pop(0)
  
  #to parse the Constants Files:
  parseFileList(constants_files)
  
  #to parse the Primary Files
  parseSharedFileList(primary_files)
  
  #to parse the files with multiple sources
  parseMultipleSources()
  
  #to parse the Secondary Files
  parseSharedFileList(secondary_files)
  
  #to parse the includes files
  parseIncludes(includes_files)
  
  #to parse the text files
  parseTextData()
  
  #parse main.asm to find the tset blocks and gfx pointers
  #parseMain()  
  print("\nFinished Loading Data")

  
#to parse the text files:
def parseTextData():
  print("\nParsing Texts...")
  #check each file in the text_data_files array
  for file in text_data_files:
    #this "parse all" code is in a nested function so it can be repeated
    #The input is the list of pointer that is needs to search for
    def parseAllText(ptr_list):
      new_ptr_list = []
    
      #parse each source in the src array
      for src in files[file]["src"]:
      
        #if the file ends with .asm, then run the "get next subfile" function
        if src.endswith(".asm"):
          content = parseFile(src)
          #go through the file until you read the appropriate pointer
          while(len(content) > 0):
            title = removeSpaces(content[0]).replace(":","")
            #if this line exists in the pointer list, then extract the data
            if(title in ptr_list):
              while(title in ptr_list):
                list_index = ptr_list.index(title)
                #remove this pointers from the list of pointers we need to find
                ptr_list.pop(list_index)
              
              #if a pointer was found, then extact from the content
              #if the return value is not "False", then it is a new pointer we need to find
              new_pointer = files[file]["extract"](content,src,ptr_list)
              
              #if the return value is not False, then add the string to the new_ptr_list
              if(new_pointer):
                new_ptr_list.append(new_pointer)
                
            else:
              content.pop(0)
        #otherwise, parse the directory and extract from each file
        else:
          dir = parseDirectory(src)
          #parse each file in the directory
          for sub_file in dir:
            content = parseCommon(sub_file)
            #go through the file until you read the appropriate pointer
            while(len(content) > 0):
              title = removeSpaces(content[0]).replace(":","")
              #if this line exists in the pointer list, then extract the data
              if(title in ptr_list):
                while(title in ptr_list):
                  list_index = ptr_list.index(title)
                  #remove this pointers from the list of pointers we need to find
                  ptr_list.pop(list_index)
                
                #if a pointer was found, then extact from the content
                #if the return value is not "False", then it is a new pointer we need to find
                new_pointer = files[file]["extract"](content,src,ptr_list)
                
                #if the return value is not False, then add the string to the new_ptr_list
                if(new_pointer):
                  new_ptr_list.append(new_pointer)
                  
              else:
                content.pop(0)
      
      #this is what was not found
      while len(ptr_list) > 0:
        print("\t" + ptr_name + " not found")
            
      #if new pointers were added to the list, then repeat search for the new list
      if len(new_ptr_list) > 0:
        parseAllText(new_ptr_list)
        
    #to create the array of all texts:
    ptr_list = []
    #go through all map texts
    for list in datasets["map_texts"]:
      for ptr in datasets["map_texts"][list]:
        if ptr not in ptr_list:
          ptr_list.append(ptr)
    #go through all trainer header texts
    for script in datasets["map_scripts"]:
      list = datasets["map_scripts"][script]["trainer_headers"]
      for trainer_header in list:
        for i in range(3,7):
          if trainer_header[i] not in ptr_list:
            ptr_list.append(trainer_header[i])

    parseAllText(ptr_list)
    print("\tFinished Parsing Texts")
    
#to parse each file in the given list
def parseFileList(list):
  for key in list:
    print("\nParsing " + key + "...")
    sources = files[key]["src"]
    #parse each source
    for src in sources:
      content = parseFile(src)
      files[key]["extract"](content)
    print("\tFinished Parsing " + key)

#to parse the multiple sources list
def parseMultipleSources():
  for file in multiple_sources:
    print("\nParsing " + file + "...")
    #get the list of pointers
    ptr_list = datasets[files[file]["pointer_list"]]
    sources = files[file]["src"]
    #parse each source
    for src in sources:
      #if the file whens with .asm, then run the "get next subfile" function
      if src.endswith(".asm"):
        content = parseFile(src)
        #go through the file until you read the appropriate pointer
        while(len(content) > 0):
          #if this line exists in the pointer list, then extract the data
          if(removeSpaces(content[0]).replace(":","") in ptr_list):
            #if a subfile was found, then extact from the content
            files[file]["extract"](content,src)
          else:
            content.pop(0)
      #otherwise, parse the directory and extract from each file
      else:
        dir = parseDirectory(src)
        #parse each file in the directory
        for sub_file in dir:
          content = parseCommon(sub_file)
          #go through the file until you read the appropriate pointer
          while(len(content) > 0):
            #if this line exists in the pointer list, then extract the data
            if(removeSpaces(content[0]).replace(":","") in ptr_list):
              #if a subfile was found, then extact from the content
              files[file]["extract"](content,sub_file)
            else:
              content.pop(0)
    print("\tFinished Parsing " + file)

#to parse the includes files
def parseIncludes(list):
  list = createSharedFilesList(list)
  
  #check each file in the list
  for each in list:
    files_list = each[0]
    source = each[1]
    content = parseFile(source)
    parseForIncludes(content,files_list,source)
    
#to parse lists that can share a file
def parseSharedFileList(list):
  list = createSharedFilesList(list)
  #go through each array in the list and parse the shared file
  for each in list:
    files_list = each[0]
    source = each[1]
    content = parseFile(source)
    parseSharedFile(content,files_list)

#to parse the given list and return a list that contains arrays of which files share the same source
def createSharedFilesList(list):
  sources = []
  files_list = []
  for key in list:
    src = files[key]["src"]
    #parse each source
    for file in src:
      #if this source already exists in the sources list, then add the files to same index in the files list
      if file in sources:
        index = sources.index(file)
        files_list[index].append(key)
      else:
        sources.append(file)
        files_list.append([key])
  ret_arr = []
  #combine the files and sources into a single array
  for i in range(len(sources)):
    ret_arr.append([files_list[i],sources[i]])
  return ret_arr
  
#to parse the content and search for any of the pointers in the given files list, and then run the "extract" function on the new content
def parseSharedFile(content,list):
  #loop until there is not more data in the the contents or in the files list
  while(len(list) > 0 and len(content) > 0):
    line = getNextLine(content)
    #go through each file in the list
    for file in list:
      label = files[file]["label"]
      #if the label for what we are extracting is in this line, then run the extract function
      if line == label:
        print("\nParsing " + file + "...")
        index = list.index(file)
        list.pop(index)
        files[file]["extract"](content)
        print("\tFinished Parsing " + file)
        
#######################################################
### List of all the files to get Parsed into Memory ###
#######################################################
### parse : function to run to parse the file/dir   ###
### src : the name of the src file/dir              ###
### read : function to perform on parsed data       ###
#######################################################

#these are the constant files to be extracted. they must be extracted first because they extract amount/id's are used in later routines
constants_files = ["Map Constants","Item Constants","Pokemon Constants","Trainer Constants","Sprite Constants","Map Dimensions","Tilesets","Special Warps"]

#if any of these share a file, they can be parsed at the same time
#this is run second because it extracts pointer names that are needed in future routines
primary_files = ["Map Header Names","Wild Pokemon Names","Tileset Headers","Map Sprite Sets","Sprite Data","Hidden Object Maps","Dungeon Warp List"]

#the "multiple sources" is run third because it uses pointers from tables and also extract additional pointers
#the "extract" function is only run on a specific set of a data relating to a specific pointer
#there are two ways it can parse data:
#1: from a directory where each file is a separate sub-file (the "extract" function will be run on each file)
#2: from a single source file, where the "sub files" need to be extracted ("extractFromFile" function will extract each individual sub-file, then the "extract" function will be run on the subfile)
#these cannot be parsed at the same time because some for later functions is extracted by an earlier function
multiple_sources = ["Map Header Data","Map Object Data","Wild Pokemon Data","Map Text Pointers","Map Scripts"]

#these "secondary files" are run separately since it is possible to extract multiple ones from a single file (and it doesnt matter what order they are parsed in)
#when the pointer needed is found, the "extract" function is run on the remaining content (and afterwards, it will remove the data it read and return a new "content" file that picks up where the extract function left off)
#they are run last because they rely on pointers extracted in earlier routines
secondary_files = ["Fly Warp Data","Hidden Object Pointers","Super Rod Data","Trainer Party Data","Warp Tiles","Door Tiles","Bookshelf Tiles","Ledge Tiles","Land Tile Pair Collisions","Water Tile Pair Collisions","Dungeon Tilesets","Bike Riding Tilesets","Escape Rope Tilesets","Water Tilesets","Split Map Sprite Sets","Sprite Sets","Force Bike or Surf","Hide or Show Data","Dungeon Warp Data"]

#the includes files get run separately, since multiple pointers can be parsed at the same time from a single file (and it doesnt matter what order they are parsed in)
#these run last because they need to know what pointer names to look for, which are extracted in earlier routines
#when a pointer is found, it is added to a separate "new_content" arr that only contains lines from the file that include the pointers we are looking for
#after parsing the file, it will then run a separate function to parse these "new_content" array
#includes_files = ["Collisions","Tileset Blocks","Map Blocks","Tileset Graphics","Sprite Graphics"]
includes_files = ["Collisions","Map Blocks","Tileset Blocks","Tileset GFX","Sprite GFX"]

#this include the functions that run when extracting text
#Since a this might actually be a pointer to another text file, the extracting gets repeated until no more "new pointers" are found
text_data_files = ["Text Data"]

#contains information about each file
files = {
  "Map Constants" : {
    "extract" : extractMaps,
  },
  "Item Constants" : {
    "extract" : extractItems,
  },
  "Pokemon Constants" : {
    "extract" : extractPokemon,
  },
  "Trainer Constants" : {
    "extract" : extractTrainers,
  },
  "Sprite Constants" : {
    "extract" : extractSprites,
  },
  "Map Dimensions" : {
    "extract" : extractMapDimensions,
  },
  "Tilesets" : {
    "extract" : extractTilesets,
  },
  "Map Header Names" : {
    "extract" : extractMapHeaderNames,
  },
  "Hidden Object Maps" : {
    "extract" : extractHiddenObjectMaps,
  },
  "Wild Pokemon Names" : {
    "extract" : extractWildPokemonNames,
  },
  "Tileset Headers" : {
    "extract" : extractTilesetHeaders,
  },
  "Map Sprite Sets" : {
    "extract" : extractMapSpriteSets,
  },
  "Sprite Data" : {
    "extract" : extractSpriteData,
  },
  "Map Header Data" : {
    "extract" : extractMapHeaderData,
    "pointer_list" : "map_headers",
  },
  "Map Object Data" : {
    "extract" : extractMapObjectData,
    "pointer_list" : "map_objects",
  },
  "Map Text Pointers" : {
    "extract" : extractTextPointers,
    "pointer_list" : "map_texts",
  },
  "Map Scripts" : {
    "extract" : extractMapScripts,
    "pointer_list" : "map_scripts",
  },
  "Wild Pokemon Data" : {
    "extract" : extractWildPokemonData,
    "pointer_list" : "wild_pokemon",
  },
  "Special Warps" : {
    "extract" : extractSpecialWarps,
  },
  "Hidden Object Pointers" : {
    "extract" : extractHiddenObjectPointers,
  },
  "Trainer Party Data" : {
    "extract" : extractTrainerPartyData,
  },
  "Warp Tiles" : {
    "extract" : extractWarpTileIDs,
  },
  "Door Tiles" : {
    "extract" : extractDoorTileIDs,
  },
  "Bookshelf Tiles" : {
    "extract" : extractBookshelfTileIDs,
  },
  "Ledge Tiles" : {
    "extract" : extractLedgeTileIDs,
  },
  "Land Tile Pair Collisions" : {
    "extract" : extractLandTilePairs,
  },
  "Water Tile Pair Collisions" : {
    "extract" : extractWaterTilePairs,
  },
  "Dungeon Tilesets" : {
    "extract" : extractDungeonTilesets,
  },
  "Bike Riding Tilesets" : {
    "extract" : extractBikeRidingTilesets,
  },
  "Escape Rope Tilesets" : {
    "extract" : extractEscapeRopeTilesets,
  },
  "Water Tilesets" : {
    "extract" : extractWaterTilesets,
  },
  "Split Map Sprite Sets" : {
    "extract" : extractSplitMapSpriteSets,
  },
  "Sprite Sets" : {
    "extract" : extractSpriteSets,
  },
  "Super Rod Data" : {
    "extract" : extractSuperRodData,
  },
  "Force Bike or Surf" : {
    "extract" : extractForceBikeSurf,
  },
  "Hide or Show Data" : {
    "extract" : extractHideShowData,
  },
  "Dungeon Warp List" : {
    "extract" : extractDungeonWarpList,
  },
  "Dungeon Warp Data" : {
    "extract" : extractDungeonWarpData,
  },
  "Fly Warp Data" : {
    "extract" : extractFlyWarpData,
  },
  "Collisions" : {
    "extract" : extractCollisions,
    "pointer" : "each.collision",
    "list" : "datasets['tilesets']",
  },
  "Map Blocks" : {
    "extract" : extractMapBlocks,
    "pointer" : "datasets['map_headers'][each.header].blocks",
    "list" : "datasets['maps']",
  },
  "Tileset Blocks" : {
    "extract" : extractTilesetBlocks,
    "pointer" : "each.blocks",
    "list" : "datasets['tilesets']",
  },
  "Tileset GFX" : {
    "extract" : extractTilesetGFX,
    "pointer" : "each.gfx",
    "list" : "datasets['tilesets']",
  },
  "Sprite GFX" : {
    "extract" : extractSpriteGFX,
    "pointer" : "each[1]",
    "list" : "pointers['sprites']",
  },
  "Text Data" : {
    "extract" : extractTextData,
  },
}

############################
###   Global Functions   ###
############################
#to convert a str to decimal if its hex
def convertHex(s):
  if s == "$":
    s = 0
  elif s.startswith("$"):
    s = int(s.replace("$",""),16)
  elif s.isdigit():
    s = int(s)
  return s
  
#to remove tabs and spaces
def removeSpaces(str):
  return re.sub(r"\t? ?\r?\n?","",str)
  
#to remove db, dw, dwb
def removeSize(str):
  return re.sub(r"db |dw |dbw ","",str)

#########################
###   Main Function   ###
#########################
def startServer():
  class Handler(CGIHTTPRequestHandler):
  
    rbufsize = -1
    
    def do_POST(self):
      self.rfile._sock = self.rfile
      return CGIHTTPRequestHandler.do_POST(self)
      
    def is_cgi(self):
      path = self.path
      for x in self.cgi_directories:
          i = len(x)
          if path[:i] == x and (not path[i:] or path[i] == '/') and path.endswith(".py"):
              self.cgi_info = path[:i], path[i+1:]
              return True
      return False
      
    def end_headers(self):
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        CGIHTTPRequestHandler.end_headers(self)
    
    cgi_directories = ["/" + params["directory"]]

  PORT = 8080
  server = HTTPServer(("", 8000), Handler)
  server.serve_forever()
  
def main():
  global data_file
  
  #if the data.js path does not exist, or the reload argument was passed, then create new data.js
  if not os.path.exists("data.js") or "-reload" in sys.argv:
    #To load the data from the necessary files
    parseData()

    #To Create the Data File
    data_file = open("data.js","w")
    writeData()
    data_file.close()
  
  #To start the server in the main folder
  os.chdir("..")
  server = Thread(target = startServer)
  server.daemon = True
  server.start()
  
  #To open the browser
  webbrowser.open("http://localhost:8000/" + params["directory"] + "/")
  
  #To keep the program running (for quick ctrl+c)
  while True:
    time.sleep(1)
  
main()
