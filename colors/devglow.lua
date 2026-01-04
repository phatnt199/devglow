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
	FG = "#E6E6E6",
	BG = "#080808",

	RED = "#AF5F5F",
	GREEN = "#87AFAF",
	BLUE = "#7590AF",
	ORANGE = "#D59572",
	YELLOW = "#E5B567",
	PINK = "#D68C8C",

	-- SHADES
	D0 = "#111111",
	D1 = "#181818",
	D2 = "#282828",
	D3 = "#383838",
	D4 = "#797979",
}

-----------------------------------------------------------------------------
-- HELPER FUNCTIONS
-----------------------------------------------------------------------------
local function set_hl(group, rfg, rbg, attr)
	if not group or type(group) ~= "string" or group == "" then
		vim.notify(string.format("Invalid highlight group name: %s", vim.inspect(group)), vim.log.levels.WARN)
		return false
	end

	attr = attr or {}
	local hl_opts = {}

	if rfg then
		hl_opts.fg = rfg
	end

	if rbg then
		hl_opts.bg = rbg
	end

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

	local ok, err = pcall(vim.api.nvim_set_hl, 0, group, hl_opts)
	if not ok then
		vim.notify(string.format("Failed to set highlight '%s': %s", group, err), vim.log.levels.ERROR)
		return false
	end

	return true
end

local function merge_tables(...)
	local result = {}
	for _, tbl in ipairs({ ... }) do
		for _, item in ipairs(tbl) do
			table.insert(result, item)
		end
	end
	return result
end

local function apply_links(links)
	for _, link in ipairs(links) do
		vim.cmd(string.format("hi! link %s %s", link.from, link.to))
	end
end

-----------------------------------------------------------------------------
-- HIGHLIGHT GROUPS
-----------------------------------------------------------------------------

-- Editor UI: Core interface elements
local editor_ui = {
	{ scope = "Normal", fg = Colors.FG, bg = Colors.BG, styles = nil },
	{ scope = "LineNr", fg = Colors.D4, bg = Colors.BG, styles = nil },
	{ scope = "SignColumn", fg = nil, bg = Colors.BG, styles = nil },
	{ scope = "CursorLine", fg = nil, bg = Colors.D2, styles = nil },
	{ scope = "CursorLineNr", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "CursorColumn", fg = nil, bg = Colors.D1, styles = nil },
	{ scope = "ColorColumn", fg = nil, bg = Colors.D1, styles = nil },
	{ scope = "Cursor", fg = Colors.BG, bg = Colors.YELLOW, styles = nil },
	{ scope = "TermCursor", fg = Colors.BG, bg = Colors.YELLOW, styles = nil },
	{ scope = "TermCursorNC", fg = Colors.BG, bg = Colors.D4, styles = nil },
	{ scope = "Visual", fg = nil, bg = Colors.D3, styles = nil },
	{ scope = "MatchParen", fg = Colors.FG, bg = Colors.RED, styles = nil },
	{ scope = "Conceal", fg = Colors.D4, bg = nil, styles = nil },
	{ scope = "NonText", fg = Colors.D4, bg = nil, styles = nil },
	{ scope = "SpecialKey", fg = Colors.D1, bg = nil, styles = nil },
	{ scope = "Directory", fg = Colors.ORANGE, bg = nil, styles = nil },
}

-- Editor UI: Windows and splits
local windows_ui = {
	{ scope = "WinSeparator", fg = Colors.D1, bg = nil, styles = nil },
	{ scope = "NormalFloat", fg = nil, bg = Colors.D2, styles = nil },
	{ scope = "FloatBorder", fg = Colors.D3, bg = nil, styles = nil },
	{ scope = "Title", fg = Colors.D4, bg = nil, styles = { bold = true } },
}

-- Editor UI: Status line and tabs
local statusline_ui = {
	{ scope = "StatusLine", fg = Colors.D1, bg = Colors.YELLOW, styles = { reverse = true } },
	{ scope = "StatusLineNC", fg = Colors.D1, bg = Colors.FG, styles = { reverse = true } },
	{ scope = "TabLine", fg = Colors.D1, bg = Colors.FG, styles = { reverse = true } },
	{ scope = "TabLineFill", fg = Colors.D1, bg = Colors.FG, styles = { reverse = true } },
}

-- Editor UI: Completion menu
local menu_ui = {
	{ scope = "Pmenu", fg = nil, bg = Colors.D1, styles = nil },
	{ scope = "PMenuSel", fg = Colors.FG, bg = Colors.D1, styles = { reverse = true } },
}

-- Editor UI: Folding
local folding_ui = {
	{ scope = "Folded", fg = Colors.D4, bg = Colors.BG, styles = nil },
	{ scope = "FoldColumn", fg = nil, bg = Colors.BG, styles = nil },
}

