-----------------------------------------------------------------------------
-- DEVGLOW
--- A professional dark colorscheme for Neovim
---
--- Features:
---   - Full Treesitter support for modern syntax highlighting
---   - LSP semantic token integration
---   - Multi-language support (TypeScript, JavaScript, Python, Rust, Go, etc.)
---   - Consistent color palette optimized for long coding sessions
---
--- Author: Phat Nguyen (tanphat199@gmail.com)
--- Version: 2.0
-- Lua version of the devglow.vim colorscheme.
-----------------------------------------------------------------------------

vim.o.background = "dark"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

-----------------------------------------------------------------------------
local Colors = {
	FOREGROUND = "#E6E6E6",
	BACKGROUND = "#080808",

	RED = "#AF5F5F",
	GREEN = "#87AFAF",
	BLUE = "#7590AF",
	YELLOW_0 = "#D59572",
	YELLOW_1 = "#E5B567",
	PURPLE = "#D68C8C",

	-- SHADES
	DARK_0 = "#111111",
	DARK_1 = "#181818",
	DARK_2 = "#282828",
	DARK_3 = "#383838",
	DARK_4 = "#797979",
}

-----------------------------------------------------------------------------
local function set_hl(group, rfg, rbg, attr)
	-- Validate group name
	if not group or type(group) ~= "string" or group == "" then
		vim.notify(string.format("Invalid highlight group name: %s", vim.inspect(group)), vim.log.levels.WARN)
		return false
	end

	-- Initialize attributes
	attr = attr or {}

	-- Build highlight options table
	local hl_opts = {}

	-- Set colors (allow nil values)
	if rfg then
		hl_opts.fg = rfg
	end
	if rbg then
		hl_opts.bg = rbg
	end

	-- Set style attributes (only if explicitly true)
	if attr.bold == true then
		hl_opts.bold = true
	end
	if attr.italic == true then
		hl_opts.italic = true
	end
	if attr.underline == true then
		hl_opts.underline = true
	end
	if attr.reverse == true then
		hl_opts.reverse = true
	end

	-- Apply highlight safely
	local ok, err = pcall(vim.api.nvim_set_hl, 0, group, hl_opts)
	if not ok then
		vim.notify(string.format("Failed to set highlight '%s': %s", group, err), vim.log.levels.ERROR)
		return false
	end

	return true
end

