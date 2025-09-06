function onRecvPacket(cid, opcode, msg)
	print("opcode " .. opcode .. " called!")
	msg:delete()
end
