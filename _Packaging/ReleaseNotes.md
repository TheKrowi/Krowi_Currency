### Added (1.0.3)
- Menu generation functions now automatically load locale
- Optional `addTitle` parameter to `CreateCurrencyOptionsMenu` and `CreateMoneyOptionsMenu` (defaults to true)

### Changed (1.0.3)
- Menu function parameter order: `options` moved to first parameter
- Abbreviations are now language-aware and use appropriate suffixes per locale
- Code style improvements: removed semicolons from Lua files for consistency

### Fixed (1.0.3)
- Locale caching to prevent repeated LibStub calls