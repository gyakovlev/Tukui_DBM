--[[
Tukui_DBM skin by Affli@RU-Howling Fjord
All rights reserved.
Thanks ALZA, Shestak, Tukz and everyone i've forgot to mention.
]]--

if not IsAddOnLoaded("DBM-Core") or not DBM then return end
local classcolor = RAID_CLASS_COLORS[TukuiDB.myclass]
local noop=function()end
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
					icon1.overlay:SetBackdropColor(0,0,0,.5)
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
					icon2.overlay:SetBackdropColor(0,0,0,.5)
				end

				if bar.color then
					tbar:SetStatusBarColor(self.color.r, self.color.g, self.color.b)
				--	spark:SetVertexColor(self.color.r, self.color.g, self.color.b)
				else
					tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
				--	spark:SetVertexColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
				end
				
				
	
	
				if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
				if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end
				--if bar.enlarged then frame:SetScale(bar.owner.options.HugeScale) else frame:SetScale(bar.owner.options.Scale) end

				if not frame.styled then
					bar.frame:SetScale(1)
					frame:SetHeight(TukuiDB.buttonsize/2)
					TukuiDB.SetTemplate(bar.frame)
					frame.styled=true
				end
				bar.frame:Show()

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
				if bar.owner.options.IconLeft then 
					icon1:Show()
					icon1.overlay:Show()
				else 
					icon1:Hide()
					icon1.overlay:Hide()
				end

				if not icon2.styled then
					icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon2:ClearAllPoints()
					icon2:SetPoint("TOPLEFT", icon2.overlay, TukuiDB.Scale(2), TukuiDB.Scale(-2))
					icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, TukuiDB.Scale(-2), TukuiDB.Scale(2))
					icon2.styled=true
				end
				if bar.owner.options.IconRight then 
					icon2:Show()
					icon2.overlay:Show() 
				else 
					icon2:Hide()
					icon2.overlay:Hide()
				end
	
				if not texture.styled then
					texture:SetTexture(TukuiCF["media"].normTex)
					texture.styled=true
				end
				texture:SetTexture(bar.owner.options.Texture)
				texture:SetAlpha(1)

				if not tbar.styled then
					tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
					tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
					tbar.styled=true
				end

				tbar:SetAlpha(1)
				frame:SetAlpha(1)

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 0, TukuiDB.Scale(4))
					name:SetWidth(165)
					name:SetHeight(8)
					name:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
					name:SetJustifyH("LEFT")
					name:SetShadowColor(0, 0, 0, 0)
					name.SetFont = noop
					name.styled=true
				end
				--	name:SetFont(bar.owner.options.Font, bar.owner.options.FontSize)
				--	name:SetTextColor(bar.owner.options.TextColorR, bar.owner.options.TextColorG, bar.owner.options.TextColorB)
				if not timer.styled then	
					timer:ClearAllPoints()
					timer:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", TukuiDB.Scale(-1), TukuiDB.Scale(2))
					timer:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.SetFont = noop
					timer.styled=true
				end
				--	timer:SetFont(bar.owner.options.Font, bar.owner.options.FontSize)
				--	timer:SetTextColor(bar.owner.options.TextColorR, bar.owner.options.TextColorG, bar.owner.options.TextColorB)
				bar:Update(0)
				bar.injected=true
			end
			bar:ApplyStyle()
		end

	end
end
hooksecurefunc(DBT, "CreateBar", SkinBars)

-- the boss frames
hooksecurefunc(DBM.BossHealth, "AddBoss", function(cId, name)
	local count = 1
	local bars = {}
	local father=DBMBossHealthDropdown:GetParent()
	local	title={father:GetRegions()}
	if title[1]:IsObjectType("FontString") then
		title[1]:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
		title[1]:SetTextColor(1,1,1,1)
	end
	while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
		local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
		local background = _G[bar:GetName().."BarBorder"]
		local progress = _G[bar:GetName().."Bar"]
		local name = _G[bar:GetName().."BarName"]
		local timer = _G[bar:GetName().."BarTimer"]
		local anchor = _G[format("DBM_BossHealth_Bar_%d", count-1)]

		if (count == 1) then
			local	p1, anch, p2 ,xo, yo = bar:GetPoint()
			bar:SetPoint(p1, anch, p2 ,TukuiDB.Scale(xo - TukuiDB.buttonsize/3), TukuiDB.Scale(yo - TukuiDB.buttonsize/4))
		else
			bar:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, -TukuiDB.buttonsize)
		end

		if not bar.styled then
			bar:SetScale(1)
			bar:SetHeight(TukuiDB.buttonsize/2)
			TukuiDB.SetTemplate(bar)
			background:SetNormalTexture(nil)
			bar.styled=true
		end	
		
		if not progress.styled then
			progress:SetStatusBarTexture(TukuiCF["media"].normTex)
			progress:SetPoint("TOPLEFT", bar, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			progress.styled=true
		end

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
		tinsert(bars, _G[format("DBM_BossHealth_Bar_%d", count)])
		count = count + 1
	end
end)

DBM.RangeCheck:Show()
DBM.RangeCheck:Hide()
TukuiDB.SetTemplate(DBMRangeCheck)
--
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

SLASH_DBMSKIN1 = "/dbmskin"
SlashCmdList["DBMSKIN"] = function(msg)
    if(msg=="apply") then
	StaticPopup_Show("APPLY_SKIN")        
    elseif(msg=="test") then
	DBM:DemoMode()
       else
        pr("use |cffFF0000/dbmskin apply|r to apply DBM settings.")
	pr("use |cffFF0000/dbmskin test|r to launch DBM testmode.")
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

