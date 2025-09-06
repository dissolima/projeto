
-- Libs Toca do Aranha

function mathtime(table)
local unit = {"sec", "min", "hour", "day"}
for i, v in pairs(unit) do
if v == table[2] then
return table[1]*(60^(v == unit[4] and 2 or i-1))*(v == unit[4] and 24 or 1)
end
end
return error("Bad declaration in mathtime function.")
end

function getAllMonstersInArea(fromPosition, toPosition)
    local monsters = {}
    local f = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z}
    local t = {x = toPosition.x, y = toPosition.y, z = toPosition.z}
    local min = (fromPosition.z > toPosition.z and toPosition.z or fromPosition.z)
    for index = 0, math.abs(toPosition.z - fromPosition.z) do
        f.z = min + index
        for x = f.x, t.x do
            for y = f.y, t.y do
                local pos = {x = x, y = y, z = f.z}
                local monster = getTopCreature(pos).uid
                if monster > 0 and isMonster(monster) then
                    table.insert(monsters, monster)
                end
            end
        end
    end
    return monsters
end

function getPointsToNextRank(cid)
    local rank = GRADUATION.getPlayerElo(cid)
    local nextRank = GRADUATION.RANKS[rank.rankId+1]    
    local eloPoints = GRADUATION.getEloPoints(cid)
    if not nextRank then return -1 end   
    return nextRank.minPoints - eloPoints
end 

function setItemUniqueOwner(cid, uid)
	local thing = getThing(uid)
	local itemInfo = getItemInfo(thing.itemid)
	if (not itemInfo) then
		print("[setItemUniqueOwner] Invalid item with id " .. thing.itemid)
		return
	end
	
	doItemSetAttribute(uid, "uniqueowner", getPlayerGUID(cid))
	doItemSetAttribute(uid, "name", "[Unique] " .. itemInfo.name)
	doItemSetAttribute(uid, "pluralname", "[Unique] " .. itemInfo.plural)
	
	local desc = itemInfo.description
	doItemSetAttribute(uid, "description", ((desc ~= "") and (desc .. "\n") or "") .. getCreatureName(cid) .. " é dono deste item.")
end

function isWalkable(pos, creature, proj, pz)
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
    if getTopCreature(pos).uid > 0 and creature then return false end
    if getTileInfo(pos).protection and pz then return false, true end
    local n = not proj and 2 or 2
    for i = 0, 255 do
        pos.stackpos = i
        local tile = getTileThingByPos(pos)
        if tile.itemid ~= 0 and not isCreature(tile.uid) then
            if hasProperty(tile.uid, n) or hasProperty(tile.uid, 7) then
                return false
            end
        end
    end
    return true
end


function doTeleportThingAround(cid, pos, rangex, rangey)
    local newpos = {x = pos.x + math.random(-rangex, rangex), y = pos.y, math.random(-rangey, rangey), z = pos.z}
    doTeleportThing(cid, newpos)
end

function round(num, n)
  local m = 10^(n or 0)
  return math.floor(num*m + 0.5)/m
end

function getStrTime(table)
local unit = {["sec"] = "second",["min"] = "minute",["hour"] = "hour",["day"] = "day"}
return tostring(table[1].." "..unit[table[2]]..(table[1] > 1 and "s" or ""))
end

function getItemsFromTab(items)
    local str = ''
    if table.maxn(items) > 0 then
        for i = 1, table.maxn(items) do
            local count, itemName = items[i][2], getItemNameById(items[i][1]) 
            str = str .. count .. ' ' .. itemName ..  addPlural(count, "s", itemName)
            if i ~= table.maxn(items) then 
                str = str .. ', ' 
            end 
        end
    end
    return str
end

function getItemNameById(itemid)
	return getItemDescriptionsById(itemid).name
end

function addPlural(counter, windup, word)
    if counter <= 1 then return "" end
    return not word and windup or (word:sub(-1,-1) ~= windup and windup or "")
end

function gettime(s)

   local h = math.floor(s/3600)

   local m = math.floor((s - h * 3600) / 60)

   return h, m, (s - h * 3600) - m * 60

end

function BlockRunesInArea(cid)
local block_area = { -- defina as areas
{{x=1082,y=672,z=8}, {x=1201,y=693,z=8}}, -- com a pos começo e final da area
{{x=1095,y=655,z=7}, {x=1193,y=720,z=7}},
{{x=1096,y=657,z=6}, {x=1186,y=712,z=6}},
{{x=1011,y=746,z=7}, {x=1029,y=765,z=7}},
{{x=1466,y=1247,z=7}, {x=1727,y=1305,z=7}}

}
for _, var in ipairs(block_area) do
if isInRange(getCreaturePosition(cid), var[1], var[2]) then
return true
end
end
return false
end

function isMonster(cid)
	return isCreature(cid) and cid >= AUTOID_MONSTERS and cid < AUTOID_NPCS
