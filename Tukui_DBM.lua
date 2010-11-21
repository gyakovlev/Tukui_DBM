if not IsAddOnLoaded("DBM-Core") or not DBM then return end
--[[

Tukui_DBM skin by Affli@RU-Howling Fjord
All rights reserved.
Thanks ALZA, Shestak, Fernir, Tukz and everyone i've forgot to mention.

]]--

-- little config
----------------------------------------
local forcebosshealthclasscolor=true -- forces BossHealth to be classcolored. not recommended.
local croprwicons=true	-- crops blizz shitty borders from icons in RaidWarning messages
local rwiconsize=18	-- RaidWarning icon size, because 12 is small for me. Works only if croprwicons=true
----------------------------------------

local classcolor = RAID_CLASS_COLORS[TukuiDB.myclass]
local function SkinBars(self)
	for bar in self:GetBarIterator() do
		if not bar.injected then
				bar.ApplyStyle=function()
				local frame = bar.frame
				local tbar = _G[frame:GetName().."Bar"]
				local spark = _G[frame:GetName().."BarSpark"]
				local texture = _G[frame:GetName().."BarTexture"]
				local icon1 = _G[frame:GetName().."BarIcon1"]
				local icon2 = _G[frame:GetName().."BarIcon2"]
				local name = _G[frame:GetName().."BarName"]
				local timer = _G[frame:GetName().."BarTimer"]

				if (icon1.overlay) then
					icon1.overlay = _G[icon1.overlay:GetName()]
				else
					icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
					icon1.overlay:SetWidth(TukuiDB.buttonsize)
					icon1.overlay:SetHeight(TukuiDB.buttonsize)
					icon1.overlay:SetFrameStrata("BACKGROUND")
					icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -TukuiDB.buttonsize/4, TukuiDB.Scale(-2))
					TukuiDB.SetTemplate(icon1.overlay)
					if ElvUIInstalled then
						TukuiDB.CreateShadow(icon1.overlay)
					end
				end

				if (icon2.overlay) then
					icon2.overlay = _G[icon2.overlay:GetName()]
				else
					icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
					icon2.overlay:SetWidth(TukuiDB.buttonsize)
					icon2.overlay:SetHeight(TukuiDB.buttonsize)
					icon2.overlay:SetFrameStrata("BACKGROUND")
					icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", TukuiDB.buttonsize/4, TukuiDB.Scale(-2))
					TukuiDB.SetTemplate(icon2.overlay)
					if ElvUIInstalled then
						TukuiDB.CreateShadow(icon2.overlay)
					end
				end

				if bar.color then
					tbar:SetStatusBarColor(bar.color.r, bar.color.g, bar.color.b)
				else
					tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
				end
				
				if bar.enlarged then frame:SetWidth(TukuiDB.Scale(bar.owner.options.HugeWidth)) else frame:SetWidth(TukuiDB.Scale(bar.owner.options.Width)) end
				if bar.enlarged then tbar:SetWidth(TukuiDB.Scale(bar.owner.options.HugeWidth)) else tbar:SetWidth(TukuiDB.Scale(bar.owner.options.Width)) end

				frame:SetScale(1)
				if not frame.styled then
					frame:SetHeight(TukuiDB.buttonsize/3)
					TukuiDB.SetTemplate(frame)
					if ElvUIInstalled then
						TukuiDB.CreateShadow(frame)
					end
					frame.styled=true
				end

				if not spark.killed then
					spark:SetAlpha(0)
					spark:SetTexture(nil)
					spark.killed=true
				end
	
				if not icon1.styled then
					icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon1:ClearAllPoints()
					icon1:SetPoint("TOPLEFT", icon1.overlay, TukuiDB.Scale(2), TukuiDB.Scale(-2))
					icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, TukuiDB.Scale(-2), TukuiDB.Scale(2))
					icon1.styled=true
				end
				
				if not icon2.styled then
					icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon2:ClearAllPoints()
					icon2:SetPoint("TOPLEFT", icon2.overlay, TukuiDB.Scale(2), TukuiDB.Scale(-2))
					icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, TukuiDB.Scale(-2), TukuiDB.Scale(2))
					icon2.styled=true
				end

				if not texture.styled then
					texture:SetTexture(TukuiCF["media"].normTex)
					texture.styled=true
				end

				if not tbar.styled then
					tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
					tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
					tbar.styled=true
				end

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, TukuiDB.Scale(4))
					name:SetWidth(165)
					name:SetHeight(8)
					name:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
					name:SetJustifyH("LEFT")
					name:SetShadowColor(0, 0, 0, 0)
					name.SetFont = TukuiDB.dummy
					name.styled=true
				end
				
				if not timer.styled then	
					timer:ClearAllPoints()
					timer:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", TukuiDB.Scale(-1), TukuiDB.Scale(2))
					timer:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.SetFont = TukuiDB.dummy
					timer.styled=true
				end

				if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
				if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
				tbar:SetAlpha(1)
				frame:SetAlpha(1)
				texture:SetAlpha(1)
				frame:Show()
				bar:Update(0)
				bar.injected=true
			end
			bar:ApplyStyle()
		end

	end
