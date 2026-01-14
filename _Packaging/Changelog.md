# Changelog
All notable changes to this project will be documented in this file.

## 2.0 - 2026-01-14
### Added
- Currency label localizations for Gold, Silver, and Copper in all supported languages:
  - English (enUS): g, s, c
  - German (deDE): g, s, k (Kupfer)
  - Spanish (esES, esMX): o, p, c (Oro, Plata, Cobre)
  - French (frFR): o, a, c (Or, Argent, Cuivre)
  - Italian (itIT): o, a, r (Oro, Argento, Rame)
  - Korean (koKR): 골, 은, 동
  - Portuguese (ptBR): o, p, c (Ouro, Prata, Cobre)
  - Russian (ruRU): з, с, м (Золото, Серебро, Медь)
  - Chinese Simplified (zhCN): 金, 银, 铜
  - Chinese Traditional (zhTW): 金, 銀, 銅

### Changed
- Refactored localization loading to use `KROWI_LIBMAN:GetCurrentLibrary()` instead of LibStub
- Updated locale methods from `GetDefaultLocale()` to `NewDefaultLocale()` and `NewLocale()`
- Renamed `PostLocalization.lua` to `Shared.lua` for better clarity
- Removed redundant `lib.L = L` assignments from individual locale files
- Simplified copyright notice across all files
- Streamlined addon metadata fields in TOC file (replaced individual links with `X-Slug`, `X-CurseForge-ID`, and `X-Wago-ID` format)

## 1.0.3 - 2026-01-07
### Added
- Menu generation functions now automatically load locale
- Optional `addTitle` parameter to `CreateCurrencyOptionsMenu` and `CreateMoneyOptionsMenu` (defaults to true)

### Changed
- Menu function parameter order: `options` moved to first parameter
- Abbreviations are now language-aware and use appropriate suffixes per locale
- Code style improvements: removed semicolons from Lua files for consistency

### Fixed
- Locale caching to prevent repeated LibStub calls

## 1.0.2 - 2026-01-02
### Fixed
- Multi addon library usage errors

## 1.0.1 - 2026-01-02
### Changed
- Localization errors suppressed

## 1.0.0 - 2026-01-02
### Added
- Codebase for upload
- All languages