/***********************"
Notes:
-Add in toggle "subblock borders" button for Objects page
-When editing super rod data: if it is "None" and you add a pokemon, auto check "save as new"
-Don't save "Map Dimensions" if the value is an int (rather than a string that appears in the Map Constants list).  instead, save the map header
-- In the map header, save as text or int (depending on what it was originally). right now it just saves as int

-For all, check to see if anything actually did change.  If nothing changed, then don't save that feature

-prevent non-alphanumberic (and _) from being saved as a new file name
-if you cancel the "new_file_name", then reset the file_names (otherwise, it will not pop up next time)

For Readme:
-It is assumed the connection map uses the same tileset
-When switching tileset gfx, mention that the new gfx needs to be in the same bank as the original (is this true?)
-A red block is glitched (containing tile ids that does exist in the tileset or block ids that does exist in the blockset)
************************/
//Create the GlitchMap object
function GlitchMap(){
	/*****************************************************************
	This contains the Pages object, everything relevant to each page
	*******************************************************************/
	var pages = {
		map : new function(){
			//map.build
			this.build = function(){
				/******************tileset Blocks Element****************/
				//to draw the tileset blocks container
				var parent = newElement("div",{
					id : "tileset_blocks_container",
					scale : currentScale,
					page : "map"
				},
				this.page);
				elements.containers.tileset_blocks = parent;
							
				//draw tileset block list container
				var div = newElement("div",{
					id : "tileset_blocklist_container",
					scale : currentScale
				},
				parent);
				elements.containers.tileset_blocklist = div;
				
				/*********************map Element******************/
				//draw map container
				var div = newElement("div",{
					id : "map_container",
					page : "map",
					scale : currentScale
				},
				this.page);
				elements.containers.map = div;
				
				/*******************Current Block Element*************/
				//create "current block container"
				var parent = newElement("div",{
					id : "current_block_container",
					text : "Current Block:",
					class : "special_block_container"
				},
				this.page);
				elements.containers.current_block_container = parent;
				
				//draw "current block"
				var div = newElement("div",{
					id : "current_block",
					class : "block",
					scale : currentScale,
					grid : "on",
					tile_grid : "off",
					page : "map"
				},
				parent);
				elements.containers.current_block = div;
				
				/**********************Border Block Element*******************/
				//create "border block container"
				var parent = newElement("div",{
					id : "border_block_container",
					text : "Border Block:",
					class : "special_block_container"
				},
				this.page);
				parent.addEventListener("click",function(){
					borderBlockClick();
				});
				elements.containers.border_block_container = parent;
				
				//draw "border block"
				var div = newElement("div",{
					id : "border_block",
					class : "block",
					scale : currentScale,
					grid : "on",
					tile_grid : "off"
				},
				parent);
				elements.containers.border_block = div;
				
				/*********************Show Tile Borders Element*****************/
				//draw the "Show Tile Borders" button
				var div = newElement("div",{
					id : "toggle_borders",
					text : "Toggle Borders",
					class : "button",
					state : "active"
				},
				this.page);
				div.addEventListener("click",function(){
					toggleMapBorders();
				});
				elements.buttons.toggle_borders = div;
				
				/***************Map Size Element********************/
				//draw "Map size" container
				var div = newElement("div",{
					id : "map_size_container"
				},
				this.page);
				elements.containers.map_size = div;
				
				var text = document.createTextNode("Height:");
				div.appendChild(text);
				
				createPlusMinus("map_height",1,div);
				
				var br = document.createElement("br");
				div.appendChild(br);
							
				var text = document.createTextNode("Width:");
				div.appendChild(text);
				
				createPlusMinus("map_width",1,div);
				
				/**********************Hover Info***************************/
				//draw "Map size" container
				var div = newElement("div",{
					id : "hover_info_container",
					mode : "dec",
				},
				this.page);
				elements.containers.hover_info = div;
				div.addEventListener("click",function(){
					//set the mode
					mode = this.getAttribute("mode") == 'dec' ? 'hex' : 'dec';
					this.setAttribute("mode",mode);
					
					//add the hover text
					var div = elements.containers.hover_info_text;
					clearNodes(div);
					var text = document.createTextNode("Hover Over Block");
					div.appendChild(text);
					var br = document.createElement("br");
					div.appendChild(br);
					var hex_or_dec = mode == "dec" ? "Hex" : "Dec";
					var text = document.createTextNode("Click to Toggle " + hex_or_dec);
					div.appendChild(text)
				});
				
				var el = newElement("div",{
					id : "hover_info_walkable",
				},
				div);
				elements.containers.hover_info_walkable = el;
				
				var el = newElement("div",{
					id : "hover_info_XY",
				},
				div);
				elements.containers.hover_info_XY = el;
				
				var el = newElement("div",{
					id : "hover_info_block_XY",
				},
				div);
				elements.containers.hover_info_block_XY = el;
				
				var el = newElement("div",{
					id : "hover_info_block_id",
				},
				div);
				elements.containers.hover_info_block_id = el;
				
				var el = newElement("div",{
					id : "hover_info_text",
					text : "Hover Over Block",
				},
				div);
				var br = document.createElement("br");
				el.appendChild(br)
				var text = document.createTextNode("Click to Toggle Hex");
				el.appendChild(text)
				elements.containers.hover_info_text = el;
				
				/********************Save As New Blocks Element**************/
				//create the "Save as New map Blocks" container
				var div = createSaveAsNew("map_blocks")
				this.page.appendChild(div);
				
			};
			
			//map.refresh
			this.refresh = function(){
				//to set the size of the page
				elements.pages.map.style.height = "550px";
										
				//update the dimensions
				elements.containers.map_height.innerHTML = current_data.dimensions.height;
				elements.containers.map_width.innerHTML = current_data.dimensions.width;
				
				//update the border block
				setBorderBlock(current_data.map.header.objects.border);
			};
			
			//map.onshow
			this.onShow = function(){
				setAllMapBorders(map_borders);
				
				elements.containers.current_block_container.appendChild(elements.containers.current_block);
				elements.containers.current_block.setAttribute("page","map");
				
				elements.pages.map.appendChild(elements.containers.map);
				elements.containers.map.setAttribute("page","map");
				elements.pages.map.appendChild(elements.containers.tileset_blocks);
				elements.containers.tileset_blocks.setAttribute("page","map");	

				setTileGrid(elements.containers.current_block,"off");			
			};
			
			this.onHide = function(){};
		},
		objects : new function(){
			//objects.build
			this.build = function(){
				/***************objects Sub Tabs Element*****************/
				var tab_list = ["Warps","Warp-To","Signs","Sprites","Hidden Objects","Special Warps","Force Bike/Surf"];
				createSubTabs("objects",tab_list);
				changeSubTab("objects","Warps");
			};
			
			//objects.refresh
			this.refresh = function(){
				elements.tabs.objects.setAttribute("state","active");
			};
			
			//objects.onshow
			this.onShow = function(){
				setAllMapBorders(map_borders);
				elements.pages.objects.appendChild(elements.containers.map);
				elements.containers.map.setAttribute("page","objects");
			};
		
			this.onHide = function(){};
		},
		connections : new function(){
			//connections.build
			this.build = function(){
				/**********************connections Sub Tabs Element*************/
				var tab_list = ["NORTH","SOUTH","EAST","WEST"];
				createSubTabs("connections",tab_list);
				
				/***********************map connections Element******************/
				//draw "map connections" container
				var parent = newElement("div",{
					id : "map_connections_container"
				},
				this.page);
				elements.containers.map_connections = parent;
				
				//draw "Current map Wrapper"
				var div = newElement("div",{
					id : "map_connections_wrapper"
				},
				parent);
				elements.containers.map_connections_wrapper = div;
						
				
				//to create the fields in each connection subpages
				for(var subpage in elements.sub_pages.connections){
					
					//to create the connection map blocks container
					var div = newElement("div",{
						id : subpage + "_connection_blocks",
						class : "connection_blocks_container"
					},
					parent);
					elements.containers[subpage + "_connection_blocks"] = div;
					
					var subpage_div = elements.sub_pages.connections[subpage];
					
					//to create the toggle button
					var button =  newElement("div",{
						id : "toggle_" + subpage,
						text : "Add",
						class : "button connection_toggle",
						state : "active",
						connection : subpage
					},
					subpage_div);
					elements.buttons["toggle_" + subpage] = button;
					button.addEventListener("click",function(){
						toggleConnection(this.getAttribute("connection"));
					});
					
					var text =  newElement("div",{
						text : "Map:",
						class : "connection_map_label"
					},
					subpage_div);
					
					//to build the map dropdown
					var select = createSelectFromList(data.lists.maps,0);
					select.id = subpage + "_connection_map"
					select.className = "connection_map";
					select.setAttribute("connection",subpage);
					select.addEventListener("change",function(){
						//to reset the options for this connection
						resetConnectionData(this.getAttribute("connection"),this.options[this.selectedIndex].value);
						updateConnectionData(this.getAttribute("connection"),"map",this.options[this.selectedIndex].value);
					});
					elements.fields[subpage + "_connection_map"] = select;
					subpage_div.appendChild(select);
					
					
					var text =  newElement("div",{
						text : "Size:",
						class : "connection_size_label"
					},
					subpage_div);

					var holder = newElement("div",{
						id : subpage + "_size_holder",
						class : "connection_size_plus_minus"
					},
					subpage_div);
					elements.containers[subpage + "_size_holder"] = holder;
					createPlusMinus(subpage + "_size",1,holder);
					
					var text =  newElement("div",{
						text : "Offset:",
						class : "connection_offset_label"
					},
					subpage_div);
					
					var holder = newElement("div",{
						id : subpage + "_offset_holder",
						class : "connection_offset_plus_minus"
					},
					subpage_div);
					elements.containers[subpage + "_offset_holder"] = holder;
					createPlusMinus(subpage + "_offset",0,holder);
					
					var text =  newElement("div",{
						text : "Movement:",
						class : "connection_movement_label"
					},
					subpage_div);
					
					var holder = newElement("div",{
						id : subpage + "_movement_holder",
						class : "connection_movement_plus_minus"
					},
					subpage_div);
					elements.containers[subpage + "_movement_holder"] = holder;
					createPlusMinus(subpage + "_movement",0,holder);

					var text =  newElement("div",{
						text : "Also Apply to Connection Map",
						class : "apply_to_other_label"
					},
					subpage_div);
					
					var input = newElement("input",{
						type : "checkbox",
						id : subpage + "_apply_to_other",
						class : "apply_to_other",
						which : subpage,
					},
					subpage_div);
					input.addEventListener("click",function(){
						toggleApplyToOther(this.getAttribute("which"));
					});
					elements.fields[subpage + "_apply_to_other"] = input;		
				};
				changeSubTab("connections","NORTH");
			};
			
			//connections.refresh
			this.refresh = function(){
				elements.tabs.connections.setAttribute("state","active");				
				
				//to convert a string that includes a dimension and possibly a minus sign into an int
				function convertToInt(str){
					//if the input is a string:
					if(typeof str == "string"){
						//if the input contains a minus sign
						if(str.indexOf("-") > -1){
							str = str.split("-");
							var first = parseInt(getFromList("map_dimensions",str[0],1));
							var second = parseInt(str[1]);
							return first - second;
						}
						else{
							return parseInt(getFromList("map_dimensions",str,1));
						}					
					}
					else return str;
				};
				
				for(var each in connections_data){
					var con = current_data.map.header.connections[each]
					
					connections_data[each].apply_to_other = false;
					elements.fields[each + "_apply_to_other"].checked = false;
					
					//if this map has the connection, then load the data
					if(con){
						connections_data[each].map = con.map;
						elements.fields[each + "_connection_map"].selectedIndex = getSortedIndex(data.lists.maps,con.map);
						
						//set the size attribute
						var size = con.height;
						//if the connection doesn't have the height attribute, set it to the width attribute
						if(!size){
							size=con.width;
						}
						
						size =  convertToInt(size);
						
						connections_data[each].size = size;
						connections_data[each].offset = con.offset;
						connections_data[each].movement = con.movement;
						
						
						//to update the counters on the GUI
						updateValue(each + "_size",size);
						updateValue(each + "_offset",con.offset);
						updateValue(each + "_movement",con.movement);
						
						connections_data[each].enabled = true;
						elements.buttons["toggle_" + each].innerHTML = "Remove";
					}
					else{
						connections_data[each].enabled = false;
						elements.buttons["toggle_" + each].innerHTML = "Add";
						connections_data[each].map = data.lists.maps[0][0];
						elements.fields[each + "_connection_map"].selectedIndex = getSortedIndex(data.lists.maps,data.lists.maps[0][0]);
						resetConnectionData(each,data.lists.maps[0][0]);
					}
				}
			};
			
			//connections.onshow
			this.onShow = function(){
				setAllMapBorders("off");
				eraseConnections();
				elements.containers.map_connections_wrapper.appendChild(elements.containers.map);
				elements.containers.map.setAttribute("page","connections");
				for(var each in elements.sub_tabs.connections){
					//finds the current tab and load the connection map for that
					if(elements.sub_tabs.connections[each].getAttribute("state") == "current"){
						//if the map connection is enabled, then draw it
						if(connections_data[each].enabled){
							drawMapConnection(each);
						}
					}
				}
			};
		
			this.onHide = function(){};
		},
		pokemon : new function(){
			//pokemon.build
			this.build = function(){
				//to build the fishing group dropdown:
				var div = newElement("div",{
					id : "current_super_rod_data_container",
					text : "Super Rod Group: "
				},
				this.page);
				elements.containers.current_super_rod_data = div;
				
				//create the fishing group dropdown
				var input = createSelectFromList(data.pointers.super_rod_data,1);
				var option = newElement("option",{
					text : "None",
					value : "None",
				},
				input);
				input.id = "super_rod_selection";
				elements.fields.super_rod_list = input;
				input.addEventListener("change",function(){
					setModified("map_super_rod_name");
					//if the current list was "none", then just reset modified for "super rod data"
					if(current_data.super_rod_data.name == "None"){
						resetModified("super_rod_data")
					}
					//set the "super_rod_data" callback to be "ShowHideSaveAs"
					setCallback("load_super_rod_data",function(){
						pages.pokemon.refresh();
						showHideSaveAs("super_rod_data");
					});
					change("super_rod_data",this.options[this.selectedIndex].value);
				})
				div.appendChild(input);
				
				//to build the wild pokemon dropdown container:
				var div = newElement("div",{
					id : "current_wild_pokemon_container",
					text : "Wild Pokemon: "
				},
				this.page);
				elements.containers.current_wild_pokemon_data = div;
				
				//create the wild pokemon dropdown
				var input = createSelectFromList(data.pointers.wild_pokemon,1);
				input.id = "wild_pokemon_selection";
				elements.fields.wild_pokemon_list = input;
				input.addEventListener("change",function(){
					setModified("map_pokemon");
					//set the "wild_pokemon" callback to be "ShowHideSaveAs"
					setCallback("load_wild_pokemon",function(){
						pages.pokemon.refresh();
						showHideSaveAs("wild_pokemon");
					});
					change("wild_pokemon",this.options[this.selectedIndex].value);
				})
				div.appendChild(input);
			
				
				/**************Save as New Super Rod Data Element**************/
				var div = createSaveAsNew("super_rod_data");
				this.page.appendChild(div);
				
				//the Super Rod List container
				var div = newElement("div",{
					id : "super_rod_pokemon_list",
					class : "wild_pokemon_list",
					text : "Super Rod Pokemon"
				},
				this.page);
				elements.containers.super_rod_list = div;
			
				
				/**************Save as New Wild Pokemon List Element**************/
				var div = createSaveAsNew("wild_pokemon");
				this.page.appendChild(div);
				
				
				//to build the containers for grass pokes and wild pokes
				var versions = ["ALL","RED","GREEN","BLUE","JAPAN","YELLOW"];
				var locations = ["grass","water"]
				
				/********************The Wild pokemon Versions Element***************/
				//to build the list for each version
				for(var j=0;j<locations.length;j++){
					//the containers
					var parent = newElement("div",{
						id : locations[j] + "_pokemon_container",
						text : locations[j].charAt(0).toUpperCase() + locations[j].slice(1) + " Pokemon",
						class : "wild_pokemon_container"
					},
					this.page);
					
					var br = document.createElement("br");
					parent.appendChild(br);
					
					elements.containers[locations[j] + "_pokemon"] = parent;
				
					/*************The Wild pokemon List Element*******************/
					for(var i=0;i<versions.length;i++){
						//the containers for each individual version
						var div = newElement("div",{
							id : versions[i] + "_" + locations[j] + "_container",
							text : versions[i],
							class : "wild_pokemon_list",
							version : versions[i]
						},
						parent);
						
						var br = document.createElement("br");
						div.appendChild(br);

						elements.containers[versions[i] + "_" + locations[j]] = div;
					
						var input = newElement("input",{
							type : "number",
							min : 0,
							max : 255,
							class : "catch_rate",
							id : versions[i] + "_" + locations[j] + "_catch_rate",
							version : versions[i],
							location : locations[j],
						},
						div);
						elements.fields[versions[i] + "_" + locations[j] + "_catch_rate"] = input;
						input.addEventListener("input",function(){
							var version = this.getAttribute("version");
							var location = this.getAttribute("location");
							//see if the input if a not number
							if(this.validity.badInput){
								this.value = current_data.wild_pokemon.data[version.toLowerCase()][location + "_rate"];
							}
							//if the number is below 0 or empty, set to 0
							else {
								if(this.value < 0 || this.value == ''){
									this.value = 0;
								}
								//if the number exceed 255, set to 255
								else if(this.value > 255){
									this.value = 255;
								}
								updateCatchRate(version,location,this.value);
							}
						});
						
						var text = document.createTextNode("Catch Rate");
						div.appendChild(text);
							
						var br = document.createElement("br");
						div.appendChild(br);
						
						//the list for each individual version
						for(var k = 0;k<10;k++){
							var input = newElement("input",{
								type : "number",
								min : 0,
								max : 255,
								class : "level",
								id : versions[i] + "_" + locations[j] + "_level_" + k,
								version : versions[i],
								location : locations[j],
								which : k,
							},
							div);
							elements.fields[versions[i] + "_" + locations[j] + "_level_" + k] = input;
							input.addEventListener("input",function(){
								var version = this.getAttribute("version");
								var location = this.getAttribute("location");
								var which = this.getAttribute("which");
								//see if the input if a not number
								if(this.validity.badInput){
									//if so, reset the value
									this.value = current_data.wild_pokemon.data[version.toLowerCase()][location + "_pokemon"][parseInt(which)][0];
								}
								//if the number is below 0 or empty, set to 0
								else {
									if(this.value < 0 || this.value == ''){
										this.value = 0;
									}
									//if the number exceed 255, set to 255
									else if(this.value > 255){
										this.value = 255;
									}
									updateWildLevel(version,location,which,this.value);
								}
							});
													
							var input = createSelectFromList(data.lists.pokemon,0);
							input.setAttribute("version",versions[i]);
							input.setAttribute("location",locations[j]);
							input.setAttribute("which",k);
							input.className = "pokemon";
							input.addEventListener("change",function(){
								var version = this.getAttribute("version");
								var location = this.getAttribute("location");
								var which = this.getAttribute("which");
								updateWildPokemon(version,location,which,this.value);
							});
							input.id = versions[i] + "_" + locations[j] + "_pokemon_" + k;
							elements.fields[versions[i] + "_" + locations[j] + "_pokemon_" + k] = input;
							div.appendChild(input);
							
							var br = document.createElement("br");
							div.appendChild(br);
						}
					}
				}
			};
			
			//pokemon.refresh
			this.refresh = function(){
				elements.tabs.pokemon.setAttribute("state","active");		
				
				elements.fields.wild_pokemon_list.selectedIndex = getSortedPointerIndex(data.pointers.wild_pokemon,1,current_data.wild_pokemon.name);
				var sr_index = getSortedPointerIndex(data.pointers.super_rod_data,1,current_data.super_rod_data.name);
				if(sr_index == -1){
					sr_index = data.pointers.super_rod_data.length;
				}
				elements.fields.super_rod_list.selectedIndex = sr_index;
				
				wp_data = current_data.wild_pokemon.data;
				
				var locs = ["grass","water"];
				
				//temp data to see if the "all" options can be set
				var arrays = {
					water_catch_rate : [],
					water_pokemon : [],
					water_levels : [],
					grass_catch_rate : [],
					grass_pokemon : [],
					grass_levels : [],
				}
				
				//to update the wild pokemon data
				for(var v in wp_data){
					for(var i=0;i<locs.length;i++){
						var version = v.toUpperCase();
						var rate = wp_data[v][locs[i] + "_rate"];
						elements.fields[version + "_" + locs[i] + "_catch_rate"].value = rate;
						
						//if the array is empty, then add this to the array. otherwise, compare
						if(arrays[locs[i] + "_catch_rate"].length == 0){
							arrays[locs[i] + "_catch_rate"] = [rate,true];
						}
						//if the second element is already false, then ignore, otherwise compare
						else if(arrays[locs[i] + "_catch_rate"][1]){
							//set the second element to true/false depending on if the rates match
							arrays[locs[i] + "_catch_rate"][1] = rate == arrays[locs[i] + "_catch_rate"][0];
						}
						
						if(wp_data[v][locs[i] + "_rate"] == 0){
							//clear out the pokemon and level
							for(var j=0;j<10;j++){
								elements.fields[version + "_" + locs[i] + "_level_" + j].disabled = true;
								elements.fields[version + "_" + locs[i] + "_level_" + j].value = 0;
								elements.fields[version + "_" + locs[i] + "_pokemon_" + j].disabled = true;
								elements.fields[version + "_" + locs[i] + "_pokemon_" + j].selectedIndex = 0;
								var pokemon = getIndexInSorted(data.lists.pokemon,0);
								
								//if the pokemon array hasn't been filled yet, then fill it
								if(j >= arrays[locs[i] + "_pokemon"].length){
									arrays[locs[i] + "_pokemon"].push([pokemon,true])
									arrays[locs[i] + "_levels"].push([0,true])
								}
								//if the second element is already false, then ignore, otherwise compare
								else {
									if(arrays[locs[i] + "_pokemon"][j][1]){
										//set the second element to true/false depending on if the rates match
										arrays[locs[i] + "_pokemon"][j][1] = (pokemon == arrays[locs[i] + "_pokemon"][j][0]);
									}
									if(arrays[locs[i] + "_levels"][j][1]){
										//set the second element to true/false depending on if the rates match
										arrays[locs[i] + "_levels"][j][1] = (0 == arrays[locs[i] + "_levels"][j][0]);
									}
								}
								
							}
						}
						else{
							//load the pokemon and level
							for(var j=0;j<10;j++){
								elements.fields[version + "_" + locs[i] + "_level_" + j].disabled = false;
								var level = wp_data[v][locs[i] + "_pokemon"][j][0];
								elements.fields[version + "_" + locs[i] + "_level_" + j].value = level;
								elements.fields[version + "_" + locs[i] + "_pokemon_" + j].disabled = false;
								var pokemon = getSortedIndex(data.lists.pokemon,wp_data[v][locs[i] + "_pokemon"][j][1]);
								elements.fields[version + "_" + locs[i] + "_pokemon_" + j].selectedIndex = pokemon;
							
								//if the pokemon array hasn't been filled yet, then fill it
								if(j >= arrays[locs[i] + "_pokemon"].length){
									arrays[locs[i] + "_pokemon"].push([pokemon,true]);
									arrays[locs[i] + "_levels"].push([level,true])
								}
								//if the second element is already false, then ignore, otherwise compare
								else {
									if(arrays[locs[i] + "_pokemon"][j][1]){
										//set the second element to true/false depending on if the rates match
										arrays[locs[i] + "_pokemon"][j][1] = (pokemon == arrays[locs[i] + "_pokemon"][j][0]);
									}
									if(arrays[locs[i] + "_levels"][j][1]){
										//set the second element to true/false depending on if the rates match
										arrays[locs[i] + "_levels"][j][1] = (level == arrays[locs[i] + "_levels"][j][0]);
									}
								}
							
							}
						}
					}
				}
				
				//to set the "ALL" data
				current_data.wild_pokemon.data.all = {};
				
				for(var i=0;i<locs.length;i++){
					var arr = arrays[locs[i] + "_catch_rate"];
					if(arr[1]){
						elements.fields["ALL_" + locs[i] + "_catch_rate"].value = arr[0];
						current_data.wild_pokemon.data.all[locs[i] + "_rate"] = arr[0];
						elements.fields["ALL_" + locs[i] + "_catch_rate"].setAttribute("green","on");
					}
					else{
						elements.fields["ALL_" + locs[i] + "_catch_rate"].value = 0;
						current_data.wild_pokemon.data.all[locs[i] + "_rate"] = 0;
						elements.fields["ALL_" + locs[i] + "_catch_rate"].setAttribute("green","off");
					}
					current_data.wild_pokemon.data.all[locs[i] + "_pokemon"] = []
					for(var j=0;j<10;j++){
						arr = arrays[locs[i] + "_pokemon"][j];
						current_data.wild_pokemon.data.all[locs[i] + "_pokemon"].push([0,getIndexInSorted(data.lists.pokemon,0)]);
						//if the value is true for all, then update
						if(arr[1]){
							elements.fields["ALL_" + locs[i] + "_pokemon_" + j].selectedIndex = arr[0];
							current_data.wild_pokemon.data.all[locs[i] + "_pokemon"][j][1] = arr[0];
							elements.fields["ALL_" + locs[i] + "_pokemon_" + j].setAttribute("green","on");
						}
						//otherwise, set to zero
						else{
							elements.fields["ALL_" + locs[i] + "_pokemon_" + j].selectedIndex = 0;
							elements.fields["ALL_" + locs[i] + "_pokemon_" + j].setAttribute("green","off");
						}
						
						arr = arrays[locs[i] + "_levels"][j];
						//if the value is true for all, then update
						if(arr[1]){
							elements.fields["ALL_" + locs[i] + "_level_" + j].value = arr[0];
							current_data.wild_pokemon.data.all[locs[i] + "_pokemon"][j][0] = arr[0];
							elements.fields["ALL_" + locs[i] + "_level_" + j].setAttribute("green","on");
						}
						//otherwise, set to zero
						else{
							elements.fields["ALL_" + locs[i] + "_level_" + j].value = 0;
							elements.fields["ALL_" + locs[i] + "_level_" + j].setAttribute("green","off");
						}
					}
				}
			},
			
			//pokemon.onshow
			this.onShow = function(){};
			
			this.onHide = function(){};
		},
		tileset : new function(){
			//tileset.build
			this.build = function(){
				/*****************Current tileset Selection Element**************/
				//the container for the current tileset
				var div = newElement("div",{
					id : "current_tileset_container",
					text : "Tileset: "
				},
				this.page);
				
				//create the tileset dropdown
				var input = createSelectFromList(data.lists.tilesets,0);
				input.id = "tileset_selection";
				elements.fields.tileset = input;
				input.addEventListener("change",function(){
					setModified("map_header");
					change("tileset",{tset : this.options[this.selectedIndex].value});
				})
				div.appendChild(input);
				
				//create the gfx dropdown
				var div = newElement("div",{
					id : "tileset_gfx_container",
					text : "GFX: "
				},
				this.page);
				
				var input = createSelectFromList(data.lists.tileset_gfx,0);
				input.id = "tileset_gfx_selection";
				elements.fields.tileset_gfx = input;
				input.addEventListener("change",function(){
					setModified("tileset_gfx");
					//reload the tileset with new gfx
					load("tileset",{tset : current_data.tileset.name,gfx_index : this.selectedIndex},true);
				})
				div.appendChild(input);
				
				//create the location dropdown
				var div = newElement("div",{
					id : "tileset_location_container",
					text : "Location: "
				},
				this.page);
				
				var input = newElement("select",{
					id : "tileset_location_selection",
				},
				this.page);
				
				var option = newElement("option",{
					value : "INDOOR",
					text : "Indoor",
				},
				input);
				var option = newElement("option",{
					value : "CAVE",
					text : "Cave",
				},
				input);
				var option = newElement("option",{
					value : "OUTDOOR",
					text : "Outdoor",
				},
				input);
				
				elements.fields.tileset_location = input;
				input.addEventListener("change",function(){
					setModified("tileset_header");
					current_data.tileset.location = this.options[this.selectedIndex].value
				})
				div.appendChild(input);
				
				/*****************tileset map Element****************/
				//to create the tileset map container
				var div = newElement("div",{
					id : "tileset_map",
				},
				this.page);
				elements.containers.tileset_map = div;
				
				/*****************tileset Size Element****************/
				//draw "tileset size" container
				var div = newElement("div",{
					id : "tileset_size_container",
					text : "Size:"
				},
				this.page);
				elements.containers.tileset_size = div;
				createPlusMinus("tileset_size",1,div);			
				
				
				/*******************tileset Sub Tabs Element*******************/
				//create the tabs
				var tab_list = ["Block","Counters","Grass","Collision","Doors","Warps","Bookshelves","Ledges","Pairs","Lists"];
				createSubTabs("tileset",tab_list);
				changeSubTab("tileset","Block");
				
				var parent = elements.sub_pages.tileset.Block;
				
				/*******************Edit Block Element********************/
				//to create the Edit Block container
				var div = newElement("div",{
					id : "edit_block_container",
				},
				parent);
				elements.containers.edit_block_container = div;
				
				/****************Current Block ID**************************/
				//to create the current block ID container:
				var div = newElement("div",{
					id : "current_block_id",
				},
				parent);
				elements.containers.current_block_id = div;
				
				/********************Current Tile Element******************/
				//to create the Current Tile container
				var div = newElement("div",{
					id : "current_tile_container",
				},
				parent);
				elements.containers.current_tile = div;
				
				//to create the current tile label
				var div = newElement("div",{
					id : "current_tile_label",
					text : "Current Tile: "
				},
				parent);
				elements.containers.current_tile_label = div;
				
				/**************Show Tile Borders Element**************/
				//draw the "Show Tile Borders" button
				var div = newElement("div",{
					id : "toggle_tile_borders",
					text : "Toggle Tile Borders",
					class : "button",
					state : "active"
				},
				parent);
				div.addEventListener("click",function(){
					toggleTileGrid();
				});
				elements.buttons.toggle_tile_borders = div;
				
				/**************Duplicate Block Element**************/
				//draw the "Duplicate Block" button
				var div = newElement("div",{
					id : "duplicate_block",
					text : "Duplicate Block",
					class : "button",
					state : "active"
				},
				parent);
				div.addEventListener("click",function(){
					duplicateBlock(currentBlock);
				});
				elements.buttons.duplicateBlock = div;
				
				/****************Save as New Tileset Blocks Element*******************/
				//create the "Save as New Tileset Blocks" container
				var div = createSaveAsNew("tileset_blocks");
				parent.appendChild(div);
				
				/*************Save as New Tileset Collision Element*******************/
				//create the "Save as New Tileset Collision" container
				var div = createSaveAsNew("tileset_collision");
				elements.sub_pages.tileset.Collision.appendChild(div);
				
				/**************Save as New Tileset Door Tiles Element**************/
				var div = createSaveAsNew("tileset_door_tiles");
				elements.sub_pages.tileset.Doors.appendChild(div);
				
				/**************Save as New Tileset Warp Tiles Element**************/
				var div = createSaveAsNew("tileset_warp_tiles");
				elements.sub_pages.tileset.Warps.appendChild(div);
				
				/******************Tilelist Elements******************/
				//create the tile lists (and ignore the last two)
				for(var i=1;i<(tab_list.length - 2);i++){
					var name = tab_list[i];
					var div = newElement("div",{
						id : name + "_tile_list",
						class : "tile_list"
					},
					elements.sub_pages.tileset[name]);
					elements.containers[name + "_tile_list"] = div;
				}
				
				/********Tile Collision Pairs Elements***********/
				drawTileCollisionContainers();
				
				/******************Grass Tile Info Element*************/
				var div = newElement("div",{
						id : "grass_list_info",
						text : "Only 1 Tile Permitted",
						class : "tile_list_info"
					},
					elements.sub_pages.tileset.Grass);
				
				/*************Counter Tiles Info Element**************/
				var div = newElement("div",{
						id : "counters_list_info",
						text : "Only 3 Tiles Permitted",
						class : "tile_list_info"
					},
					elements.sub_pages.tileset.Counters);
					
				/*************Tileset List Elements********************/
				var checkbox_lists = {
					bike_riding : "Allow Bike Riding?",
					water : "Has Water?",
					escape_rope : "Allow Escape Rope?",
					dungeon : "Is Dungeon?"
				};
				
				for(var list in checkbox_lists){
					var parent = newElement("div",{
							id : "tileset_list_" + list,
							class : "tileset_list_container"
						},
						elements.sub_pages.tileset.Lists);
					elements.containers["tileset_list_" + list] = parent;
						
					var div = newElement("input",{
							type : "checkbox",
							id : "tileset_list_checkbox_" + list,
							which : list,
						},
						parent);
					div.addEventListener("click",function(){
						toggleTilesetList(this.getAttribute("which"));
					});
					elements.fields["tileset_list_" + list] = div;
					
					var text = document.createTextNode(checkbox_lists[list])
					parent.appendChild(text)
				}
				
			};
			
			//tileset.refresh
			this.refresh = function(update_gfx){
				elements.tabs.tileset.setAttribute("state","active");	
				
				elements.fields.tileset.selectedIndex = getSortedIndex(data.lists.tilesets,current_data.tileset.name);
				
				//to set the "location" selected index
				locs = ["INDOOR","CAVE","OUTDOOR"];
				var index = locs.indexOf(current_data.tileset.location);
				//if the index was -1, then convert the "location" to an int
				if(index == -1){
					index = parseInt(current_data.tileset.location)
				};
				elements.fields.tileset_location.selectedIndex = index;
				
				//to set the gfx selected index (if we did not just update the gfx)
				if(!update_gfx){
					var gfx = getFromPointerList("tileset_gfx",current_data.tileset.gfx,1).split("/").pop();
					elements.fields.tileset_gfx.selectedIndex = getSortedIndex(data.lists.tileset_gfx,gfx);
				}
				
				elements.containers.tileset_size.innerHTML = current_data.tileset_blocks.length;
				
				//to fill the tile lists
				updateTileList("Counters");
				updateTileList("Grass");
				updateTileList("Collision");
				updateTileList("Warps");
				updateTileList("Doors");
				updateTileList("Bookshelves");
				updateTileList("Ledges");
				updateTileList("Pairs");
				
				//to update the tileset lists checkbox
				elements.fields.tileset_list_water.checked = current_data.tileset.water;
				elements.fields.tileset_list_dungeon.checked = current_data.tileset.dungeon;
				elements.fields.tileset_list_bike_riding.checked = current_data.tileset.bike_riding;
				elements.fields.tileset_list_escape_rope.checked = current_data.tileset.escape_rope;
				
			},
			
			//tileset.onshow
			this.onShow = function(){
				elements.pages.tileset.appendChild(elements.containers.tileset_blocks);
				elements.containers.tileset_blocks.setAttribute("page","tileset");
				
				elements.containers.edit_block_container.appendChild(elements.containers.current_block)
				elements.containers.current_block.setAttribute("page","tileset");

				setTileGrid(elements.containers.current_block,tile_grid);
				
				var tile_list = elements.containers.tileset_map.getElementsByClassName("tile");
				//turn off the highlight for every tile in the tilemap
				for(var i=0;i<tile_list.length;i++){
					tile_list[i].setAttribute("highlight","off");
				}
				
				//update the current subtab
				for(var each in elements.sub_tabs.tileset){
					if(elements.sub_tabs.tileset[each].getAttribute("state") == "current"){
						onShowSubTab.tileset(each);
					}
				}
				
			};
			
			//tileset.onhide
			this.onHide = function(){
				hideTilePairTab();
			};
		},
		sprites : new function(){
			//contains the elements on this page
			this.elements = {};
			
			this.build = function(){};
			
			//sprites.refresh
			this.refresh = function(){
				elements.tabs.sprites.setAttribute("state","active");			
			},
			
			this.onShow = function(){};
			
			this.onHide = function(){};
		},
	};	
	/*******************************************************************
	This holds constants for this editor
	*********************************************************************/
	var currentTab = 'map';
	var currentScale = 'default';
	var map_borders = "off";
	var tile_grid = "off";
	var currentBlock = 0;
	var current_tile = 0;
	var mouse_down = '';
	var allow_filename = false;
	var save_data_key = ''
	
	//to convert the scale from text to a value
	var scale_convert = {
		half : 1,
		default : 2,
		plus_half : 3,
		double : 4
	};
	
	//this holds the data that is loaded and being modified
	var current_data = {};
	this.current_data = current_data;
		
	//contains all of the HTML DOM elements within the GUI
	var elements = {
		tabs : {},
		pages : {},
		fields : {},
		buttons : {},
		containers : {},
		windows : {},
		labels : {},
		sub_tabs : {},
		sub_pages : {}
	};
	
	//contains the new file names (for saving new files)
	var new_files = {
		map_blocks : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Map Blocks",
			src : "getSharedPointers(each,current_data.map.header.blocks)",
			alert : false,
			shared_array : [],
			tab : 'map',
			also_modify : [],
		},
		tileset_blocks : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Tileset Blocks",
			src : "getSharedPointers(each,current_data.tileset.blocks)",
			alert : false,
			shared_array : [],
			tab : 'tileset',
			also_modify : [],
		},
		tileset_collision : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Tileset Collision",
			src : "getSharedPointers(each,current_data.tileset.collision)",
			alert : false,
			shared_array : [],
			tab : 'tileset',
			also_modify : [],
		},
		tileset_door_tiles : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Tileset Door Tiles",
			src : "getSharedPointers(each,current_data.tileset.name)",
			alert : false,
			shared_array : [],
			tab : 'tileset',
			also_modify : [],
		},
		tileset_warp_tiles : {
			save_new : false,
			new_name : false,
			file_name : '',
			title : "Tileset Warp Tiles",
			src : "getSharedPointers(each,current_data.tileset.warp_tiles)",
			alert : false,
			shared_array : [],
			tab : 'tileset',
			also_modify : [],
		},
		wild_pokemon : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Wild Pokemon",
			src : "removeFromArray(getIndexInPointerList('wild_pokemon',current_data.wild_pokemon.name,0),current_data.map.name)",
			alert : false,
			shared_array : [],
			tab : 'pokemon',
			also_modify : ["map_pokemon"],
		},
		super_rod_data : {
			save_new : false,
			new_name : true,
			file_name : '',
			title : "Super Rod Data",
			src : "removeFromArray(getIndexInPointerList('super_rod_data',current_data.super_rod_data.name,0),current_data.map.name)",
			alert : false,
			shared_array : [],
			tab : 'pokemon',
			also_modify : ["map_super_rod_name"],
		},
	};
	this.new_files = new_files;
	
	//contains the connection data (needs to be separate because these values need to be known, but not stored as part of the current data unless it is toggled on)
	var connections_data = {
		NORTH : {},
		SOUTH : {},
		EAST : {},
		WEST : {},
	};
	
	//contains information about the current tile pair we are editing/viewing and the tiles that are currently highlighted
	var tile_pair_settings = {
		editing : false,
		view_element : '',
		which_list : '',
		viewing : 0,
		tile_list : [],
	};
	this.tile_pair_settings = tile_pair_settings;
	/**************************************************************
	These are callbacks, functions to run when other functions finish
	**************************************************************/
	//callback functions:
	var callback_functions = {
		load_tileset : [],
		load_wild_pokemon : [],
		load_super_rod_data : [],
		load_map : [],
		save_map : [],
		save_wild_pokemon : [],
		save_super_rod_data : [],
		save_tileset : []
	};
	this.callbacks = callback_functions
	
	//to run a callback and then clear it
	function callback(id){
	
		var list = callback_functions[id];
		//get each function in the array and run it
		while(list.length > 0){
			var f = list.splice(0,1);
			f[0]();
		}
	};
	
	//to set a callback
	//if back is set to be true, then place at back.  otherwise, place at front
	function setCallback(id,f,back){
		if(back){
			callback_functions[id].push(f);
		}
		else{
			callback_functions[id].unshift(f);
		}
	};
	
	//to clear the given callbacks
	function clearCallback(id){
		callback_functions[id] = [];
	};
	/**************************************************************
	These are for saving the data
	**************************************************************/
	//this holds whether or not the given data has been modified or not
	var modified = {
		map_dimensions : false,
		map_blocks : false,
		map_header : false,
		map_super_rod_name : false,
		tileset_blocks : false,
		tileset_collision : false,
		tileset_door_tiles : false,
		tileset_warp_tiles : false,
		tileset_ledges : false,
		tileset_bookshelves : false,
		tileset_water_pairs : false,
		tileset_land_pairs : false,
		tileset_list_water : false,
		tileset_list_dungeon : false,
		tileset_list_bike_riding : false,
		tileset_list_escape_rope : false,
		tileset_header : false,
		tileset_gfx : false,
		map_pokemon : false,
		wild_pokemon : false,
		super_rod_data : false,
	};
	
	//functions to update the internal data for each type of data
	var updateInternalData = {
		map_dimensions : function(){
			//initialize the return object
			ret_obj = {}
		
			//if the "save as new blocks" is checked:
			if(new_files.map_blocks.save_new){
				var height_name = current_data.map.header.height;
				var width_name = current_data.map.header.width;
						
				var height_index = getFromList("map_dimensions",height_name);
				var width_index = getFromList("map_dimensions",width_name);
						
				data.lists.map_dimensions[height_index][1] = current_data.dimensions.height;
				data.lists.map_dimensions[width_index][1] = current_data.dimensions.width;
				
				ret_obj[height_name] = current_data.dimensions.height;
				ret_obj[width_name] = current_data.dimensions.width
				
			}
			else{
				//get the array that lists all of the blocks that use this blocklist
				var arr = getFromPointerList("map_blocks",current_data.map.header.blocks,0).slice();
				//check each map
				for(var each in data.maps){
					//if the blocks for this map are in the array of maps using these blocks
					if(arr.indexOf(data.maps[each].header.blocks) > -1){
						var height_name = data.maps[each].header.height;
						var width_name = data.maps[each].header.width;
						
						var height_index = getFromList("map_dimensions",height_name);
						var width_index = getFromList("map_dimensions",width_name);
						
						data.lists.map_dimensions[height_index][1] = current_data.dimensions.height;
						data.lists.map_dimensions[width_index][1] = current_data.dimensions.width;
						
						ret_obj[height_name] = current_data.dimensions.height;
						ret_obj[width_name] = current_data.dimensions.width
					}
				}
			}
			//return the map dimension list to save
			return {
				data : ret_obj,
				data_names : ["Map Dimensions"],
			}
				
		},
		map_blocks : function(){
			var map_blocks_name = current_data.map.header.blocks;
			var new_value = current_data.map_blocks.slice();
			saveToPointerList("map_blocks",map_blocks_name,new_value);
			
			//return the data
			return {
				data : new_value,
				path : getFromPointerList("map_blocks",map_blocks_name,1),
				data_names : [map_blocks_name + " (Map Blocks)"],
				save_as_new : new_files.map_blocks.save_new
			}
			
		},
		map_header : function(){
			current_data.map.header.tileset = current_data.tileset.name;
			//initialize the return data object
			var ret_data = {}
			var data_names = [current_data.map.header.name + " (Map Header)"]
			var con = {};
			for(var each in connections_data){
				if(connections_data[each].enabled){
					con[each] = {};
					
					var map_name = connections_data[each].map
					
					var size = "height";
					if(each == "NORTH" || each == "SOUTH"){
						var size = "width";
					}
					
					con[each].map = map_name;
					con[each].offset = connections_data[each].offset;
					con[each][size] = connections_data[each].size;
					con[each].movement = connections_data[each].movement;
					con[each].map_height = data.maps[map_name].header.height
					con[each].map_width = data.maps[map_name].header.width
					con[each].blocks = data.maps[map_name].header.blocks
					
					//if we apply this connection to the other map (and the other map is not THIS map)
					if(connections_data[each].apply_to_other && map_name != current_data.map.name){
						var dir = {};
						data_names.push(data.maps[map_name].header.name + " (Map Header)")
						dir.map = current_data.map.name;
						dir.map_height = current_data.map.header.height
						dir.map_width = current_data.map.header.width
						dir.blocks = current_data.map.header.blocks
						dir.offset = 0;
						//set the size to be the size of the the current map
						dir[size] = current_data.dimensions[size];
						//inverse the movement and combine with offset (since we set offset to zero)
						dir.movement = connections_data[each].offset - connections_data[each].movement;
					
						var other_map_size_name = data.maps[map_name].header[size];
						var other_map_size = getFromList("map_dimensions",other_map_size_name,1);
						
						//while the movement exceeds -3, then increase movement and offset
						while(dir.movement < -3){
							dir.movement++;
							dir.offset++;
							dir[size]--;
						}
						
						//if the movement + size exceeds the size of the other map by more than 3, then decrease size
						while((dir.movement + dir[size]) > (other_map_size + 3)){
							dir[size]--;
						}
					
						var dir_convert = {
							NORTH : "SOUTH",
							SOUTH : "NORTH",
							EAST : "WEST",
							WEST : "EAST"
						};
						var new_dir = dir_convert[each];
						
						data.maps[map_name].header.connections[new_dir] = dir;
						
						//add this map header to the "return data" object
						ret_data[map_name] = data.maps[map_name].header
						
					}
					
				};
			};
			
			current_data.map.header.connections = con;
			
			data.maps[current_data.map.name].header = JSON.parse(JSON.stringify(current_data.map.header));
			
			//add this map to the return data
			ret_data[current_data.map.name] = data.maps[current_data.map.name].header
			
			
			//to return the data to save
			return {
				data : ret_data,
				data_names : data_names,
			}
			
		},
		tileset_blocks : function(){
			var tset_blocks_name = current_data.tileset.blocks;
			var new_value = current_data.tileset_blocks.slice();
			saveToPointerList("tileset_blocks",tset_blocks_name,new_value);
			
			//return the data
			return {
				data : new_value,
				path : getFromPointerList("tileset_blocks",tset_blocks_name,1),
				data_names : [tset_blocks_name + " (Tileset Blocks)"],
				save_as_new : new_files.tileset_blocks.save_new
			}
		},
		tileset_collision : function(){
			var map_collision_name = current_data.tileset.collision;
			var new_value = current_data.collision.slice();
			saveToPointerList("tileset_collision",map_collision_name,new_value);
			
			//return the data
			return {
				data : new_value,
				path : getFromPointerList("tileset_collision",map_collision_name,1),
				data_names : [map_collision_name + " (Collision)"],
				save_as_new : new_files.tileset_collision.save_new
			}
		},
		tileset_door_tiles : function(){
			var door_tiles_name = getFromPointerList("tileset_door_tiles",current_data.tileset.name,1)
			//if we are saving a new name:
			if(new_files.tileset_door_tiles.save_new){
				door_tiles_name = new_files.tileset_door_tiles.file_name; 
			}
			var new_value = current_data.tiles.doors.slice();
			saveToPointerList("tileset_door_tiles",current_data.tileset.name,new_value);
						
			//return the data
			return {
				data : data.pointers["tileset_door_tiles"],
				data_names : [door_tiles_name + " (Door Tiles)"]
			}
		},
		tileset_warp_tiles : function(){
			var warp_tiles_name = current_data.tileset.warp_tiles;
			var new_value = current_data.tiles.warps.slice();
			saveToPointerList("tileset_warp_tiles",warp_tiles_name,new_value);
			
			number_tsets = data.lists.tilesets[data.lists.tilesets.length - 1][1]
			var tset_arr = new Array(number_tsets)
			
			for(var tset in data.tilesets){
				index = data.tilesets[tset].id;
				warps = data.tilesets[tset].warp_tiles;
				tset_arr[index] = warps
			}
			
			//return the data
			return {
				data : {
					tilesets: tset_arr,
					warps : data.pointers["tileset_warp_tiles"],
				},
				data_names : [warp_tiles_name + " (Warp Tiles)"]
			}
		},
		tileset_list_water : function(){
			data.tilesets[current_data.tileset.name].water = current_data.tileset.water;
			
			//return the data
			return {
				data : createTilesetList("water"),
				data_names : ["Water Tileset List"],
			}
		},
		tileset_list_bike_riding : function(){
			data.tilesets[current_data.tileset.name].bike_riding = current_data.tileset.bike_riding;
			
			//return the data
			return {
				data : createTilesetList("bike_riding"),
				data_names : ["Bike Riding Tileset List"],
			}
		},
		tileset_list_dungeon : function(){
			data.tilesets[current_data.tileset.name].dungeon = current_data.tileset.dungeon;
			//return the data
			return {
				data : createTilesetList("dungeon"),
				data_names : ["Dungeon Tileset List"],
			}
		},
		tileset_list_escape_rope : function(){
			data.tilesets[current_data.tileset.name].escape_rope = current_data.tileset.escape_rope;
			//return the data
			return {
				data : createTilesetList("escape_rope"),
				data_names : ["Escape Rope Tileset List"],
			}
		},
		tileset_ledges : function(){
			data.tilesets[current_data.tileset.name].ledges = current_data.tileset.ledges.slice();
			
			//return the data
			return {
				data : return_data = collectTilelistData("ledges"),
				data_names : ["Ledge Tiles"],
			}
		},
		tileset_bookshelves : function(){
			data.tilesets[current_data.tileset.name].bookshelf_tiles = current_data.tileset.bookshelf_tiles.slice();
						
			//return the data
			return {
				data : collectTilelistData("bookshelf_tiles"),
				data_names : ["Bookshelf Tiles"],
			}
		},
		tileset_water_pairs : function(){
			data.tilesets[current_data.tileset.name].tile_pair_collision_water = current_data.tileset.tile_pair_collision_water.slice();			
			//return the data
			return {
				data : collectTilelistData("tile_pair_collision_water"),
				data_names : ["Water Tile Pair Collisions"],
			}
		},
		tileset_land_pairs : function(){
			data.tilesets[current_data.tileset.name].tile_pair_collision_land = current_data.tileset.tile_pair_collision_land.slice();			
			//return the data
			return {
				data : collectTilelistData("tile_pair_collision_land"),
				data_names : ["Land Tile Pair Collisions"],
			}
		},
		tileset_header : function(){
			tset = data.tilesets[current_data.tileset.name];
			tset.grass = current_data.tileset.grass;
			tset.counter1 = current_data.tileset.counter1;
			tset.counter2 = current_data.tileset.counter2;
			tset.counter3 = current_data.tileset.counter3;
			tset.location = current_data.tileset.location;
		
			return {
				data : data.tilesets[current_data.tileset.name],
				data_names : ["Tileset Header"],
			}
		},
		tileset_gfx : function(){
			var ptr = current_data.tileset.gfx;
			var path_name = elements.fields.tileset_gfx.options[elements.fields.tileset_gfx.selectedIndex].value;
			var path = getFromList("tileset_gfx",path_name,1);
			
			//to remove this ptr from the original pointer list
			var arr = getFromPointerList("tileset_gfx",ptr,0);
			var src = getFromPointerList("tileset_gfx",ptr,2);
			var shared_arr = [];
			
			//if this array only contains this png:
			if(arr.length == 1){
				var index = getFromPointerList("tileset_gfx",ptr);
				var new_index = getIndexInPointerList("tileset_gfx",path);
				//if the path does not appear elsewhere, then just update this path
				if(new_index === false){
					data.pointers.tileset_gfx[index][1] = path;
				}
				//otherwise, remove old list and arr this name to the new list
				else{
					shared_arr = data.pointers.tileset_gfx[new_index][0].slice();
					data.pointers.tileset_gfx[new_index][0].push(ptr);
					data.pointers.tileset_gfx.splice(index,1);
				}
			}
			else{
				//remove this ptr from the array
				arr.splice(arr.indexOf(ptr),1);
				//find the new array and append
				var index = getIndexInPointerList("tileset_gfx",path);
				//if no array was found, then add new one
				if(index === false){
					data.pointers.tileset_gfx.push([[ptr],path,src]);
				}
				else{
					shared_arr = data.pointers.tileset_gfx[index][0].slice();
					data.pointers.tileset_gfx[index][0].push(ptr);
				}
			}
			
			return {
				data : {
					image_path : path,
					shared_pointers : shared_arr,
					pointer : ptr,
				},
				path : getFromPointerList("tileset_gfx",ptr,2),
				data_names : ["Tileset GFX"],
			}
		},
		map_pokemon : function(){
			
			var name = current_data.wild_pokemon.name;
			var old_name = getFromPointerList("wild_pokemon",current_data.map.name,1);
			
			//if we saved a new name
			if(new_files.wild_pokemon.save_new){
				//get the new name
				var name = new_files.wild_pokemon.file_name;
			}
			
			
			//only update the internal data if the name is different from the old name
			if(name != old_name){
				//remove this map from the old list
				var arr = getFromPointerList("wild_pokemon",current_data.map.name,0);
				var index = getFromPointerList("wild_pokemon",current_data.map.name);
				var file = getFromPointerList("wild_pokemon",current_data.map.name,2);
				var list = elements.fields.wild_pokemon_list;
				arr.splice(arr.indexOf(current_data.map.name),1);
				
				var delete_info = {
					delete_check : false,
					pointer : old_name,
					path : file,
				};
				
				//if this is empty, then remove
				if(arr.length == 0){
					delete_info.delete_check = true;
				
					//to remove from the dropdown list
					var list_index = getSortedPointerIndex(data.pointers.wild_pokemon,1,old_name);
					var option = list.childNodes[list_index];
					list.removeChild(option);
					
					delete data.wild_pokemon[old_name];
					
					data.pointers.wild_pokemon.splice(index,1);
				}
				
				//if we saved a new name
				if(new_files.wild_pokemon.save_new){					
					//add a new element to the list
					var arr = [[current_data.map.name],name,file];
					data.pointers.wild_pokemon.push(arr);
					
					//to add new element to dropdown
					var option = document.createElement("option");
					option.value = name;
					var text = document.createTextNode(name);
					option.appendChild(text);
					
					index = getSortedPointerIndex(data.pointers.wild_pokemon,1,name);
					list.insertBefore(option,list.childNodes[index]);
					list.selectedIndex = index;
				}
				else{
					//add this map to the new list
					var arr = getIndexInPointerList("wild_pokemon",name,0);
					arr.push(current_data.map.name);
				}
			}
		
			return {
				data : {
					name : name,
					id : current_data.map.id,
					delete_info : delete_info,
				},
				data_names : ["Wild Pokemon Names"],
			}
		},
		wild_pokemon : function(){
			var name = current_data.wild_pokemon.name;
			var list_name = name;
			var file = getIndexInPointerList("wild_pokemon",name,2);
			
			var new_data = {
				japan : {},
				yellow : {},
				red : {},
				blue : {},
				green : {},
			};
			
			//to copy the data
			for(var v in new_data){
				new_data[v] = JSON.parse(JSON.stringify(current_data.wild_pokemon.data[v]));
			}
				
			var ret_data = {
				pokemon : new_data,
				save_as_new : new_files.wild_pokemon.save_new,
			};
			
			//if we saved a new name
			if(new_files.wild_pokemon.save_new){
				//get the new name
				var new_name = new_files.wild_pokemon.file_name;
				list_name = new_name;
				ret_data.new_name = new_name;
				
				current_data.wild_pokemon.name = new_name;
			}
			
			data.wild_pokemon[list_name] = new_data
			
			return {
				data : ret_data,
				path : file,
				pointer : name,
				data_names : [list_name + " (Wild Pokemon Data)"],
			}
		},
		map_super_rod_name : function(){
		
			var name = current_data.super_rod_data.name;
			var old_name = getFromPointerList("super_rod_data",current_data.map.name,1);
			
			//if we saved a new name
			if(new_files.super_rod_data.save_new){
				//get the new name
				var name = new_files.super_rod_data.file_name;
			}
			
			
			//only update the internal data if the name is different from the old name
			if(name != old_name){
				var list = elements.fields.super_rod_list;
				
				//remove this map from the old list (if old_name isn't false)
				if(old_name !== false){
					var arr = getFromPointerList("super_rod_data",current_data.map.name,0);
					var index = getFromPointerList("super_rod_data",current_data.map.name);
					arr.splice(arr.indexOf(current_data.map.name),1);
					
					//if this is empty, then remove
					if(arr.length == 0){				
						//to remove from the dropdown list
						var list_index = getSortedPointerIndex(data.pointers.super_rod_data,1,old_name);
						var option = list.childNodes[list_index];
						list.removeChild(option);
						
						delete data.super_rod_data[old_name];
						
						data.pointers.super_rod_data.splice(index,1);
					}
				}
				
				//if we saved a new name
				if(new_files.super_rod_data.save_new){					
					//add a new element to the list
					var arr = [[current_data.map.name],name];
					data.pointers.super_rod_data.push(arr);
					
					//to add new element to dropdown
					var option = document.createElement("option");
					option.value = name;
					var text = document.createTextNode(name);
					option.appendChild(text);
					
					index = getSortedPointerIndex(data.pointers.super_rod_data,1,name);
					list.insertBefore(option,list.childNodes[index]);
					list.selectedIndex = index;
				}
				//add it to the new list if the new name is "None"
				else if(name != "None"){
					//add this map to the new list
					var arr = getIndexInPointerList("super_rod_data",name,0);
					arr.push(current_data.map.name);
				}
			}
		
			return {
				data : data.pointers.super_rod_data,
				data_names : ["Super Rod Map List"],
			}
		},
		super_rod_data : function(){
			var name = current_data.super_rod_data.name;
			var og_name = name
			
			//if the og name is none, then set it to be the first name in the list
			if(og_name == "None"){
				og_name = data.pointers.super_rod_data[0][1];
			}
			
			var sr_data = {};
			
			//if we saved a new name
			if(new_files.super_rod_data.save_new){
				//get the new name
				name = new_files.super_rod_data.file_name;
				sr_data.new_name = name;
				
				current_data.super_rod_data.name = name;
			}
			
			data.super_rod_data[name] = current_data.super_rod_data.data;
			sr_data.pokemon = data.super_rod_data[name];
			
			return {
				data : sr_data,
				pointer : og_name +":",
				save_as_new : new_files.super_rod_data.save_new,
				data_names : [name + " (Super Rod Data)"],
			};
		},
	};
	
	//to create a tileset list of the given name
	function createTilesetList(name){
		var return_arr = []
		//check each tileset
		for(var tset in data.tilesets){
			//if the value is of the list name for this tileset is true, add it to the return array
			if(data.tilesets[tset][name]){
				return_arr.push(tset)
			}
		}
		
		return return_arr
			
	};
	
	//to collect the data for the given tilelist
	function collectTilelistData(name){
		
		//collect the tset ledges data
		obj = {}
		for(var tset in data.tilesets){
			//see if any ledges exist. If so, add it to the object data
			if(data.tilesets[tset][name].length > 0){
				obj[tset] = data.tilesets[tset][name]
			}
		}
		return obj
	};
	
	//to update info saved in a pointers list
	function saveToPointerList(list,name,new_value){
		var list_index = getFromPointerList(list,name);
		//if this name exists in the list, then modify the list
		if(list_index !== false){
			//if the "save as new data" is checked:
			if(new_files[list].save_new){
				//to remove this name from the shared pointers array
				var arr = getSharedPointers(list,name);
				data.pointers[list][list_index][0] = arr;
								
				//to create the new pointer info and insert before the old array
				var new_arr = [];
				new_arr.push([name]);
				//only add a filename if the "new_name" attribute is set to true
				if(new_files[list].new_name){
					new_arr.push(new_files[list].file_name);
				}
				new_arr.push(new_value);
				data.pointers[list].splice(list_index,0,new_arr);
			}
			else{
				index = new_files[list].new_name ? 2 : 1;
				data.pointers[list][list_index][index] = new_value;
			}
		}
		//otherwise, add it
		else{var new_arr = [];
			new_arr.push([name]);
			//only add a filename if the "new_name" attribute is set to true
			if(new_files[list].new_name){
				new_arr.push(new_files[list].file_name);
			}
			new_arr.push(new_value);
			data.pointers[list].push(new_arr)
		}
	};
	
	//to reset the modified attributes to false
	//if id = map, then reset all of them. otherwise, only reset ones with the given keyword
	function resetModified(id){
		//to set all of the "modified" attributes to false
		for(var each in modified){
			if(id == "map" || each.indexOf(id) > -1){
				modified[each] = false;
			}
		}
		for(var each in new_files){
			if(id == "map" || each.indexOf(id) > -1){
				//reset the data for the "save as new files" data
				new_files[each].save_new = false;
				new_files[each].file_name = '';
				new_files[each].shared_array = [];
				new_files[each].alert = false;
			}
		}
		
		//to set the state of the save button to inactive
		if(id == "map"){
			elements.buttons.save.setAttribute("state","inactive");
		}
	};
	
	//to check to see if there are changes to the data
	//If the key is not "map", then it will only check properties that include the key word
	function checkForChanges(key){
		var ret = false;
		for(var each in modified){
			if(modified[each] && (key == "map" || each.indexOf(key) > -1)){
				ret = true;
			}
		}
		return ret;
	};
	
	//to set the modified data to true
	function setModified(id){
		modified[id] = true;
		elements.buttons.save.setAttribute("state","active");
		return true;
	};
	
	//to toggle if the file should be saved as new file or not
	function toggleNewFile(id){
		new_files[id].save_new = !(new_files[id].save_new);
		setModified(id);
		for(var i=0;i<new_files[id].also_modify.length;i++){
			setModified(new_files[id].also_modify[i]);
		}
		return true;
	};
	
	//to toggle if this map should be applied to other
	function toggleApplyToOther(dir){
		//only permit if it is enabled
		if(connections_data[dir].enabled){
			connections_data[dir].apply_to_other = !(connections_data[dir].apply_to_other);
			setModified("map_header");
			return true;
		}
		else {
			elements.fields[dir + "_apply_to_other"].checked = false;
			return false
		}
	};
		
	//to initiate the saving routine by checking to see if new files have to be created or not
	function save(type){
		var new_file = false;
		for(var each in new_files){
			//check to see if the save new is true, it gets a new name, it doesnt already have a name, and matched the input type
			if(new_files[each].save_new && new_files[each].new_name && new_files[each].file_name == '' && (type == "map" || new_files[each].tab == type)){
				new_file = true;
			}
		}
		//check to see if any new files have to be created
		if(new_file){
			//if so, display the popup and the callback function
			displayAlert("newFileNames",type);
		}
		else{
			//if not, then jump straight to "save files" function.
			saveData(type);
		}
	};
	
	//to save the data to files and internal data
	//if the key is not map, it will only save the data the contains that key word
	function saveData(key){
		data_to_save = {};
		list_to_save = [];
		
		//set the "save" callback to be "changeTab"
		setCallback("save_" + key,function(){
			changeTab(currentTab);
		});
	
		for(var each in modified){
			//for each set of data that was modified, update the internal data and then add the data to the "data to save" object
			if(modified[each] && (key == "map" || each.indexOf(key) > -1)){
				input = updateInternalData[each]();
				data_to_save[each] = input;
				list_to_save = list_to_save.concat(input["data_names"])
			}
		}
		//add the json data to save
		data_to_save.json = {
			data : data,
			path : data.params.directory + "/data.js",
			data_names : ["data.js"],
		};
			
		save_data_key = key;
		displayAlert("saving",list_to_save);
		saveToFile(data_to_save,list_to_save);

	};
	
	//to save the given data to the given file path (and in the given format, binary or text);
	function saveToFile(input,list){
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("POST","http://localhost:8000/" + data.params.directory + "/save.py");
		
		xmlhttp.setRequestHeader("Content-type", "application/json;charset=UTF-8");
		
		xmlhttp.send(JSON.stringify(input));
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState==4) {
				if(xmlhttp.status == 200){
					response = JSON.parse(xmlhttp.responseText);
					
					var box = elements.containers.alert_box_text;
					
					clearNodes(box)
					
					var br = document.createElement("br");
					box.appendChild(br)
					
					var text = document.createTextNode("Saving:");
					box.appendChild(text);
					var br = document.createElement("br");
					box.appendChild(br)
			
					for(var i=0;i<list.length;i++){
						var div = newElement("div",{
							text : "-" + list[i] + "..." + response[list[i]],
							class : "saving_text"
						},box)
					}
					
					var text = document.createTextNode("Done!");
					box.appendChild(text);
					
					addAlertButton({
						text : "OK",
						click : closeSaveAlert,
					});
				}
			}
		}
	};
	/********************************************************
	These deal with drawing the tiles and blocks and map
	********************************************************/	
	//to set up a tile background size based on the current scale
	function drawTileBg(div){
	
		var id = div.getAttribute("index");
	
		var scale = scale_convert[currentScale];
		
		w = current_data.tiles.bg_w
		
		var x = scale * (id%w);
		var y = scale * (Math.floor(id/w));
		div.style.backgroundPosition = -8*x + "px " + -8*y +"px";
	};
	
	//to toggle the borders of the tiles in the current block and tileset map
	function toggleTileGrid(){
		tile_grid = (tile_grid == "on") ? "off" : "on"
		setTileGrid(elements.containers.current_block,tile_grid);
	};
	
	//to toggle highlight of a tile
	function toggleTileHighlight(index){
		var el = elements.containers.tileset_map.childNodes[index];
		var new_value = el.getAttribute("highlight") == "on" ? "off" : "on";
		el.setAttribute("highlight",new_value);
	};
	
	//to set the highlight of a tile to the given value (if it exists in the tileset tile list)
	function setTileHighlight(index,value){
		if(index < current_data.tiles.list.length){
			var el = elements.containers.tileset_map.childNodes[index];
			el.setAttribute("highlight",value);
		}
	}
	
	//to resize the tileset map
	function resizeTilesetMap(){
		var scale = scale_convert[currentScale];
		var h = Math.round((current_data.tiles.bg_h * current_data.tiles.bg_w)/16);
		
		var pixels = scale*8 + 2;
		
		var tileset_map = elements.containers.tileset_map;
		tileset_map.style.height = pixels*h + "px";
		tileset_map.style.width = pixels*16 + "px";
	};
	
	//to set the grid of all tiles in the given element to the given value
	function setTileGrid(el,value){
		el.setAttribute("tile_grid",value);
		var tiles = el.getElementsByClassName("tile");
		for(var i=0;i<tiles.length;i++){
			tiles[i].setAttribute("grid",value);
		}
	};
	
	//to add the mouseover/out functions to a map block tiles
	function addTilesMouseOverOut(block){
		//to add event listeners to each child:
		var tiles = block.childNodes;
		for(var j=0;j<tiles.length;j++){
			tile = tiles[j];
			tile.addEventListener("mouseover",function(){
				//update the X Y
				var div = elements.containers.hover_info_XY;
				clearNodes(div);
				var index = parseInt(this.parentNode.getAttribute("map_blocks_index"));
				var x = index%current_data.dimensions.width;
				var y = Math.floor(index/current_data.dimensions.width);
				
				//to adjust the X Y based upon the location in the block
				var adjust = {
					top_left : function(){
						x = 2*x;
						y = 2*y;
					},
					top_right : function(){
						x = 2*x+1;
						y = 2*y;
					},
					bottom_left : function(){
						x = 2*x;
						y = 2*y+1;
					},
					bottom_right : function(){
						x = 2*x+1;
						y = 2*y+1;
					},
				};
				
				adjust[this.getAttribute("location")]();

				if(elements.containers.hover_info.getAttribute("mode") == "hex"){
					x = hex(x);
					y = hex(y);
				}
				
				var text = document.createTextNode("X, Y : " + x + ", " + y);
				div.appendChild(text);
				
				//update the X Y
				var div = elements.containers.hover_info_walkable;
				clearNodes(div);
				
				var tile_to_check = {
					top_left : 4,
					top_right : 6,
					bottom_left : 12,
					bottom_right : 14,
				}
				
				//get the tile to check for collision
				var index = tile_to_check[this.getAttribute("location")];
				
				var new_tile_id = this.parentNode.childNodes[index].getAttribute("index");
				
				//set walkable to true if the index is in the collision list
				var walkable = (current_data.collision.indexOf(parseInt(new_tile_id)) > -1);
				
				var s = walkable ? "Walkable" : "Not Walkable";
				var text = document.createTextNode(s);
				div.appendChild(text);
			});
			tile.addEventListener("mouseout",function(){
				//clear the X Y
				var div = elements.containers.hover_info_XY;
				clearNodes(div);
				//clear the walkable
				var div = elements.containers.hover_info_walkable;
				clearNodes(div);
			});
		}
	};
	
	//to draw the map
	function drawMap(){
		current_data.map_block_elements = []
		resizeMap();
		
		var el = elements.containers.map;
		
		//to clear elements within the block list
		clearNodes(el)
		
		//to draw each block in this map and append to the element
		for(var i=0;i<current_data.map_blocks.length;i++){		
			var block = drawBlock(current_data.map_blocks[i],map_borders);
			block.setAttribute("map_blocks_index",i);
			block.setAttribute("type","map");
			block.addEventListener("contextmenu",function(evt){
				//only run if we are on the map page
				if(currentTab == "map"){
					setCurrentBlock(this.getAttribute("index"));
				}
			},false);
			block.addEventListener("mousedown",function(evt){
				//only run right left mouse click
				if(evt.button == 0){
					mapBlockClick(this);
					mouse_down = "block";
				}
			});
			block.addEventListener("mouseover",function(){
				if(mouse_down == "block"){
					mapBlockClick(this);
				}
				//update the block X Y
				var div = elements.containers.hover_info_block_XY;
				clearNodes(div);
				var index = parseInt(this.getAttribute("map_blocks_index"));
				var x = index%current_data.dimensions.width;
				var y = Math.floor(index/current_data.dimensions.width);
				if(elements.containers.hover_info.getAttribute("mode") == "hex"){
					x = hex(x);
					y = hex(y);
				}
				var text = document.createTextNode("Block X, Y : " + x + ", " + y);
				div.appendChild(text);
			});
			block.addEventListener("mouseout",function(){
				//clear the block X Y
				var div = elements.containers.hover_info_block_XY;
				clearNodes(div);
			});
			current_data.map_block_elements.push(block);
			el.appendChild(block);
			
			addTilesMouseOverOut(block);
			
		}
	};
	
	//to set the size of the map
	function resizeMap(){
		var el = elements.containers.map;
				
		var h = current_data.dimensions.height;
		var w = current_data.dimensions.width;

		//current height of each block in pixels
		var pixels = 32 * scale_convert[currentScale];
		
		//increase the size of each block by 2 if the border is on and we are not on the connections tab
		if(map_borders == 'on' && currentTab != "connections"){
			pixels += 2;
		}
		
		el.style.width = pixels * w + "px";
		el.style.height =  pixels * h + "px";
	}
	
	//to clear the nodes inside the given element
	function clearNodes(el){
		while (el.firstChild) {
			el.removeChild(el.firstChild);
		}
	};
	
	//to draw a tile list (array of tiles) into the given div
	function drawTileList(div,arr){
		clearNodes(div);
		if(arr.length == 0){
			var text = document.createTextNode("None (click to add)");
			div.appendChild(text);
		}
		else{
			for(var i=0;i<arr.length;i++){
				//get the tile
				var tile = cloneTile(arr[i]);
				tile.style.float = "initial";
				tile.style.border = "1px solid white";
				div.appendChild(tile);
				if(arr[i] < 10){
					arr[i] = "0" + arr[i];
				}
				var text = document.createTextNode(" (" + arr[i] + ") ");
				div.appendChild(text);
			}
		}
	};
	
	//to unhighlight the tiles that exist in the tile pair settings
	function unhighlightTilePairList(){
		for(var i=0;i<tile_pair_settings.tile_list.length;i++){
			setTileHighlight(tile_pair_settings.tile_list[i],"off");
		}
	};
	
	//to highlight the tiles that exist in the tile pair settings
	function highlightTilePairList(){
		for(var i=0;i<tile_pair_settings.tile_list.length;i++){
			setTileHighlight(tile_pair_settings.tile_list[i],"on");
		}
	};
	
	//to draw tile pair lists from the given arr into the given. num_tiles is how many tiles to add to each separate list
	//also input is the functions for when the tile container is clicked and when delete is clicked
	//returns an object containing the "separate tile list containers"
	function drawSeparateTileLists(div,arr,num_tiles,click_func,del_func){
		clearNodes(div);
		var containers = [];
		if(arr.length == 0){
			var text = document.createTextNode("None");
			div.appendChild(text);
		}
		else{
			for(var i=0;i<arr.length;i++){
				var element = newElement("div",{
					class : "separate_tile_list_row",
				},div);
				var tile_container = newElement("div",{
					class : "separate_tile_list_container",
					which : i,
					state : "active",
				},element);
				containers.push(tile_container);
				tile_container.addEventListener("click",click_func);
				var text = "";
				for(var j=0;j<num_tiles;j++){
					var tile = cloneTile(arr[i][j]);
					tile.style.float = "initial";
					tile.style.border = "1px solid white";
					tile.style.marginRight = "2px";
					tile_container.appendChild(tile);
					if(arr[j] < 10){
						arr[j] = "0" + arr[i][j];
					}
					text += " (" + arr[i][j] + ") "
				}
				var br = document.createElement("br");
				tile_container.appendChild(br)
				var text_node = document.createTextNode(text);
				tile_container.appendChild(text_node);
				
				var button = newElement("div",{
					class : "button",
					text : "Delete",
					which : i,
					state : "active"
				},
				element);
				button.addEventListener("click",del_func);
			}
		}
		return containers;
	};
	
	//to draw the tileset list
	function drawTilesetBlocklist(){
		var el = elements.containers.tileset_blocklist
		
		//to clear elements within the block list
		clearNodes(el)
		
		//to draw each block in this tileset and append to the element
		for(var i=0;i<current_data.tileset_blocks.length;i++){		
			var block = drawBlock(i,"on");
			block.setAttribute("type","list");
			block.addEventListener("click",function(){
				tilesetListClick(this);
			});
			el.appendChild(block);
		}
	};

	//to produce a div containing the tiles in the block of the given index of the current tileset
	function drawBlock(index,grid,div){
		//if a div was given, then just update that div
		if(div){
			var block = div;
		}
		//otherwise, create a new div
		else{
			var block = document.createElement("div");
		}
		block.className="block";
		block.setAttribute("scale",currentScale);
		block.setAttribute("grid",grid);
		block.setAttribute("index",index);
		block.setAttribute("tile_grid","off");
		
		var locs = ["top_left","top_right","top_left","top_right","bottom_left","bottom_right","bottom_left","bottom_right"]
		
		//only add tiles to the block if the block ID exists
		if(index < current_data.tileset_blocks.length){
			for(var i=0;i<16;i++){
				var tile_id = current_data.tileset_blocks[index][i];
				var tile = cloneTile(tile_id);
				tile.setAttribute("block_index",i);
				//to add the location (top-left,top-right,bot-left,bot-right) to each tile:
				tile.setAttribute("location",locs[Math.floor(i/2)]);
			
				block.appendChild(tile);
			}
		}
		
		block.addEventListener("mouseover",function(){
			//clear the hover text
			var div = elements.containers.hover_info_text;
			clearNodes(div);
				
			//update the block ID
			var div = elements.containers.hover_info_block_id;
			clearNodes(div);
			var index = this.getAttribute("index");
			if(elements.containers.hover_info.getAttribute("mode") == "hex"){
				index = hex(index);
			}
			var text = document.createTextNode("Block ID : " + index);
			div.appendChild(text);
		});
		block.addEventListener("mouseout",function(){
			//clear the block index
			var div = elements.containers.hover_info_block_id;
			clearNodes(div);
			//add the hover text
			var div = elements.containers.hover_info_text;
			clearNodes(div);
			var text = document.createTextNode("Hover Over Block");
			div.appendChild(text);
			var br = document.createElement("br");
			div.appendChild(br);
			var hex_or_dec = elements.containers.hover_info.getAttribute("mode") == "dec" ? "Hex" : "Dec";
			var text = document.createTextNode("Click to Toggle " + hex_or_dec);
			div.appendChild(text)
		});		
		
		return block;
	};
	
	//to clone a tile (or create empty one)
	function cloneTile(id){
		//only add the tile if it appears in the list
		if(id < current_data.tiles.list.length){
			var tile = current_data.tiles.list[id].cloneNode();
		}
		//otherwise, create blank tile
		else{
			var tile = document.createElement("div");
			tile.className = "tile";
			tile.setAttribute("scale",currentScale);
			tile.setAttribute("index",256);
			tile.setAttribute("grid","off");
			tile.setAttribute("highlight","off");
		}
		return tile;
	};
	
	//to update the tile inside all blocks that match the current block to the current tile
	function replaceBlockTile(index){
		//get every block
		var blocks = document.getElementsByClassName("block");
		for(var i=0;i<blocks.length;i++){
			//only check for blocks that match the current block
			if(blocks[i].getAttribute("index") == currentBlock){
				//get the new tile and insert before the index we want
				var tile = cloneTile(current_tile);
				var replace = blocks[i].childNodes[index];
				blocks[i].insertBefore(tile,replace);
				blocks[i].removeChild(replace);
			}
		}
		
		current_data.tileset_blocks[currentBlock][index] = parseInt(current_tile);
		setModified("tileset_blocks");
		
		//update the current block tiles
		setCurrentBlock(currentBlock);	
	};
	
	//to set the current block
	function setCurrentBlock(index){
		var el = elements.containers.current_block_id;
		clearNodes(el);
		var text = document.createTextNode("Current Block: " + index);
		el.appendChild(text);
		
		currentBlock = parseInt(index);
		var block = elements.containers.current_block;
		clearNodes(block);
		drawBlock(index,"on",block);
		
		//add the onclick to each tile in this block
		var tiles = block.getElementsByClassName("tile");
		for(var i=0;i<tiles.length;i++){
			tiles[i].addEventListener("contextmenu",function(evt){
				var index = this.getAttribute("index")
				//only run if we are on the tileset page and the current tile is not equal to this tile
				if(currentTab == "tileset" && index != current_tile){
					toggleTileHighlight(index);
					setCurrentTile(index);
				}
			},false);
			tiles[i].addEventListener("mousedown",function(evt){
				//only run if we are on the tileset page and left mouse click
				if(this.parentNode.getAttribute("page") == "tileset" && evt.button == 0){
					replaceBlockTile(this.getAttribute("block_index"));
					mouse_down = "tile";
				}
			});
			tiles[i].addEventListener("mouseover",function(){
				if(mouse_down == "tile" && this.parentNode.getAttribute("page") == "tileset"){
					replaceBlockTile(this.getAttribute("block_index"));
				}
			});
		}
		
		if(currentTab == "tileset" && tile_grid == "on"){
			setTileGrid(block,"on");
			block.setAttribute("tile_grid","on");
		}
	};
	
	//to set the current tile
	function setCurrentTile(index){
		
		//turn off the current tile highlight
		toggleTileHighlight(current_tile);
		
		current_tile = index;
		var el = elements.containers.current_tile;
		clearNodes(el);
		var tile = cloneTile(current_tile);
		el.appendChild(tile);
		
		if(index < 10){
			index = "0" + index;
		}
		elements.containers.current_tile_label.innerHTML = "Current Tile: (" + index + ")"
		
	};
	
	//to set the size of the map connection:
	function setConnectionMapSize(dir){
		var el = elements.containers[dir + "_connection_blocks"];
		
		var movement = connections_data[dir].movement;
		
		//current height of each block in pixels
		var pixels = 32 * scale_convert[currentScale];
		
		var h,w,map_left,map_top,el_left,el_top;
		
		var load_params = {
			NORTH : function(){
				w = pixels * connections_data[dir].size;
				h = pixels * 3;
				
				if(movement < 0){
					map_left = (0 - (movement * pixels)) + "px";
					el_left = "0px";
				}
				else{
					el_left = (movement * pixels) + "px";
					map_left = "0px";
				}
				map_top = h + 4 + "px";
				el_top = "0px";
			},
			SOUTH : function(){
				w =  pixels * connections_data[dir].size;
				h =  pixels * 3;
				
				if(movement < 0){
					map_left = (0 - (movement * pixels)) + "px";
					el_left = "0px";
				}
				else{
					el_left = (movement * pixels) + "px";
					map_left = "0px";
				}
				map_top = "0px";
				el_top = 2 + elements.containers.map.offsetHeight + "px";
			},
			WEST : function(){
				h =  pixels * connections_data[dir].size;
				w =  pixels * 3;
				
				if(movement < 0){
					map_top = (0 - (movement * pixels)) + "px";
					el_top = "0px";
				}
				else{
					map_top = "0px";
					el_top = (movement * pixels) + "px";
				}
				map_left = w + 4 + "px";
				el_left = "0px";
			},
			EAST : function(){
				h =  pixels * connections_data[dir].size;
				w =  pixels * 3;
				
				if(movement < 0){
					map_top = (0 - (movement * pixels)) + "px";
					el_top = "0px";
				}
				else{
					map_top = "0px";
					el_top = (movement * pixels) + "px";
				}
				map_left = "0px";
				el_left = 2 + elements.containers.map.offsetWidth + "px";
			},
		};
		
		load_params[dir]();
		var map = elements.containers.map_connections_wrapper;
		map.style.left = map_left;
		map.style.top = map_top;
		
		el.style.left = el_left;
		el.style.top = el_top;
		el.style.width = w + "px";
		el.style.height = h + "px";
	};
	
	//to draw the map connection for the given direction
	function drawMapConnection(dir){
		eraseConnections();
		var el = elements.containers[dir + "_connection_blocks"];
		var blocks = getConnectionBlocks(dir);
		setConnectionMapSize(dir);
		
		//to draw each block in this map and append to the element
		for(var i=0;i<blocks.length;i++){
			var block = drawBlock(blocks[i],"off");
			el.appendChild(block);
		}
		
		el.style.visibility = "visible";
		el.style.display = "initial";
		
	};
	
	//to erase the connections windows
	function eraseConnections(){
		for(var each in connections_data){
			var el = elements.containers[each + "_connection_blocks"];
			el.style.height = "0px";
			el.style.width = "0px";
			el.style.visibility = "hidden";
			el.style.display = "none";
			clearNodes(el);
		};
		var el = elements.containers.map_connections_wrapper;
		el.style.left = "0px";
		el.style.top = "0px";
	};
	
	//to get the blocks for the connections
	function getConnectionBlocks(dir){
		var arr = [];
		var offset = connections_data[dir].offset;
		
		var map = connections_data[dir].map;
				
		var size =  connections_data[dir].size;
		//if the connection map is the current map, then use the current height/width
		if(map == current_data.map.name){
			var height = current_data.dimensions.height;
			var width = current_data.dimensions.width;
		}
		else{
			var height_name = data.maps[map].header.height;
			var width_name = data.maps[map].header.width;
			
			var height = getFromList("map_dimensions",height_name,1);
			var width = getFromList("map_dimensions",width_name,1);
		}
		
		var limit = 3;
		
		//to determine the start index in the connecting map blocks
		var getStart = {
			NORTH : function(){
				limit = size;
				return ((height-3) * width) + offset;
			},
			SOUTH : function(){
				limit = size;
				return offset;
			},
			WEST : function(){
				return (width-3) + (width * offset)
			},
			EAST : function(){
				return (width * offset);
			},
		};
		
		var start_index = getStart[dir]();
		//if its not the current map, then get the real blocks
		if(map != current_data.map.name){
			var blocks_name = data.maps[map].header.blocks;
			var blocks = getFromPointerList("map_blocks",blocks_name,2).slice();
		}
		//otherwise, load the current blocks
		else{
			var blocks = current_data.map_blocks.slice();
		}
		
		var i = start_index;
		var j = 0;
		//copy the block ids to the new array
		while(arr.length < (3*size)){
			if(j<limit){
				arr.push(blocks[i + j]);
				j++;
			}
			else{
				j=0;
				i += width;
			}
		}
		return arr;
	};
	
	//to take an int (as a string) and convert it to a hex string
	function hex(s){
		s = parseInt(s).toString(16);
		if(s.length == 1){
			s = "0" + s;
		}
		
		return "$" + s.toUpperCase();
	};
	/***********************************************************
	These functions deals with the alert box
	***********************************************************/
	//to build the different alert boxed
	var buildAlert = {
		sharedFiles : function(params){
			var list = params.list;
			var box = elements.containers.alert_box_text;
			var text = document.createTextNode("These " + params.title + " are shared with the following:");
			box.appendChild(text);
			var br = document.createElement("br");
			box.appendChild(br)
			var br = document.createElement("br");
			box.appendChild(br)
			
			for(var i=0;i<list.length;i++){
				var text = document.createTextNode(list[i]);
				box.appendChild(text);
				var br = document.createElement("br");
				box.appendChild(br)
			}
			
			var br = document.createElement("br");
			box.appendChild(br)
			var text = document.createTextNode("Check the 'Save as New File' checkbox to create separate data");
			box.appendChild(text);
			
			addAlertButton({
				text : "OK",
				click : nextCurrentTabAlert,
			});
		},
		newFileNames : function(type){
			var box = elements.containers.alert_box_text;
			var text = document.createTextNode("Please enter the name of the file you want to save as:");
			box.appendChild(text);
			var br = document.createElement("br");
			box.appendChild(br)
			for(var each in new_files){
				//only look at the ones that have save_new as true, it doesn't already have a name, and match the given type and get a new_name
				if(new_files[each].save_new && new_files[each].new_name  && new_files[each].file_name == '' && (type == "map" || new_files[each].tab == type)){
					var text = document.createTextNode(new_files[each].title + ":");
					box.appendChild(text);
					var input = document.createElement("input");
					input.type = "text";
					input.className = "save_new_file";
					input.setAttribute("unique","false");
					input.setAttribute("which",each);
					input.addEventListener("input",function(){
						var which = this.getAttribute("which");
						var name = saveFileName[which](this.value);
						//check to see if this file name exists:
						if(checkFileName(which,name) && this.value != ''){
							this.setAttribute("unique","true");
						}
						else{
							this.setAttribute("unique","false");
						}
					});
					box.appendChild(input)
					var br = document.createElement("br");
					box.appendChild(br)
				}
			}
			box.scrollTop = 0;
			
			addAlertButton({
				text : "Save",
				click : function(){
					saveNewFiles(type);
				},
			});
			addAlertButton({
				text : "Cancel",
				click : cancelAlert,
			});
		},
		saveChanges : function(params){
			var box = elements.containers.alert_box_text;
			var text = document.createTextNode("There are changes to the data associated with this " + params.type.replace(/^[a-z]|[\b_][a-z]/g,function(match){
				return match.replace("_"," ").toUpperCase();
			}));
			box.appendChild(text);
			var br = document.createElement("br");
			box.appendChild(br);
			var br = document.createElement("br");
			box.appendChild(br);
			var text = document.createTextNode("Save changes?");
			box.appendChild(text);
			
			addAlertButton({
				text : "Yes",
				click : function(){
					closeAlert();
					
					//set the "save" callback to be "load"
					setCallback("save_" + params.type,function(){
						load(params.type,params.load);
					});
					
					save(params.type);
				}
			});
			addAlertButton({
				text : "No",
				click : function(){
					closeAlert();
					load(params.type,params.load);
				}
			});
			addAlertButton({
				text : "Cancel",
				click : cancelAlert,
			});
		},
		loading : function(){
			var box = elements.containers.alert_box_text;
			
			var br = document.createElement("br");
			box.appendChild(br)
			var br = document.createElement("br");
			box.appendChild(br)
			var br = document.createElement("br");
			box.appendChild(br)
			
			var text = document.createTextNode("Loading " + current_data.map.name + "...");
			box.appendChild(text);
		},
		saving : function(params){
			var box = elements.containers.alert_box_text;
			
			var br = document.createElement("br");
			box.appendChild(br)
			
			var text = document.createTextNode("Saving:");
			box.appendChild(text);
			var br = document.createElement("br");
			box.appendChild(br)
			
			for(var i=0;i<params.length;i++){
				var div = newElement("div",{
					text : "-" + params[i] + "...",
					class : "saving_text"
				},box)
			}
			
		},
	};
	
	//to check to see if this filename exists in the given pointer list
	//returns true if the given name does not exist in the list
	function checkFileName(which,name){
		var list = data.pointers[which];
		var ret = true;
		
		//if this type of file gets a new name, then run the check functoin
		if(new_files[which].new_name){
			for(var i =0;i<list.length;i++){
				if(list[i][1].replace("../","") == name){
					ret = false;
				}
			}
		}
		//otherwise, check the first set of names
		else{
			for(var i =0;i<list.length;i++){
				for(var j=0;j<list[i][0].length;j++){
					if(list[i][0][j] == name){
						ret = false;
					}
				}
			}
		}
		
		return ret;
	};
	
	//to close the save popup
	function closeSaveAlert(){
		key = save_data_key;
		
		cancelAlert();
		
		showHideSaveAs(key);
		//reset the data from the given key
		resetModified(key);
		
		callback("save_" + key);
	};
	
	//to save the new filenames
	function saveNewFiles(type){
		var unique = true;
		for(var each in new_files){
			//only check the files that we are saving as new
			if(new_files[each].save_new && (type == "map" || new_files[each].tab == type)){
				//if the new file is empty or already exists, set to false
				if(new_files[each].file_name == '' || !(checkFileName(each,new_files[each].file_name))){
					unique = false;
				}
			}
		}
		//if we have all unique file names, then continue saving
		if(unique){
			closeAlert();
			saveData(type);
		}
	};
	
	//to go to the next current tab alert
	function nextCurrentTabAlert(){
		closeAlert();
		displayCurrentTabAlert();
	};
	
	//to save a new file:
	var saveFileName = {
		map_blocks : function(name){
			name = "maps/" + name + ".blk";
			new_files.map_blocks.file_name = name;
			return name;
		},
		tileset_blocks : function(name){
			name = "gfx/blocksets/" + name + ".bst";
			new_files.tileset_blocks.file_name = name;
			return name;
		},
		tileset_collision : function(name){
			name = "gfx/tilesets/" + name + ".tilecoll";
			new_files.tileset_collision.file_name = name;
			return name;
		},
		tileset_door_tiles : function(name){
			new_files.tileset_door_tiles.file_name = name;
			return name;
		},
		tileset_warp_tiles : function(name){
			new_files.tileset_warp_tiles.file_name = name;
			return name;
		},
		wild_pokemon : function(name){
			new_files.wild_pokemon.file_name = name;
			return name;
		},
		super_rod_data : function(name){
			new_files.super_rod_data.file_name = name;
			return name;
		},
	};
	
	//to display the given alert box
	function displayAlert(id,input){
		clearNodes(elements.containers.alert_box_text);
		clearNodes(elements.containers.alert_box_buttons);
		buildAlert[id](input);
		//to blur any inputs
		document.activeElement.blur();
		showAlertBox();
	};
	
	//to display the alerts for the current page
	function displayCurrentTabAlert(){
		var cont = true;
		for(var each in new_files){
			//check to see if this is the tab where the alert should be displayed
			if(new_files[each].tab == currentTab && cont == true){
				//if so, check to see if the new file alert is set to true
				if(new_files[each].alert){
					displayAlert("sharedFiles",{
						list : new_files[each].shared_array,
						title : new_files[each].title,
						});
					new_files[each].alert = false;
					cont = false;
				}
			}
		}
	};
	
	//to add an alert button to the alert box
	function addAlertButton(input){
			var div = elements.containers.alert_box_buttons;
			var button =  newElement("div",{
				text : input.text,
			});
			button.className = "alert_button";
			button.addEventListener("click",input.click);
			div.appendChild(button);
	};
	
	//to show the alert box
	function showAlertBox(){
		elements.containers.alert_box_container.style.visibility = "visible";
		elements.containers.alert_box.style.visibility = "visible";
	};
	
	//to hide the alert box
	function closeAlert(){
		elements.containers.alert_box_container.style.visibility = "hidden";
		elements.containers.alert_box.style.visibility = "hidden";
	};
	
	//to cancel an alert
	function cancelAlert(){
		closeAlert();
		
		//refresh the current page
		pages[currentTab].refresh();
	}
	
	/***********************************************************
	These functions deal with interaction of GUI
	***********************************************************/
	//functions to when when a tile is in the tilemap is clicked, depending on which tab is active
	var tilemap_functions = {
		Block : function(index){
			//only change if we click on a new tile
			if(index != current_tile){
				toggleTileHighlight(index);
				setCurrentTile(index);
			}
		},
		Counters : function(index){
			var finish = false;
			var i=1;
			//loop 3 times or until we reach a match/empty counter
			while(i<4 && !finish){
				//if we reached an empty tile, then add it and exist
				if(current_data.tileset["counter" + i] == 255){
					current_data.tileset["counter" + i] = parseInt(index);
					finish = true;
				}
				//if we reach a matching tile, then remove and shift remaining tiles
				else if(current_data.tileset["counter" + i] == index){
					for(var j=i;j<3;j++){
						current_data.tileset["counter" + j] = parseInt(current_data.tileset["counter" + (j+1)]);
					}
					current_data.tileset.counter3 = 255;
					finish = true;
				}
				i++;
			}
			
			//if we made a change, update the tilelist
			if(finish){
				toggleTileHighlight(index);
				updateTileList("Counters");
				setModified("tileset_header");
			}
		},
		Grass : function(index){
			var current_grass = current_data.tileset.grass
			//if we clicked on the current grass tile, turn it off
			if(current_grass == index){
				current_data.tileset.grass = 255;
			}
			else {
				//if there was a previous grass tile, then unhighlight it
				if(current_grass != 255){
					toggleTileHighlight(current_grass);
				}
				current_data.tileset.grass = parseInt(index);
			}
			toggleTileHighlight(index);
			updateTileList("Grass");
			setModified("tileset_header");
		},
		Collision : function(index){
			var arr = current_data.collision.slice();
			var new_arr = addOrRemoveTile(arr,index);
			//sort
			current_data.collision = new_arr.sort(function(a,b){return a - b});
			toggleTileHighlight(index);
			updateTileList("Collision");
			setModified("tileset_collision");
		},
		Doors : function(index){
			var arr = current_data.tiles.doors.slice();
			var new_arr = addOrRemoveTile(arr,index);
			//sort
			current_data.tiles.doors = new_arr.sort(function(a,b){return a - b});
			
			//get the name of the door tile list
			var door_tile_name = getFromPointerList("tileset_door_tiles",current_data.tileset.name,1)
			
			//if this tileset did not have a door tile list:
			if(door_tile_name === false){
				//if this array is longer than 1 then add one
				if(new_arr.length > 0){
					new_files["tileset_door_tiles"].save_new = true;
				}
				//if the array is 0, then set save new to false
				else{
					new_files["tileset_door_tiles"].save_new = false;
				}
			}
			
			
			toggleTileHighlight(index);
			updateTileList("Doors");
			setModified("tileset_door_tiles");
		},
		Warps : function(index){
			var arr = current_data.tiles.warps.slice();
			var new_arr = addOrRemoveTile(arr,index);
			//sort
			current_data.tiles.warps = new_arr.sort(function(a,b){return a - b});
			
			toggleTileHighlight(index);
			updateTileList("Warps");
			setModified("tileset_warp_tiles");
		},
		Bookshelves : function(index){
			//only run if we are currently editing bookshelves and the tile you clicked isn't already highlighted
			if(tile_pair_settings.editing && tile_pair_settings.which_list == "bookshelves" && tile_pair_settings.tile_list.indexOf(index) == -1){
				current_data.tileset.bookshelf_tiles.push([parseInt(index),0]);
				
				//unhighlight the currently highlighted tiles
				var arr = tile_pair_settings.tile_list.slice();
				for(var i=0;i<arr.length;i++){
					setTileHighlight(arr[i],"off");
				}
				
				toggleTileHighlight(index);
				
				tile_pair_settings.editing = false;
				tile_pair_settings.tile_list = [index];
				
				setModified("tileset_bookshelves");
				updateTileList("Bookshelves");
				
				//to highlight the new list item
				var tile_list = elements.sub_pages.tileset.Bookshelves.getElementsByClassName("tile_list")[0];
				var row_list = tile_list.getElementsByClassName("separate_tile_list_container")
				var el = row_list[tile_pair_settings.viewing];
				el.setAttribute("state","current");
				tile_pair_settings.view_element = el;
				
			}
		},
		Ledges : function(index){
			//only run if we are currently editing ledges and the tile you clicked isn't already highlighted
			if(tile_pair_settings.editing && tile_pair_settings.which_list == "ledges"){
				//if the tile you clicked was already highlighted, then unhighlight
				if(tile_pair_settings.tile_list.indexOf(index) > -1){
					toggleTileHighlight(index);
					tile_pair_settings.tile_list = [];
				}
				else{
					//if this is the second tile, then finish
					if(tile_pair_settings.tile_list.length == 1){
						current_data.tileset.ledges.push([tile_pair_settings.tile_list[0],index,"DOWN"]);
						
						//highlight the new tile
						toggleTileHighlight(index);
						
						tile_pair_settings.editing = false;
						tile_pair_settings.tile_list.push(index);
						
						setModified("tileset_ledges");
						updateTileList("Ledges");
						
						//to highlight the new list item
						var tile_list = elements.sub_pages.tileset.Ledges.getElementsByClassName("tile_list")[0];
						var row_list = tile_list.getElementsByClassName("separate_tile_list_container");
						var el = row_list[tile_pair_settings.viewing];
						el.setAttribute("state","current");
						tile_pair_settings.view_element = el;
					}
					//otherwise, just update this list
					else{
						toggleTileHighlight(index);
						tile_pair_settings.tile_list.push(index);
					}
				}
			}
		},
		Pairs : function(index){
			//only run if we are currently editing a pairs list and the tile you clicked isn't already highlighted
			if(tile_pair_settings.editing && (tile_pair_settings.which_list == "water_pairs" || tile_pair_settings.which_list == "land_pairs")){
				//if the tile you clicked was already highlighted, then unhighlight
				if(tile_pair_settings.tile_list.indexOf(index) > -1){
					toggleTileHighlight(index);
					tile_pair_settings.tile_list = [];
				}
				else{
					//if this is the second tile, then finish
					if(tile_pair_settings.tile_list.length == 1){
						var which = tile_pair_settings.which_list;
						current_data.tileset["tile_pair_collision_" + which.replace("_pairs","")].push([tile_pair_settings.tile_list[0],index]);
						
						//highlight the new tile
						toggleTileHighlight(index);
						
						tile_pair_settings.editing = false;
						tile_pair_settings.tile_list.push(index);
						
						setModified("tileset_" + which);
						updateTileList("Pairs");
						
						container_index = 0;
						if(which == "land_pairs"){
							container_index = 1;
						}
						
						//to highlight the new list item
						var tile_list = elements.sub_pages.tileset.Pairs.getElementsByClassName("tile_pairs_list")[container_index];
						var row_list = tile_list.getElementsByClassName("separate_tile_list_container");
						var el = row_list[tile_pair_settings.viewing];
						el.setAttribute("state","current");
						tile_pair_settings.view_element = el;
					}
					//otherwise, just update this list
					else{
						toggleTileHighlight(index);
						tile_pair_settings.tile_list.push(index);
					}
				}
			}
		},
		Lists : function(){},
	};
	
	//to add or remove the given tile to the given array
	function addOrRemoveTile(arr,index){
		var unique = true;
		var new_arr = [];
		for(var i=0;i<arr.length;i++){
			//if this already exists in the collision list
			if(arr[i] == index){
				unique = false;
			}
			else{
				new_arr.push(arr[i]);
			}
		}
		//if we didn't find a match
		if(unique){
			new_arr.push(parseInt(index));
		}
		return new_arr;
	};
	
	//run a function when a tilemap is clicked, depending on what tab is open
	function tilemapClick(index){
		//find the current tab and run the corresponding function
		for(var each in elements.sub_tabs.tileset){
			if(elements.sub_tabs.tileset[each].getAttribute("state") == "current"){
				tilemap_functions[each](index);
			}
		}
	};
	
	//to toggle the map borders
	function toggleMapBorders(){
		var new_value = "on";
		if(map_borders == "on"){
			new_value = "off";
		}
		map_borders = new_value;

		setAllMapBorders(map_borders)
	};
	
	//to set all map borders to the given value
	function setAllMapBorders(value){
		blocks = elements.containers.map.getElementsByClassName("block");
		for(var i=0;i<blocks.length;i++){
			blocks[i].setAttribute("grid",value);
		}
		var orig_map_borders = map_borders;
		map_borders = value;
		resizeMap();
		map_borders = orig_map_borders;
	};
	
	//functions to change the scale of objects:
	function setScale(value){
		var list = ["half","default","plus_half","double"];
		currentScale = list[value];
		
		elements.containers.tileset_blocks.setAttribute("scale",currentScale);
		elements.containers.tileset_blocklist.setAttribute("scale",currentScale);
		elements.containers.map.setAttribute("scale",currentScale);
		
		//to resize the maps
		resizeMap();
		for(var each in elements.sub_tabs.connections){
			if(elements.sub_tabs.connections[each].getAttribute("state") == "current" && connections_data[each].enabled){
				setConnectionMapSize(each);
			}
		};
		resizeTilesetMap();
		
		scrollCheck();
		
		//to update every tile in the page
		tiles = document.getElementsByClassName("tile");
		for(var i=0;i<tiles.length;i++){
			drawTileBg(tiles[i]);
			tiles[i].setAttribute("scale",currentScale);
		}
		
		//to update the list of tiles (that get cloned)
		tiles = current_data.tiles.list;
		for(var i=0;i<tiles.length;i++){
			drawTileBg(tiles[i]);
			tiles[i].setAttribute("scale",currentScale);
		}
		
		//to update all blocks on the page
		blocks = document.getElementsByClassName("block");
		for(var i=0;i<blocks.length;i++){
			blocks[i].setAttribute("scale",currentScale);
		}
		
	};
	
	//function to run when a map block is clicked
	function mapBlockClick(el){
		//only run if we are on the map page
		if(currentTab == "map"){
			var index = el.getAttribute('map_blocks_index');
			var block = current_data.map_block_elements[index];
			clearNodes(block);
			current_data.map_blocks[index] = currentBlock;
			drawBlock(currentBlock,map_borders,block);
			addTilesMouseOverOut(block);
			
			//to update the "modified" data to true
			setModified("map_blocks");
		}
	};
		
	//function to run when a block in the tileset list is clicked
	function tilesetListClick(el){
		var index = el.getAttribute('index');
		setCurrentBlock(index);
	};

	//function to run when the border block is clicked
	function borderBlockClick(){
		setBorderBlock(currentBlock);
	};
	
	//to set the border block to the given index
	function setBorderBlock(index){
		var block = elements.containers.border_block;
		clearNodes(block);
		drawBlock(index,"on",block);
		current_data.map.header.objects.border = index;
	};
	
	//to draw the tile collision containers
	function drawTileCollisionContainers(){
		var div = newElement("div",{
			id : "water_pairs_list_title",
			class : "tile_pairs_list_title",
			text : "Water Tile Collision Pairs:"
		},
		elements.sub_pages.tileset.Pairs);
		
		var div = newElement("div",{
			id : "water_pairs_tile_list",
			class : "tile_pairs_list",
		},
		elements.sub_pages.tileset.Pairs);
		elements.containers["water_pairs_tile_list"] = div;
		
		var div = newElement("div",{
			id : "land_pairs_list_title",
			class : "tile_pairs_list_title",
			text : "Land Tile Collision Pairs:"
		},
		elements.sub_pages.tileset.Pairs);
		
		var div = newElement("div",{
			id : "land_pairs_tile_list",
			class : "tile_pairs_list"
		},
		elements.sub_pages.tileset.Pairs);
		elements.containers["land_pairs_tile_list"] = div;
	};
	
	//to change the size of the map
	function changeMapSize(value,dimension){
		//don't allow map resize if it will set the dimension to zero
		if(current_data.dimensions[dimension] == 1 && value < 0){
			return false;
		}
		else{
			//increase the value in the data
			var new_value = current_data.dimensions[dimension] + value;
			current_data.dimensions[dimension] = new_value;
			
			//this array will hold the connections that we modified.
			var edited_connections = [];
			
			//check to see if any of the map connections need to be updated (only if the size of map was shrunk)
			if(value < 0){
				for(var each in connections_data){
					var map = connections_data[each].map;
					//if you change the width and this map is a north or south connection:
					//or you change the height and the map is a east or west connection:
					if((dimension == "width" && (each == "NORTH" || each == "SOUTH")) || (dimension == "height" && (each == "EAST" || each == "WEST"))){
						//if the connection map is the same as this map, then check the size of the connection
						if(current_data.map.name == map){
							//if the new size is less than the connection size
							if(new_value < connections_data[each].size){
								//then update the size to the new value
								connections_data[each].size = new_value;
								updateValue(each + "_size",new_value);
								//add this dir to the edited connections array
								if(edited_connections.indexOf(each) == -1){
									edited_connections.push(each)
								}
								
								//if this disconnects the connections, then shift the movement
								if((new_value + connections_data[each].movement) == 0){
									plusClick(each + "_movement");
									//add this dir to the edited connections array
									if(edited_connections.indexOf(each) == -1){
										edited_connections.push(each)
									}
								}
							}
						}
						//if the sum of the movement and the size exceeds the new map size + 3, then decrease the map size
						if((connections_data[each].size + connections_data[each].movement > new_value + 3)){
							//if the movement is -3, then reduce the size
							if(connections_data[each].movement == -3){
								minusClick(each + "_size");
							}
							else{
								minusClick(each + "_movement");
							}
							//add this dir to the edited connections array
							if(edited_connections.indexOf(each) == -1){
								edited_connections.push(each)
							}
						}
						
						//if this disconnects the connections, then shift the movement
						if((new_value - connections_data[each].movement) <= 0){
							minusClick(each + "_movement");
							//add this dir to the edited connections array
							if(edited_connections.indexOf(each) == -1){
								edited_connections.push(each)
							}
						}
					}
				}
			}
			
			//to set the map header to "edited" if we had to adjust
			for(var k=0;k<edited_connections.length;k++){
				//check to see if the direction is enabled
				if(connections_data[edited_connections[k]].enabled){
					setModified("map_header");
				}
			}
			
			//to update the counter on the GUI
			updateValue('map_' + dimension,new_value)
			
			var new_blocks = []
			var length = current_data.map_blocks.length;
			var width = current_data.dimensions.width;
			var height = current_data.dimensions.height;
			
			//to add or remove the blocks to the height/width
			for(var i=0;i<length;i++){
				//if we are increasing:
				if(value > 0){
					new_blocks.push(current_data.map_blocks[i]);
					if(dimension == "width"){
						//if we reach the end of the row, add a blank block
						if((i+1)%(width-1) == 0 && (i > 0 || width == 2)){
							new_blocks.push(currentBlock);
						}
					}
					else{
						//if we are adding to height, then add a row to the end of the list
						if(i+1 == length){
							for(var j=0;j<width;j++){
								new_blocks.push(currentBlock);
							}
						}
					}
				}
				//if we are decreasing:
				else{
					if(dimension == "width"){
						//if removing from width, ignore the end of row
						if((i+1)%(width+1) != 0 || i == 0){
							new_blocks.push(current_data.map_blocks[i]);
						}
					}
					//if we are removing from height, then just skip the last row
					else{
						new_blocks.push(current_data.map_blocks[i]);
						if(i+1+width == length){
							i = length;
						}
					}
				}
			}
			
			current_data.map_blocks = new_blocks;
			
			//redraw the map
			drawMap();
			
			//to update the "modified" data to true
			setModified("map_dimensions");
			setModified("map_blocks");
			
			return true;
		}
	};
	
	//to toggle the tileset list
	function toggleTilesetList(which){
		setModified("tileset_list_" + which)
		current_data.tileset[which] = !current_data.tileset[which];
	};
	
	//to toggle if a map connection exists or not
	function toggleConnection(dir){
		var con = current_data.map.header.connections;
		//if this connection is enabled:
		if(connections_data[dir].enabled){
			connections_data[dir].enabled = false;
			elements.buttons["toggle_" + dir].innerHTML = "Add";
			elements.fields[dir + "_apply_to_other"].checked = false;
			eraseConnections();
		}
		else{
			connections_data[dir].enabled = true;
			elements.buttons["toggle_" + dir].innerHTML = "Remove";
			drawMapConnection(dir);
		}
		
		setModified("map_header");
	};
	
	//to update the connection data
	function updateConnectionData(dir,which,value){
		connections_data[dir][which] = value;
		//if the map connection is enabled, then draw it
		if(connections_data[dir].enabled){
			setModified("map_header");
			drawMapConnection(dir);
		}
	};
	
	//to reset connection data
	function resetConnectionData(dir,map){
		var dim = "height";
		if(dir == "NORTH" || dir == "SOUTH"){
			dim = "width";
		}
		var size = current_data.dimensions[dim];
		
		//if the connection map is not the current map
		if(map != current_data.map.name){
			var map_width = data.maps[map].header[dim];
			//set the size to be the lower of current map size and connection map size
			size = Math.min(size,getFromList("map_dimensions",map_width,1));
		}
		
		//set the size to be the current map size
		connections_data[dir].size = size;
		updateValue(dir + "_size",size);
		connections_data[dir].offset = 0;
		updateValue(dir + "_offset",0);
		connections_data[dir].movement = 0;
		updateValue(dir + "_movement",0);
	};
	
	//to update the innerhtml value of the given div
	function updateValue(name,value){
		var el = elements.containers[name]
		clearNodes(el);
		var text = document.createTextNode(value);
		el.appendChild(text);
	};
	
	//to update the wild pokemon catch rate
	function updateCatchRate(version,location,value){
		var versions = ["RED","GREEN","BLUE","JAPAN","YELLOW"];
		setModified("wild_pokemon");
		if(version == "ALL"){
			current_data.wild_pokemon.data.all[location + "_rate"] = parseInt(value);
			for(var i=0;i<versions.length;i++){
				elements.fields[versions[i] + "_" + location + "_catch_rate"].value = parseInt(value);
				updateCatchRate(versions[i],location,value);
				elements.fields["ALL_" + location + "_catch_rate"].setAttribute("green","on");
			}
		}
		else{
			current_data.wild_pokemon.data[version.toLowerCase()][location + "_rate"] = parseInt(value);
			
			//if the ALL catch rate is green, then check to see if this deviates
			var cr_all = elements.fields["ALL_" + location + "_catch_rate"];
			if(cr_all.getAttribute("green") == "on" && cr_all.value != value){
				cr_all.value = 0;
				current_data.wild_pokemon.data.all[location + "_rate"] = 0;
				cr_all.setAttribute("green","off");
			}
			//otherwise, check to see if it should turn green
			else{
				var turn_green = true;
				for(var i=0;i<versions.length;i++){
					//if turn_green is still true, then compare
					if(turn_green){
						turn_green = (current_data.wild_pokemon.data[versions[i].toLowerCase()][location + "_rate"] == parseInt(value));
					}
				}
				//if turn green is still true, then turn green
				if(turn_green){
					current_data.wild_pokemon.data.all[location + "_rate"] = parseInt(value);
					elements.fields["ALL_" + location + "_catch_rate"].value = parseInt(value);
					elements.fields["ALL_" + location + "_catch_rate"].setAttribute("green","on");
				}
			}
			
			//if we set catch rate to 0, then disable the pokemon
			if(parseInt(value) == 0){
				for(var i=0;i<10;i++){
					elements.fields[version + "_" + location + "_level_" + i].disabled = true; 
					elements.fields[version + "_" + location + "_pokemon_" + i].disabled = true; 
				}
			}
			//otherwise, enable the pokemon
			else{
				for(var i=0;i<10;i++){
					elements.fields[version + "_" + location + "_level_" + i].disabled = false; 
					elements.fields[version + "_" + location + "_pokemon_" + i].disabled = false; 
				}
			}
		}
	};
	
	//to update the wild pokemon
	function updateWildPokemon(version,location,which,value){
		setModified("wild_pokemon");
		var versions = ["RED","GREEN","BLUE","JAPAN","YELLOW"];
		if(version == "ALL"){
			current_data.wild_pokemon.data.all[location + "_pokemon"][which][1] = value;
			for(var i=0;i<versions.length;i++){
				elements.fields[versions[i] + "_" + location + "_pokemon_" + which].selectedIndex = getSortedIndex(data.lists.pokemon,value);
				updateWildPokemon(versions[i],location,which,value);
				elements.fields["ALL_" + location + "_pokemon_" + which].setAttribute("green","on");
			}
		}
		else{
			current_data.wild_pokemon.data[version.toLowerCase()][location + "_pokemon"][which][1] = value;
			//if the ALL pokemon is green, then check to see if this deviates
			var pk_all = elements.fields["ALL_" + location + "_pokemon_" + which];
			if(pk_all.getAttribute("green") == "on" && pk_all.options[pk_all.selectedIndex].value != value){
				pk_all.selectedIndex = 0;
				current_data.wild_pokemon.data.all[location + "_pokemon"][which][1] = getIndexInSorted(data.lists.pokemon,0);
				pk_all.setAttribute("green","off");
			}
			//otherwise, check to see if it should turn green
			else{
				var turn_green = true;
				for(var i=0;i<versions.length;i++){
					//if turn_green is still true, then compare
					if(turn_green){
						turn_green = (current_data.wild_pokemon.data[versions[i].toLowerCase()][location + "_pokemon"][which][1] == value);
					}
				}
				//if turn green is still true, then turn green
				if(turn_green){
					current_data.wild_pokemon.data.all[location + "_pokemon"][which][1] = value;
					elements.fields["ALL_" + location + "_pokemon_" + which].selectedIndex = getSortedIndex(data.lists.pokemon,value);
					elements.fields["ALL_" + location + "_pokemon_" + which].setAttribute("green","on");
				}
			}
		}
	};
	//to update the wild level
	function updateWildLevel(version,location,which,value){
		setModified("wild_pokemon");
		var versions = ["RED","GREEN","BLUE","JAPAN","YELLOW"];
		if(version == "ALL"){
			current_data.wild_pokemon.data.all[location + "_pokemon"][which][0] = parseInt(value);
			for(var i=0;i<versions.length;i++){
				elements.fields[versions[i] + "_" + location + "_level_" + which].value = parseInt(value);
				updateWildLevel(versions[i],location,which,value);
				elements.fields["ALL_" + location + "_level_" + which].setAttribute("green","on");
			}
		}
		else{
			current_data.wild_pokemon.data[version.toLowerCase()][location + "_pokemon"][which][0] = parseInt(value);
			//if the ALL level is green, then check to see if this deviates
			var pk_all = elements.fields["ALL_" + location + "_level_" + which];
			if(pk_all.getAttribute("green") == "on" && pk_all.value != parseInt(value)){
				pk_all.value = 0;
				current_data.wild_pokemon.data.all[location + "_pokemon"][which][0] = 0;
				pk_all.setAttribute("green","off");
			}
			//otherwise, check to see if it should turn green
			else{
				var turn_green = true;
				for(var i=0;i<versions.length;i++){
					//if turn_green is still true, then compare
					if(turn_green){
						turn_green = (current_data.wild_pokemon.data[versions[i].toLowerCase()][location + "_pokemon"][which][0] == parseInt(value));
					}
				}
				//if turn green is still true, then turn green
				if(turn_green){
					current_data.wild_pokemon.data.all[location + "_pokemon"][which][0] = parseInt(value);
					elements.fields["ALL_" + location + "_level_" + which].value = parseInt(value);
					elements.fields["ALL_" + location + "_level_" + which].setAttribute("green","on");
				}
			}
		}
	};
	
	//to get the index of the given name in the given list (sorted)
	function getSortedIndex(list,name){
		var arr = [];
		for(var i=0;i<list.length;i++){
			arr.push(list[i][0])
		}
		arr.sort();
		return arr.indexOf(name);
	};
	//to get the name of index in the given list (sorted)
	function getIndexInSorted(list,index){
		var arr = [];
		for(var i=0;i<list.length;i++){
			arr.push(list[i][0])
		}
		arr.sort();
		return arr[index];
	};
	//to get the index of the given name in the given list (sorted)
	function getSortedPointerIndex(list,index,name){
		var arr = [];
		for(var i=0;i<list.length;i++){
			arr.push(list[i][index])
		}
		arr.sort();
		return arr.indexOf(name);
	};
	
	//to build the super rod data list
	function buildSuperRodData(){
		var el = elements.containers.super_rod_list;
		clearNodes(el);
		
		var text = document.createTextNode("Super Rod Pokemon");
		el.appendChild(text);
		
		var br = document.createElement("br");
		el.appendChild(br);
		
		for(var i=0;i<current_data.super_rod_data.data.length;i++){
			var input = newElement("input",{
				type : "number",
				min : 0,
				max : 255,
				class : "level",
				which : i,
				value : current_data.super_rod_data.data[i][0],
			},
			el);
			input.addEventListener("input",function(){
				var which = parseInt(this.getAttribute("which"));
				//see if the input if a not number
				if(this.validity.badInput){
					//if so, reset the value
					this.value = current_data.super_rod_data.data[which][0];
				}
				//if the number is below 0 or empty, set to 0
				else {
					if(this.value < 0 || this.value == ''){
						this.value = 0;
					}
					//if the number exceed 255, set to 255
					else if(this.value > 255){
						this.value = 255;
					}
					setModified("super_rod_data");
					current_data.super_rod_data.data[which][0] = this.value;
				}
			});
			
			var div = newElement("div",{
				which : i,
				class : "delete_button",
				text : "X"
			},el);
			div.addEventListener(("click"),function(){
				setModified("super_rod_data");
				var which = parseInt(this.getAttribute("which"));
				current_data.super_rod_data.data.splice(which,1);
				buildSuperRodData();
			});
									
			var input = createSelectFromList(data.lists.pokemon,0);
			input.setAttribute("which",i);
			input.className = "pokemon";
			input.selectedIndex = getSortedPointerIndex(data.lists.pokemon,0,current_data.super_rod_data.data[i][1]);
			input.addEventListener("change",function(){
				setModified("super_rod_data");
				var which = parseInt(this.getAttribute("which"));
				current_data.super_rod_data.data[which][1] = this.value;
			});
			el.appendChild(input);
			
			var br = document.createElement("br");
			el.appendChild(br);
		
		}
		
		//to create the "add pokemon" button
		var div = newElement("div",{
			text : "Add Pokemon",
			class : "button",
			state : "active",
			id : "super_rod_add_pokemon"
		},el);
		div.addEventListener("click",function(){
			//if the current list is "none", then auto set save-as-new
			if(elements.fields.super_rod_list.selectedIndex == data.pointers.super_rod_data.length){
				toggleNewFile("super_rod_data")
			}
			setModified("super_rod_data");
			var arr = [0,getIndexInSorted(data.lists.pokemon,0)];
			current_data.super_rod_data.data.push(arr);
			buildSuperRodData();
		});
		
	};
	/*************************************************************************
	Functions that deal with the loading of data
	*************************************************************************/
	//cancel load callbacks
	var cancel_load_callback = {
		map : function(){},
		tileset : function(){
			elements.fields.tileset.selectedIndex = getSortedIndex(data.lists.tilesets,current_data.tileset.name);
		},
		wild_pokemon : function(){},
	};
	
	//function that gets run when the user decides to load a map
	function change(type,id){
		//If there are changes, then show "Save?" pop-up
		if(checkForChanges(type)){
			displayAlert("saveChanges",{
				type : type,
				load : id
			});
		}
		else{
			load(type,id);
		}
	};
	
	//function to update the given tile pair list id and element
	//the given input is the array that contains the tile list
	//returns a list of all of the containers in that list
	//the get_tile_list input is a statement that is run to get the tile pair when clicked
	//the tile pair container contains the list we care about
	//num tiles is how many tiles to draw per container
	//highlight_all declares if you want to highlight the previously selected tiles when adding a new one or not
	//if no id is given, its assumed to be the same as the ID (but in lowercase)
	function updateTilePairList(page,el,arr,get_tile_list,tile_pair_container,num_tiles,highlight_all,id){
			id = typeof id !== 'undefined' ? id : page.toLowerCase();
			var click_func = function(){
				//only run if we are not editing
				if(!tile_pair_settings.editing){
					unhighlightTilePairList();
					var index = this.getAttribute("which");
					tile_pair_settings.viewing = parseInt(index);
					
					//if a view element exists, then unhighlight
					if(tile_pair_settings.view_element != ''){
						tile_pair_settings.view_element.setAttribute("state","active");
					}
					
					tile_pair_settings.which_list = id;
					
					tile_pair_settings.view_element = this;
					this.setAttribute("state","current");
					tile_pair_settings.tile_list = eval(get_tile_list);
					highlightTilePairList();
				}
			};
			var del_func = function(){
				//only run if we are not editing
				if(!tile_pair_settings.editing){
					var index = this.getAttribute("which");
					//unhighlight the tiles if we deleted the tiles we are viewing
					if(tile_pair_settings.viewing == index){
						unhighlightTilePairList();
						tile_pair_settings.tile_list = [];
						tile_pair_settings.view_element = '';
						tile_pair_settings.which_list = '';
					}
					//decrease the viewing index if it was higher than what we are deleting
					else if(tile_pair_settings.viewing > index){
						tile_pair_settings.viewing--;
					}
					arr.splice(index,1);
					
					setModified("tileset_" + id)
					updateTileList(page);
					
					//to rehighlight the previous tile_pair
					if(tile_pair_settings.view_element != ''){
						tile_pair_container = eval(tile_pair_container);
						var row_list = tile_pair_container.getElementsByClassName("separate_tile_list_container");;
						var el = row_list[tile_pair_settings.viewing];
						el.setAttribute("state","current");
						tile_pair_settings.view_element = el;
					}
				}
			};
			var list = drawSeparateTileLists(el,arr,num_tiles,click_func,del_func);
				
			var br = document.createElement("br");
			el.appendChild(br);
					
			var br = document.createElement("br");
			el.appendChild(br);
			
			//to create the "Add New" button
			var button = newElement("div",{
				class : "button",
				text : "Add New",
				new_index : arr.length,
				state : "active"
			},
			el);
			button.addEventListener("click",function(){
				//highlight all of the tiles (if the input was true)
				var new_arr = [];
				if(highlight_all){
					for(var i=0;i<arr.length;i++){
						var index = i;
						//get the sub array, which is the tile array for the given row in the array
						var sub_arr = eval(get_tile_list);
						for(var j=0;j<sub_arr.length;j++){
							new_arr.push(sub_arr[j]);
							setTileHighlight(sub_arr[j],"on");
						}
					}
				}
				else{
					unhighlightTilePairList();
				}
				tile_pair_settings.tile_list = new_arr;
				
				tile_pair_settings.editing = true;
				tile_pair_settings.which_list = id;
				
				tile_pair_settings.viewing = parseInt(this.getAttribute("new_index"));
				updateTileList(page);
			});
			
			var br = document.createElement("br");
			el.appendChild(br)
			
			var br = document.createElement("br");
			el.appendChild(br)
			
			return list;
	};
	
	//to update a tile list for the given tab
	function updateTileList(tab){
		var list_functions = {
			Counters : function(){
				for(var i=1;i<4;i++){
					var tile_index = current_data.tileset["counter" + i];
					if(tile_index != 255){
						arr.push(tile_index);
					}
				}
				drawTileList(el,arr);
			},
			Grass : function(){
				var tile_index = current_data.tileset.grass;
				if(tile_index != 255){
					arr.push(tile_index);
				}
				drawTileList(el,arr);
			},
			Collision : function(){
				arr = current_data.collision.slice();
				drawTileList(el,arr);
			},
			Doors : function(){
				arr = current_data.tiles.doors.slice();
				drawTileList(el,arr);
			},
			Warps : function(){
				arr = current_data.tiles.warps.slice();
				drawTileList(el,arr);
			},
			Bookshelves : function(){
				//if we are drawing this because we are adding a new one, then add the "add new"
				//otherwise, add everything
				if(tile_pair_settings.editing){
					clearNodes(el);
					var container = newElement("div",{
						class : "separate_tile_list_row",
						text : "Click on a New Tile to Add"
					},el);
				}
				else{
					//draw the tile list
					var tile_list_container = 'elements.sub_pages.tileset.Bookshelves.getElementsByClassName("tile_list")[0]';
					var list = updateTilePairList("Bookshelves",el,current_data.tileset.bookshelf_tiles,"[arr[index][0]]",tile_list_container,1,true);
					
					//to add the "text id" to each
					for(var i=0;i<list.length;i++){
						var br = document.createElement("br");
						list[i].appendChild(br)
						
						var text = document.createTextNode("Text:");
						list[i].appendChild(text);
						
						var input = newElement("input",{
							type : "number",
							class : "bookshelf_text",
							max : 255,
							min : 0,
							which : i,
							value : current_data.tileset.bookshelf_tiles[i][1]
						},
						list[i]);
						input.addEventListener("input",function(){
							var index = this.getAttribute("which");
							//see if the input if a not number
							if(this.validity.badInput){
								//if so, reset the value
								this.value = current_data.tileset.bookshelf_tiles[index][1];
							}
							//if the number is below 0 or empty, set to 0
							else {
								if(this.value < 0 || this.value == ''){
									this.value = 0;
								}
								//if the number exceed 255, set to 255
								else if(this.value > 255){
									this.value = 255;
								}
								current_data.tileset.bookshelf_tiles[index][1] = parseInt(this.value);
								setModified("tileset_bookshelves");
							}
						});
					}
				}
			},
			Ledges : function(){
				//if we are drawing this because we are adding a new one, then add the "add new"
				//otherwise, add everything
				if(tile_pair_settings.editing){
					clearNodes(el);
					var container = newElement("div",{
						class : "separate_tile_list_row",
						text : "Click on 2 Tiles to Add"
					},el);
				}
				else{
					//draw the tile list
					var tile_list_container = 'elements.sub_pages.tileset.Ledges.getElementsByClassName("tile_list")[0]';
					var list = updateTilePairList("Ledges",el,current_data.tileset.ledges,"[arr[index][0],arr[index][1]]",tile_list_container,2,false);
				
					//to add the "direction" dropdown to each
					for(var i=0;i<list.length;i++){
						var br = document.createElement("br");
						list[i].appendChild(br);
						
						var select = newElement("select",{
							class : "direction",
							which : i,
						},
						list[i]);
						var dirs = ["UP","DOWN","LEFT","RIGHT"];
						for(var j=0;j<dirs.length;j++){
							var option = newElement("option",{
								value : dirs[j],
								text : dirs[j]
							},
							select);
							//if this is the correct direction, then set as selected index
							if(current_data.tileset.ledges[i][2] == dirs[j]){
								select.selectedIndex = j;
							}
						}
						select.addEventListener("change",function(){
							var index = this.getAttribute("which");
							current_data.tileset.ledges[index][2] = this.value;
							setModified("tileset_ledges");
						});
					}
				}
			},
			Pairs : function(){
				//if we are drawing this because we are adding a new one, then add the "add new"
				//otherwise, add everything
				if(tile_pair_settings.editing){
					var el = elements.sub_pages.tileset.Pairs;
					clearNodes(el);
					var container = newElement("div",{
						class : "tile_list",
					},
					el);
					
					var list = newElement("div",{
						class : "separate_tile_list_row",
						text : "Click on 2 Tiles to Add"
					},container);
				}
				else{
					var el = elements.sub_pages.tileset.Pairs;
					clearNodes(el);
					drawTileCollisionContainers();
					var locations = {
						water : {
							container : 'elements.sub_pages.tileset.Pairs.getElementsByClassName("tile_pairs_list")[0]',
						},
						land : {
							container : 'elements.sub_pages.tileset.Pairs.getElementsByClassName("tile_pairs_list")[1]',
						}
					};
					for(var loc in locations){
						//draw the tile list
						var el = elements.containers[loc + "_pairs_tile_list"];
						var tile_list_container = locations[loc].container;
						var list = updateTilePairList("Pairs",el,current_data.tileset["tile_pair_collision_" + loc],"arr[index].slice()",tile_list_container,2,false,loc + "_pairs");
					}
				}
			},
		}
		
		var arr = [];
		var el = elements.containers[tab + "_tile_list"];
		list_functions[tab]();
	};
	
	//to show or hide the save as elements
	function showHideSaveAs(key){
		//if this map shares blocks with another, then alert the user
		for(var each in new_files){
			if(key == "map" || each == key || new_files[each].tab == key){
				var shared_array = eval(new_files[each].src);
				//if the pointer exists
				if(shared_array !== false){
					if(shared_array.length > 0){
						new_files[each].shared_array = shared_array;
						new_files[each].alert = true;
						elements.containers["save_new_" + each].style.visibility = "inherit";
					}
					else{
						elements.containers["save_new_" + each].style.visibility = "hidden";
					}
				}
				else{
					elements.containers["save_new_" + each].style.visibility = "hidden";
				}
				elements.fields["save_new_" + each].checked = false;
			}
		}
	};
	
	//the function to run when the tileset finished loading (when we are loading a new map)
	function finishLoadingMap(){
		//to refresh the pages
		pages.map.refresh();
		pages.connections.refresh();
		pages.objects.refresh();
		pages.sprites.refresh();
		pages.pokemon.refresh();
		
		//close the loading textbox
		closeAlert();
		
		//to show or hide the save as features
		showHideSaveAs("map");
			
		scrollCheck();
		
		callback("load_map");
	};
	
	//functions to run when loading certain data
	var load_functions = {
		map : function(name){		
			//load the map
			current_data.map = JSON.parse(JSON.stringify(data.maps[name]));
			current_data.map.name = name;
			
			//show the loading alertbox
			displayAlert("loading");
			
			//load the map dimensions
			current_data.dimensions = {};
			current_data.dimensions.height = getFromList("map_dimensions",current_data.map.header.height,1);
			current_data.dimensions.width = getFromList("map_dimensions",current_data.map.header.width,1);
						
			//load the wild pokemon
			var wild_pokemon = current_data.map.wild_pokemon
			//current_data.wild_pokemon = JSON.parse(JSON.stringify(data.wild_pokemon[wild_pokemon]));
			
			//to load the map blocks
			var map_blocks = current_data.map.header.blocks;
			current_data.map_blocks = getFromPointerList("map_blocks",map_blocks,2).slice()
			
			//to move the "load map" container and show the header_fields
			elements.containers.header_fields.appendChild(elements.containers.load_map);
			elements.containers.load_map.setAttribute("placement","final");
			elements.buttons.load_map.setAttribute("placement","final");
			elements.fields.map.setAttribute("placement","final");
			
			//update the text in the Save Button
			clearNodes(elements.buttons.save);
			var text = document.createTextNode("Save " + name);
			elements.buttons.save.appendChild(text);
			
			elements.containers.header_fields.style.visibility = 'visible';
			elements.containers.tabs.style.visibility = 'visible';
			
			var wild_pk_name = getFromPointerList("wild_pokemon",current_data.map.name,1);
			load("wild_pokemon",wild_pk_name);
			
			var sr_data_name = getFromPointerList("super_rod_data",current_data.map.name,1);
			load("super_rod_data",sr_data_name);
			
			//set the tileset callback function to be "finishLoadingMap";
			setCallback("load_tileset",finishLoadingMap);
			
			//load the tileset (and place the "change_tab" at the front of the callback order)
			var tset = current_data.map.header.tileset;
			load("tileset",{tset : tset},false,true);
		},
		tileset : function(input){
			var tset = input.tset;
			
			var gfx_only = input.hasOwnProperty("gfx_index");
			
			//if the tileset in the header is the index instead of the name, then switch it to the name
			if(typeof getFromList("tilesets",tset,0) === 'undefined'){
				tset = data.lists.tilesets[parseInt(tset)][0];
			}
			current_data.tileset = JSON.parse(JSON.stringify(data.tilesets[tset]));
			current_data.tileset.name = tset;
			
			//to load the tileset blocks
			var tileset_blocks = current_data.tileset.blocks;
			current_data.tileset_blocks = [];
			var arr = getFromPointerList("tileset_blocks",tileset_blocks,2).slice();
			for(var i=0;i<arr.length;i++){
				current_data.tileset_blocks.push(arr[i].slice());
			}
			
			//to load the collision
			var collision_name = current_data.tileset.collision;
			current_data.collision = getFromPointerList("tileset_collision",collision_name,2).slice();
			
			//to load the tileset background image and get the size and then create the tile list
			current_data.tiles = {};
			
			//determine if we want to use the default gfx or different gfx
			var src = "../" + getFromPointerList("tileset_gfx",current_data.tileset.gfx,1);
			if(gfx_only){
				var path_name = elements.fields.tileset_gfx.options[input["gfx_index"]].value;
				src = getFromList("tileset_gfx",path_name,1);
			}
			current_data.tiles.src = src;
			
			current_data.tiles.list = [];
			
			//to load the tile lists
			var doors = getFromPointerList("tileset_door_tiles",current_data.tileset.name,2)
			//if this map exists in the doors pointer list
			if(doors !== false){
				current_data.tiles.doors = doors.slice();
			}
			else{
				current_data.tiles.doors = [];
			}
			
			var name = current_data.tileset.warp_tiles;
			current_data.tiles.warps = getFromPointerList("tileset_warp_tiles",name,1).slice();
			
			var img = new Image();
			img.src = current_data.tiles.src;
			current_data.tiles.img = img;
			
			//to load the Tiles list and finished loading data when the image loads
			img.onload = function(){
				bg_h = Math.round(img.height/8);
				bg_w = Math.round(img.width/8);
				
				current_data.tiles.bg_w = bg_w;
				current_data.tiles.bg_h = bg_h;
				
				resizeTilesetMap();
				var tileset_map = elements.containers.tileset_map;
				clearNodes(tileset_map);
				
				for(var i=0;i<(current_data.tiles.bg_w * current_data.tiles.bg_h);i++){
					var div = document.createElement("div");
					div.className = "tile";
					div.setAttribute("scale",currentScale);
					div.setAttribute("index",i);
					div.setAttribute("grid","off");
					div.setAttribute("highlight","off");
					
					div.style.backgroundImage = "url(" + current_data.tiles.src + ")";
					div.style.imageRendering = "pixelated";
					
					div.style.backgroundSize = bg_w + "00% " + bg_h + "00%";

					drawTileBg(div);
					current_data.tiles.list.push(div);
					
					//add to the tileset map
					var copy = div.cloneNode();
					copy.setAttribute("grid","on");
					copy.addEventListener("click",function(){
						tilemapClick(this.getAttribute("index"));
					});
					tileset_map.appendChild(copy);
				}
				
				drawTilesetBlocklist();
				drawMap();
				setCurrentBlock(0);	
				setCurrentTile(0);
				changeSubTab("tileset","Block");
				
				//to show/hide the save as data for the tileset (if we are not just updating the gfx
				if(!gfx_only){
					showHideSaveAs("tileset");
				}
								
				//to refresh the tileset page (pass along if we are just updating the gfx or not)
				pages.tileset.refresh(gfx_only);

				callback("load_tileset");
			}
		},
		wild_pokemon : function(name){
			var wp_data = data.wild_pokemon[name];
			//update the current_data to a copy of this pokemon data
			current_data.wild_pokemon = {
				data : JSON.parse(JSON.stringify(wp_data)),
				name : name,
			};
			
			var versions = ["RED","GREEN","BLUE","JAPAN","YELLOW"];
			var locations = ["water","grass"];
			var name = getIndexInSorted(data.lists.pokemon,0);
			for(var i=0;i<versions.length;i++){
				var version = versions[i].toLowerCase();
				for(var j=0;j<locations.length;j++){
					var location = locations[j];
					var arr = current_data.wild_pokemon.data[version][location + "_pokemon"];
					if(arr.length == 0){
						for(var k=0;k<10;k++){
							arr.push([0,name])
						}
					}
				}
			}
			
			callback("load_wild_pokemon");
		},
		super_rod_data : function(name){
			if(!name || name == "None"){
				name = "None";
				var sr_data = [];
			}
			else{
				var sr_data = data.super_rod_data[name];
			}
			
			//update the current_data to a copy of this super rod data
			current_data.super_rod_data = {
				data : JSON.parse(JSON.stringify(sr_data)),
				name : name,
			};
			
			buildSuperRodData();
			
			callback("load_super_rod_data");
		},
	};
	
	//to run the functions to load a certain type of data into memory
	function load(type,input,partial,front){
		var back = front !== true;
		//set the "load" callback to be "changeTab"
		setCallback("load_" + type,function(){
			changeTab(currentTab);
		},back);

		//determine if we are loading brand new data or just partial data
		if(typeof partial === 'undefined'){
			partial = false;
		}
		
		//if we are not loading partial data, then reset modified for the given data type
		if(!partial){
			resetModified(type);
		}
		
		load_functions[type](input);
	};
	
	/*********************************************************
	This deals with navigating throughout the GUI
	*********************************************************/
	//to hide the current tab and show the new tab
	function changeTab(id){
		var tab = elements.tabs[currentTab];
		var page = elements.pages[currentTab];
		
		tab.setAttribute("state","active");
		page.style.visibility = 'hidden';
		page.style.display = 'none';
		
		pages[currentTab].onHide();
		
		currentTab = id
		
		var tab = elements.tabs[currentTab];
		var page = elements.pages[currentTab];
		tab.setAttribute("state","current");
		page.style.visibility = 'visible';
		page.style.display = 'initial';
		
		pages[currentTab].onShow();
		
		scrollCheck();
		resizeCheck();
		
		//display alert for the current tab (if there are any)
		displayCurrentTabAlert();
	};
	/***********************************************************************
	This deals with building the GUI
	***********************************************************************/	
	//to create a "Save As New" container
	function createSaveAsNew(name){
		var div = newElement("div",{
			id : "save_new_" + name + "_container"
		});
		elements.containers["save_new_" + name] = div;
		
		var input = document.createElement("input");
		input.type = "checkbox";
		input.id = "save_new_" + name;
		input.setAttribute("which",name);
		input.addEventListener("click",function(){
			toggleNewFile(this.getAttribute("which"));
		});
		elements.fields["save_new_" + name] = input;
		div.appendChild(input);
		
		var label = document.createElement("label");
		var text = document.createTextNode("Save As New " + new_files[name].title);
		label.appendChild(text);
		label.id = "save_new_" + name + "_label";
		label.for = "save_new_" + name;
		div.appendChild(label);
		
		return div;
	};

	//to duplicate a block
	function duplicateBlock(index){
		var length = current_data.tileset_blocks.length;
		
		var arr = current_data.tileset_blocks[index].slice();
		current_data.tileset_blocks.push(arr);
		
		//add the block to the list
		var block = drawBlock(length,"on");
		block.addEventListener("click",function(){
			tilesetListClick(this);
		});
		elements.containers.tileset_blocklist.appendChild(block);
		
		elements.containers.tileset_size.innerHTML = length + 1;
		
		//redraw the map
		drawMap();
		setModified("tileset_blocks");
	};
	
	//the creates sub tabs for the given page and list of tabs
	function createSubTabs(page,list){
		elements.sub_tabs[page] = {};
		elements.sub_pages[page] = {};
	
		//to create the subtab section container
		var section =  newElement("div",{
			id : page + "_subtab_container"
		});
		elements.containers[page + "subtabs"] = section;
		elements.pages[page].appendChild(section);
	
		//to create the tabs container
		var div =  newElement("div",{
			id : page + "_subtab_list"
		});
		elements.containers[page + "subtab_list"] = div;
		elements.containers[page + "subtabs"].appendChild(div);
	
		for(var i=0;i<list.length;i++){
			//to create the "tabs" buttons
			var div =  newElement("div",{
				id : page + "_subtab_ " + list[i],
				text : list[i]
			});
			div.className="tab subtab " + page + "_subtab";
			div.setAttribute("state","active");
			div.setAttribute("sub_tab",list[i]);
			div.setAttribute("sub_page",page);
			div.addEventListener("click",function(){
				if(this.getAttribute("state") == "active"){
					changeSubTab(this.getAttribute("sub_page"),this.getAttribute("sub_tab"));
				}
			});
			elements.sub_tabs[page][list[i]] = div;
			elements.containers[page + "subtab_list"].appendChild(div);
			
			//to create the subpages
			var div = newElement("div",{
				id : page + "_subpage_" + list[i],
			});
			div.className = page + "_subpage";
			elements.sub_pages[page][list[i]] = div;
			elements.containers[page + "subtabs"].appendChild(div);
		}
	};
	
	var onShowSubTab = {
		objects : function(){},
		connections : function(subtab){
			//if this connection is enabled, then draw
			if(connections_data[subtab].enabled){
				drawMapConnection(subtab);
			}
			else{
				eraseConnections();
			}
		},
		tileset : function(subtab){
			var highlightTiles = {
				Block : function(){
					setTileHighlight(current_tile,"on");
				},
				Counters : function(){
					for(var i=1;i<4;i++){
						var tile = current_data.tileset["counter" + i];
						if(tile != 255){
							setTileHighlight(tile,"on");
						}
					}
				},
				Grass : function(){
					var tile_index = current_data.tileset.grass;
					if(tile_index != 255){
						setTileHighlight(tile_index,"on");
					}
				},
				Collision : function(){
					var arr = current_data.collision.slice();
					for(var i=0;i<arr.length;i++){
						setTileHighlight(arr[i],"on");
					}
				},
				Doors : function(){
					var name = current_data.tileset.name;
					var arr = getFromPointerList("tileset_door_tiles",name,2);
					
					if(arr !== false){
						arr = arr.slice();
						for(var i=0;i<arr.length;i++){
							setTileHighlight(arr[i],"on");
						}
					}
				},
				Warps : function(){
					var name = current_data.tileset.warp_tiles;
					var arr = getFromPointerList("tileset_warp_tiles",name,1).slice();
					for(var i=0;i<arr.length;i++){
						setTileHighlight(arr[i],"on");
					}
				},
				Bookshelves : function(){
					updateTileList("Bookshelves");
				},
				Pairs : function(){
					updateTileList("Pairs");
				},
				Ledges : function(){
					updateTileList("Ledges");
				},
				Lists : function(){},
			};
			//highlight the tiles if the tileset map has child nodes
			if(elements.containers.tileset_map.hasChildNodes()){
				highlightTiles[subtab]();
			}
		},
	};
	
	//function to run when hiding a tile pair tab
	function hideTilePairTab(){
		//if we are currently editing a new one, then delete that info
		if(tile_pair_settings.editing){
			tile_pair_settings.editing = false;
		}
		
		//if a view element exists, then unhighlight
		if(tile_pair_settings.view_element != ''){
			tile_pair_settings.view_element.setAttribute("state","active");
		}
		tile_pair_settings.view_element = '';
		tile_pair_settings.which_list = '';
		tile_pair_settings.viewing = 0;
		
		unhighlightTilePairList();
		tile_pair_settings.tile_list = [];
	};
	
	var onHideSubTab = {
		objects : function(){},
		connections : function(subtab){},
		tileset : function(subtab){
			var unhighlightTiles = {
				Block : function(){
					setTileHighlight(current_tile,"off");
				},
				Counters : function(){
					for(var i=1;i<4;i++){
						var tile = current_data.tileset["counter" + i];
						if(tile != 255){
							setTileHighlight(tile,"off");
						}
					}
				},
				Grass : function(){
					var tile_index = current_data.tileset.grass;
					if(tile_index != 255){
						setTileHighlight(tile_index,"off");
					}
				},
				Collision : function(){
					var arr = current_data.collision.slice();
					for(var i=0;i<arr.length;i++){
						setTileHighlight(arr[i],"off");
					}
				},
				Doors : function(){
					var arr = current_data.tiles.doors;
					for(var i=0;i<arr.length;i++){
						setTileHighlight(arr[i],"off");
					}
				},
				Warps : function(){
					var arr = current_data.tiles.warps;
					for(var i=0;i<arr.length;i++){
						setTileHighlight(arr[i],"off");
					}
				},
				Bookshelves : function(){
					hideTilePairTab();
				},
				Pairs : function(){
					hideTilePairTab();
				},
				Ledges : function(){
					hideTilePairTab();
				},
				Lists : function(){},
			};
			
			//unhighlight the tiles if the tileset map has child nodes
			if(elements.containers.tileset_map.hasChildNodes()){
				unhighlightTiles[subtab]();
			}
		},
	};
	
	
	//to change to the given subtab
	function changeSubTab(page,subtab){
		for(var each in elements.sub_tabs[page]){
			//run the onhidesubtab function for this page and sent the tab we are leaving
			if(elements.sub_tabs[page][each].getAttribute("state") == "current"){
				onHideSubTab[page](each);
			}
			elements.sub_tabs[page][each].setAttribute("state","active");
			elements.sub_pages[page][each].style.visibility = 'hidden';
		}
		
		//run the onshow function for the new page
		onShowSubTab[page](subtab);
		
		elements.sub_tabs[page][subtab].setAttribute("state","current");
		elements.sub_pages[page][subtab].style.visibility = 'visible';
	};
	
	//runs the corresponding function when a plus button gets clicked
	function plusClick(id){
		var connection = false;
		
		//see if the ID contains a direction
		for(var each in connections_data){
			if(id.indexOf(each) > -1){
				connection = true;
			}
		}
		
		//it its a map connection holder:
		if(connection){
			plus_functions["map_connections"](id);
		}
		else{
			plus_functions[id]();
		}
	};
	
	//functions to run when a plus gets clicked
	var plus_functions = {
		map_height : function(){
			changeMapSize(1,"height");
		},
		map_width : function(){
			changeMapSize(1,"width");
		},
		map_connections : function(id){
			var inputs = id.split("_");
			var new_value = connections_data[inputs[0]][inputs[1]] + 1;
			var map = connections_data[inputs[0]].map;
			if(inputs[0] == "NORTH" || inputs[0] == "SOUTH"){
				var size = current_data.dimensions.width;
				//if we aren't connecting to the same map, then get the width of the connecting map
				if(map != current_data.map.name){
					var width = data.maps[map].header.width;
					size = getFromList("map_dimensions",width,1);
				}
			}
			else{
				var size = current_data.dimensions.height;
				//if we aren't connecting to the same map, then get the height of the connecting map
				if(map != current_data.map.name){
					var height = data.maps[map].header.height;
					size = getFromList("map_dimensions",height,1);
				}
			}
			
			
			if(inputs[0] == "NORTH" || inputs[0] == "SOUTH"){
				var cur_size = current_data.dimensions.width;
			}
			else{
				var cur_size = current_data.dimensions.height;
			}
					
			limits = {
				size : function(){
					//the connection strip size plus offset must not exceed the total size of the map
					//otherwise, the function will read past the end of the map blocks list
					//and the movement plus the size of connection strip must not exceed the size of the current map by more than 3
					return ((new_value + connections_data[inputs[0]].offset) <= size) && ((new_value + connections_data[inputs[0]].movement) <= (cur_size + 3));
				},
				movement : function(){
					//the movement must not exceed the size of the current map
					//and the movement plus the size of connection strip must not exceed the size of the current map by more than 3
					return (new_value < cur_size) && ((new_value + connections_data[inputs[0]].size) <= (cur_size + 3));
				},
				offset : function(){
					//the connection strip size plus offset must not exceed the total size of the map
					//otherwise, the function will read past the end of the map blocks list
					return (new_value + connections_data[inputs[0]].size) <= size;
				},
			};
			
			//if it doesnt reach the limit, then update
			if(limits[inputs[1]]()){
				updateValue(inputs[0] + "_" + inputs[1],new_value);
				updateConnectionData(inputs[0],inputs[1],new_value)
			}
		},
		tileset_size : function(){
			var length = current_data.tileset_blocks.length;
			var arr = [];
			//create the new block filled with the current tile
			for(var i=0;i<16;i++){
				arr.push(current_tile);
			}
			current_data.tileset_blocks.push(arr);
			
			
			//add the block to the list
			var block = drawBlock(length,"on");
			block.addEventListener("click",function(){
				tilesetListClick(this);
			});
			elements.containers.tileset_blocklist.appendChild(block);
			
			elements.containers.tileset_size.innerHTML = length + 1;
			//redraw the map
			drawMap();
			setModified("tileset_blocks");
		},
	};	
	
	//runs the correspending function when a plus button gets clicked
	function minusClick(id){
		var connection = false;
		
		//see if the ID contains a direction
		for(var each in connections_data){
			if(id.indexOf(each) > -1){
				connection = true;
			}
		}
		
		//it its a map connection holder:
		if(connection){
			minus_functions["map_connections"](id);
		}
		else{
			minus_functions[id]();
		}
	};
	
	//functions to run when a minus gets clicked
	var minus_functions = {
		map_height : function(){
			changeMapSize(-1,"height");
		},
		map_width : function(){
			changeMapSize(-1,"width");
		},
		map_connections : function(id){
			var inputs = id.split("_");
			var new_value = connections_data[inputs[0]][inputs[1]] - 1;

			limits = {
				size : function(){
					return new_value != 0;
				},
				movement : function(){
					var size = connections_data[inputs[0]].size;
					//movement cannot extend 3 past the edge of the map
					//movement cannot exceed the size of the connecting map
					return (new_value > (0- size)) && (new_value >= -3);
				},
				offset : function(){	
					return new_value > -1;
				},
			};
			
			//if it doesnt reach the limit, then update
			if(limits[inputs[1]]()){
				updateValue(inputs[0] + "_" + inputs[1],new_value);
				updateConnectionData(inputs[0],inputs[1],new_value);
				
				//if we reduce size, then make sure the movement keeps the maps connected
				if(inputs[1] == "size" && (connections_data[inputs[0]].size + connections_data[inputs[0]].movement) == 0){
					plusClick(inputs[0] + "_movement");
				}
			}
		},
		tileset_size : function(){
			var length = current_data.tileset_blocks.length;
			//if the number of blocks is greater than one, then remove the last block
			if(length > 1){
				//decrease the index of the current block if we just deleted it
				if((currentBlock + 1) == length){
					setCurrentBlock(currentBlock -1);
				}
				current_data.tileset_blocks.pop();
				elements.containers.tileset_blocklist.removeChild(elements.containers.tileset_blocklist.lastChild);
				elements.containers.tileset_size.innerHTML = (length - 1);
				//redraw the map
				drawMap();
				setModified("tileset_blocks");
			}
		},
	};
	
	//to create plus/minus buttons for the given ID and appends them to the given div, and the given default value
	function createPlusMinus(id,def,div){
		var plus = newElement("div",{
			id : id + "_plus",
			text : "+"
		});
		plus.className = "plus_minus";
		elements.fields[id + "_plus"] = plus;
		plus.setAttribute("which",id);
		plus.addEventListener("click",function(){
			plusClick(this.getAttribute("which"));
		});
		div.appendChild(plus);
		
		var value = newElement("div",{
			id : id,
			text : def,
		});
		value.className = "value";
		elements.containers[id] = value;
		div.appendChild(value);
		
		var minus = newElement("div",{
			id : id + "_minus",
			text : "-"
		});
		minus.className = "plus_minus";
		elements.fields[id + "_minus"] = minus;
		minus.setAttribute("which",id);
		minus.addEventListener("click",function(){
			minusClick(this.getAttribute("which"));
		});
		div.appendChild(minus);
	};
	
	//this creates an element of the given type with the given inputs.  If a third attribute (parent, an element) is given, it will append to the parent
	function newElement(type,obj,parent){
		var el = document.createElement(type);
		//to create the properties
		for(var prop in obj){
			if(prop == "text"){
				var text = document.createTextNode(obj[prop]);
				el.appendChild(text);
			}
			else if(prop == "class"){
				el.className = obj[prop];
			}
			else{
				el.setAttribute(prop,obj[prop]);
			}
		}
		//if a parent was given
		if(typeof parent !== 'undefined'){
			parent.appendChild(el);
		}
		
		return el;
	};
	
	//this will create a select element from the given list of arrays.  Each option will be the given index of each array in the list.
	function createSelectFromList(list,index){
		var select = document.createElement("select");
		
		var arr = []
			
		for(var i=0;i<list.length;i++){
			arr.push(list[i][index]);
		}
		
		arr.sort();
		
		for(var i=0;i<arr.length;i++){
			var option = document.createElement("option");
			option.value = arr[i];
			var text = document.createTextNode(option.value);
			option.appendChild(text);
			select.appendChild(option);
		}
		
		return select;
	};
	/******************************************************
	These deal with getting specific information from the 'data'
	******************************************************/
	//to will return the item in the index of the array in the given Pointer List where the first index contains the given pointer name
	function getFromPointerList(list,name,index){
		list = data.pointers[list]
		for(var i=0;i<list.length;i++){
			//if the first index of this list item contains the given name, then return the given index of this list item
			if(list[i][0].indexOf(name) > -1){
				if(typeof index !== 'undefined'){
					return list[i][index];
				}
				else return i;
			}
		}
		return false;
	};
	
	//to will return the item in the index of the array in the given List where the first index contains the given pointer name
	//if no index is given, then return the index in the array
	function getFromList(list,name,index){
		list = data.lists[list];
		for(var i=0;i<list.length;i++){
			//if the first index of this list item contains the given name, then return the given index of this list item
			if(list[i][0] == name){
				if(typeof index !== 'undefined'){
					return list[i][index];
				}
				else return i;
			}
		}
	};
	
	//to return the name of object in list with the matching id
	function getIndexInList(name,index,ret_index){
		list = data.lists[name];
		for(var i=0;i<list.length;i++){
			//if the index of this list item contains the given index, then return the name
			if(list[i][1] == index){
				if(typeof ret_index !== 'undefined'){
					return list[i][ret_index];
				}
				else return i;
			}
		}
		return false;
	};
	
	//to return the name of object in list with the matching id
	function getIndexInPointerList(name,index,ret_index){
		list = data.pointers[name];
		for(var i=0;i<list.length;i++){
			//if the index of this list item contains the given index, then return the name
			if(list[i][1] == index){
				if(typeof ret_index !== 'undefined'){
					return list[i][ret_index];
				}
				else return i;
			}
		}
		return false;
	};
	
	//returns an array of all pointers that share this file
	function getSharedPointers(list,name){
		var arr =  getFromPointerList(list,name,0)
		//if this name exists in the list, then continue.
		if(arr !== false){
			arr = arr.slice();
			var remove = arr.indexOf(name);
			arr.splice(remove,1);
			return arr;
		}
		else return false
	};
	
	//to remove the given name fromthe given array
	function removeFromArray(array,name){
		if(!array){
			return false;
		}
		array = array.slice();
		if(array.indexOf(name) > -1){
			array.splice(array.indexOf(name),1);
		}
		return array;
	};
	/**************************************************************
	Functions for when the page/window view changes
	**************************************************************/	
	//function that gets run when the page scrolls or scale changes
	function scrollCheck(){
		var block_container_convert = {
			half : 174,
			default:216,
			plus_half:258,
			double:300
		};
		var block_container_left = block_container_convert[currentScale];
		var X = window.pageXOffset;
		var Y = window.pageYOffset;
		
		var blocklist = elements.containers.tileset_blocks;
		var hover = elements.containers.hover_info;
		var current = elements.containers.current_block_container;
		var border = elements.containers.border_block_container;
		
		if(Y < 354){
			if(X > 0 && blocklist.getAttribute("page") == "map"){
				blocklist.style.position = "fixed";
				blocklist.style.top = 461 - Y + "px";
				
				hover.style.position = "fixed";
				hover.style.top = 377 - Y + "px";
			}
			else{
				blocklist.style.position = "absolute";
				blocklist.style.top = "5em";
				hover.style.position = "absolute";
				hover.style.top = "1em";
			}
			
			
			current.style.position = "absolute";
			current.style.top = "6.5em";
			current.style.left = block_container_left + "px";
			
			elements.containers.border_block_container.style.position = "absolute";
			elements.containers.border_block_container.style.top = "16.5em";
			elements.containers.border_block_container.style.left = block_container_left + "px";
		}
		else{
			if(blocklist.getAttribute("page") == "map"){
				blocklist.style.position = "fixed";
				blocklist.style.top = "5.5em";
				hover.style.position = "fixed";
				hover.style.top = "1.5em";
			}
			else{
				blocklist.style.position = "absolute";
				blocklist.style.top = "5em";
				hover.style.position = "absolute";
				hover.style.top = "1em";
			}
			
			current.style.position = "fixed";
			current.style.top = "7em";
			current.style.left = (block_container_left - X) + "px";
			
			border.style.position = "fixed";
			border.style.top = "17em";
			border.style.left = (block_container_left - X) + "px";
		}
	};
	
	//function that gets run when the window resizes
	function resizeCheck(){
		//set the size of the tileset blocks container
		elements.containers.tileset_blocks.style.height = window.innerHeight - 150 + "px";
	};	
	/***************************************
	Initial Start-up function to build the page
	***************************************/
	(function(){
		/**********************Header Element****************/
		//to create the Header
		var parent = newElement("div",{
			id : "header"
		},
		document.body);
		elements.containers.header = parent;
		
		var title = newElement("div",{
			id : "title",
			text : "GlitchMap"
		},
		parent);
		
		var div = newElement("div",{
			id : "version",
			text : "v0.8"
		},
		title);
		
		/*****************Load Map Element***************/
		//to build the "load map" container
		var div = newElement("div",{
			id : "load_map_container",
			text : "Load Map:",
			placement : "initial",
		},
		parent);
		elements.containers.load_map = div;
		
		//to build the "load map" dropdown
		var select = createSelectFromList(data.lists.maps,0);
		select.id = "load_map_select";
		select.setAttribute("placement","initial");
		elements.fields.map = select;
		div.appendChild(select);
		
		//to build the "load map" button
		var button = newElement("div",{
			id : "load_map_button",
			text : "Load",
			class : "button",
			state : "active",
			placement : "initial"
		},
		div);
		elements.buttons.load_map = button;
		button.addEventListener("click",function(){
			change("map",elements.fields.map.value);
		});
		/*****************Header Fields Element*********************/
		//to create the header fields container
		var div = newElement("div",{
			id : "header_fields"
		},
		document.body);
		elements.containers.header_fields = div;
		
		/*****************Scale Element****************/
		var label = document.createElement("label");
		var text = document.createTextNode("Scale:");
		label.id = "scale_label"
		label.for = "scale";
		elements.labels.scale = label;
		label.appendChild(text);
		div.appendChild(label);		
		
		var input = newElement("input",{
			id : "scale",
			type : "range",
			value : 1,
			min : 0,
			max : 3,
		},
		div);
		input.addEventListener("change",function(){
			setScale(this.value);
		});
		elements.fields.scale = input;
		
		/********************Save Button Element**************/
		var button =  newElement("div",{
			id : "save",
			class : "button",
			state : "inactive"
		},
		div);
		elements.buttons.save = button;
		button.addEventListener("click",function(){
			//only run if the state is active
			if(this.getAttribute("state") == "active"){
				save("map");
			}
		});
		
		/**************Alert Box Element***************/
		//to create the alert box container
		var div = newElement("div",{
			id : "alert_box_container"
		},
		document.body);
		elements.containers.alert_box_container = div;
		
		//to create the alert box window
		var parent = newElement("div",{
			id : "alert_box"
		},
		document.body);
		elements.containers.alert_box = parent;
		
		//to create the alert box text
		var div = newElement("div",{
			id : "alert_box_text"
		},
		parent);
		elements.containers.alert_box_text = div;
		
		//to create the alert box buttons
		var div = newElement("div",{
			id : "alert_box_buttons"
		},
		parent);
		elements.containers.alert_box_buttons = div;
		
		/**********Tab List Element***************/
		//to create the tabs container
		var div =  newElement("div",{
			id : "tab_container"
		},
		document.body);
		div.style.visibility = "hidden";
		elements.containers.tabs = div;
	
		/*************Pages Elements*************/
		for(var page in pages){
			//to create the "tabs" buttons
			var div =  newElement("div",{
				id : page + "_tab",
				text : page.slice(0,1).toUpperCase() + page.slice(1,page.length),
				class : "tab",
				state : "inactive",
				page : page
			},
			elements.containers.tabs);
			div.addEventListener("click",function(){
				if(this.getAttribute("state") == "active"){
					changeTab(this.getAttribute("page"));
				}
			});
			elements.tabs[page] = div;
			
			//to create the pages
			var div = newElement("div",{
				id : page + "_page",
				class : "page"
			},
			document.body);
			elements.pages[page] = div;
			
			//set the local "page" value to be this div
			pages[page].page = div;
			
			//to build the page
			pages[page].build();
		}
		
		//to add the onscroll event listener
		window.addEventListener("scroll",scrollCheck);
		//to add the onresize event listener
		window.addEventListener("resize",resizeCheck);
		
		//run the resize check to load proper sizes
		resizeCheck();
		
		//to set an event listener to the editor knows if the mouse is currently being clicked (for clicking and dragging in the map block editor)
		document.addEventListener("mouseup",function(){
			mouse_down = '';
		});
		
	})();
	

}

var GlitchMap;
document.addEventListener("DOMContentLoaded", function(event) {
	GlitchMap = new GlitchMap();
});
//to disable tabbing between inputs
document.addEventListener('keydown', function (e) {
    if (e.which == 9) {
        e.preventDefault();
    }
});
document.addEventListener("contextmenu",function(evt){
	evt.preventDefault();
	return false;
},false);