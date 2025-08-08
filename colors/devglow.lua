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

-----------------------------------------------------------------------------
-- Set the Normal and LineNr highlight groups
set_hl("Normal", Colors.FOREGROUND, Colors.BACKGROUND, nil)
set_hl("LineNr", Colors.COMMENT, Colors.BACKGROUND, nil)
set_hl("SignColumn", nil, Colors.BACKGROUND, nil)
set_hl("Todo", Colors.RED, Colors.BACKGROUND, { bold = true })

-- Vim Highlighting
set_hl("Comment", Colors.COMMENT, nil, {})
set_hl("NonText", Colors.COMMENT, nil, nil)
set_hl("SpecialKey", Colors.DARK_1, nil, nil)
set_hl("Search", Colors.BACKGROUND, Colors.YELLOW_2, nil)
set_hl("TabLine", Colors.DARK_1, Colors.FOREGROUND, { reverse = true })
set_hl("TabLineFill", Colors.DARK_1, Colors.FOREGROUND, { reverse = true })
set_hl("StatusLine", Colors.DARK_1, Colors.YELLOW_2, { reverse = true })
set_hl("StatusLineNC", Colors.DARK_1, Colors.FOREGROUND, { reverse = true })
set_hl("Visual", nil, Colors.DARK_3, nil)
set_hl("Directory", Colors.YELLOW_0, nil, nil)
set_hl("ModeMsg", Colors.GREEN, nil, nil)
set_hl("MoreMsg", Colors.GREEN, nil, nil)
set_hl("Question", Colors.GREEN, nil, nil)
set_hl("WarningMsg", Colors.YELLOW_1, nil, { bold = true })
set_hl("MatchParen", nil, Colors.WINE, nil)
set_hl("Folded", Colors.COMMENT, Colors.BACKGROUND, nil)
set_hl("FoldColumn", nil, Colors.BACKGROUND, nil)
set_hl("Pmenu", nil, Colors.DARK_1, nil)
set_hl("CursorLine", nil, Colors.DARK_2, nil)
set_hl("CursorLineNr", Colors.YELLOW_1, nil, nil)
set_hl("CursorColumn", nil, Colors.DARK_1, nil)
set_hl("PMenuSel", Colors.FOREGROUND, Colors.DARK_1, { reverse = true })
set_hl("ColorColumn", nil, Colors.DARK_1, nil)
set_hl("WinSeparator", Colors.DARK_1, nil, nil)
set_hl("NormalFloat", nil, Colors.DARK_1, nil)
set_hl("FloatBorder", Colors.DARK_3, nil, nil)

-- Standard Highlighting
set_hl("Title", Colors.COMMENT, nil, { bold = true })
set_hl("Identifier", Colors.FOREGROUND, nil, nil)
set_hl("Statement", Colors.RED, nil, nil)
set_hl("Conditional", Colors.RED, nil, nil)
set_hl("Repeat", Colors.RED, nil, nil)
set_hl("Structure", Colors.YELLOW_1, nil, nil)
set_hl("Function", Colors.GREEN, nil, { bold = true })
set_hl("Constant", Colors.YELLOW_1, nil, nil)
set_hl("Keyword", Colors.RED, nil, nil)
set_hl("String", Colors.YELLOW_2, nil, nil)
set_hl("Special", Colors.YELLOW_1, nil, nil)
set_hl("Delimiter", Colors.YELLOW_1, nil, nil)
set_hl("PreProc", Colors.BLUE, nil, nil)
set_hl("Operator", Colors.PURPLE, nil, nil)
set_hl("Type", Colors.YELLOW_1, nil, nil)
set_hl("Define", Colors.GREEN, nil, nil)
set_hl("Include", Colors.RED, nil, nil)
set_hl("Tag", Colors.YELLOW_1, nil, { bold = true })
set_hl("Underlined", Colors.YELLOW_1, nil, { underline = true })
set_hl("QuickFixLine", Colors.RED, nil, { bold = true })

-- Diffs
set_hl("DiffAdded", Colors.GREEN, Colors.BACKGROUND, nil)
set_hl("DiffChange", Colors.YELLOW_2, Colors.BACKGROUND, nil)
set_hl("DiffDelete", Colors.RED, Colors.BACKGROUND, nil)
set_hl("DiffLine", Colors.BLUE, Colors.BACKGROUND, { italic = true })
set_hl("DiffSubname", Colors.FOREGROUND, Colors.BACKGROUND, nil)

vim.cmd("hi! link diffAdded DiffAdded")
vim.cmd("hi! link DiffAdd DiffAdded")
vim.cmd("hi! link diffAdd DiffAdded")
vim.cmd("hi! link diffChange DiffChange")
vim.cmd("hi! link diffDelete DiffDelete")
vim.cmd("hi! link diffLine DiffLine")
vim.cmd("hi! link diffSubname DiffSubname")
vim.cmd("hi! link DiffRemoved DiffDelete")
vim.cmd("hi! link diffRemoved DiffDelete")

-- Telescope
set_hl("TelescopeBorder", Colors.DARK_3, nil, nil)
set_hl("TelescopeTitle", Colors.RED, nil, { bold = true })
set_hl("TelescopePromptTitle", Colors.FOREGROUND, nil, { bold = true })
set_hl("TelescopePreviewTitle", Colors.GREEN, nil, { bold = true })

-- Diagnostics
set_hl("DiagnosticError", Colors.ERORR, nil, { bold = true })
set_hl("DiagnosticWarn", Colors.WARN, nil, { bold = true })
set_hl("DiagnosticInfo", Colors.INFO, nil, { bold = true })
set_hl("DiagnosticHint", Colors.BLUE, nil, { bold = true })

-- Nvim
set_hl("NvimParenthesis", Colors.YELLOW_1, nil, nil)

-- NvimTree
set_hl("NvimTreeNormal", Colors.DARK_4, Colors.DARK_0, nil)
set_hl("NvimTreeRootFolder", Colors.RED, nil, nil)
set_hl("NvimTreeFolderName", Colors.YELLOW_0, nil, { bold = true })
set_hl("NvimTreeExecFile", Colors.RED, nil, { bold = true })
set_hl("NvimTreeOpenedFile", Colors.FOREGROUND, nil, nil)
set_hl("NvimTreeWindowPicker", Colors.DARK_4, Colors.DARK_1, { bold = true })

vim.cmd("hi! link NvimTreeFolderIcon Directory")
vim.cmd("hi! link NvimTreeEmptyFolderName NvimTreeFolderName")
vim.cmd("hi! link NvimTreeOpenedFolderName NvimTreeFolderName")

-- BlinkCmp
set_hl("BlinkCmpMenuBorder", Colors.DARK_3, nil, nil)
vim.cmd("hi! link BlinkCmpDocBorder BlinkCmpMenuBorder")
