function onSay(cid, words, param, channel)

local guild, enemy, guildFrags, enemyFrags = getPlayerGuildId(cid)
local fightingGuilds = {}
local tmp = db.getResult("SELECT `guild_id`, `enemy_id`, `guild_kills`, `enemy_kills`, `frags` FROM `guild_wars` WHERE `guild_id` = "..guild.." OR `enemy_id` = "..guild.." AND `status` = 1;")
if tmp:getID() ~= -1 then
	i = 1
	repeat
		if tmp:getDataInt("guild_id") == guild then
			enemy = tmp:getDataInt("enemy_id")
			guildFrags = tmp:getDataInt("guild_kills")
			enemyFrags = tmp:getDataInt("enemy_kills")
		else
			enemy = tmp:getDataInt("guild_id")
			guildFrags = tmp:getDataInt("enemy_kills")
			enemyFrags = tmp:getDataInt("guild_kills")
		end
		local enemyName, _tmp = "", db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. enemy)
		if(_tmp:getID() ~= -1) then
			enemyName = _tmp:getDataString("name")
			_tmp:free()
 
		end
 
		fightingGuilds[i] = {}
		fightingGuilds[i].name = enemyName
		fightingGuilds[i].guildFrags = guildFrags
		fightingGuilds[i].enemyFrags = enemyFrags
		fightingGuilds[i].limit = tmp:getDataInt("frags")
 
		i = i + 1
	until not(tmp:next())
	tmp:free()
 
	table.sort(fightingGuilds, function (a, b)
		return (a.name < b.name)
	end)
 
	local warString = ""
 
	for k, v in pairs(fightingGuilds) do
		if (v.guildFrags < v.limit and v.enemyFrags < v.limit) then
			if not warString then
				warString = "Your guild is currently in war with the " .. v.name .. " (" .. v.guildFrags .. ":" .. v.enemyFrags .. " frags, limit ".. v.limit ..")"
			else
warString = "Sua guild esta em war contra a guild " .. v.name .. " (" .. v.guildFrags .. ":" .. v.enemyFrags .. " frags, limite ".. v.limit ..")"			end
		end
	end
 
	if (warString ~= "") then 
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, warString .. ".")
	end
end

return true
end