end
 
local SkinBossTitle=function()
	local anchor=DBMBossHealthDropdown:GetParent()
	if not anchor.styled then
		local header={anchor:GetRegions()}
			if header[1]:IsObjectType("FontString") then
				header[1]:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
				header[1]:SetTextColor(1,1,1,1)
				anchor.styled=true	
			end
		header=nil
	end
	anchor=nil
end

local SkinBoss=function()
	local count = 1
	while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
		local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
		local background = _G[bar:GetName().."BarBorder"]
		local progress = _G[bar:GetName().."Bar"]
		local name = _G[bar:GetName().."BarName"]
		local timer = _G[bar:GetName().."BarTimer"]
		local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]	

		if (count == 1) then
			local	_, anch, _ ,_, _ = bar:GetPoint()
			bar:ClearAllPoints()
			if DBM_SavedOptions.HealthFrameGrowUp then
				bar:SetPoint("BOTTOM", anch, "TOP" , 0 , TukuiDB.Scale(12))
			else
				bar:SetPoint("TOP", anch, "BOTTOM" , 0, -TukuiDB.buttonsize)
			end
		else
			bar:ClearAllPoints()
			if DBM_SavedOptions.HealthFrameGrowUp then
				bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, TukuiDB.buttonsize)
			else
				bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, -TukuiDB.buttonsize)
			end
		end

		if not bar.styled then
			bar:SetScale(1)
			bar:SetHeight(TukuiDB.buttonsize/3)
			TukuiDB.SetTemplate(bar)
			if ElvUIInstalled then
				TukuiDB.CreateShadow(bar)
			end
			background:SetNormalTexture(nil)
			bar.styled=true
			
		end	
		
		if not progress.styled then
			progress:SetStatusBarTexture(TukuiCF["media"].normTex)
			if(forcebosshealthclasscolor)then
				local tslu=0
				progress:SetStatusBarColor(classcolor.r,classcolor.g,classcolor.b,1)
				progress:HookScript("OnUpdate",function(self,elapsed)
					tslu=tslu+elapsed
					if tslu>0.025 then
						self:SetStatusBarColor(classcolor.r,classcolor.g,classcolor.b,1)
						tslu=0
					end
				end)
			end
			progress.styled=true
		end				
		progress:ClearAllPoints()
		progress:SetPoint("TOPLEFT", bar, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
		progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))

		if not name.styled then
			name:ClearAllPoints()
			name:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", TukuiDB.Scale(4), TukuiDB.Scale(1))
			name:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
			name:SetJustifyH("LEFT")
			name:SetShadowColor(0, 0, 0, 0)
			name.styled=true
		end
		
		if not timer.styled then
			timer:ClearAllPoints()
			timer:SetPoint("BOTTOMRIGHT", bar, "TOPRIGHT", TukuiDB.Scale(-1), TukuiDB.Scale(1))
			timer:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
			timer:SetJustifyH("RIGHT")
			timer:SetShadowColor(0, 0, 0, 0)
			timer.styled=true
		end
		count = count + 1
	end
end

-- mwahahahah, eat this ugly DBM.
hooksecurefunc(DBT,"CreateBar",SkinBars)
hooksecurefunc(DBM.BossHealth,"Show",SkinBossTitle)
hooksecurefunc(DBM.BossHealth,"AddBoss",SkinBoss)
DBM.RangeCheck:Show()
DBM.RangeCheck:Hide()
DBMRangeCheck:HookScript("OnShow",function(self)
	TukuiDB.SetTemplate(self)
	if ElvUIInstalled then
		TukuiDB.CreateShadow(self)
	end
end)
if(croprwicons)then
	local replace=string.gsub
	local old=RaidNotice_AddMessage
	RaidNotice_AddMessage=function(noticeFrame, textString, colorInfo)
		if textString:find(" |T") then
			textString=replace(textString,"(:12:12)",":"..rwiconsize..":"..rwiconsize..":0:0:64:64:5:59:5:59")
		end
		return old(noticeFrame, textString, colorInfo)
	end
end

local UploadDBM = function()
	DBM_SavedOptions.Enabled=true
	DBM_SavedOptions.WarningIconLeft=false
	DBM_SavedOptions.WarningIconRight=false
	DBM_SavedOptions["WarningColors"] = {{["b"] = classcolor.b, ["g"] = classcolor.g, ["r"] = classcolor.r,},
                             {["b"] = classcolor.b, ["g"] = classcolor.g, ["r"] = classcolor.r,},
                             {["b"] = classcolor.b, ["g"] = classcolor.g, ["r"] = classcolor.r,},
                             {["b"] = classcolor.b, ["g"] = classcolor.g, ["r"] = classcolor.r,},}

	DBT_SavedOptions["DBM"].StartColorR=classcolor.r
	DBT_SavedOptions["DBM"].StartColorG=classcolor.g
	DBT_SavedOptions["DBM"].StartColorB=classcolor.b
	DBT_SavedOptions["DBM"].EndColorR=classcolor.r
	DBT_SavedOptions["DBM"].EndColorG=classcolor.g
	DBT_SavedOptions["DBM"].EndColorB=classcolor.b
	DBT_SavedOptions["DBM"].Scale=1
	DBT_SavedOptions["DBM"].HugeScale=1
	DBT_SavedOptions["DBM"].BarXOffset=0
	DBT_SavedOptions["DBM"].BarYOffset=3
	DBT_SavedOptions["DBM"].IconLeft=true
	DBT_SavedOptions["DBM"].ExpandUpwards=true
	DBT_SavedOptions["DBM"].Texture="Interface\\AddOns\\Tukui\\media\\textures\\normTex"
	DBT_SavedOptions["DBM"].IconRight=false
