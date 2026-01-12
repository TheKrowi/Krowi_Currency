--[[
    Copyright (c) 2026 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local lib = KROWI_LIBMAN:GetCurrentLibrary(true)
if not lib then	return end

local L = lib.Localization.NewLocale('deDE')
if not L then return end

-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2026-01-02 11-03-56 ]] --
L["1k"] = "1T"
L["1m"] = "1M"
L["Comma"] = "Komma"
L["Currency Abbreviate"] = "Währung Abkürzen"
L["Currency Options"] = "Währungsoptionen"
L["Icon"] = "Symbol"
L["Millions Suffix"] = "M"
L["Money Abbreviate"] = "Geld Abkürzen"
L["Money Colored"] = "Geld Farbig"
L["Money Gold Only"] = "Nur Gold Anzeigen"
L["Money Label"] = "Geldbeschriftung"
L["Money Options"] = "Geldoptionen"
L["None"] = "Keine"
L["Period"] = "Punkt"
L["Space"] = "Leerzeichen"
L["Text"] = true
L["Thousands Separator"] = "Tausendertrennzeichen"
L["Thousands Suffix"] = "T"
L["Gold Label"] = "g"
L["Silver Label"] = "s"
L["Copper Label"] = "k"