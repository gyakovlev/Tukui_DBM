This addon skins DBM (http://deadlybossmods.com/) Tukui-like.

Screenshot worth a thousand words: http://img.skitch.com/20101015-qmn9dg3b47s5rtfkgakf7i56eh.jpg

	Limited Support provided here:
		http://www.tukui.org/forums/topic.php?id=3549

	Usage:

		* Install DBM
		* Install Tukui_DBM to <WOWDir>/Interface/AddOns/
		* type /tukuidbm apply
		* reconfigure DBM as you like
		* go kill some bosses
	
	Config & commands:

		/tukuidbm test - launch DBM demo mode
		/tukuidbm bh - launch BossHealth demo mode
		/tukuidbm apply - apply skin settings
		
		Tiny config can be found at the top of Tukui_DBM.lua file.
		The lines a pretty well commented and self-descriptive

		Default config:
		--------------------------
		local croprwicons=true	-- crops shitty blizz borders from icons in RaidWarning messages
		local drawshadow=false	-- draw Tukui shadows around frames.
		local rwiconsize=18	-- RaidWarning icon size. Works only if croprwicons=true
		local transparent=false	-- Use transparent template on bars.
		--------------------------			

	FAQ:

		Q) Do i need to change something within Tukui to use your style instead of default one?
			A) No, Tukui will auto-disable it's skinn and this skin will be used.

		Q) My bars overlap (http://img33.imageshack.us/img33/1364/dbma.jpg), what should i do?
			A) Open DBM settings and modify Y-Offset (Bar options and style)

		Q) Should i run /tukuidbm apply every time the skin updates?
			A) No. Only on first install.

		Q) I want this skin, but i do not use Tukui
			A) Try DBM_Styler (https://github.com/Affli/DBM_Styler), it's unsupported and early alpha.

		Q) Can i include this addon into my Tukui-edit?
			A) Sure.
			You can include like any addon, or even embed it into your edit, but there is one limitation. 
			The following comment section should never be deleted from Tukui_DBM.lua
				--[[

				Tukui_DBM skin by Affli@RU-Howling Fjord
				All rights reserved.
				Thanks ALZA, Shestak, Fernir, Tukz and everyone i've forgot to mention.

				]]--