-- Search and replace
local search_ui = {
	{ scope = "Search", fg = Colors.BG, bg = Colors.YELLOW, styles = nil },
	{ scope = "IncSearch", fg = Colors.BG, bg = Colors.RED, styles = nil },
	{ scope = "CurSearch", fg = Colors.BG, bg = Colors.RED, styles = nil },
	{ scope = "Substitute", fg = Colors.BG, bg = Colors.PINK, styles = nil },
}

-- Messages and prompts
local messages_ui = {
	{ scope = "ModeMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "MoreMsg", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Question", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "WarningMsg", fg = Colors.ORANGE, bg = nil, styles = { bold = true } },
	{ scope = "Error", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "ErrorMsg", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "Todo", fg = Colors.RED, bg = Colors.BG, styles = { bold = true } },
}

-- Spell checking
local spell_ui = {
	{ scope = "SpellBad", fg = Colors.RED, bg = nil, styles = { underline = true } },
	{ scope = "SpellCap", fg = Colors.YELLOW, bg = nil, styles = { underline = true } },
	{ scope = "SpellRare", fg = Colors.BLUE, bg = nil, styles = { underline = true } },
	{ scope = "SpellLocal", fg = Colors.GREEN, bg = nil, styles = { underline = true } },
}

-- Syntax: Language elements
local syntax_hl = {
	{ scope = "Comment", fg = Colors.D4, bg = nil, styles = nil },
	{ scope = "Identifier", fg = Colors.FG, bg = nil, styles = nil },
	{ scope = "Statement", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Conditional", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Repeat", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Keyword", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Include", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "Function", fg = Colors.GREEN, bg = nil, styles = { bold = true } },
	{ scope = "Constant", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "String", fg = Colors.YELLOW, bg = nil, styles = nil },
	{ scope = "Type", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "Structure", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "Operator", fg = Colors.PINK, bg = nil, styles = nil },
	{ scope = "Delimiter", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "Special", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "PreProc", fg = Colors.BLUE, bg = nil, styles = nil },
	{ scope = "Define", fg = Colors.GREEN, bg = nil, styles = nil },
	{ scope = "Tag", fg = Colors.ORANGE, bg = nil, styles = { bold = true } },
	{ scope = "Underlined", fg = Colors.ORANGE, bg = nil, styles = { underline = true } },
	{ scope = "QuickFixLine", fg = Colors.RED, bg = nil, styles = { bold = true } },
}

-- Syntax: Custom semantic groups
local semantic_hl = {
	{ scope = "SpecialKeyword", fg = Colors.ORANGE, bg = nil, styles = { italic = true } },
	{ scope = "AccessModifier", fg = Colors.RED, bg = nil, styles = { italic = true } },
	{ scope = "TypeParameter", fg = Colors.GREEN, bg = nil, styles = { italic = true } },
}

-- Git/Diff
local diff_hl = {
	{ scope = "DiffAdded", fg = Colors.GREEN, bg = Colors.BG, styles = nil },
	{ scope = "DiffChange", fg = Colors.YELLOW, bg = Colors.BG, styles = nil },
	{ scope = "DiffDelete", fg = Colors.RED, bg = Colors.BG, styles = nil },
	{ scope = "DiffLine", fg = Colors.BLUE, bg = Colors.BG, styles = { italic = true } },
	{ scope = "DiffSubname", fg = Colors.FG, bg = Colors.BG, styles = nil },
}

-- LSP/Diagnostics
local diagnostics_hl = {
	{ scope = "DiagnosticError", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticWarn", fg = Colors.YELLOW, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticInfo", fg = Colors.BLUE, bg = nil, styles = { bold = true } },
	{ scope = "DiagnosticHint", fg = Colors.BLUE, bg = nil, styles = { bold = true } },
}

