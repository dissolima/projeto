function onUse(cid, item, frompos, item2, topos)
local voc = 3 -- id da vocação
local outfit = {lookType = 11} -- Outfit inicial da vocação
    doPlayerSetVocation(cid, voc)
    doRemoveItem(item.uid,1)
    doSetCreatureOutfit(cid, outfit, -1)
    doPlayerSendTextMessage(cid, 22, "Voce trocou sua vocation para Ron Weasley")
return true
end
