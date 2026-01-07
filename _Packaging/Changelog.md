# Changelog
All notable changes to this project will be documented in this file.

## 1.0.3 - 2026-01-07
### Added
- Menu generation functions now automatically load locale

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