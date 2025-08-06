-- =========================================================================
--  devglow.lua
--
--  A Lua version of the devglow.vim colorscheme.
--  For a modern Neovim setup with 24-bit color support.
-- =========================================================================

-- Set background to dark
vim.o.background = "dark"

-- Reset existing highlights
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

-- Define colors
local c = {
	fg = "#EEE2DE",
	dfg = "#BBBBBB",
	bg = "#080808",
	mbg0 = "#111111",
	mbg1 = "#1D2021",
	comment = "#797979",
	red = "#AF5F5F",
	orange = "#D59572",
	yellow = "#E5B567",
	dim_yellow = "#AF875F",
	green = "#87AFAF",
	blue = "#7EAAC7",
	wine = "#924653",
	purple = "#9E86C8",
	dark0 = "#181818",
	dark1 = "#282828",
	dark2 = "#383838",
	error = "#EA5455",
	warn = "#FFA500",
	info = "#7DB9B6",
}

-- Handle background option
local bg = c.bg
if vim.g.devglow_minimal_bg then
	bg = c.mbg1
end

-- Function to set a highlight group
-- This now correctly handles a table of attributes
local function set_hl(group, fg, rbg, attr)
	attr = attr or {}
	vim.api.nvim_set_hl(0, group, {
		fg = fg,
		bg = rbg,
		bold = attr.bold,
		italic = attr.italic,
		underline = attr.underline,
		reverse = attr.reverse,
	})
end

-- Set the Normal and LineNr highlight groups
set_hl("Normal", c.fg, bg, nil)
set_hl("LineNr", c.comment, bg, nil)
set_hl("SignColumn", nil, bg, nil)
set_hl("Todo", c.red, bg, { bold = true })

-- Vim Highlighting
set_hl("Comment", c.comment, nil, { italic = vim.g.devglow_italic_comments })
set_hl("NonText", c.comment, nil, nil)
set_hl("SpecialKey", c.dark0, nil, nil)
set_hl("Search", bg, c.yellow, nil)
set_hl("TabLine", c.dark0, c.fg, { reverse = true })
set_hl("TabLineFill", c.dark0, c.fg, { reverse = true })
set_hl("StatusLine", c.dark0, c.yellow, { reverse = true })
set_hl("StatusLineNC", c.dark0, c.fg, { reverse = true })
set_hl("Visual", nil, c.dark2, nil)
set_hl("Directory", c.dim_yellow, nil, nil)
set_hl("ModeMsg", c.green, nil, nil)
set_hl("MoreMsg", c.green, nil, nil)
set_hl("Question", c.green, nil, nil)
set_hl("WarningMsg", c.orange, nil, { bold = true })
set_hl("MatchParen", nil, c.wine, nil)
set_hl("Folded", c.comment, bg, nil)
set_hl("FoldColumn", nil, bg, nil)
set_hl("Pmenu", nil, c.dark0, nil)
set_hl("CursorLine", nil, c.dark1, nil)
set_hl("CursorLineNr", c.orange, nil, nil)
set_hl("CursorColumn", nil, c.dark0, nil)
set_hl("PMenuSel", c.fg, c.dark0, { reverse = true })
set_hl("ColorColumn", nil, c.dark0, nil)
set_hl("WinSeparator", c.dark0, nil, nil)
set_hl("NormalFloat", nil, c.dark0, nil)
set_hl("FloatBorder", c.dark2, nil, nil)

-- Standard Highlighting
-- set_hl("Title", c.comment, nil, { bold = true })
-- set_hl("Identifier", c.fg, nil, nil)
-- set_hl("Statement", c.red, nil, nil)
-- set_hl("Conditional", c.red, nil, nil)
-- set_hl("Repeat", c.red, nil, nil)
-- set_hl("Structure", c.orange, nil, nil)
-- set_hl("Function", c.green, nil, { bold = true })
-- set_hl("Constant", c.orange, nil, nil)
-- set_hl("Keyword", c.red, nil, nil)
-- set_hl("String", c.yellow, nil, nil)
-- set_hl("Special", c.orange, nil, nil)
-- set_hl("Delimiter", c.orange, nil, nil)
-- set_hl("PreProc", c.blue, nil, nil)
-- set_hl("Operator", c.purple, nil, nil)
-- set_hl("Type", c.orange, nil, nil)
-- set_hl("Define", c.green, nil, nil)
-- set_hl("Include", c.red, nil, nil)
-- set_hl("Tag", c.orange, nil, { bold = true })
-- set_hl("Underlined", c.orange, nil, { underline = true })
-- set_hl("QuickFixLine", c.red, nil, { bold = true })

-- Link some highlight groups
vim.cmd("hi! link diffAdded DiffAdded")
vim.cmd("hi! link diffChange DiffChange")
vim.cmd("hi! link diffDelete DiffDelete")
vim.cmd("hi! link diffLine DiffLine")
vim.cmd("hi! link diffSubname DiffSubname")
vim.cmd("hi! link DiffRemoved DiffDelete")
vim.cmd("hi! link diffRemoved DiffDelete")
vim.cmd("hi! link GitGutterChangeLineDefault DiffDelete")
vim.cmd("hi! link DiffAdd DiffAdded")
vim.cmd("hi! link diffAdd DiffAdded")
vim.cmd("hi! link NvimTreeFolderIcon Directory")
vim.cmd("hi! link NvimTreeEmptyFolderName NvimTreeFolderName")
vim.cmd("hi! link NvimTreeOpenedFolderName NvimTreeFolderName")

-- Diffs
set_hl("DiffAdded", c.green, c.bg, nil)
set_hl("DiffChange", c.yellow, c.bg, nil)
set_hl("DiffDelete", c.red, c.bg, nil)
set_hl("DiffLine", c.blue, c.bg, { italic = true })
set_hl("DiffSubname", c.fg, c.bg, nil)

-- Telescope
set_hl("TelescopeBorder", c.dark2, nil, nil)
set_hl("TelescopeTitle", c.red, nil, { bold = true })
set_hl("TelescopePromptTitle", c.fg, nil, { bold = true })
set_hl("TelescopePreviewTitle", c.green, nil, { bold = true })

-- Diagnostics
set_hl("DiagnosticError", c.error, nil, { bold = true })
set_hl("DiagnosticWarn", c.warn, nil, { bold = true })
set_hl("DiagnosticInfo", c.info, nil, { bold = true })
set_hl("DiagnosticHint", c.blue, nil, { bold = true })

-- Nvim
set_hl("NvimParenthesis", c.orange, nil, nil)

-- NvimTree
set_hl("NvimTreeNormal", c.dfg, c.mbg0, nil)
set_hl("NvimTreeRootFolder", c.red, nil, nil)
set_hl("NvimTreeFolderName", c.dim_yellow, nil, { bold = true })
set_hl("NvimTreeExecFile", c.red, nil, { bold = true })
set_hl("NvimTreeOpenedFile", c.fg, nil, nil)
set_hl("NvimTreeWindowPicker", c.dfg, c.dark0, { bold = true })

-- Blink CMP
set_hl("BlinkCmpMenuBorder", c.dark2, nil, nil)
set_hl("BlinkCmpDocBorder", c.dark2, nil, nil)
