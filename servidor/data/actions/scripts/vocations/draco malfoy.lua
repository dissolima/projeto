function onUse(cid, item, frompos, item2, topos)
local voc = 4 -- id da vocação
local outfit = {lookType = 16} -- Outfit inicial da vocação
    doPlayerSetVocation(cid, voc)
    doRemoveItem(item.uid,1)
    doSetCreatureOutfit(cid, outfit, -1)
    doPlayerSendTextMessage(cid, 22, "Voce trocou sua vocation para Draco Malfoy")
return true
end
