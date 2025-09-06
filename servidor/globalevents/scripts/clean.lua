function executeClean(interval)
	doCleanMap()
	doBroadcastMessage("Mapa limpo, próximo clean em 30 minutos.")
	return true
end

function onThink(interval)
	doBroadcastMessage("Clean em 10 segundos, por favor, retire seus itens do chão!")
	addEvent(executeClean, 10000, interval)
	return true
end
