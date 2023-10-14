
local page_start
local page_end
local message_index

local phonics

--[[phonics = {
	a={name="a", length=.65, gain=1, also_silent=0},
	au={name="au", length=.6, gain=1, also_silent=0}, 
	b={name="b", length=.35, gain=1, also_silent=0},	
	c={name="c", length=.65, gain=1, also_silent=0},	
	ch={name="ch", length=.17, gain=1, also_silent=0},
	d={name="d", length=.77, gain=1, also_silent=0},
	e={name="e", length=.5, gain=1, also_silent=0},	
	f={name="f", length=.7, gain=1, also_silent=0},
	g={name="g", length=.14, gain=1, also_silent=0},
	h={name="h", length=.0, gain=0, also_silent=0},
	i={name="i", length=.64, gain=1, also_silent=1},  --  silent for viente?
	j={name="j", length=.48, gain=1, also_silent=0},	
	k={name="k", length=.3, gain=1, also_silent=0},	
	l={name="l", length=.65, gain=1, also_silent=0},
	ll={name="ll", length=.20, gain=1, also_silent=0},	--used javanese text 
	m={name="m", length=.65, gain=1, also_silent=0},
	n={name="n", length=.65, gain=1, also_silent=0},	
 	_n={name="~n", length=.17, gain=50, also_silent=0},  --***need sound & length
	o={name="o", length=.65, gain=1, also_silent=0},
	p={name="p", length=.35, gain=1, also_silent=0},	
	q={name="q", length=.3, gain=1, also_silent=0},	
	r={name="r", length=.65, gain=1, also_silent=0},
	rr={name="rr", length=.47, gain=1, also_silent=0},	--should use tahoma 16
	s={name="s", length=.65, gain=1, also_silent=0},
	t={name="t", length=.3, gain=1, also_silent=0},	
	u={name="u",length=.65, gain=1, also_silent=1},	-- silent for aqui	
	v={name="v", length=.65, gain=1, also_silent=0},   --sometimes makes makes a sound like a v or halfway between a "v" & a "b"
	w={name="w", length=.45, gain=1, also_silent=0},	
	x={name="x", length=.6, gain=1, also_silent=0},  
	y={name="y", length=.84, gain=1, also_silent=0},			
	z={name="z", length=.65, gain=1, also_silent=0}
}

two_char_phonics = {
	au= {name="au"},
	ch= {name="ch"},
	ll= {name="ll"},
	rr= {name="rr"}	
}

three_char_phonics = {
	--ing= {name="ing"}
}

--]]