-- Plugin: Telescope
local telescope_hl = {
	{ scope = "TelescopeBorder", fg = Colors.D3, bg = nil, styles = nil },
	{ scope = "TelescopeTitle", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePromptTitle", fg = Colors.FG, bg = nil, styles = { bold = true } },
	{ scope = "TelescopePreviewTitle", fg = Colors.GREEN, bg = nil, styles = { bold = true } },
}

-- Plugin: NvimTree
local nvimtree_hl = {
	{ scope = "NvimParenthesis", fg = Colors.ORANGE, bg = nil, styles = nil },
	{ scope = "NvimTreeNormal", fg = Colors.FG, bg = Colors.D0, styles = nil },
	{ scope = "NvimTreeRootFolder", fg = Colors.RED, bg = nil, styles = nil },
	{ scope = "NvimTreeFolderName", fg = Colors.ORANGE, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeExecFile", fg = Colors.RED, bg = nil, styles = { bold = true } },
	{ scope = "NvimTreeOpenedFile", fg = Colors.FG, bg = nil, styles = nil },
	{ scope = "NvimTreeWindowPicker", fg = Colors.FG, bg = Colors.D1, styles = { bold = true } },
}

-- Plugin: BlinkCmp
local blinkcmp_hl = {
	{ scope = "BlinkCmpMenuBorder", fg = Colors.D3, bg = nil, styles = nil },
}

-- Merge all highlight groups
local highlights = merge_tables(
	editor_ui,
	windows_ui,
	statusline_ui,
	menu_ui,
	folding_ui,
	search_ui,
	messages_ui,
	spell_ui,
	syntax_hl,
	semantic_hl,
	diff_hl,
	diagnostics_hl,
	telescope_hl,
	nvimtree_hl,
	blinkcmp_hl
)

-----------------------------------------------------------------------------
-- APPLY HIGHLIGHTS
-----------------------------------------------------------------------------
for _, h in ipairs(highlights) do
	set_hl(h.scope, h.fg, h.bg, h.styles)
end

-----------------------------------------------------------------------------
-- HIGHLIGHT LINKS
-----------------------------------------------------------------------------

-- Diff links
apply_links({
	{ from = "diffAdded", to = "DiffAdded" },
	{ from = "DiffAdd", to = "DiffAdded" },
	{ from = "diffAdd", to = "DiffAdded" },
	{ from = "diffChange", to = "DiffChange" },
	{ from = "diffDelete", to = "DiffDelete" },
	{ from = "diffLine", to = "DiffLine" },
	{ from = "diffSubname", to = "DiffSubname" },
	{ from = "DiffRemoved", to = "DiffDelete" },
	{ from = "diffRemoved", to = "DiffDelete" },
})

-- NvimTree links
apply_links({
	{ from = "NvimTreeFolderIcon", to = "Directory" },
	{ from = "NvimTreeEmptyFolderName", to = "NvimTreeFolderName" },
	{ from = "NvimTreeOpenedFolderName", to = "NvimTreeFolderName" },
})

-- BlinkCmp links
apply_links({
	{ from = "BlinkCmpDocBorder", to = "BlinkCmpMenuBorder" },
})

-- Treesitter: Type parameters
apply_links({
	{ from = "@type.parameter", to = "TypeParameter" },
	{ from = "@lsp.type.typeParameter", to = "TypeParameter" },
	{ from = "@typeParameter", to = "TypeParameter" },
})

-- Treesitter: Special keywords (this, self, super)
apply_links({
	{ from = "@variable.builtin", to = "SpecialKeyword" },
	{ from = "@keyword.this", to = "SpecialKeyword" },
	{ from = "@keyword.self", to = "SpecialKeyword" },
	{ from = "@keyword.super", to = "SpecialKeyword" },
	{ from = "@lsp.type.selfKeyword", to = "SpecialKeyword" },
})

-- Treesitter: Access modifiers
apply_links({
	{ from = "@keyword.modifier", to = "AccessModifier" },
	{ from = "@storageclass", to = "AccessModifier" },
	{ from = "@lsp.type.modifier", to = "AccessModifier" },
	{ from = "@lsp.typemod.keyword.modifier", to = "AccessModifier" },
})

-- Treesitter: Operators & Punctuation
apply_links({
	{ from = "@operator", to = "Operator" },
	{ from = "@punctuation", to = "Delimiter" },
	{ from = "@punctuation.bracket", to = "Delimiter" },
	{ from = "@punctuation.delimiter", to = "Delimiter" },
	{ from = "@punctuation.special", to = "Special" },
})

-- Treesitter: Types & Classes
apply_links({
	{ from = "@type", to = "Type" },
	{ from = "@type.builtin", to = "Type" },
	{ from = "@type.definition", to = "Type" },
	{ from = "@type.qualifier", to = "Keyword" },
	{ from = "@class", to = "Type" },
	{ from = "@interface", to = "Type" },
	{ from = "@struct", to = "Type" },
	{ from = "@enum", to = "Type" },
	{ from = "@union", to = "Type" },
	{ from = "@typedef", to = "Type" },
})

-- Treesitter: Variables & Properties
apply_links({
	{ from = "@variable", to = "Identifier" },
	{ from = "@variable.member", to = "Identifier" },
	{ from = "@parameter", to = "Identifier" },
	{ from = "@property", to = "Identifier" },
	{ from = "@field", to = "Identifier" },
})

-- Treesitter: Functions & Methods
apply_links({
	{ from = "@function", to = "Function" },
	{ from = "@function.builtin", to = "Function" },
	{ from = "@function.call", to = "Function" },
	{ from = "@function.method", to = "Function" },
	{ from = "@method", to = "Function" },
	{ from = "@method.call", to = "Function" },
	{ from = "@constructor", to = "Function" },
})

-- Treesitter: Keywords & Control Flow
apply_links({
	{ from = "@keyword", to = "Keyword" },
	{ from = "@keyword.function", to = "Keyword" },
	{ from = "@keyword.operator", to = "Keyword" },
	{ from = "@keyword.return", to = "Keyword" },
	{ from = "@keyword.import", to = "Include" },
	{ from = "@conditional", to = "Conditional" },
	{ from = "@repeat", to = "Repeat" },
	{ from = "@label", to = "Keyword" },
})

-- Treesitter: Constants & Literals
apply_links({
	{ from = "@constant", to = "Constant" },
	{ from = "@constant.builtin", to = "Constant" },
	{ from = "@constant.macro", to = "Constant" },
	{ from = "@number", to = "Constant" },
	{ from = "@number.float", to = "Constant" },
	{ from = "@float", to = "Constant" },
	{ from = "@boolean", to = "Constant" },
	{ from = "@character", to = "String" },
	{ from = "@character.special", to = "Special" },
})

-- Treesitter: Strings
apply_links({
	{ from = "@string", to = "String" },
	{ from = "@string.documentation", to = "Comment" },
	{ from = "@string.escape", to = "Special" },
	{ from = "@string.regexp", to = "Special" },
	{ from = "@string.regex", to = "Special" },
	{ from = "@string.special", to = "Special" },
	{ from = "@string.special.symbol", to = "Special" },
})

-- Treesitter: Comments & Documentation
apply_links({
	{ from = "@comment", to = "Comment" },
	{ from = "@comment.documentation", to = "Comment" },
	{ from = "@comment.error", to = "Error" },
	{ from = "@comment.warning", to = "WarningMsg" },
	{ from = "@comment.note", to = "Todo" },
	{ from = "@comment.todo", to = "Todo" },
})

-- Treesitter: Modules & Namespaces
apply_links({
	{ from = "@namespace", to = "Type" },
	{ from = "@module", to = "Type" },
	{ from = "@include", to = "Include" },
})

-- Treesitter: HTML/JSX Tags
apply_links({
	{ from = "@tag", to = "Tag" },
	{ from = "@tag.builtin", to = "Tag" },
	{ from = "@tag.attribute", to = "Identifier" },
	{ from = "@tag.delimiter", to = "Delimiter" },
})

-- Treesitter: Attributes & Decorators
apply_links({
	{ from = "@attribute", to = "Special" },
	{ from = "@attribute.builtin", to = "Special" },
	{ from = "@decorator", to = "Special" },
})

-- Treesitter: Preprocessor
apply_links({
	{ from = "@preproc", to = "PreProc" },
	{ from = "@define", to = "Define" },
	{ from = "@macro", to = "PreProc" },
})

-- Treesitter: Text & Markup
apply_links({
	{ from = "@text", to = "Normal" },
	{ from = "@text.strong", to = "Bold" },
	{ from = "@text.emphasis", to = "Italic" },
	{ from = "@text.underline", to = "Underlined" },
	{ from = "@text.title", to = "Title" },
	{ from = "@text.literal", to = "String" },
	{ from = "@text.uri", to = "Underlined" },
	{ from = "@text.reference", to = "Identifier" },
})

-- LSP Semantic Tokens: Types
apply_links({
	{ from = "@lsp.type.class", to = "Type" },
	{ from = "@lsp.type.interface", to = "Type" },
	{ from = "@lsp.type.struct", to = "Type" },
	{ from = "@lsp.type.enum", to = "Type" },
	{ from = "@lsp.type.type", to = "Type" },
	{ from = "@lsp.type.enumMember", to = "Constant" },
})

-- LSP Semantic Tokens: Functions & Methods
apply_links({
	{ from = "@lsp.type.function", to = "Function" },
	{ from = "@lsp.type.method", to = "Function" },
})

-- LSP Semantic Tokens: Variables & Properties
apply_links({
	{ from = "@lsp.type.variable", to = "Identifier" },
	{ from = "@lsp.type.parameter", to = "Identifier" },
	{ from = "@lsp.type.property", to = "Identifier" },
})

-- LSP Semantic Tokens: Namespaces & Modules
apply_links({
	{ from = "@lsp.type.namespace", to = "Type" },
})

-- LSP Semantic Tokens: Decorators & Macros
apply_links({
	{ from = "@lsp.type.decorator", to = "Special" },
	{ from = "@lsp.type.macro", to = "PreProc" },
})

-- LSP Semantic Tokens: Comments
apply_links({
	{ from = "@lsp.type.comment", to = "Comment" },
})

-- Additional text objects for markdown/help
vim.cmd("hi! link Bold Function")
vim.cmd("hi! link Italic Comment")
