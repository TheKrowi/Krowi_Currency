# CLAUDE.md

Krowi's Currency (`Krowi_Currency_2`) is a World of Warcraft library in Lua 5.1 that formats money (copper as gold, silver and copper, with text or icon labels, colours, thousands separators and k/m abbreviations) and other currency amounts, and builds the matching options submenus with the consumer's Krowi_Menu menu builder. Addons embed it as the `Libs/Krowi_Currency` submodule; it is also published on its own. The workspace-wide rules (tooling traps, the game loop, taint, git, release safety, how Krowi wants choices presented) load from the workspace `CLAUDE.md` two folders up, a copy of `Krowi_ClaudeKit/WowAddons.md`; this file adds only what is specific to this repo.

There is no build, lint or test step: the library is tested in game through an addon that embeds it. The `krowi` plugin (enabled in `.claude/settings.json`) syntax-checks every edited `.lua` with Lua 5.1 and guards the known tooling traps. The repo is public, but `.claude/settings.json` points at the private kit by absolute path, so the plugin loads only on Krowi's machine; that is intended.

## Clients and loading

- One TOC, `Krowi_Currency.toc`, `## Interface: 120000, 110207, 50503, 20505, 11508` (stale, see Known debt). No saved variables, no dependencies. Embedded, the consumer's TOC decides the clients.
- Load order: `Krowi_Currency.xml` loads `Krowi_Currency.lua`, then `Localization\Files.xml` (enUS, the ten other locales, `Shared.lua`). A new `.lua` must be listed in one of those XML files or it never loads.
- The consumer must load Krowi_Util before it: `KROWI_LIBMAN`, and the `LocalizationHelper` that `NewLibrary` calls for `InitLocalization` (Krowi_Util `LibMan.lua:37-39`).

## Versioning

- The library registers once, through Krowi_Util's LibMan: `KROWI_LIBMAN:NewLibrary('Krowi_Currency_2', 0, {...})` at `Krowi_Currency.lua:9`, which ends in `LibStub:NewLibrary(name, minor)` (Krowi_Util `LibMan.lua:22`). Any change to `Krowi_Currency.lua` bumps that minor; there are no submodules.
- The `Localization/` files register nothing and no minor reloads them. They attach to `KROWI_LIBMAN:GetCurrentLibrary(true)`, and only the first copy that loads registers strings (Known debt): a new or changed string reaches only players whose first-loaded copy has it.
- The minor is `0` and has not changed since 2.0 moved to LibMan. The major `Krowi_Currency_2` changes only for a breaking change; the consumers hard-code it in `KROWI_LIBMAN:GetLibrary('Krowi_Currency_2')`.

## Consumers

Krowi_Brokers_Currency and Krowi_ExtendedVendorUI embed it as `Libs/Krowi_Currency` (both at 2.0). A change reaches players only after a release here, then a submodule bump and a release in each of them.

- Krowi_Brokers_Currency (`addon.CurrencyLib`, set in `Libs/Libs.lua`) formats every amount through `addon:FormatMoney` and `addon:FormatCurrency` with options from `KrowiBCU_Options`, and builds both menus in `Menu.lua` with `addTitle` false.
- Krowi_ExtendedVendorUI formats the token banner's costs and holdings in `Gui/TokenBanner/TokenMixin.lua` and builds both menus in `Gui/TokenBanner/TokenBanner.lua` on its AceDB profile.

## Architecture

- `lib:FormatMoney(value, options)` (`Krowi_Currency.lua:89`) takes copper. It reads `ThousandsSeparator` (`Space`, `Period` or `Comma`, otherwise none), `MoneyAbbreviate` (`1k` or `1m`, applied to the gold part), `MoneyLabel` (`Text` from the locale, `Icon` as `|T` textures `TextureSize` + 2 high, default 14), `MoneyColored` and `MoneyGoldOnly`.
- `lib:FormatCurrency(value, options)` (`:105`) reads `ThousandsSeparator` and `CurrencyAbbreviate`.
- `lib:CreateCurrencyOptionsMenu` and `lib:CreateMoneyOptionsMenu` (`:112`, `:124`), both `(parentMenu, menuBuilder, options, addTitle)`, write those keys straight into `options` through the menu builder's `CreateRadio` and `CreateCheckbox`. The keys and values therefore live in the consumers' saved variables: renaming one loses players' settings.
- No frames, events, hooks or saved variables of its own.

## Taint-sensitive areas

The library touches no Blizzard frame, hooks nothing and registers no events. Its risk is secret values: the format functions compare and compute with `value` (`Krowi_Currency.lua:30-33`, `:50`, `:58`), which errors on a secret number. What the consumers pass today (`GetMoney`, `C_CurrencyInfo.GetCurrencyInfoFromLink(...).quantity`, `C_Item.GetItemCount`, `C_Bank.FetchDepositedMoney`) has no secret flag in `wow-ui-source\live` 12.1.5 (70391). Check again when a consumer feeds a new source, and run the `krowi:taint-reviewer` agent after changing the format functions.

