---@param cid number
---@param opcode number
---@param msg NetworkMessage
function onRecvPacket(cid, opcode, msg)
	local specialOpcode = msg:getByte()
	local module = OtcSpecialModulesOpcodes[specialOpcode]
	if (module) then
		module.handleOpcode(module, cid, msg)
	end
	msg:delete()
end
