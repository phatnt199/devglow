# devglow

A professional dark colorscheme for Neovim — and beyond.

Two palettes. One philosophy: colors that stay quiet while you think.

---

## The Story

**devglow** was born from the [Afterglow](https://github.com/danilo-augusto/vim-afterglow) theme for Sublime Text, then rewritten from scratch for modern Neovim. It has since grown into a full design system spanning terminal, shell, editors, and file managers.

It ships with two palettes:

### Sage — *one for the quiet night*

Muted, grey-tinted, calm. Built for the long session, the 2am refactor, the "I've been staring at this for 4 hours and my eyes don't hurt" feeling. A dark room with just enough candlelight to read by. Colors aged like leather and old paper. Restrained. Quiet.

### Ember — *one for the fire*

What's left after the fire — not the flame itself, but the glowing coals underneath. Terracotta, warm gold, burnt wine. The background isn't pure black, it's charcoal. The foreground isn't pure white, it's cream. Everything has a temperature. It glows from within, like its name.

---

## Palettes

### Sage

| Role | Color | Hex |
|------|-------|-----|
| Foreground | ![#E6E6E6](https://placehold.co/16x16/E6E6E6/E6E6E6) | `#E6E6E6` |
| Background | ![#080808](https://placehold.co/16x16/080808/080808) | `#080808` |
| Red | ![#AF5F5F](https://placehold.co/16x16/AF5F5F/AF5F5F) | `#AF5F5F` |
| Green | ![#87AFAF](https://placehold.co/16x16/87AFAF/87AFAF) | `#87AFAF` |
| Blue | ![#7590AF](https://placehold.co/16x16/7590AF/7590AF) | `#7590AF` |
| Orange | ![#D59572](https://placehold.co/16x16/D59572/D59572) | `#D59572` |
| Yellow | ![#E5B567](https://placehold.co/16x16/E5B567/E5B567) | `#E5B567` |
| Pink | ![#D68C8C](https://placehold.co/16x16/D68C8C/D68C8C) | `#D68C8C` |
| Gold | ![#EBC17A](https://placehold.co/16x16/EBC17A/EBC17A) | `#EBC17A` |
| Teal | ![#7DB9B6](https://placehold.co/16x16/7DB9B6/7DB9B6) | `#7DB9B6` |
| Sky | ![#7EAAC7](https://placehold.co/16x16/7EAAC7/7EAAC7) | `#7EAAC7` |
| Wine | ![#924653](https://placehold.co/16x16/924653/924653) | `#924653` |

### Ember

| Role | Color | Hex |
|------|-------|-----|
| Foreground | ![#F5F0EB](https://placehold.co/16x16/F5F0EB/F5F0EB) | `#F5F0EB` |
| Background | ![#141311](https://placehold.co/16x16/141311/141311) | `#141311` |
| Red | ![#D06060](https://placehold.co/16x16/D06060/D06060) | `#D06060` |
| Green | ![#6AADAD](https://placehold.co/16x16/6AADAD/6AADAD) | `#6AADAD` |
| Blue | ![#5A9D9D](https://placehold.co/16x16/5A9D9D/5A9D9D) | `#5A9D9D` |
| Orange | ![#D4785E](https://placehold.co/16x16/D4785E/D4785E) | `#D4785E` |
| Yellow | ![#E0BA6A](https://placehold.co/16x16/E0BA6A/E0BA6A) | `#E0BA6A` |
| Pink | ![#E08B72](https://placehold.co/16x16/E08B72/E08B72) | `#E08B72` |
| Gold | ![#EACA80](https://placehold.co/16x16/EACA80/EACA80) | `#EACA80` |
| Teal | ![#7BBDBD](https://placehold.co/16x16/7BBDBD/7BBDBD) | `#7BBDBD` |
| Sky | ![#6AADAD](https://placehold.co/16x16/6AADAD/6AADAD) | `#6AADAD` |
| Wine | ![#B45A42](https://placehold.co/16x16/B45A42/B45A42) | `#B45A42` |

---

## Requirements

- Neovim >= 0.10
- A terminal with true color support (most modern terminals)
- A [Nerd Font](https://www.nerdfonts.com/) (recommended, for icon support in integrations)

---

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "phatnt199/devglow",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("devglow")
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "phatnt199/devglow",
  config = function()
    vim.cmd.colorscheme("devglow")
  end,
}
```

### Manual

Clone the repository into your Neovim runtime path:

```sh
git clone https://github.com/phatnt199/devglow.git \
  ~/.local/share/nvim/site/pack/plugins/start/devglow
```

---

## Usage

```vim
" Sage (default)
:colorscheme devglow
:colorscheme devglow-sage

" Ember
:colorscheme devglow-ember
```

Or in your Lua config:

```lua
vim.cmd.colorscheme("devglow")       -- sage (default)
vim.cmd.colorscheme("devglow-ember") -- ember
```

### Accessing the palette programmatically

```lua
-- Load a specific palette
local sage = require("devglow.palette").load("sage")
local ember = require("devglow.palette").load("ember")

-- Use in your own highlights
vim.api.nvim_set_hl(0, "MyCustomGroup", { fg = sage.TEAL, bg = sage.DARK_01 })
```

---

## What's Included

### Neovim Highlights

devglow provides highlight definitions for:

**Editor UI** — Normal, NormalFloat, CursorLine, Visual, Search, Pmenu, StatusLine, WinBar, TabLine, FloatBorder, FloatTitle, and more.

**Syntax** — Full coverage of Vim's built-in syntax groups (Comment, String, Function, Keyword, Type, Operator, etc.) with custom semantic groups for access modifiers, special keywords (`this`/`self`/`super`), and type parameters.

**Treesitter** — All current canonical captures (`@variable`, `@function`, `@keyword.conditional`, `@markup.*`, `@diff.*`, etc.). No deprecated capture names.

**LSP Semantic Tokens** — `@lsp.type.*` for all standard token types, `@lsp.mod.deprecated` (strikethrough), and `@lsp.typemod.*` for combined modifiers.

**Diagnostics** — Error, Warn, Info, Hint, Ok with matching underline variants (undercurl with `sp` color), plus `DiagnosticDeprecated` (strikethrough) and `DiagnosticUnnecessary` (dimmed).

**LSP UI** — LspReferenceText/Read/Write, LspInlayHint, LspCodeLens, LspSignatureActiveParameter.

**Terminal** — 16 terminal colors (`vim.g.terminal_color_0` through `_15`).

### Plugin Support

| Plugin | Status |
|--------|--------|
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) | Borders and titles |
| [NvimTree](https://github.com/nvim-tree/nvim-tree.lua) | Full highlight support |
| [BlinkCmp](https://github.com/Saghen/blink.cmp) | Menu and doc borders |
| [Lualine](https://github.com/nvim-lualine/lualine.nvim) | Dedicated theme |

#### Lualine

```lua
require("lualine").setup({
  options = {
    theme = "devglow",
  },
})
```

### Beyond Neovim

devglow is a design system, not just a Vim colorscheme. It ships with theme files for:

| Tool | File | Format |
|------|------|--------|
| [Alacritty](https://alacritty.org/) | See [dotfiles](https://github.com/phatnt199/dotfiles) | TOML |
| [Gemini Code](https://github.com/google-gemini/gemini-cli) | `lua/gemini/devglow.json` | JSON |
| [OpenCode](https://github.com/opencode-ai/opencode) | `lua/opencode/devglow.json` | JSON |
| [Superfile](https://github.com/yorukot/superfile) | `lua/superfile/themes/devglow.toml` | TOML |
| [Zsh](https://www.zsh.org/) | `lua/zsh/devglow.zsh-theme` | Zsh theme |

---

## Project Structure

```
devglow/
  colors/
    devglow.lua              # :colorscheme devglow (loads sage)
    devglow-sage.lua         # :colorscheme devglow-sage
    devglow-ember.lua        # :colorscheme devglow-ember
  lua/
    devglow/
      palette.lua            # Palette loader
      highlights.lua         # Shared highlight definitions
      palettes/
        sage.lua             # Sage palette
        ember.lua            # Ember palette
    lualine/
      themes/
        devglow.lua          # Lualine statusline theme
    gemini/
      devglow.json           # Gemini editor theme
    opencode/
      devglow.json           # OpenCode editor theme
    superfile/
      themes/
        devglow.toml         # Superfile file manager theme
    zsh/
      devglow.zsh-theme      # Zsh prompt theme
```

---

## Design Principles

1. **Quiet colors** — No high saturation. Every color earns its place by being distinct without being loud.
2. **Semantic consistency** — Red is always keywords/errors. Green is always functions/success. Orange is always types/constants. Across every tool.
3. **Dark-first** — Pure dark backgrounds (`#080808` / `#141311`) optimized for long sessions in low light.
4. **Warm neutrals** — Grey shades lean warm, never cold blue-grey. Comments and UI chrome feel like part of the palette, not an afterthought.
5. **Minimal but complete** — 12 colors + 5 shades. Small enough to memorize, large enough to cover every semantic role.

---

## Color Semantics

| Color | Role |
|-------|------|
| **Red** | Keywords, errors, control flow |
| **Green** | Functions, success, staged changes |
| **Blue** | Preprocessor, diagnostics info |
| **Orange** | Types, constants, directories, warnings |
| **Yellow** | Strings, search highlights, numbers |
| **Pink** | Operators, substitution |
| **Gold** | Primary accent, cursor, completion match |
| **Teal** | Secondary accent, terminal cyan |
| **Sky** | Info hints, terminal blue |
| **Wine** | Magenta, special control flow |
| **Dark 00–04** | UI shades from darkest to comments |

---

## Adding a New Palette

1. Create `lua/devglow/palettes/yourname.lua`:

```lua
-- Your story here.

return {
  FOREGROUND = "#......",
  BACKGROUND = "#......",

  RED = "#......",
  GREEN = "#......",
  BLUE = "#......",
  ORANGE = "#......",
  YELLOW = "#......",
  PINK = "#......",
  GOLD = "#......",
  TEAL = "#......",
  SKY = "#......",
  WINE = "#......",

  DARK_00 = "#......",
  DARK_01 = "#......",
  DARK_02 = "#......",
  DARK_03 = "#......",
  DARK_04 = "#......",
}
```

2. Create `colors/devglow-yourname.lua`:

```lua
vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "devglow-yourname"

local palette = require("devglow.palette").load("yourname")
require("devglow.highlights")(palette)
```

3. Use it: `:colorscheme devglow-yourname`

---

## Support

If devglow helps you code through the quiet nights or by the fire, consider buying me a coffee.

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-tanphat199-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/tanphat199)

---

## Inspired By

[Afterglow](https://github.com/danilo-augusto/vim-afterglow) — the original Sublime Text theme that started it all. devglow began as a Vim port of Afterglow, then evolved into its own design system with new palettes, modern Neovim APIs, and multi-tool support.

---

## License

[MIT](LICENSE)

---

## Author

**Phat Nguyen** ([@phatnt199](https://github.com/phatnt199))

*Two palettes. Same soul. One for the quiet night. One for the fire.*
