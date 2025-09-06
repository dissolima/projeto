function formatTime(t, ptBr)
	local str = ""
	if (t <= 0) then
		return str
	end

	local year = math.floor(t / 31536000)
	local day = math.floor(t / 86400) % 365
	local hour = math.floor(t / 3600) % 24
	local min = math.floor(t / 60) % 60
	local sec = t % 60
	if (year ~= 0) then
		str = string.format("%s%d %s%s, ", str, year, (ptBr and "ano" or "year"), (year > 1 and "s" or ""))
	end
	if (day ~= 0) then
		str = string.format("%s%d %s%s, ", str, day, (ptBr and "dia" or "day"), (day > 1 and "s" or ""))
	end
	if (hour ~= 0) then
		str = string.format("%s%d %s%s, ", str, hour, (ptBr and "hora" or "hour"), (hour > 1 and "s" or ""))
	end
	if (min ~= 0) then
		str = string.format("%s%d %s%s, ", str, min, (ptBr and "minuto" or "minute"), (min > 1 and "s" or ""))
	end
	if (sec ~= 0) then
		str = string.format("%s%d %s%s, ", str, sec, (ptBr and "segundo" or "second"), (sec > 1 and "s" or ""))
	end
	return (str:sub(1, #str - 2):gsub("(.+), (.+)", "%1 " .. (ptBr and "e" or "and") .. " %2"))
end

function invertNumber(n)
	if (n > 0) then
		return -n
	end
	return math.abs(n)
end

function getItemFormattedName(uid)
	local thing = getThing(uid)
	if (thing.itemid < 100) then
		return "ERROR - NOT ITEM"
	end

	if (thing.type > 1) then
		return thing.type .. " " .. (getItemAttribute(uid, "plural") or (getTileInfo(thing.itemid) or {plural = "unknown item"}).plural)
	end

	local itemInfo = getTileInfo(thing.itemid)
	local itemName = getItemAttribute(uid, "name") or (itemInfo and itemInfo.name or "unknown item")
	return (getItemAttribute(uid, "article") or (itemInfo and itemInfo.article or getArticle(itemName))) .. " " .. itemName
end

function getItemFormattedNameById(itemid, count)
	if (itemid < 100) then
		return "ERROR - NOT ITEM"
	end

	local itemInfo = getTileInfo(itemid)
	if (count > 1) then
		return count .. " " .. (itemInfo and itemInfo.plural or "unknown item")
	end
	return itemInfo and (itemInfo.article .. " " .. itemInfo.name) or "an unknown item"
end

function doPlayerCheckAndRemoveItems(cid, items)
	for _, i in ipairs(items) do
		if (getPlayerItemCount(cid, (i[1] or i.id)) < (i[2] or i.count)) then
			return false, 1
		end
	end

	for _, i in ipairs(items) do
		if (not doPlayerRemoveItem(cid, (i[1] or i.id), (i[2] or i.count))) then
			return false, 2
		end
	end
	return true
end

function getTableSize(t)
	local c = 0
	for _ in pairs(t) do c = c + 1 end
	return c
end

function doSendMagicEffectWithOffset(position, effect, offset, player)
	local tmpPosition = {x = position.x, y = position.y, z = position.z}
	tmpPosition.x = tmpPosition.x + offset.x or offset[1]
	tmpPosition.y = tmpPosition.y + offset.y or offset[2]

	if (player) then
		doSendMagicEffect(tmpPosition, effect, player)
	else
		doSendMagicEffect(tmpPosition, effect)
	end
end

function doSendDistanceShootWithOffset(fromPosition, toPosition, effect, offset, player)
	local tmpFromPosition = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z}
	tmpFromPosition.x = tmpFromPosition.x + offset.x or offset[1]
	tmpFromPosition.y = tmpFromPosition.y + offset.y or offset[2]

	local tmpToPosition = {x = toPosition.x, y = toPosition.y, z = toPosition.z}
	tmpToPosition.x = tmpToPosition.x + offset.x or offset[1]
	tmpToPosition.y = tmpToPosition.y + offset.y or offset[2]

	if (player) then
		doSendDistanceShoot(fromPosition, toPosition, effect, player)
	else
		doSendDistanceShoot(fromPosition, toPosition, effect)
	end
end
