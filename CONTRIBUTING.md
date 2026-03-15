# Contributing to devglow

Thanks for your interest in contributing to devglow.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```sh
   git clone https://github.com/YOUR_USERNAME/devglow.git
   ```
3. Create a branch:
   ```sh
   git checkout -b your-feature
   ```

## Project Structure

```
colors/                    # Colorscheme entry points (:colorscheme devglow-*)
lua/devglow/
  palette.lua              # Palette loader
  highlights.lua           # Shared highlight definitions
  palettes/                # Palette definitions (one per variant)
doc/                       # Neovim help documentation
```

## Adding a New Palette

1. Create `lua/devglow/palettes/yourname.lua` with all 17 color keys (see `sage.lua` for reference)
2. Create `colors/devglow-yourname.lua` entry point
3. Update `doc/devglow.txt` and `README.md`
4. Submit a PR

## Adding Plugin Support

Add highlight definitions to `lua/devglow/highlights.lua` under the PLUGINS section. Use only palette colors — never hardcode hex values in the highlights file.

## Guidelines

- **Use palette colors only** — all hex values live in palette files, never in highlights
- **Test both palettes** — run `:colorscheme devglow-sage` and `:colorscheme devglow-ember` to verify
- **Use the Lua API** — `vim.api.nvim_set_hl`, not `vim.cmd("highlight")`
- **No breaking changes to palette keys** — adding keys is fine, renaming/removing requires a major version bump
- **Keep it minimal** — don't add highlights for plugins nobody asked for
- **Tabs for indentation** — see `.editorconfig`

## Submitting Changes

1. Make sure your changes work on Neovim >= 0.10
2. Test with both sage and ember palettes
3. Update CHANGELOG.md
4. Open a pull request with a clear description of what changed and why

## Reporting Issues

Open an issue on GitHub with:

- Neovim version (`:version`)
- Terminal emulator
- Screenshot if it's a visual issue
- Minimal config to reproduce
