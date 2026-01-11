--[[
    Copyright (c) 2026 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:GetCurrentLibrary(true)
if not lib then	return end

local L = lib.Localization.NewDefaultLocale()
if not L then return end
lib.L = L

-- [[ https://legacy.curseforge.com/wow/addons/krowi-currency/localization ]] --
-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-02 11-03-56 ]] --
L["1k"] = true
L["1m"] = true
L["Comma"] = true
L["Currency Abbreviate"] = true
L["Currency Options"] = true
L["Icon"] = true
L["Millions Suffix"] = "m"
L["Money Abbreviate"] = true
L["Money Colored"] = true
L["Money Gold Only"] = true
L["Money Label"] = true
L["Money Options"] = true
L["None"] = true
L["Period"] = true
L["Space"] = true
L["Text"] = true
L["Thousands Separator"] = true
L["Thousands Suffix"] = "k"
L["Gold Label"] = "g"
L["Silver Label"] = "s"
L["Copper Label"] = "c"