
	-- Cast System
    enableCast = "true"

	-- Owner Data
	ownerName = ""
	ownerEmail = ""
	url = ""
	location = "Brazil"

	-- Messages
	motd = "Welcome to the Projeto!"
	serverName = "Projeto"
	loginMessage = "Welcome to Projeto!"
	displayGamemastersWithOnlineCommand = false

	-- MySql
	sqlType = "mysql"
	sqlHost = "localhost"
	sqlPort = 3306
	sqlUser = "root"
	sqlPass = ""
	sqlDatabase = "projeto"
	sqlFile = "schemas/otxserver.s3db"
	sqlKeepAlive = 0
	mysqlReadTimeout = 6000
	mysqlWriteTimeout = 6000
	mysqlReconnectionAttempts = 5
	encryptionType = "sha1"

	-- World / Ip / Port
	worldId = 0
	ip = "127.0.0.1"
	worldType = "open"
	bindOnlyGlobalAddress = false
	loginPort = 7171
	gamePort = 7172
	statusPort = 7171
	loginOnlyWithLoginServer = false

	-- Account manager
	accountManager = false
	namelockManager = true
	newPlayerChooseVoc = true
	newPlayerSpawnPosX = 97
	newPlayerSpawnPosY = 175
	newPlayerSpawnPosZ = 5
	newPlayerTownId = 1
	newPlayerLevel = 8
	newPlayerMagicLevel = 0
	generateAccountNumber = false
	generateAccountSalt = false

	-- Limits on frags / Time
	fragsLimit = 24 * 60 * 60
	fragsSecondLimit = 7 * 24 * 60 * 60
	fragsThirdLimit = 30 * 24 * 60 * 60

	-- Red Skull Config
	fragsToRedSkull = 40
	fragsSecondToRedSkull = 130
	fragsThirdToRedSkull = 99999
	redSkullLength = 1 * 24 * 60 * 60

	-- Black Skull Config
	fragsToBlackSkull = 220
	fragsSecondToBlackSkull = 600
	fragsThirdToBlackSkull = 99999999
	blackSkulledDeathHealth = 40
	blackSkulledDeathMana = 0
	blackSkullLength = 1 * 24 * 60 * 60
	useBlackSkull = true

	-- Banishment Config
	-- killsBanLength works only if useBlackSkull option is disabled.
	notationsToBan = 3
	warningsToFinalBan = 4
	warningsToDeletion = 5
	banLength = 7 * 24 * 60 * 60
	killsBanLength = 7 * 24 * 60 * 60
	finalBanLength = 30 * 24 * 60 * 60
	ipBanLength = 1 * 24 * 60 * 60
	fragsToBanishment = 999
	fragsSecondToBanishment = 999
	fragsThirdToBanishment = 999



	-- Battle
	-- NOTE: showHealth/ManaChangeForMonsters inherites from showHealth/ManaChange.
	protectionLevel = 200
	pvpTileIgnoreLevelAndVocationProtection = true
	pzLocked = 60 * 1000
	huntingDuration = 60 * 1000
	criticalHitMultiplier = 1
	displayCriticalHitNotify = false
	removeWeaponAmmunition = true
	removeWeaponCharges = true
	removeRuneCharges = true
	whiteSkullTime = 3 * 60 * 1000
	advancedFragList = true
	useFragHandler = true
	noDamageToSameLookfeet = false
	showHealthChange = true
	showManaChange = true
	showHealthChangeForMonsters = false
	showManaChangeForMonsters = false
	fieldOwnershipDuration = 5 * 1000
	stopAttackingAtExit = false
	loginProtectionPeriod = 1 * 750
	deathLostPercent = 10
	stairhopDelay = 1 * 1000
	pushCreatureDelay = 1 * 350
	deathContainerId = 1987
	gainExperienceColor = 215
	addManaSpentInPvPZone = true
	recoverManaAfterDeathInPvPZone = true
	squareColor = 0
	broadcastBanishments = false
	maxViolationCommentSize = 60
	violationNameReportActionType = 2

	-- Anti-Push Prevention System by Xampy
	useAntiPush = true
	antiPushDelay = 450
	antiPushItems = "2148,2152,2160,3976"

	-- RSA
	-- NOTE: These should not be changed unless you know what your doing!
	-- Prime1 - known as p; Prime2 - known as q; Public - known as e;
	-- Modulus - known as n; Private - known as d.
	-- How make custom client with custom RSA Key: http://vapus.net/customclient
	rsaPrime1 = "14299623962416399520070177382898895550795403345466153217470516082934737582776038882967213386204600674145392845853859217990626450972452084065728686565928113"
	rsaPrime2 = "7630979195970404721891201847792002125535401292779123937207447574596692788513647179235335529307251350570728407373705564708871762033017096809910315212884101"
	rsaPublic = "65537"
	rsaModulus = "109120132967399429278860960508995541528237502902798129123468757937266291492576446330739696001110603907230888610072655818825358503429057592827629436413108566029093628212635953836686562675849720620786279431090218017681061521755056710823876476444260558147179707119674283982419152118103759076030616683978566631413"
	rsaPrivate = "46730330223584118622160180015036832148732986808519344675210555262940258739805766860224610646919605860206328024326703361630109888417839241959507572247284807035235569619173792292786907845791904955103601652822519121908367187885509270025388641700821735345222087940578381210879116823013776808975766851829020659073"

	-- OTX Server Extras Features
		-- Battle
		optionalWarAttackableAlly = true
		fistBaseAttack = 7
		criticalHitChance = 7
		noDamageToGuildMates = false
			-- if true then no damage, if false then damage
		noDamageToPartyMembers = false
			-- if true then no damage, if false then damage

		-- Rook System
		rookLevelTo = 5
		rookLevelToLeaveRook = 8
		rookTownId = 1
		useRookSystem = false

		-- Paralyze delay
		paralyzeDelay = 1500

		-- GUI
		premiumDaysToAddByGui = 0

		-- Depot and Miscellaneous
		-- set playerFollowExhaust to 2000 if someone causes lags and kicks by following unreachable creatures too often
		useCapacity = true
		defaultDepotSize = 500
		defaultDepotSizePremium = 1000
		enableProtectionQuestForGM = true
		cleanItemsInMap = false
		playerFollowExhaust = 2000

		-- 8.7x + config
		tibiaClassicSlots = true
		monsterSpawnWalkback = true
		allowBlockSpawn = true

		-- Summons and monsters
		NoShareExpSummonMonster = false

		-- Others
		
		highscoreDisplayPlayers = 10
		updateHighscoresAfterMinutes = 60
		attackImmediatelyAfterLoggingIn = true
		exhaustionNPC = true
		exhaustionInSecondsNPC = 0.5

		-- Advanced Version
		-- Note: If you use another protocol than the one we set as you will have functional failures.
		-- Supported (860) = 8.60
		manualVersionConfig = false
		versionMin = 860
		versionMax = 860
		versionMsg = "Only clients with protocol 8.60 allowed!"

	-- Connection config
	loginTries = 20
	retryTimeout = 5 * 1000
	loginTimeout = 60 * 1000
	maxPlayers = 250
	displayOnOrOffAtCharlist = false
	onePlayerOnlinePerAccount = false
	allowClones = 0
	statusTimeout = 1000
	replaceKickOnLogin = true
	forceSlowConnectionsToDisconnect = false
	premiumPlayerSkipWaitList = true
	packetsPerSecond = 80


	-- Deathlist
	deathListEnabled = true
	deathListRequiredTime = 1 * 60 * 1000
	deathAssistCount = 20
	maxDeathRecords = 5
	multipleNames = false

	-- Guilds
	-- NOTE: externalGuildWarsManagement supports Automatic Account Creator(webpage or whatever you want)
	externalGuildWarsManagement = false
	ingameGuildManagement = true
	levelToFormGuild = 200
	premiumDaysToFormGuild = 0
	guildNameMinLength = 4
	guildNameMaxLength = 20

	-- Houses
	buyableAndSellableHouses = true
	houseNeedPremium = false
	bedsRequirePremium = false
	levelToBuyHouse = 300
	housesPerAccount = 2
	houseRentAsPrice = false
	housePriceAsRent = 20000
	housePriceEachSquare = 10000
	houseRentPeriod = "never"
	houseCleanOld = 0
	guildHalls = false
	houseSkipInitialRent = true
	houseProtection = true

	-- Item usage
	timeBetweenActions = 1000
	timeBetweenExActions = 1000
	timeBetweenCustomActions = 1000
	checkCorpseOwner = false
	hotkeyAimbotEnabled = true
	maximumDoorLevel = 1500
	tradeLimit = 100
	canOnlyRopePlayers = false

	-- Map
	-- NOTE: storeTrash costs more memory, but will perform alot faster cleaning.
	-- houseDataStorage usage may be found at how-use-internal-functions.log
	mapAuthor = "DBO Gameplayer"
	randomizeTiles = true
	houseDataStorage = "binary-tilebased"
	storeTrash = true
	cleanProtectedZones = true
	mapName = "projeto.otbm"
		-- For Windows(compiled with MSVC) and Linux use:
		-- OTX Server use default GroundCache
		-- GroundCache mode save memory: __GROUND_CACHE__
			-- forgotten map on normal mode use memory: 361,512 KB
			-- forgotten map with groundCache mode use memory: 334,124 KB

	-- Mailbox
	mailMaxAttempts = 5
	mailBlockPeriod = 30 * 60 * 1000
	mailAttemptsFadeTime = 5 * 60 * 1000
	mailboxDisabledTowns = ""
		-- Example disable rook depot (temple) "4"
		-- mailboxDisabledTowns = "4"

	-- Startup
	-- For Linux use "-1" is default
	-- daemonize works only on *nix, same as niceLevel
	daemonize = false
	defaultPriority = "higher"
	niceLevel = 5
	serviceThreads = 1
	coresUsed = "-1"
	startupDatabaseOptimization = false
	removePremiumOnInit = true
	confirmOutdatedVersion = false
	skipItemsVersionCheck = true

	-- Muted buffer
	maxMessageBuffer = 20

	-- Miscellaneous
	dataDirectory = "data/"
	logsDirectory = "data/logs/"
	disableOutfitsForPrivilegedPlayers = false
	bankSystem = true
	spellNameInsteadOfWords = true
	emoteSpells = true
	unifiedSpells = true
	promptExceptionTracerErrorBox = false
	storePlayerDirection = false
	savePlayerData = true
	monsterLootMessage = 3
	monsterLootMessageType = 25
	separateViplistPerCharacter = false
	vipListDefaultLimit = 20
	vipListDefaultPremiumLimit = 100

	-- Outfits
	allowChangeOutfit = true
	allowChangeColors = true
	allowChangeAddons = true
	addonsOnlyPremium = true

	-- Ghost mode
	ghostModeInvisibleEffect = true
	ghostModeSpellEffects = true

	-- Limits
	idleWarningTime = 147777777777777777 * 60 * 1000
	idleKickTime = 157777777777777777777 * 60 * 1000
	expireReportsAfterReads = 1
	playerQueryDeepness = -1
	protectionTileLimit = 5
	houseTileLimit = 5
	tileLimit = 5

	-- Premium-related
	freePremium = false
	premiumForPromotion = true
	updatePremiumStateAtStartup = true

	-- Blessings
	blessings = true
	blessingOnlyPremium = false
	blessingReductionBase = 30
	blessingReductionDecrement = 5
	eachBlessReduction = 0
	useFairfightReduction = false
	pvpBlessingThreshold = 40
	fairFightTimeRange = 60

	-- Rates
	experienceStages = true
	rateExperience = 1.0
	rateExperienceFromPlayers = 0
	levelToOfflineTraining = 8
	rateSkill = 1.0
	rateSkillOffline = 0.5
	rateMagic = 1.0
	rateMagicOffline = 0.5
	rateLoot = 1.0
	rateSpawnMin = 1
	rateSpawnMax = 1
	formulaLevel = 10.0
	formulaMagic = 1.7
		-- Monster rates
		rateMonsterHealth = 1.0
		rateMonsterMana = 1.0
		rateMonsterAttack = 1.0
		rateMonsterDefense = 1.0

	-- Experience from players
	minLevelThresholdForKilledPlayer = 0.9
	maxLevelThresholdForKilledPlayer = 1.1

	-- Stamina System
	rateStaminaLoss = 1
	rateStaminaGain = 3
	rateStaminaThresholdGain = 12
	staminaRatingLimitTop = 40 * 60
	staminaRatingLimitBottom = 14 * 60
	staminaLootLimit = 14 * 60
	rateStaminaAboveNormal = 1.5
	rateStaminaUnderNormal = 0.5
	staminaThresholdOnlyPremium = true

	-- Party System
	experienceShareRadiusX = 30
	experienceShareRadiusY = 30
	experienceShareRadiusZ = 1
	experienceShareLevelDifference = 2 / 3
	extraPartyExperienceLimit = 20
	extraPartyExperiencePercent = 5
	experienceShareActivity = 2 * 60 * 1000

	-- Global save
	globalSaveEnabled = true
	globalSaveHour = 23
	globalSaveMinute = 00
	shutdownAtGlobalSave = true
	cleanMapAtGlobalSave = false

	-- Spawns
	minRateSpawn = 1
	maxRateSpawn = 3
	deSpawnRange = 2
	deSpawnRadius = 50

	-- Summons
	maxPlayerSummons = 2
	teleportAllSummons = false
	teleportPlayerSummons = true

	-- Logs
	disableLuaErrors = false
	adminLogs = true
	displayPlayersLogging = true
	prefixChannelLogs = ""
	runFile = "server/run.log"
	outputLog = "server/out.log"
	truncateLogOnStartup = false
	logPlayersStatements = false

	-- Manager
	-- NOTE: managerPassword left blank disables manager.
	managerPort = 7171
	managerLogs = true
	managerPassword = ""
	managerLocalhostOnly = true
	managerConnectionsLimit = 1

	-- Admin
	-- NOTE: adminPassword left blank disables manager.
	-- Set to anything if you set adminRequireLogin to false.
	-- adminEncryption available options: rsa1024xtea;
	-- remember to set correct data!
	adminPort = 7171
	adminPassword = ""
	adminLocalhostOnly = true
	adminConnectionsLimit = 1
	adminRequireLogin = true
	adminEncryption = ""
	adminEncryptionData = ""

	-- Don't edit use at your own risk
	saveGlobalStorage = true
	bufferMutedOnSpellFailure = false
	autoLootEnabled = true