## Localization

`Localization/enUS.lua` and the ten other locale files are the CurseForge export (the project's localization page is linked in `Localization/Shared.lua:6`): code above the `AUTOGENTOKEN` marker (line 14), strings below the `Exported at` line (line 16), at the same place in every file. The 21 strings are the menu labels plus `Gold Label`, `Silver Label`, `Copper Label`, `Thousands Suffix` and `Millions Suffix`, which enUS gives as `g`, `s`, `c`, `k` and `m` and every locale gives its own. Outside enUS, `= true` appears only where the key is already the right text (`1k` and `1m` in esES, esMX, frFR, itIT and ptBR; `Text` in deDE). `Shared.lua` sets `lib.L` last. A missing key is not silent: AceLocale reports it to the error handler (BugSack) and shows the key.

## Code style

Match the file you are editing; this style is not Krowi_AchievementFilter's:

- Tabs in `Krowi_Currency.lua` (its options table uses spaces), four spaces in the XML files. XML attributes are single-quoted.
- No semicolons. Single quotes in code; double quotes only in the CurseForge export lines.
- Lua files open with the `--[[ Copyright (c) 2026 Krowi ... ]]` block, a blank line, `---@diagnostic disable: undefined-global` (`Krowi_Currency.lua` adds `cast-local-type`), a blank line, then the `KROWI_LIBMAN` call and its early `return`. The TOC and XML files carry the same notice as `#` and `<!-- -->` comments.
- Functions PascalCase; locals mostly camelCase, with some snake_case in the formatting helpers (`icon_pre`, `thousands_separator`).
- CRLF on disk (LF in git, `core.autocrlf=true`), no BOM, no final newline (only `Localization/Files.xml` has one). There is no `.editorconfig` and no `.vscode/`.
- Do not restyle lines you are not otherwise changing.

## Testing in game

Test through a consumer. The kit's `Deploy.ps1` run here installs a standalone `Interface\AddOns\Krowi_Currency`: it errors on `KROWI_LIBMAN` unless an addon that embeds Krowi_Util loads before it, and otherwise wins over every consumer's copy with the same minor. Do not leave one installed.

- Point the consumer's `Libs/Krowi_Currency` at the change (in a consumer worktree, check this branch out in the submodule) and deploy the consumer. Or deploy this checkout into an installed consumer with `Deploy.ps1 -Destination "<client>\Interface\AddOns\<consumer>\Libs\Krowi_Currency"`; the consumer's next deploy overwrites it.
- With equal minors the copy in the first addon to load wins, and Krowi_Brokers_Currency loads before Krowi_ExtendedVendorUI. To test through Krowi_ExtendedVendorUI, disable Krowi_Brokers_Currency or bump the minor.
- Exercise both: Krowi_Brokers_Currency's broker text, tooltip and Money and Currency submenus; Krowi_ExtendedVendorUI's token banner at a merchant that sells for gold and for a currency, and its banner options.

## Git and release

- `main` is the only branch and the integration branch: branch from it and open PRs against it. Releases are `Release x.y` commits and tags on `main` (tags 1.0.0 to 2.0).
- Release only with the plugin's `krowi:release`, from `Krowi_Libraries\Krowi_Currency` (the addon manager lists it in `LIBRARY_NAMES`). Every upload is a full release: `--stability stable`.
- After a release, bump `Libs/Krowi_Currency` in each consumer.
- The changelog entries up to 2.0 are written for addon developers who embed the library: they name the API, files and behaviour that changed.

## Known debt (verified 2026-10-17)

- **A newer copy's strings are never registered when an older copy loaded first.** The upgrade reuses `lib`, and `InitLocalization` returns early because `lib.Localization` exists (Krowi_Util `LocalizationHelper.lua:37`). The old `localeIsLoaded` stays, so `NewDefaultLocale` and `NewLocale` return nothing (`:15`, `:24`) and the locale files stop at `if not L then return end`. Passing `addMore` (`NewDefaultLocale(true)`, `NewLocale('<code>', true)`) lets new keys in, but AceLocale never overwrites an existing enUS value (`AceLocale-3.0.lua:62-69`). Every LibMan library with `InitLocalization` has this.
- `FormatMoney` is wrong for negative amounts: `BreakMoney` floors towards minus infinity (`Krowi_Currency.lua:50`), so -1g 50s shows as -2g 50s 0c. No consumer passes a negative amount today.
- Krowi_Brokers_Currency passes `GoldLabel`, `SilverLabel` and `CopperLabel` in its options; the library ignores them and uses its own locale (`Krowi_Currency.lua:73`).
- `Localization/Shared.lua:11` reads `if not lib and not lib.L then return end`: it indexes nil when `lib` is nil and never returns otherwise. Harmless today, because `Krowi_Currency.lua:9` always sets the current library (`LibMan.lua:24`, `:31`).
- The TOC's `## Interface` is stale: the live clients are 120105, 50504, 20506 and 11509, and 11.2.7 no longer exists. It sets the standalone upload's game versions and the README badges.