end

function doPlayerGiveItem(cid, itemid, amount, subType)
	local item = 0
	if(isItemStackable(itemid)) then
		item = doCreateItemEx(itemid, amount)
		if(doPlayerAddItemEx(cid, item, true) ~= RETURNVALUE_NOERROR) then
			return false
		end
	else
		for i = 1, amount do
			item = doCreateItemEx(itemid, subType)
			if(doPlayerAddItemEx(cid, item, true) ~= RETURNVALUE_NOERROR) then
				return false
			end
		end
	end

	return true
end

function doRemoveItemsFromTab(cid,items)
    local count = 0
    if table.maxn(items) > 0 then
        for i = 1, table.maxn(items) do
            if getPlayerItemCount(cid,items[i][1]) >= items[i][2] then
                count = count + 1 
            end 
        end 
    end
    if count == table.maxn(items) then
        for i = 1, table.maxn(items) do doPlayerRemoveItem(cid,items[i][1],items[i][2]) end
    else 
        return false 
    end
    return true 
end

function doPlayerAddRateTime(cid, type, added_value, time)
    local actual_rate = getPlayerExtraRate(cid, type)
    doPlayerSetRate(cid, type, (1 + (.01 * added_value)) + actual_rate)
    if time then
        addEvent(function()
            if isPlayer(cid) then
                doPlayerAddRateTime(cid, type, -added_value)
                print("acabou")
            end
        end, time * 1000)
    end
end

function getPlayerExtraRate(cid, type)
    return (getPlayerRates(cid)[type]-1)
end

function getPlayerLastLogout(cid, date_string)
    local query = db.getResult("SELECT `lastlogout` as `logout_time` FROM `players` WHERE `id` = " .. getPlayerGUID(cid) .. ";")
    if query:getID() == -1 then
        return false
    end
    local logoutTime = query:getDataInt("logout_time")
    return not date_string and logoutTime or os.date("%d %B %Y %X", logoutTime)
end

function getPlayerLastLogout(cid, date_string)
    local query = db.getResult("SELECT `lastlogout` as `logout_time` FROM `players` WHERE `id` = " .. getPlayerGUID(cid) .. ";")
    if query:getID() == -1 then
        return false
    end
    local logoutTime = query:getDataInt("logout_time")
    return not date_string and logoutTime or os.date("%d %B %Y %X", logoutTime)
end

