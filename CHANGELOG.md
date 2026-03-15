# Changelog

All notable changes to devglow will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [3.0.0] - 2025-03-15

### Added
- **Ember palette** — warm terracotta variant inspired by earth tones
- Multi-palette architecture with shared highlight engine
- New palette colors: GOLD, TEAL, SKY, WINE
- Terminal colors (`vim.g.terminal_color_0` through `_15`)
- Missing highlight groups: FloatTitle, FloatFooter, WinBar, WinBarNC, TabLineSel, StatusLineTerm, PmenuMatch, PmenuMatchSel, DiffText, EndOfBuffer, VisualNOS, NormalNC
- Full diagnostic underline groups with undercurl and `sp` color
- DiagnosticOk, DiagnosticDeprecated (strikethrough), DiagnosticUnnecessary (dimmed)
- LSP groups: LspReferenceText/Read/Write, LspInlayHint, LspCodeLens, LspSignatureActiveParameter
- `@lsp.mod.deprecated` with strikethrough
- Neovim help documentation (`:help devglow`)

### Changed
- Renamed palette keys: FG/BG to FOREGROUND/BACKGROUND, D0-D4 to DARK_00-DARK_04
- Extracted palette to `lua/devglow/palettes/` for multi-variant support
- Extracted highlight logic to `lua/devglow/highlights.lua` (shared across palettes)
- Simplified helper functions — removed over-engineered `set_hl` wrapper
- Replaced `vim.cmd("hi! link")` with `nvim_set_hl` link API
- Updated all treesitter captures to current canonical names
- Set `vim.g.colors_name` (was missing)

### Removed
- `TermCursorNC` (removed in Neovim 0.11)
- Deprecated treesitter captures (`@method`, `@field`, `@parameter`, `@text.*`, `@float`, etc.)
- `merge_tables` helper (no longer needed)
- Legacy vimscript colorscheme approach

## [2.0.0] - 2024-01-01

### Changed
- Full rewrite from VimScript to Lua
- Treesitter and LSP semantic token support
- Lualine theme integration

## [1.0.0] - 2019-01-01

### Added
- Initial release — Vim adaptation of Afterglow theme from Sublime Text
- Airline theme support
- Multi-language syntax highlighting
