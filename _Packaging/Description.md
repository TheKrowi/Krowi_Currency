A comprehensive currency formatting library for World of Warcraft addon development, providing flexible and customizable formatting for in-game currency (gold, silver, copper) and other currency values.

## Features

### Currency Formatting (`Krowi_Currency-1.0`)
- **Money Formatting**: Format copper values into gold, silver, and copper with customizable display options
- **Custom Separators**: Support for comma, period, or space thousands separators
- **Abbreviations**: Abbreviate large values with "k" (thousands) or "m" (millions)
- **Color Options**: Optional colored currency text matching WoW's visual style
- **Icon Support**: Display currency with icons or text labels
- **Flexible Display**: Show gold only or include silver and copper
- **Menu Generation**: Automatically generate options menus for currency and money settings
- **LibStub Support**: Standard LibStub library structure for dependency management

## Usage Examples

### Basic Setup
```lua
local currency = LibStub("Krowi_Currency-1.0")
```

### Format Money
```lua
-- Format 1234567 copper (123g 45s 67c)
local formatted = currency:FormatMoney(1234567, {
    ThousandsSeparator = "Comma",      -- "Comma", "Period", "Space", or ""
    MoneyAbbreviate = "None",          -- "None", "1k", or "1m"
    MoneyColored = true,               -- Colorize currency
    MoneyLabel = "Text",               -- "Text" or "Icon"
    MoneyGoldOnly = false,             -- Show only gold
    GoldLabel = "g",                   -- Custom gold label (if using text)
    SilverLabel = "s",                 -- Custom silver label (if using text)
    CopperLabel = "c",                 -- Custom copper label (if using text)
    TextureSize = 14                   -- Icon size (if using icons)
})
-- Result: "|cffffd100123g|r |cffe6e6e645s|r |cffc8602c67c|r" (colored)
```

### Format Currency
```lua
-- Format arbitrary currency values
local formatted = currency:FormatCurrency(1500000, {
    ThousandsSeparator = "Comma",
    CurrencyAbbreviate = "1m"          -- Abbreviate millions
})
-- Result: "1m"
```

## API Reference

### Currency Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `FormatMoney` | `value, options` | string | Formats copper value into gold/silver/copper with custom options |
| `FormatCurrency` | `value, options` | string | Formats numeric currency value with separators and abbreviations |
| `CreateCurrencyOptionsMenu` | `parentMenu, menuBuilder, options` | void | Generates a submenu for currency abbreviation options |
| `CreateMoneyOptionsMenu` | `parentMenu, menuBuilder, options` | void | Generates a submenu for money formatting options including label, abbreviation, separator, and display settings |

### Options Table

#### FormatMoney Options
| Option | Type | Values | Description |
|--------|------|--------|-------------|
| `ThousandsSeparator` | string | "Comma", "Period", "Space", "" | Thousands separator style |
| `MoneyAbbreviate` | string | "None", "1k", "1m" | Abbreviation level |
| `MoneyColored` | boolean | true/false | Whether to colorize currency |
| `MoneyLabel` | string | "Text", "Icon" | Label display type |
| `MoneyGoldOnly` | boolean | true/false | Show only gold portion |
| `GoldLabel` | string | any | Custom gold text label (default: "g") |
| `SilverLabel` | string | any | Custom silver text label (default: "s") |
| `CopperLabel` | string | any | Custom copper text label (default: "c") |
| `TextureSize` | number | any | Icon texture size (default: 14) |

#### FormatCurrency Options
| Option | Type | Values | Description |
|--------|------|--------|-------------|
| `ThousandsSeparator` | string | "Comma", "Period", "Space", "" | Thousands separator style |
| `CurrencyAbbreviate` | string | "None", "1k", "1m" | Abbreviation level |

### Examples

#### Gold Only Display
```lua
local gold = currency:FormatMoney(1234567, {
    MoneyGoldOnly = true,
    MoneyColored = true,
    MoneyLabel = "Text"
})
-- Result: "|cffffd100123g|r"
```

#### Icon Display
```lua
local withIcons = currency:FormatMoney(1234567, {
    MoneyLabel = "Icon",
    TextureSize = 16
})
-- Result: Icons for gold, silver, and copper
```

#### Abbreviated Currency
```lua
local abbreviated = currency:FormatCurrency(1500000, {
    ThousandsSeparator = "Comma",
    CurrencyAbbreviate = "1m"
})
-- Result: "1m"

local thousands = currency:FormatCurrency(5500, {
    CurrencyAbbreviate = "1k"
})
-- Result: "5k"
```

### Menu Generation
```lua
-- Create currency options menu (for use with a menu builder system)
local parentMenu = {} -- Your menu system's parent menu
local menuBuilder = {} -- Your menu builder object with required methods
local options = {} -- Your addon's options table

currency:CreateCurrencyOptionsMenu(parentMenu, menuBuilder, options)
-- Creates submenu with:
--   - Currency Abbreviate (None/1k/1m)

currency:CreateMoneyOptionsMenu(parentMenu, menuBuilder, options)
-- Creates submenu with:
--   - Money Label (None/Text/Icon)
--   - Money Abbreviate (None/1k/1m)
--   - Thousands Separator (Space/Period/Comma)
--   - Money Gold Only (checkbox)
--   - Money Colored (checkbox)
```

**Note:** Abbreviations are automatically localized (e.g., "k/m" for English, "T/M" for German, "千/百万" for Chinese).

## Use Cases
- Display player gold in custom UI frames
- Format auction house prices
- Show currency costs in tooltips
- Display quest rewards
- Format currency in chat messages
- Create custom currency displays with consistent formatting
- Generate options menus for currency/money formatting settings in your addon

## Requirements
- LibStub