local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
setHealingFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 180.0, 220.0)

function onCastSpell(cid, var)
	local pos1 = {x = getPlayerPosition(cid).x + 0, y = getPlayerPosition(cid).y + 0, z = getPlayerPosition(cid).z}
	doSendMagicEffect(pos1, 87)
	return doCombat(cid, combat, var)
end