function register_nodes(phonics, language, write_command)

	minetest.register_chatcommand(write_command, {
		params = "<message>",
		description = "Write phonics message on a page in "..language,
		privs = {shout=true},
		func = function(name, param)
			if page_start == nil or page_end == nil then minetest.chat_send_player(name, "You need to create a page first") return end
			write_message(string.lower(param))
		end,		})
		
	function write_message(param)
		write_message_to_page(param)		
	end	

	for key,value in pairs(phonics) do
		minetest.register_node(language..":"..key, {
		description = key,
		tiles = {"phonics_"..key..".jpg"},
		is_ground_content = true,
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
		on_punch = function(pos, node, puncher) 
	--		minetest.chat_send_all("phonic.on_punch:" .. pos.x ..">" )
			hit_with = puncher:get_wielded_item()
			wear=hit_with:get_wear()
			if wear == 0 then       
				activate_node({pos, key, phonics[key].length})
			end
		end,	
		})
		minetest.register_node(language..":"..key.."_active", {
		description = key.."_active",
		tiles = {"phonics_"..key.."_active.png"},
		light_source = 20,
		is_ground_content = true,
		groups = {cracky=3, choppy=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		})	
		if  phonics[key].also_silent ==1 then	
			minetest.register_node(language..":0"..key, {
			description = "Silent "..key,
			tiles = {"phonics_0"..key..".png"},
			is_ground_content = true,
			groups = {cracky=3, choppy=3},
			sounds = default.node_sound_stone_defaults(),
			})	
		end
	end


	minetest.register_node(language..":question_mark", {
		description = "Question Mark",
		tiles = {
		"question_mark.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	--	on_punch = function(pos, node, puncher)      
	--	end
	})
	minetest.register_node(language..":exclamation_point", {
		description = "Exclamation Point",
		tiles = {
		"exclamation_point.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	--	on_punch = function(pos, node, puncher)      
	--	end
	})
	minetest.register_node(language..":period", {
		description = "Period",
		tiles = {
		"period.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	--	on_punch = function(pos, node, puncher)      
	--	end
	})

	minetest.register_node(language..":SayWord", {
		description = "say word",
		tiles = {
		"white.jpg",
		"white.jpg",
		"SpeakingMouth64.png",
		"SpeakingMouth64.png",
		"SpeakingMouth64.png",
		"SpeakingMouth64.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
		on_punch = function(pos, node, puncher) 
			sound_out_word(pos, "x", 1, language,phonics)
			sound_out_word(pos, "x", -1, language,phonics)
			sound_out_word(pos, "z", 1, language,phonics)
			sound_out_word(pos, "z", -1, language,phonics)       
		end
	})




	minetest.register_node(language..":PaperStart", {
		description = "Paper Start",
		tiles = {
		"white.jpg",
		"white.jpg",
		"nicubunu_Scroll.png",
		"nicubunu_Scroll.png",
		"nicubunu_Scroll.png",
		"nicubunu_Scroll.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
		after_place_node = function(pos)        
			get_page_start_loc(pos)
		end,
		on_punch = function(pos, node, puncher)        
			clear_page(pos, language)
		end--[[,		
		on_dig = function(pos_dig,node)
			replace_page(pos_dig, "x", 1, "air")
			replace_page(pos_dig, "x", -1, "air")
			replace_page(pos_dig, "z", 1, "air")
			replace_page(pos_dig, "z", -1, "air")
			replace_column(pos_dig, "air")
		end,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local player = digger:get_player_name()
			local itemstack = ItemStack(language..":PaperStart")
			local inv = minetest.get_inventory({type = "player", name = player})

			if inv and inv:room_for_item("main", itemstack) then
				inv:add_item("main", itemstack)
			else
				-- If the player's inventory is full, spawn the item on the ground
				minetest.add_item(pos, itemstack)
			end
		end]]
	})

	minetest.register_node(language..":PaperFinish", {
		description = "Paper Finish",
		tiles = {
		"white.jpg",
		"white.jpg",
		"finish_line_flag_pin_th.png",
		"finish_line_flag_pin_th.png",
		"finish_line_flag_pin_th.png",
		"finish_line_flag_pin_th.png",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
		after_place_node = function(pos)
			blank_page(pos)
		end
	})
	minetest.register_node(language..":BlankPaper", {
		description = "Blank Paper",
		tiles = {
		"white.jpg",
		"white.jpg",
		"white.jpg",
		"white.jpg",
		"white.jpg",
		"white.jpg",},
		is_ground_content = true,
			paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

function clear_page(pos, language)
	local clear_pos = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
      clear_pos.x = pos.x 
      clear_pos.y = pos.y 
      clear_pos.z = pos.z 

	replace_page(clear_pos, "x", 1, language..":BlankPaper")
	replace_page(clear_pos, "x", -1, language..":BlankPaper")
	replace_page(clear_pos, "z", 1, language..":BlankPaper")
	replace_page(clear_pos, "z", -1, language..":BlankPaper")
	replace_column(clear_pos, language..":BlankPaper")
	page_start = pos
	page_end = pos
end
	    



function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local play_sound = function(list, soundname)
		local gain = 1.0
		local handler = minetest.sound_play("phonics_"..soundname, {gain=gain})
end

function revertnode(parms)  
 	local pos3 = parms[1]
 	local node3= parms[2]
 	minetest.env:remove_node(pos3,{name=language..":"..node3.."_active"})
 	minetest.env:place_node(pos3,{name=language..":"..node3})
end

function activate_node(anparms)
	local pos2 = anparms[1]
	local nodename = anparms[2]
	local duration = anparms[3]
 	minetest.env:remove_node(pos2,{name=language..":"..nodename})
 	minetest.env:place_node(pos2,{name=language..":"..nodename.."_active"}) 
 	play_sound(phonics, nodename) 
 	local np = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
              np.x = pos2.x 
              np.y = pos2.y 
              np.z = pos2.z 
 	minetest.after(duration, revertnode, {np, nodename})		
end

function sound_out_word(pos1, axis, direction, language,phonics)
	local cumulative_delay = 0
	local mpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      mpos.x = pos1.x 
      mpos.y = pos1.y 
      mpos.z = pos1.z 
--see if there are any sounds next to mouth on this axis.  (or if there is a BlankPage before it.) If not, do nothing.  
	local test_pos = {} 
      test_pos.x = pos1.x 
      test_pos.y = pos1.y 
      test_pos.z = pos1.z 
	if axis == "x" then
		test_pos.x=test_pos.x+direction
	end	
	if axis == "z" then
		test_pos.z=test_pos.z+direction
	end	
	local test_nodename = minetest.env:get_node(test_pos).name 
	local test_nodenamearray = split(test_nodename, ":")
	local test_nodename_prefix = test_nodenamearray[1]
	local test_nodename_suffix = test_nodenamearray[2]
	--see if blank page before it		
	if axis == "x" then
		test_pos.x=test_pos.x-(direction*2)
	end	
	if axis == "z" then
		test_pos.z=test_pos.z-(direction*2)
	end			
	local b4_nodename = minetest.env:get_node(test_pos).name 			
	if b4_nodename ~=language..":BlankPaper" then	
	   	if test_nodename_prefix ~=language or test_nodename_suffix == "BlankPaper" or test_nodename_suffix =="PaperStart" then 
	   		return
	    end
	end
    
    local row_count = 1
    repeat  --go to next row 1 time    	      
		repeat  --continue sounding on this row until you reach blank paper or a non phonics node
			if axis == "x" then
				mpos.x=mpos.x+direction
			end	
			if axis == "z" then
					mpos.z=mpos.z+direction
			end	
			local nodename = minetest.env:get_node(mpos).name 
			local nodenamearray = split(nodename, ":")
			local nodename_prefix = nodenamearray[1]
			local nodename_suffix = nodenamearray[2]
			local delay = phonics[nodename_suffix]
			if  delay ~=nil and nodename_prefix ==language  then 		
				local lpos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
	              lpos.x = mpos.x 
	              lpos.y = mpos.y 
	              lpos.z = mpos.z 	
				minetest.after(cumulative_delay, activate_node, {lpos, nodename_suffix, phonics[nodename_suffix].length}) 
				cumulative_delay = cumulative_delay + phonics[nodename_suffix].length 
			end
		until nodename_prefix ~=language or nodename_suffix == "BlankPaper"
--if I will find a BlankPaper in this row, then dont look in next row
		local find_blank_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      	find_blank_pos.x = mpos.x 
      	find_blank_pos.y = mpos.y 
      	find_blank_pos.z = mpos.z 	
		repeat
			--is this node BlankPaper?
			local find_blank_nodename = minetest.env:get_node(find_blank_pos).name 
			local find_blank_nodenamearray = split(find_blank_nodename, ":")
			local find_blank_nodename_prefix = find_blank_nodenamearray[1]
			local find_blank_nodename_suffix = find_blank_nodenamearray[2]			
			if find_blank_nodename_suffix == "BlankPaper" then
				return
			end			
			--if not, increment pointer and repeat search
			if axis == "x" then
				find_blank_pos.x=find_blank_pos.x+direction
			end	
			if axis == "z" then
					find_blank_pos.z=find_blank_pos.z+direction
			end			
		until find_blank_nodename_prefix ~=language--prefix not phonics

--we're not done, so search next row for more phonics to sound out
		local new_row_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      	new_row_pos.x = mpos.x 
      	new_row_pos.y = mpos.y 
      	new_row_pos.z = mpos.z 	
		new_row_pos.y=new_row_pos.y-1		
		if nodename_suffix == "BlankPaper" then 
			return
		end
		repeat  --go to the beginning of the new row				
			if axis == "x" then
				new_row_pos.x=new_row_pos.x-direction
			end	
			if axis == "z" then
					new_row_pos.z=new_row_pos.z-direction
			end	
			local new_row_nodename = minetest.env:get_node(new_row_pos).name 
			local new_row_nodenamearray = split(new_row_nodename, ":")
			local new_row_nodename_prefix = new_row_nodenamearray[1]
			local new_row_nodename_suffix = new_row_nodenamearray[2]
			mpos.x = new_row_pos.x 
			mpos.y = new_row_pos.y
			mpos.z = new_row_pos.z
		until new_row_nodename_prefix ~=language
		row_count= row_count +1
	until row_count >2 or nodename_suffix == "BlankPaper"
end

function write_message_to_page(message)
	local start_page_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
    start_page_pos.x = page_start.x 
    start_page_pos.y = page_start.y 
    start_page_pos.z = page_start.z 	
	local start_message_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      start_message_pos.x = page_start.x 
      start_message_pos.y = page_start.y 
      start_message_pos.z = page_start.z 
	write_message_to_page_on_axis(start_message_pos, "x", 1, message)
	write_message_to_page_on_axis(start_message_pos, "x", -1, message)
	write_message_to_page_on_axis(start_message_pos, "z", 1, message)
	write_message_to_page_on_axis(start_message_pos, "z", -1, message)	
end

function write_message_to_page_on_axis(pos, axis, direction,message)
	local page_position = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
    page_position.x = pos.x 
    page_position.y = pos.y 
    page_position.z = pos.z 
    message_index = 1
    --if the first node after the PageStart node is not a phonic, skip everything.
    local first_position = {}    
    first_position.x = pos.x 
    first_position.y = pos.y 
    first_position.z = pos.z 
    if axis=="x" then
    	first_position.x = first_position.x +direction
    end
    if axis=="z" then
    	first_position.z = first_position.z +direction
    end
    local first_nodename = minetest.env:get_node(first_position).name 
	local firstnamearray = split(first_nodename, ":")
	local firstname_prefix = firstnamearray[1]
	if firstname_prefix == language then  --we have phonics on this axis		      
		repeat
			local current_nodename = minetest.env:get_node(page_position).name 
			local nodenamearray = split(current_nodename, ":")
			local nodename_prefix = nodenamearray[1]
			local nodename_suffix = nodenamearray[2]
			write_page_row(page_position, axis, direction,message)
			page_position.y = page_position.y-1
		until nodename_prefix ~=language or message_index > string.len(message)		
	end
end


function write_page_row(pos, axis, direction, message)
	local replace_pointer = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
	replace_pointer.x = pos.x 
    replace_pointer.y = pos.y 
    replace_pointer.z = pos.z 
	local nodename = minetest.env:get_node(replace_pointer).name 
	if nodename==language..":PaperStart" then
		if axis == "x" then
			replace_pointer.x=replace_pointer.x+direction
			new_nodename =language..":SayWord" 
			minetest.env:add_node(replace_pointer, {name=new_nodename})	
			replace_pointer.x=replace_pointer.x+direction
		end	
		if axis == "z" then
			replace_pointer.z=replace_pointer.z+direction
			new_nodename =language..":SayWord"
			minetest.env:add_node(replace_pointer, {name=new_nodename})	
			replace_pointer.z=replace_pointer.z+direction
		end	
	end	
--1get me node at current location
--2if node prefix is phonics then replace node with next phonic in the message
--3(and have some code behind the scenes automatically bump the message_index)
--4increment the replace pointer
--5repeat 1-4 until node prefix at current location is not phonics	
	repeat
		local nodename = minetest.env:get_node(replace_pointer).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if nodename_prefix ==language  then 			
			if new_nodename ==language..":BlankPaper" then
			--if we had a space between words then inject sayword block into stream
				new_nodename =language..":SayWord"
				minetest.env:add_node(replace_pointer, {name=new_nodename})				
			else
				new_nodename = get_next_phonic_in_message(message)
				if minetest.registered_nodes[new_nodename] then
					minetest.env:add_node(replace_pointer, {name=new_nodename})	--*******************************************		
				end
			end	
			if minetest.registered_nodes[new_nodename] then
				if axis == "x" then
					replace_pointer.x=replace_pointer.x+direction
				end	
				if axis == "z" then
					replace_pointer.z=replace_pointer.z+direction
				end				
			end
		end
	until nodename_prefix ~=language or message_index > string.len(message)	
end

function get_next_phonic_in_message(message)
--and have some code behind the scenes automatically bump the message_index	
	string.len(message)
	if message_index <= string.len(message) then
		local current_char_in_message = string.sub(message,message_index,message_index)	
		phonic_builder = current_char_in_message
		--if currentchar=" " then just set cpim to blankPaper and skip all the char business"
		if current_char_in_message==" " then 
			current_phonic_in_message = language..":BlankPaper"
		elseif current_char_in_message=="." then 
			current_phonic_in_message = language..":period"
		elseif current_char_in_message=="?" then 
			current_phonic_in_message = language..":question_mark"			
		elseif current_char_in_message=="!" then 
			current_phonic_in_message = language..":exclamation_point"						
		else
			if current_char_in_message == "0" or current_char_in_message == "_" then			
				message_index = message_index +1
				current_char_in_message = string.sub(message,message_index,message_index)		
				phonic_builder = phonic_builder..current_char_in_message
			end	
			char_after_current_char = string.sub(message,message_index+1,message_index+1)
			third_char = string.sub(message,message_index+2,message_index+2)
			two_chars = current_char_in_message..char_after_current_char
			three_chars = two_chars..third_char
			--minetest.log("x", "phonic_builder: "..phonic_builder)
			--minetest.log("x", "phonic_builder 1st char: "..string.sub(phonic_builder,1,1))
			--minetest.log("x", "two_chars: "..two_chars)
			--check to see if this is a 2 character phonic.  But only if it doesn't begin with an "_" or if it is _oo.
			--this is because the only two character phonic that can use the "_" prefix is the "_oo" phonic.
			if (two_char_phonics[two_chars] ~= nil and string.sub(phonic_builder,1,1) ~= "_" and string.sub(phonic_builder,1,1) ~= "0") or (two_chars == "oo" and string.sub(phonic_builder,1,1) ~= "0") then										
				phonic_builder = phonic_builder..char_after_current_char
				message_index = message_index +1
			end	
			if (three_char_phonics[three_chars] ~= nil and string.sub(phonic_builder,1,1) ~= "_" and string.sub(phonic_builder,1,1) ~= "0")then						
				phonic_builder = phonic_builder..string.sub(message,message_index+1,message_index+2)
				message_index = message_index +2
			end			
			current_phonic_in_message = language..":"..phonic_builder
		end
		message_index = message_index +1	
	else
		current_phonic_in_message = language..":BlankPaper"
	end 	
	return current_phonic_in_message			
end

function replace_page(pos, axis, direction,new_nodename)
	local replace_row_pos = {}  --needed this because the node being passed to revertnode was incremented (must have been by reference
      replace_row_pos.x = pos.x 
      replace_row_pos.y = pos.y 
      replace_row_pos.z = pos.z 
	repeat
		local current_nodename = minetest.env:get_node(replace_row_pos).name 
		local nodenamearray = split(current_nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		replace_page_row(replace_row_pos, axis, direction,new_nodename)
		replace_row_pos.y = replace_row_pos.y-1
	until nodename_prefix ~=language	
end

function replace_column(pos, new_nodename)
	replace_column_pos= pos
	repeat
		local current_nodename = minetest.env:get_node(replace_column_pos).name 
		local nodenamearray = split(current_nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if nodename_prefix ==language then	
			if new_nodename =="air" then					
				minetest.env:add_node(replace_column_pos, {name=new_nodename})			
			end
			if new_nodename ==language..":BlankPaper" and current_nodename ~=language..":PaperStart" then					
				minetest.env:add_node(replace_column_pos, {name=new_nodename})			
			end
		end
		replace_column_pos.y = replace_column_pos.y-1
	until nodename_prefix ~=language
end

function replace_page_row(pos, axis, direction, new_nodename)
	local replace_pointer = {} --needed this because the node being passed to revertnode was incremented (must have been by reference
	replace_pointer.x = pos.x 
    replace_pointer.y = pos.y 
    replace_pointer.z = pos.z 	
	repeat
		if axis == "x" then
			replace_pointer.x=replace_pointer.x+direction
		end	
		if axis == "z" then
			replace_pointer.z=replace_pointer.z+direction
		end	
		local nodename = minetest.env:get_node(replace_pointer).name 
		local nodenamearray = split(nodename, ":")
		local nodename_prefix = nodenamearray[1]
		local nodename_suffix = nodenamearray[2]
		if  nodename_prefix ==language  then 		
			minetest.env:add_node(replace_pointer, {name=new_nodename})
		end
	until nodename_prefix ~=language	
end

function get_page_start_loc(pos)
	page_start = pos
end

function blank_page(pos)
	page_end = pos
	if page_start ~= nil and math.abs(page_start.x-page_end.x) <20 and math.abs(page_start.y-page_end.y) <20 and math.abs(page_start.z-page_end.z) <20 then 
		if page_end.y <= page_start.y then  --if the page end block was placed at or below page start block
			if page_end.x == page_start.x then
				buildwall(page_start.z, pos.z, page_start.y, pos.y, "x", pos.x, language..":BlankPaper")	
			end
			if page_end.z == page_start.z then  
				buildwall(page_start.x, pos.x, page_start.y, pos.y, "z", pos.z, language..":BlankPaper")	
			end	
		end	
	end 
end

function buildwall(hstart, hend, ystart, yend, haxis, haxis_fixed, nodename)	
	repeat
	buildrow(hstart, hend, ystart, haxis, haxis_fixed, nodename)
	ystart = ystart -1
	until ystart < yend
end

function buildrow(hstart, hend, y, haxis, haxis_fixed, nodename)
	local hpos = math.min(hstart, hend)
	local hmax = math.max(hstart, hend)
	local current_pos={}
	current_pos.y = y
	repeat
		if haxis =="x" then
			current_pos.z = hpos
			current_pos.x = haxis_fixed		
		end
		if haxis =="z" then
			current_pos.x = hpos
			current_pos.z = haxis_fixed		
		end	
		if minetest.env:get_node(current_pos).name ~= language..":PaperStart" then   --leave paperstart node there.
			minetest.env:add_node(current_pos, {name=nodename})
		end
		hpos = hpos +1
	until hpos> hmax
end


 
--turn the phonics nodes into ores:

-- Function to generate the phonics nodes underground

--[[phonics_scarcity = tonumber(minetest.settings:get("phonics_scarcity")) or 350]]

function register_ores(phonics, language, phonics_scarcity)
if phonics_scarcity >0 then
	-- Register nodes based on the phonics data
		for key, value in pairs(phonics) do
			-- Generate the nodes underground using the register_ore function
			minetest.register_ore({
				ore_type       = "scatter",
				ore            = language..":" .. key,
				wherein        = "default:stone",
				clust_scarcity = phonics_scarcity,
				clust_num_ores = 1,
				clust_size     = 1,
				y_min          = -31000,  -- Adjust these values for your desired depth range
				y_max          = 100,
			})

			if  phonics[key].also_silent ==1 then	
				minetest.register_ore({
					ore_type       = "scatter",
					ore            = language..":0" .. key,
					wherein        = "default:stone",
					clust_scarcity = phonics_scarcity,
					clust_num_ores = 1,
					clust_size     = 1,
					y_min          = -31000,  -- Adjust these values for your desired depth range
					y_max          = 100,
				})
			end
		end
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":SayWord",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":PaperStart",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":PaperFinish",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":period",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":exclamation_point",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})

		minetest.register_ore({
			ore_type       = "scatter",
			ore            = language..":question_mark",
			wherein        = "default:stone",
			clust_scarcity = phonics_scarcity,
			clust_num_ores = 1,
			clust_size     = 1,
			y_min          = -31000,  -- Adjust these values for your desired depth range
			y_max          = 100,
		})
	end
end

--[[local dpath = minetest.get_modpath("spanish") .. "/"
dofile(dpath .. "crafting.lua")
print("Spanish Mod Loaded!")]]
 	--minetest.env:punch_node(pos) 
 	--minetest.env:dig_node(pos) 
 	--http://minetest.net/forum/viewtopic.php?id=2602
 	--https://c9.io/lkjoel/minetest-modder/workspace/parseme.txt