function getStringTime(time, low_precision)
    local checkTime = time
    local unit = {{86400,"day"},{3600,"hour"},{60,"min"},{1,"sec"}}
    local strs, str, n = {}, "", 1
    if time == 1 then
        return string.format("1 %s", unit[4][2])
    elseif time <= 0 then
        return 0 
    end
    while time > 1 do
        local k = unit[n]
        if time > k[1] then
            local t, s = math.floor(time/k[1]), k[2]
            table.insert(strs, t.." "..(t > 1 and s.."s" or s))
            time = time % k[1]
        end
        n = n + 1
    end
    if not low_precision then
        for i = 1, #strs do
            str = str..strs[i]..(i == #strs-1 and " and " or i == #strs and "" or ", ")
        end
    else
        if #strs > 1 then
            if checkTime > 60 then
                str = "about "..strs[1]
            end
        else
            str = strs[1]
        end
    end
    return str
end

function getPlayersInArea(fromPos, toPos)
    local players = {}
    for _, pid in ipairs(getPlayersOnline()) do
      if isInRange(getPlayerPosition(pid), fromPos, toPos) then
         table.insert(players, pid)
      end
    end
    return players
end

function getStringTime(time, low_precision)
    local checkTime = time
    local unit = {{86400,"day"},{3600,"hour"},{60,"min"},{1,"sec"}}
    local strs, str, n = {}, "", 1
    if time == 1 then
        return string.format("1 %s", unit[4][2])
    elseif time <= 0 then
        return 0 
    end
    while time > 1 do
        local k = unit[n]
        if time > k[1] then
            local t, s = math.floor(time/k[1]), k[2]
            table.insert(strs, t.." "..(t > 1 and s.."s" or s))
            time = time % k[1]
        end
        n = n + 1
    end
    if not low_precision then
        for i = 1, #strs do
            str = str..strs[i]..(i == #strs-1 and " and " or i == #strs and "" or ", ")
        end
    else
        if #strs > 1 then
            if checkTime > 60 then
                str = "about "..strs[1]
            end
        else
            str = strs[1]
        end
    end
    return str
end

function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function setStorageTable(storage, tab, cid)
    local tabstr = "&"
    for i,x in pairs(tab) do
        tabstr = tabstr .. i .. "," .. x .. ";"
    end
    if not cid then
        return setGlobalStorageValue(storage, tabstr:sub(1, #tabstr-1))
    end
    return setPlayerStorageValue(cid, storage, tabstr:sub(1, #tabstr-1))
end

function setStorageTable(storage, tab, cid)
    local tabstr = "&"
    for i,x in pairs(tab) do
        tabstr = tabstr .. i .. "," .. x .. ";"
    end
    if not cid then
        return setGlobalStorageValue(storage, tabstr:sub(1, #tabstr-1))
    end
    return setPlayerStorageValue(cid, storage, tabstr:sub(1, #tabstr-1))
end

function getStorageTable(storage, cid)
local tabstr = getGlobalStorageValue(storage)
if cid then
    tabstr = getPlayerStorageValue(cid, storage)
end
local tab = {}
if type(tabstr) ~= "string" then
return {}
end
if tabstr:sub(1,1) ~= "&" then
return {}
end
local tabstr = tabstr:sub(2, #tabstr)
local a = string.explode(tabstr, ";")
for i,x in pairs(a) do
local b = string.explode(x, ",")
tab[tonumber(b[1]) or b[1]] = tonumber(b[2]) or b[2]
end
return tab
end

function addValueInTable(storage, value, cid)
    local x = {}
    for i = 1,#getStorageTable(storage, cid) do
        table.insert(x,getStorageTable(storage, cid)[i])
    end
    if x ~= 0 then
        table.insert(x,tonumber(value))
        setStorageTable(storage, x, cid)
    else
        setStorageTable(storage, {value}, cid)
    end
end

function addValueInTable(storage, value, cid)
    local x = {}
    for i = 1,#getStorageTable(storage, cid) do
        table.insert(x,getStorageTable(storage, cid)[i])
    end
    if x ~= 0 then
        table.insert(x,tonumber(value))
        setStorageTable(storage, x, cid)
    else
        setStorageTable(storage, {value}, cid)
    end
end

function getStorageTableValue(storage, index, cid)
    local tab = getStorageTable(storage, cid)
    return tab[index]
end

function setStorageTableValue(storage, index, value, cid)
    local x = {}
    local tab = getStorageTable(storage, cid)
    for i = 1, #tab do
        table.insert(x, tab[i])
    end
    if x[index] then
        x[index] = value
    end
    setStorageTable(storage, x, cid)
end

function doPlayerAddItemTab(cid, itemTable)
    if (not isItemStackable(itemTable[1]) and itemTable[2] > 1) then
        for k = 1, itemTable[2] do
            doPlayerAddItem(cid, itemTable[1], 1)
        end
    else
        doPlayerAddItem(cid, itemTable[1], itemTable[2])
    end
    return true
end

function getGuildName(guildId)
local query = db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. guildId .. ";")
if query:getID() == -1 then
    return nil
end
local guildName = query:getDataString("name")
query:free()
return tostring(guildName)
end

function doPlayerAddItemTab(cid, itemTable)
    if (not isItemStackable(itemTable[1]) and itemTable[2] > 1) then
        for k = 1, itemTable[2] do
            doPlayerAddItem(cid, itemTable[1], 1)
        end
    else
        doPlayerAddItem(cid, itemTable[1], itemTable[2])
    end
    return true
end

function count(T) local count = 0 for _ in pairs(T) do count = count + 1 end return count end

function capitalizeAll(str)
    return str:lower():gsub("%w+", 
        function(w) 
          return w:sub(1,1):upper() .. w:sub(2)
    end)
end

function getStrItemsFromList(items)
    local str = ''
    if table.maxn(items) > 0 then
        for i = 1, table.maxn(items) do
            str = str .. items[i][2] .. ' ' .. getItemNameById(items[i][1])
            if i ~= table.maxn(items) then str = str .. ', ' end 
        end 
    end
    return str
end

function doCleanCustomArea(fromPos, toPos, clean_monsters)
    if clean_monsters then
        local monsters = getAllMonstersInArea(fromPos, toPos)
        if #monsters > 0 then
            for i = 1, #monsters do
                doRemoveCreature(monsters[i])
            end
        end
    end
    local positionsToClean = getAllWalkablePositionsInArea(fromPos, toPos)
    if #positionsToClean > 0 then
        for i = 1, #positionsToClean do
            doCleanTile(positionsToClean[i])
        end
    end
end

function getAllWalkablePositionsInArea(fromPosition, toPosition)
    local positions = {}
    local f = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z}
    local t = {x = toPosition.x, y = toPosition.y, z = toPosition.z}
    local min = (fromPosition.z > toPosition.z and toPosition.z or fromPosition.z)
    for index = 0, math.abs(toPosition.z - fromPosition.z) do
        f.z = min + index
        for x = f.x, t.x do
            for y = f.y, t.y do
                local pos = {x = x, y = y, z = f.z}
                local tile = getTileThingByPos(pos)
                if tile.itemid ~= 0 then
                    if not hasProperty(tile.uid, CONST_PROP_BLOCKSOLID) then
                        table.insert(positions, pos)
                    end
                end
            end
        end
    end
    return positions
end