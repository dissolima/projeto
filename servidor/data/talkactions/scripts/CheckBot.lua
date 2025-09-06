function TeleportBot(cid)
	if getPlayerStorageValue(cid, 934563) ~= -1 then
		doPlayerPopupFYI(cid, "Seu personagem foi teleportado para o templo, por uso de Bot 100% AFK.")
		doTeleportThing(cid, getPlayerMasterPos(cid))
		setPlayerStorageValue(cid, 934563, -1)
	end
return true
end

function CheckBot(cid)
local numer = math.random(2, 999)
	if isPlayer(cid) then
		doPlayerPopupFYI(cid, "Seu personagem está sendo verificado por Bot AFK!\n\nVoce tem 1 minuto para responder.\n\nPor favor digite:\n\n!check info, "..numer.."")
		setPlayerStorageValue(cid, 934563, numer)
		addEvent(TeleportBot, 60000, cid)
	end
return true
end


function onSay(cid, words, param, channel) 
local param = param:lower()
local t = string.explode(param, ",")
local Numero = tonumber(t[2])

if (t[1] == "add") then
	if getPlayerGroupId(cid) < 2 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce não tem permissão para fazer verificações!")
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Foi enviado uma verificação para o jogador: "..getCreatureName(getPlayerByName(t[2])).."")
		CheckBot(getPlayerByName(t[2]))
	return true
	end
elseif (t[1] == "info") then
			if Numero == nil then
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce precisa digitar o valor.")
			end

			if 	getPlayerStorageValue(cid, 934563) == -1 then
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce não tem verificações pendentes.")
			end
		
			if getPlayerStorageValue(cid, 934563) ~= -1 and getPlayerStorageValue(cid, 934563) == Numero then
				setPlayerStorageValue(cid, 934563, -1)
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Obrigado por fazer a verificação, Bom jogo!")
			end
			
			
end
  return true
end