local highlights = {
	-- Set the Normal and LineNr highlight groups
	{ scope = "Normal", fg = Colors.FOREGROUND, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "LineNr", fg = Colors.DARK_4, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "SignColumn", fg = nil, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "Todo", fg = Colors.RED, bg = Colors.BACKGROUND, styles = { bold = true } },

	-- Vim Highlighting
	{ scope = "Comment", fg = Colors.DARK_4, bg = nil, styles = nil },
	{ scope = "NonText", fg = Colors.DARK_4, bg = nil, styles = nil },
	{ scope = "SpecialKey", fg = Colors.DARK_1, bg = nil, styles = nil },
	{ scope = "Search", fg = Colors.BACKGROUND, bg = Colors.YELLOW_1, styles = nil },
	{ scope = "TabLine", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "TabLineFill", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "StatusLine", fg = Colors.DARK_1, bg = Colors.YELLOW_1, styles = { reverse = true } },
	{ scope = "StatusLineNC", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "Visual", fg = nil, bg = Colors.DARK_3, styles = nil },
	{ scope = "Directory", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "ModeMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "MoreMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Question", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "WarningMsg", fg = Colors.YELLOW_0, bg = nil, styles = { bold = true } },
	{ scope = "MatchParen", fg = Colors.FOREGROUND, bg = Colors.RED, styles = nil },
	{ scope = "Folded", fg = Colors.DARK_4, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "FoldColumn", fg = nil, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "Pmenu", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "CursorLine", fg = nil, bg = Colors.DARK_2, styles = nil },
	{ scope = "CursorLineNr", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "CursorColumn", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "PMenuSel", fg = Colors.FOREGROUND, bg = Colors.DARK_1, styles = { reverse = true } },
	{ scope = "ColorColumn", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "WinSeparator", fg = Colors.DARK_1, bg = nil, styles = nil },
	{ scope = "NormalFloat", fg = nil, bg = Colors.DARK_2, styles = nil },
	{ scope = "FloatBorder", fg = Colors.DARK_3, bg = nil, styles = nil },

	-- Standard Highlighting
	{ scope = "Title", fg = Colors.DARK_4, bg = nil, styles = { bold = true } },
	{ scope = "Identifier", fg = Colors.FOREGROUND, bg = nil, styles = nil },
	{ scope = "Statement", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Conditional", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Repeat", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Structure", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "Function", fg = Colors.GREEN, bg = nil, styles = { bold = true } },
	{ scope = "Constant", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "Keyword", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "String", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "Special", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "Delimiter", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "PreProc", fg = Colors.BLUE, bg = nil, styles = nil },
	{ scope = "Operator", fg = Colors.PURPLE, bg = nil, styles = nil },
	{ scope = "Type", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "Define", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Include", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Tag", fg = Colors.YELLOW_0, bg = nil, styles = { bold = true } },
	{ scope = "Underlined", fg = Colors.YELLOW_0, bg = nil, styles = { underline = true } },
	{ scope = "QuickFixLine", fg = Colors.RED, bg = nil, styles = { bold = true } },

	-- Special Keywords (this, self, super)
	{ scope = "SpecialKeyword", fg = Colors.YELLOW_0, bg = nil, styles = { italic = true } },

	-- Access Modifiers (private, protected, public, readonly, static, abstract)
	{ scope = "AccessModifier", fg = Colors.RED, bg = nil, styles = { italic = true } },

	-- Diffs
	{ scope = "DiffAdded", fg = Colors.GREEN, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffChange", fg = Colors.YELLOW_1, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffDelete", fg = Colors.RED, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffLine", fg = Colors.BLUE, bg = Colors.BACKGROUND, styles = { italic = true } },
	{ scope = "DiffSubname", fg = Colors.FOREGROUND, bg = Colors.BACKGROUND, styles = nil },

	-- Telescope
	{ scope = "TelescopeBorder", fg = Colors.DARK_3, bg = nil, styles = nil },
	{ scope = "TelescopeTitle", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePromptTitle", fg = Colors.FOREGROUND, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePreviewTitle", fg = Colors.GREEN, bg = nil, styles = { bold = true } },

	-- Diagnostics
	{ scope = "DiagnosticError", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticWarn", fg = Colors.YELLOW_1, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticInfo", fg = Colors.BLUE, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticHint", fg = Colors.BLUE, bg = nil, styles = { bold = true } },

	-- NvimTree
	{ scope = "NvimParenthesis", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "NvimTreeNormal", fg = Colors.FOREGROUND, bg = Colors.DARK_0, styles = nil },
	{ scope = "NvimTreeRootFolder", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "NvimTreeFolderName", fg = Colors.YELLOW_0, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeExecFile", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeOpenedFile", fg = Colors.FOREGROUND, bg = nil, styles = nil },
	{ scope = "NvimTreeWindowPicker", fg = Colors.FOREGROUND, bg = Colors.DARK_1, styles = { bold = true } },

	-- BlinkCmp
	{ scope = "BlinkCmpMenuBorder", fg = Colors.DARK_3, bg = nil, styles = nil },

	-- TypeScript/Generic Type Parameters
	{ scope = "TypeParameter", fg = Colors.GREEN, bg = nil, styles = { italic = true } },
}

-----------------------------------------------------------------------------
for index in ipairs(highlights) do
	local h = highlights[index]
	set_hl(h.scope, h.fg, h.bg, h.styles)
end

vim.cmd("hi! link diffAdded DiffAdded")
vim.cmd("hi! link DiffAdd DiffAdded")
vim.cmd("hi! link diffAdd DiffAdded")
vim.cmd("hi! link diffChange DiffChange")
vim.cmd("hi! link diffDelete DiffDelete")
vim.cmd("hi! link diffLine DiffLine")
vim.cmd("hi! link diffSubname DiffSubname")
vim.cmd("hi! link DiffRemoved DiffDelete")
vim.cmd("hi! link diffRemoved DiffDelete")

vim.cmd("hi! link NvimTreeFolderIcon Directory")
vim.cmd("hi! link NvimTreeEmptyFolderName NvimTreeFolderName")
vim.cmd("hi! link NvimTreeOpenedFolderName NvimTreeFolderName")

vim.cmd("hi! link BlinkCmpDocBorder BlinkCmpMenuBorder")

-- TypeScript/JavaScript Generic Type Parameters
vim.cmd("hi! link @type.parameter TypeParameter")
vim.cmd("hi! link @lsp.type.typeParameter TypeParameter")
vim.cmd("hi! link @typeParameter TypeParameter")

-- Special Keywords (this, self, super) - OOP languages
vim.cmd("hi! link @variable.builtin SpecialKeyword")
vim.cmd("hi! link @keyword.this SpecialKeyword")
vim.cmd("hi! link @keyword.self SpecialKeyword")
vim.cmd("hi! link @keyword.super SpecialKeyword")
vim.cmd("hi! link @lsp.type.selfKeyword SpecialKeyword")

-- Access Modifiers (private, protected, public, readonly, static, abstract)
vim.cmd("hi! link @keyword.modifier AccessModifier")
vim.cmd("hi! link @storageclass AccessModifier")
vim.cmd("hi! link @lsp.type.modifier AccessModifier")
vim.cmd("hi! link @lsp.typemod.keyword.modifier AccessModifier")

-- Operators & Punctuation (All languages)
vim.cmd("hi! link @operator Operator")
vim.cmd("hi! link @punctuation Delimiter")
vim.cmd("hi! link @punctuation.bracket Delimiter")
vim.cmd("hi! link @punctuation.delimiter Delimiter")
vim.cmd("hi! link @punctuation.special Special")

-- Types & Classes (All languages)
vim.cmd("hi! link @type Type")
vim.cmd("hi! link @type.builtin Type")
vim.cmd("hi! link @type.definition Type")
vim.cmd("hi! link @type.qualifier Keyword")
vim.cmd("hi! link @class Type")
vim.cmd("hi! link @interface Type")
vim.cmd("hi! link @struct Type")
vim.cmd("hi! link @enum Type")
vim.cmd("hi! link @union Type")
vim.cmd("hi! link @typedef Type")
