-----------------------------------------------------------------------------
-- DEVGLOW
-- Lua version of the devglow.vim colorscheme.
-----------------------------------------------------------------------------

vim.o.background = "dark"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

-----------------------------------------------------------------------------
local Colors = {
	FOREGROUND = "#EEE2DE",
	BACKGROUND = "#080808",
	COMMENT = "#797979",
	RED = "#AF5F5F",
	YELLOW_0 = "#AF875F",
	YELLOW_1 = "#D59572",
	YELLOW_2 = "#E5B567",
	GREEN = "#87AFAF",
	BLUE = "#7EAAC7",
	WINE = "#924653",
	PURPLE = "#9E86C8",
	DARK_0 = "#111111",
	DARK_1 = "#181818",
	DARK_2 = "#282828",
	DARK_3 = "#383838",
	DARK_4 = "#BBBBBB",
	ERORR = "#EA5455",
	WARN = "#FFA500",
	INFO = "#7DB9B6",
}

-----------------------------------------------------------------------------
local function set_hl(group, rfg, rbg, attr)
	attr = attr or {}
	vim.api.nvim_set_hl(0, group, {
		fg = rfg,
		bg = rbg,
		bold = attr.bold,
		italic = attr.italic,
		underline = attr.underline,
		reverse = attr.reverse,
	})
end

local highlights = {
	-- Set the Normal and LineNr highlight groups
	{ scope = "Normal", fg = Colors.FOREGROUND, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "LineNr", fg = Colors.COMMENT, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "SignColumn", fg = nil, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "Todo", fg = Colors.RED, bg = Colors.BACKGROUND, styles = { bold = true } },

	-- Vim Highlighting
	{ scope = "Comment", fg = Colors.COMMENT, bg = nil, styles = {} },
	{ scope = "NonText", fg = Colors.COMMENT, bg = nil, styles = nil },
	{ scope = "SpecialKey", fg = Colors.DARK_1, bg = nil, styles = nil },
	{ scope = "Search", fg = Colors.BACKGROUND, bg = Colors.YELLOW_2, styles = nil },
	{ scope = "TabLine", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "TabLineFill", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "StatusLine", fg = Colors.DARK_1, bg = Colors.YELLOW_2, styles = { reverse = true } },
	{ scope = "StatusLineNC", fg = Colors.DARK_1, bg = Colors.FOREGROUND, styles = { reverse = true } },
	{ scope = "Visual", fg = nil, bg = Colors.DARK_3, styles = nil },
	{ scope = "Directory", fg = Colors.YELLOW_0, bg = nil, styles = nil },
	{ scope = "ModeMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "MoreMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Question", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "WarningMsg", fg = Colors.YELLOW_1, bg = nil, styles = { bold = true } },
	{ scope = "MatchParen", fg = nil, bg = Colors.WINE, styles = nil },
	{ scope = "Folded", fg = Colors.COMMENT, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "FoldColumn", fg = nil, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "Pmenu", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "CursorLine", fg = nil, bg = Colors.DARK_2, styles = nil },
	{ scope = "CursorLineNr", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "CursorColumn", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "PMenuSel", fg = Colors.FOREGROUND, bg = Colors.DARK_1, styles = { reverse = true } },
	{ scope = "ColorColumn", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "WinSeparator", fg = Colors.DARK_1, bg = nil, styles = nil },
	{ scope = "NormalFloat", fg = nil, bg = Colors.DARK_1, styles = nil },
	{ scope = "FloatBorder", fg = Colors.DARK_3, bg = nil, styles = nil },

	-- Standard Highlighting
	{ scope = "Title", fg = Colors.COMMENT, bg = nil, styles = { bold = true } },
	{ scope = "Identifier", fg = Colors.FOREGROUND, bg = nil, styles = nil },
	{ scope = "Statement", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Conditional", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Repeat", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Structure", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "Function", fg = Colors.GREEN, bg = nil, styles = { bold = true } },
	{ scope = "Constant", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "Keyword", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "String", fg = Colors.YELLOW_2, bg = nil, styles = nil },
	{ scope = "Special", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "Delimiter", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "PreProc", fg = Colors.BLUE, bg = nil, styles = nil },
	{ scope = "Operator", fg = Colors.PURPLE, bg = nil, styles = nil },
	{ scope = "Type", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "Define", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Include", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Tag", fg = Colors.YELLOW_1, bg = nil, styles = { bold = true } },
	{ scope = "Underlined", fg = Colors.YELLOW_1, bg = nil, styles = { underline = true } },
	{ scope = "QuickFixLine", fg = Colors.RED, bg = nil, styles = { bold = true } },

	-- Diffs
	{ scope = "DiffAdded", fg = Colors.GREEN, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffChange", fg = Colors.YELLOW_2, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffDelete", fg = Colors.RED, bg = Colors.BACKGROUND, styles = nil },
	{ scope = "DiffLine", fg = Colors.BLUE, bg = Colors.BACKGROUND, styles = { italic = true } },
	{ scope = "DiffSubname", fg = Colors.FOREGROUND, bg = Colors.BACKGROUND, styles = nil },

	-- Telescope
	{ scope = "TelescopeBorder", fg = Colors.DARK_3, bg = nil, styles = nil },
	{ scope = "TelescopeTitle", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePromptTitle", fg = Colors.FOREGROUND, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePreviewTitle", fg = Colors.GREEN, bg = nil, styles = { bold = true } },

	-- Diagnostics
	{ scope = "DiagnosticError", fg = Colors.ERORR, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticWarn", fg = Colors.WARN, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticInfo", fg = Colors.INFO, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticHint", fg = Colors.BLUE, bg = nil, styles = { bold = true } },

	-- NvimTree
	{ scope = "NvimParenthesis", fg = Colors.YELLOW_1, bg = nil, styles = nil },
	{ scope = "NvimTreeNormal", fg = Colors.DARK_4, bg = Colors.DARK_0, styles = nil },
	{ scope = "NvimTreeRootFolder", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "NvimTreeFolderName", fg = Colors.YELLOW_0, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeExecFile", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeOpenedFile", fg = Colors.FOREGROUND, bg = nil, styles = nil },
	{ scope = "NvimTreeWindowPicker", fg = Colors.DARK_4, bg = Colors.DARK_1, styles = { bold = true } },

	-- BlinkCmp
	{ scope = "BlinkCmpMenuBorder", fg = Colors.DARK_3, bg = nil, styles = nil },
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
