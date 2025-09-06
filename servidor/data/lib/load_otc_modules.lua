SpecialOpcode = 67

OtcModulesOpcodes = {}
function registerOtcModule(opcode, module)
	OtcModulesOpcodes[opcode] = module
end

OtcSpecialModulesOpcodes = {}
function registerSpecialOtcModule(opcode, module)
	OtcSpecialModulesOpcodes[opcode] = module
end

dodirectory(getDataDir() .. "lib/otc_modules", false)