end

local pr = function(msg)
    print("|cffC495DDDBMskin|r:", tostring(msg))
end

local function rt(i) return function() return i end end

local function healthdemo()
		DBM.BossHealth:Show("Scary bosses")
		DBM.BossHealth:AddBoss(rt(25), "Algalon")
		DBM.BossHealth:AddBoss(rt(50), "Mimiron")
		DBM.BossHealth:AddBoss(rt(75), "Sindragosa")
		DBM.BossHealth:AddBoss(rt(100), "Hogger")
end

SLASH_DBMSKIN1 = "/dbmskin"
SlashCmdList["DBMSKIN"] = function(msg)
	if(msg=="apply") then
		StaticPopup_Show("APPLY_SKIN")        
	elseif(msg=="test") then
		DBM:DemoMode()
	elseif(msg=="bh")then
		healthdemo()
	else
		pr("use |cffFF0000/dbmskin apply|r to apply DBM settings.")
		pr("use |cffFF0000/dbmskin test|r to launch DBM testmode.")
		pr("use |cffFF0000/dbmskin bh|r to show test BossHealth frame")
	end
end

StaticPopupDialogs["APPLY_SKIN"] = {
	text = "We need to set some DBM options to apply Tukui DBM skin.\nMost of your settings will remain untouched.",
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = function() UploadDBM() ReloadUI() end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = true,
}

---
local function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[TukuiDB.myclass]
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function SetOriginalBackdrop(self)
	self:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
	self:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
end
local function SkinButton(f)
	f:SetNormalTexture("")
	f:SetHighlightTexture("")
	f:SetPushedTexture("")
	f:SetDisabledTexture("")
	TukuiDB.SetTemplate(f)
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end
local SkinPanel=TukuiDB.SetTemplate
local SkinBlizzUI = CreateFrame("Frame")
SkinBlizzUI:RegisterEvent("ADDON_LOADED")
SkinBlizzUI:SetScript("OnEvent", function(self, event, addon)
if addon == "DBM-GUI" then
		SkinPanel(_G["DBM_GUI_OptionsFrame"])
		SkinPanel(_G["DBM_GUI_OptionsFramePanelContainer"])
		SkinButton(_G["DBM_GUI_OptionsFrameTab1"])
		SkinButton(_G["DBM_GUI_OptionsFrameTab2"])

		_G["DBM_GUI_OptionsFrameTab1Left"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1Middle"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1Right"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1LeftDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1MiddleDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1RightDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab1HighlightTexture"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2Left"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2Middle"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2Right"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2LeftDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2MiddleDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2RighΩtDisabled"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameTab2HighlightTexture"]:SetAlpha(0)

		_G["DBM_GUI_OptionsFrameTab1"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab1"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameBossMods"], "TOPLEFT", 0, TukuiDB.Scale(27))
		_G["DBM_GUI_OptionsFrameTab2"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameTab2"]:SetPoint("TOPLEFT", _G["DBM_GUI_OptionsFrameTab1"], "TOPRIGHT", TukuiDB.Scale(6), 0)

		_G["DBM_GUI_OptionsFrameBossMods"]:HookScript("OnShow", function(self) SkinPanel(self) end)
		_G["DBM_GUI_OptionsFrameDBMOptions"]:HookScript("OnShow", function(self) SkinPanel(self) end)
		_G["DBM_GUI_OptionsFrameHeader"]:SetTexture("")
		_G["DBM_GUI_OptionsFrameHeader"]:ClearAllPoints()
		_G["DBM_GUI_OptionsFrameHeader"]:SetPoint("TOP", DBM_GUI_OptionsFrame, 0, TukuiDB.Scale(7))

		_G["DBM_GUI_OptionsFrameBossModsTop"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsTopLeft"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsTopRight"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsBottom"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsBottomLeft"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsBottomRight"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsLeft"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameBossModsRight"]:SetAlpha(0)
		
		_G["DBM_GUI_OptionsFrameDBMOptionsTop"]:SetAlpha(0)
		_G["DBM_GUI_OptionsFrameDBMOptionsBottom"]:SetAlpha(0)
		
		-- disable scale settings
	--	_G["DBM_GUI_Option_61"]:SetAlpha(0)
	--	_G["DBM_GUI_Option_67"]:SetAlpha(0)

		local dbmbskins = {
			"DBM_GUI_OptionsFrameOkay",
		}

		for i = 1, getn(dbmbskins) do
			local DBMButtons = _G[dbmbskins[i]]
			if DBMButtons then
				SkinButton(DBMButtons)
			end
		end
	end
end) 

