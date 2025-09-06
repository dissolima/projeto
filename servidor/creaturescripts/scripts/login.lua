local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

local function checkTarget(cid)

    if not isPlayer(cid) then
        return
    end
    
    local target = getCreatureTarget(cid)
    
    if not isPlayer(target) then
        addEvent(checkTarget, 250, cid)
        return
    end
    
    if exhaustion.check(target, STORAGE_TARGET)then

        doPlayerRemoveTarget(cid)
    end
    
    addEvent(checkTarget, 1, cid)
end

function onLogin(cid)
	local loss = getConfigValue('deathLostPercent')
	if(loss ~= nil) then
		doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	end
	
	local accountManager = getPlayerAccountManager(cid)
	if(accountManager == MANAGER_NONE) then
		local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		if(lastLogin > 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
		else
									setPlayerStorageValue(cid, 30024, 0)
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
	elseif(accountManager == MANAGER_NAMELOCK) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
	elseif(accountManager == MANAGER_ACCOUNT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type {account} to manage your account and if you want to start over then type {cancel}.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type {account} to create an account or type {recover} to recover an account.")
	end


	registerCreatureEvent(cid, "Mail")
	registerCreatureEvent(cid, "SkullCheck")
	registerCreatureEvent(cid, "NoPartyAttack")
	registerCreatureEvent(cid, "TiraBattle")
	registerCreatureEvent(cid, "Idle")
	if(config.useFragHandler) then
		registerCreatureEvent(cid, "SkullCheck")
		registerCreatureEvent(cid, "Reward")
	end
	registerCreatureEvent(cid, "FullHpMana")
	registerCreatureEvent(cid, "AdvanceSave")
	registerCreatureEvent(cid, "ZombieAttack")
	registerCreatureEvent(cid, "BlessCheck")
	registerCreatureEvent(cid, "advance")
	registerCreatureEvent(cid, "SkullCheck")
	registerCreatureEvent(cid, "ReportBug")
	registerCreatureEvent(cid,"Outfit")
	registerCreatureEvent(cid, "FragReward")
	registerCreatureEvent(cid, "Niwdeath")
	registerCreatureEvent(cid, "AdvanceSave")
	registerCreatureEvent(cid, "LevelRecompense")
	registerCreatureEvent(cid, "BoasVindas")
	registerCreatureEvent(cid, "BroadDeath")
	registerCreatureEvent(cid, "SaveStamina")
	registerCreatureEvent(cid, "Vip")
	registerCreatureEvent(cid, "onPrepareDeath")
	--------- SHOP ---------
	registerCreatureEvent(cid, "VocShenron")
	registerCreatureEvent(cid, "VocVegetto")
	registerCreatureEvent(cid, "VocTapion")
	registerCreatureEvent(cid, "VocKame")
	registerCreatureEvent(cid, "VocKagome")
	registerCreatureEvent(cid, "VocKingVegeta")
	registerCreatureEvent(cid, "VocZaiko")
	registerCreatureEvent(cid, "VocChilled")
	registerCreatureEvent(cid, "VocC8")
	registerCreatureEvent(cid, "VocBlack")
	registerCreatureEvent(cid, "VocJiren")
	registerCreatureEvent(cid, "VocHitto")
	registerCreatureEvent(cid, "RemovedorDeFrags")
	registerCreatureEvent(cid, "ProtectLevel")
	
	---------- Safe Zone ----------------
	registerCreatureEvent(cid, "SafezonePush")
	
	---------- Imortalidade ----------------
	registerCreatureEvent(cid, "invencible")
	if getPlayerStorageValue(cid, 3482101) ~= 0 then
        setPlayerStorageValue(cid, 3482101, 0) 
	end
	
	registerCreatureEvent(cid, "susanodef")
	if getPlayerStorageValue(cid, 3482108) ~= 0 then
        setPlayerStorageValue(cid, 3482108, 0) 
	end
    	registerCreatureEvent(cid, "izanagi")
	if getPlayerStorageValue(cid, 19333) == -1 then
        setPlayerStorageValue(cid, 19333, 0) 
    	end 
	registerCreatureEvent(cid, "jutsusexy")
	if getPlayerStorageValue(cid, 3482110) ~= 0 then
        setPlayerStorageValue(cid, 3482110, 0) 
	end
	
		--------------- Info All ----------------
	registerCreatureEvent(cid, "InfoLogin")
	registerCreatureEvent(cid, "InfoLook")
return true
end