math.randomseed(os.mtime())

EffectQueue = {}
function EffectQueue:new()
	return setmetatable({ effects = {} }, { __index = self })
end

function EffectQueue:add(effect, position)
	self.effects[#self.effects + 1] = { effect, { x = position.x, y = position.y, z = position.z } }
end

function EffectQueue:execute()
	for i = 1, #self.effects do
		local t = self.effects[i]
		doSendMagicEffect(t[2], t[1])
	end
end

function EffectQueue:clear()
	if (self.effects) then
		self.effects = {}
	end
end

function isvalidnumber(n)
	local inf = math.huge
	return type(n) == "number" and n == n and n ~= inf and n ~= -inf
end

function string.front(s)
	return s:sub(1, 1)
end

function string.back(s)
	return s:sub(#s, #s)
end

function formatStrTime(t, mode)
	mode = mode or 1
	local d = math.floor(t / 86400)
	local h = math.floor(t / 3600)
	local m = math.floor(t / 60) % 60
	local s = math.floor(t % 60)

	local str = ""
	if (mode == 1) then
		h = h % 24
		if (d > 0) then str = str .. d .. " dia" .. (d > 1 and "s, " or ", ") end
		if (h > 0) then str = str .. h .. " hora" .. (h > 1 and "s, " or ", ") end
		if (m > 0) then str = str .. m .. " minuto" .. (m > 1 and "s, " or ", ") end
		if (s > 0 or str == "") then str = str .. s .. " segundo" .. (s > 1 and "s, " or ", ") end
		str = (str:sub(1, #str - 2):gsub("(.+), ", "%1 e ", 1))
	else
		if (h > 0) then
			str = string.format("%02d:%02d:%02d", h, m, s)
		else
			str = string.format("%02d:%02d", m, s)
		end
	end
	return str
end

function getAreaCreatures(area, full, ignoreStaff)
	local data = {
		creatures = {},
		players = {},
		monsters = {},
		npcs = {}
	}

	if (full) then
		data.summons = {}
		data.nonSummonMonsters = {}
		data.playersSummons = {}
		data.monstersSummons = {}
	end

	local rangeX = math.ceil((area.to.x - area.from.x) / 2)
	local rangeY = math.ceil((area.to.y - area.from.y) / 2)
	local center = { x = area.from.x + rangeX, y = area.from.y + rangeY }

	for floor = area.from.z, area.to.z do
		center.z = floor
		local spectators = getSpectators(center, rangeX, rangeY, false)
		if (spectators) then
			for i = 1, #spectators do
				local cid = spectators[i]
				data.creatures[#data.creatures + 1] = cid
				if (isPlayer(cid) and (not ignoreStaff or not getPlayerCustomFlagValue(cid, 5))) then
					data.players[#data.players + 1] = cid
				elseif (isMonster(cid)) then
					data.monsters[#data.monsters + 1] = cid
					if (full) then
						local master = getCreatureMaster(cid)
						if (master) then
							data.summons[#data.summons + 1] = cid
							if (isPlayer(master)) then
								data.playersSummons[#data.playersSummons + 1] = cid
							elseif (isMonster(master)) then
								data.monstersSummons[#data.monstersSummons + 1] = cid
							end
						else
							data.nonSummonMonsters[#data.nonSummonMonsters + 1] = cid
						end
					end
				elseif (isNpc(cid)) then
					data.npcs[#data.npcs + 1] = cid
				end
			end
		end
	end
	return data
end

function setItemUniqueOwner(cid, uid)
	local thing = getThing(uid)
	errors(false)
	local itemInfo = getItemInfo(thing.itemid)
	errors(true)
	if (not itemInfo) then
		print(debug.traceback("Invalid item"))
		return
	end

	doItemSetAttribute(uid, "uniqueowner", getPlayerGUID(cid))
	doItemSetAttribute(uid, "name", "[Unique] " .. (getItemAttribute(uid, "name") or itemInfo.name))
	doItemSetAttribute(uid, "pluralname", "[Unique] " .. (getItemAttribute(uid, "pluralname") or itemInfo.plural))

	local desc = getItemAttribute(uid, "description") or itemInfo.description
	doItemSetAttribute(uid, "description", (desc ~= "" and (desc .. "\n") or "") .. getCreatureName(cid) .. " é dono desse item.")
end

function doPlayerAddUniqueItem(cid, id, count)
	local itemInfo = getItemInfo(id)
	local stackSize = 1
	if (itemInfo.stackable) then
		stackSize = 100
	end

	while (count > 0) do
		local addCount = math.min(stackSize, count)
		local item = doCreateItemEx(id, addCount)
		setItemUniqueOwner(cid, item)
		doPlayerAddItemEx(cid, item, true)
		count = count - addCount
	end
end

function doSendMagicEffectWO(position, eff, offset)
	position.x = position.x + offset.x
	position.y = position.y + offset.y
	doSendMagicEffect(position, eff)
	position.x = position.x - offset.x
	position.y = position.y - offset.y
end

function getCreatureStorageNum(cid, storage)
	local storageNum = tonumber(getCreatureStorage(cid, storage))
	if (not isvalidnumber(storageNum)) then
		storageNum = -1
	end
	return storageNum
end

function getStorageNum(storage)
	local storageNum = tonumber(getStorage(storage))
	if (not isvalidnumber(storageNum)) then
		storageNum = -1
	end
	return storageNum
end

function setCooldownTime(cid, storage, time)
	doCreatureSetStorage(cid, storage, time + os.time())
end

function getCooldownTime(cid, storage)
	return math.max(0, getCreatureStorageNum(cid, storage) - os.time())
end

function getItemNameByIdAndCount(id, count)
	errors(false)
	local itemInfo = getItemInfo(id)
	errors(true)

	local itemName = ""
	if (itemInfo) then
		itemName = count > 1 and itemInfo.plural or itemInfo.name
		if (count > 1 and itemName == "" and itemInfo.name ~= "") then
			itemName = itemInfo.name .. (itemInfo.name:back():lower() ~= "s" and "s" or "")
		end
	end

	if (itemName == "") then
		itemName = "UNKNOWN"
	end
	return itemName
end

function getFormattedItemName(id, count)
	errors(false)
	local itemInfo = getItemInfo(id)
	errors(true)

	local article
	if (count > 1 or not itemInfo or itemInfo.article == "") then
		article = count .. " "
	else
		article = itemInfo.article .. " "
	end

	local name = ""
	if (itemInfo) then
		name = count > 1 and itemInfo.plural or itemInfo.name
		if (name == "" and itemInfo.name ~= "") then
			name = itemInfo.name .. (itemInfo.name:back():lower() ~= "s" and "s" or "")
		end
	end

	if (name == "") then
		name = "UNKNOWN_ITEM"
	end
	return article .. name
end

function isWalkable(position, ignorePZ, ignoreCreatures)
	errors(false)
	local tileInfo = getTileInfo(position)
	errors(true)
	if (not tileInfo) then
		return false
	end

	if (tileInfo.protection and not ignorePZ) then
		return false
	end

	if (tileInfo.creatures > 0 and not ignoreCreatures) then
		return false
	end

	if (tileInfo.teleport) then
		return false
	end

	for i = 1, #tileInfo.floorChange do
		if (tileInfo.floorChange[i]) then
			return false
		end
	end

	local checkProps = { 0, 7, 12, 13 }
	local tmpPosition = { x = position.x, y = position.y, z = position.z }
	for stackpos = 0, 255 do
		tmpPosition.stackpos = stackpos
		errors(false)
		local tileThing = getThingFromPosition(tmpPosition)
		errors(true)
		if (tileThing.uid == 0) then
			break
		end

		-- 1 = creatures, 2 or more = items
		if (tileThing.itemid > 1) then
			for i = 1, #checkProps do
				if (hasItemProperty(tileThing.uid, checkProps[i])) then
					return false
				end
			end
		end
	end
	return true
end

function doCreatureSetPositionStorage(cid, storage, position)
	doCreatureSetStorage(cid, storage, string.format("|%d|%d|%d", position.x, position.y, position.z))
end

function getCreaturePositionStorage(cid, storage)
	local storageValue = tostring(getCreatureStorage(cid, storage))
	local x, y, z = storageValue:match("|(%d+)|(%d+)|(%d+)")
	if (x and y and z) then
		return { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
	end
	return nil
end

function doSetGlobalPositionStorage(storage, position)
	doSetStorage(storage, string.format("|%d|%d|%d", position.x, position.y, position.z))
end

function getGlobalPositionStorage(storage)
	local storageValue = tostring(getStorage(storage))
	local x, y, z = storageValue:match("|(%d+)|(%d+)|(%d+)")
	if (x and y and z) then
		return { x = tonumber(x), y = tonumber(y), z = tonumber(z) }
	end
	return nil
end

function genSerial(length)
	length = length or 11
	local serial = "S"
	for _ = 1, length do
		local bytechar = math.random(33, 126)
		if (bytechar == 92 --[[ "\" char ]]) then
			bytechar = 47 -- "/" char
		end
		serial = serial .. string.char(bytechar)
	end
	return serial
end

function teleportWithEffect(thing, position, effect, offset)
	effect = effect or CONST_ME_TELEPORT
	local fromEffectPosition = getThingPosition(thing)
	local toEffectPosition = { x = position.x, y = position.y, z = position.z }
	if (offset) then
		fromEffectPosition.x = fromEffectPosition.x + offset.x
		fromEffectPosition.y = fromEffectPosition.y + offset.y
		toEffectPosition.x = toEffectPosition.x + offset.x
		toEffectPosition.y = toEffectPosition.y + offset.y
	end

	local ret = doTeleportThing(thing, position, false)
	doSendMagicEffect(fromEffectPosition, effect)
	doSendMagicEffect(toEffectPosition, effect)
	return ret
end

function getFreePosition(position, maxDistance, ignorePZ, ignoreCreatures)
	maxDistance = maxDistance or 2
	if (isWalkable(position, ignorePZ, ignoreCreatures)) then
		return position
	end

	if (maxDistance > 0) then
		local tmpPosition = { z = position.z }
		for i = 1, maxDistance do
			for x = -i, i do
				tmpPosition.x = position.x + x
				for y = -i, i do
					tmpPosition.y = position.y + y
					if ((math.abs(x) == i or math.abs(y) == i) and
							isSightClear(position, tmpPosition, false) and
							isWalkable(tmpPosition, ignorePZ, ignoreCreatures)) then
						return tmpPosition
					end
				end
			end
		end
	end
	return position
end

function teleportToFreePosition(thing, position, maxDistance)
	local thingPosition = getThingPosition(thing)
	errors(false)
	local tileInfo = getTileInfo(thingPosition)
	errors(true)
	return teleportWithEffect(thing, getFreePosition(position, maxDistance, tileInfo and tileInfo.protection))
end

function isEqual(obj1, obj2, deepCheck)
	local obj1Type = type(obj1)
	if (obj1Type ~= type(obj2)) then
		return false
	end

	if (obj1Type == "table") then
		for k, v in pairs(obj1) do
			if ((not deepCheck and v ~= obj2[k]) or (deepCheck and not isEqual(v, obj2[k], deepCheck))) then
				return false
			end
		end
		for k, v in pairs(obj2) do
			if ((not deepCheck and v ~= obj1[k]) or (deepCheck and not isEqual(v, obj1[k], deepCheck))) then
				return false
			end
		end
		return true
	end
	return obj1 == obj2
end

function doPlayerSafeAddItem(cid, itemid, count, unique, rarity)
	local itemInfo = getItemInfo(itemid)
	local maxCount = (itemInfo.stackable and 100 or 1)
	local sentToDepot = false
	local sentAllToDepot = true
	while (count > 0) do
		local createdCount = math.min(count, maxCount)
		local item = doCreateItemEx(itemid, createdCount)
		if (item) then
			if (unique) then
				setItemUniqueOwner(cid, item)
			end
			
			if (rarity) then
				RaritySystemV2:applyRarity(item, itemid, rarity)
			end

			if (safeAddPlayerItemEx(cid, item)) then
				sentToDepot = true
			else
				sentAllToDepot = false
			end
		else
			print("Could not create item with id " .. itemid)
		end
		count = count - createdCount
	end
	return sentToDepot, sentAllToDepot
end

--[[
	CREATE TABLE IF NOT EXISTS `account_storage` (
		`account_id` INT NOT NULL,
		`key` VARCHAR(255) NOT NULL,
		`value` TEXT NOT NULL,
		PRIMARY KEY (`account_id`),
		UNIQUE KEY `account_storage_index` (`account_id`, `key`),
		FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE
	) ENGINE = InnoDB;
]]

function getAccountStorage(accountID, key)
	local ret = db.storeQuery("SELECT `value` FROM `account_storage` WHERE `account_id` = " ..
	accountID .. " AND `key` = '" .. key .. "'")
	if (ret) then
		local value = result.getDataString(ret, "value")
		result.free(ret)
		return value
	end
	return "-1"
end

function setAccountStorage(accountID, key, value)
	if (value == nil) then
		db.query("DELETE FROM `account_storage` WHERE `account_id` = " .. accountID .. " AND `key` = '" .. key .. "'")
		return true
	end

	local ret = db.storeQuery("SELECT `value` FROM `account_storage` WHERE `account_id` = " ..
	accountID .. " AND `key` = '" .. key .. "'")
	if (ret) then
		result.free(ret)
		db.query("UPDATE `account_storage` SET `value` = '" ..
		value .. "' WHERE `account_id` = " .. accountID .. " AND `key` = '" .. key .. "'")
	else
		db.query("INSERT INTO `account_storage` (`account_id`, `key`, `value`) VALUES (" ..
		accountID .. ", '" .. key .. "', '" .. value .. "')")
	end
	return true
end
