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
set_hl("Title", c.comment, nil, { bold = true })
set_hl("Identifier", c.fg, nil, nil)
set_hl("Statement", c.red, nil, nil)
set_hl("Conditional", c.red, nil, nil)
set_hl("Repeat", c.red, nil, nil)
set_hl("Structure", c.orange, nil, nil)
set_hl("Function", c.green, nil, { bold = true })
set_hl("Constant", c.orange, nil, nil)
set_hl("Keyword", c.red, nil, nil)
set_hl("String", c.yellow, nil, nil)
set_hl("Special", c.orange, nil, nil)
set_hl("Delimiter", c.orange, nil, nil)
set_hl("PreProc", c.blue, nil, nil)
set_hl("Operator", c.purple, nil, nil)
set_hl("Type", c.orange, nil, nil)
set_hl("Define", c.green, nil, nil)
set_hl("Include", c.red, nil, nil)
set_hl("Tag", c.orange, nil, { bold = true })
set_hl("Underlined", c.orange, nil, { underline = true })
set_hl("QuickFixLine", c.red, nil, { bold = true })

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

-- Vim Highlighting
set_hl("vimCommand", c.wine, nil, {})

-- C Highlighting
set_hl("cType", c.wine, nil, {})
set_hl("cStorageClass", c.orange, nil, {})
set_hl("cConditional", c.wine, nil, {})
set_hl("cRepeat", c.wine, nil, {})

-- PHP Highlighting
set_hl("phpVarSelector", c.wine, nil, {})
set_hl("phpKeyword", c.wine, nil, {})
set_hl("phpRepeat", c.wine, nil, {})
set_hl("phpConditional", c.wine, nil, {})
set_hl("phpStatement", c.wine, nil, {})
set_hl("phpMemberSelector", c.fg, nil, {})

-- Ruby Highlighting
set_hl("rubySymbol", c.blue, nil, {})
set_hl("rubyConstant", c.green, nil, {})
set_hl("rubyAccess", c.yellow, nil, {})
set_hl("rubyAttribute", c.blue, nil, {})
set_hl("rubyInclude", c.blue, nil, {})
set_hl("rubyLocalVariableOrMethod", c.orange, nil, {})
set_hl("rubyCurlyBlock", c.orange, nil, {})
set_hl("rubyStringDelimiter", c.yellow, nil, {})
set_hl("rubyInterpolationDelimiter", c.orange, nil, {})
set_hl("rubyConditional", c.wine, nil, {})
set_hl("rubyRepeat", c.wine, nil, {})
set_hl("rubyControl", c.wine, nil, {})
set_hl("rubyException", c.wine, nil, {})

-- Crystal Highlighting
set_hl("crystalSymbol", c.green, nil, {})
set_hl("crystalConstant", c.yellow, nil, {})
set_hl("crystalAccess", c.yellow, nil, {})
set_hl("crystalAttribute", c.blue, nil, {})
set_hl("crystalInclude", c.blue, nil, {})
set_hl("crystalLocalVariableOrMethod", c.orange, nil, {})
set_hl("crystalCurlyBlock", c.orange, nil, {})
set_hl("crystalStringDelimiter", c.green, nil, {})
set_hl("crystalInterpolationDelimiter", c.orange, nil, {})
set_hl("crystalConditional", c.wine, nil, {})
set_hl("crystalRepeat", c.wine, nil, {})
set_hl("crystalControl", c.wine, nil, {})
set_hl("crystalException", c.wine, nil, {})

-- Python Highlighting
set_hl("pythonInclude", c.green, nil, { italic = true })
set_hl("pythonStatement", c.blue, nil, {})
set_hl("pythonConditional", c.wine, nil, {})
set_hl("pythonRepeat", c.wine, nil, {})
set_hl("pythonException", c.orange, nil, {})
set_hl("pythonFunction", c.green, nil, { italic = true })
set_hl("pythonPreCondit", c.wine, nil, {})
set_hl("pythonExClass", c.orange, nil, {})
set_hl("pythonBuiltin", c.blue, nil, {})
set_hl("pythonOperator", c.wine, nil, {})
set_hl("pythonNumber", c.purple, nil, {})
set_hl("pythonString", c.yellow, nil, {})
set_hl("pythonRawString", c.yellow, nil, {})
set_hl("pythonDecorator", c.wine, nil, {})
set_hl("pythonDoctest", c.yellow, nil, {})
set_hl("pythonImportFunction", c.orange, nil, {})
set_hl("pythonImportModule", c.orange, nil, {})
set_hl("pythonImportObject", c.orange, nil, {})
set_hl("pythonImportedClassDef", c.orange, nil, {})
set_hl("pythonImportedFuncDef", c.orange, nil, {})
set_hl("pythonImportedModule", c.orange, nil, {})
set_hl("pythonImportedObject", c.orange, nil, {})

-- JavaScript Highlighting
set_hl("javaScriptEndColons", c.fg, nil, {})
set_hl("javaScriptOpSymbols", c.fg, nil, {})
set_hl("javaScriptLogicSymbols", c.fg, nil, {})
set_hl("javaScriptFunction", c.green, nil, {})
set_hl("javaScriptComment", c.comment, nil, {})
set_hl("javaScriptLineComment", c.comment, nil, {})
set_hl("javaScriptDocComment", c.comment, nil, {})
set_hl("javaScriptCommentTodo", c.red, nil, {})
set_hl("javaScriptString", c.yellow, nil, {})
set_hl("javaScriptRegexpString", c.yellow, nil, {})
set_hl("javaScriptTemplateString", c.yellow, nil, {})
set_hl("javaScriptNumber", c.purple, nil, {})
set_hl("javaScriptFloat", c.purple, nil, {})
set_hl("javaScriptGlobal", c.purple, nil, {})
set_hl("javaScriptCharacter", c.blue, nil, {})
set_hl("javaScriptPrototype", c.blue, nil, {})
set_hl("javaScriptConditional", c.blue, nil, {})
set_hl("javaScriptBranch", c.blue, nil, {})
set_hl("javaScriptIdentifier", c.orange, nil, {})
set_hl("javaScriptRepeat", c.blue, nil, {})
set_hl("javaScriptStatement", c.blue, nil, {})
set_hl("javaScriptMessage", c.blue, nil, {})
set_hl("javaScriptReserved", c.blue, nil, {})
set_hl("javaScriptOperator", c.blue, nil, {})
set_hl("javaScriptNull", c.dfg, nil, {})
set_hl("javaScriptBoolean", c.purple, nil, {})
set_hl("javaScriptLabel", c.blue, nil, {})
set_hl("javaScriptSpecial", c.blue, nil, {})
set_hl("javaScriptExceptions", c.red, nil, {})
set_hl("javaScriptDeprecated", c.red, nil, {})
set_hl("javaScriptError", c.red, nil, {})

-- Typescript Highlighting
set_hl("typescriptReserved", c.blue, nil, {})
set_hl("typescriptLabel", c.blue, nil, {})
set_hl("typescriptFunction", c.green, nil, {})
set_hl("typescriptIdentifier", c.orange, nil, {})
set_hl("typescriptEndColons", c.blue, nil, {})
set_hl("typescriptDOMObjects", c.orange, nil, {})
set_hl("typescriptAjaxMethods", c.orange, nil, {})
set_hl("typescriptLogicSymbols", c.fg, nil, {})
set_hl("typescriptDocComment", c.comment, nil, {})
set_hl("typescriptDocSeeTag", c.comment, nil, {})
set_hl("typescriptDocParam", c.comment, nil, {})
set_hl("typescriptDocTags", c.comment, nil, {})
set_hl("typescriptGlobalObjects", c.purple, nil, {})
set_hl("typescriptParens", c.fg, nil, {})
set_hl("typescriptOpSymbols", c.fg, nil, {})
set_hl("typescriptHtmlElemProperties", c.fg, nil, {})
set_hl("typescriptNull", c.dfg, nil, {})
set_hl("typescriptInterpolationDelimiter", c.orange, nil, {})

-- LaTeX
set_hl("texStatement", c.blue, nil, {})
set_hl("texMath", c.wine, nil, {})
set_hl("texMathMacher", c.yellow, nil, {})
set_hl("texRefLabel", c.wine, nil, {})
set_hl("texRefZone", c.blue, nil, {})
set_hl("texComment", c.comment, nil, {})
set_hl("texDelimiter", c.purple, nil, {})
set_hl("texMathZoneX", c.purple, nil, {})

-- CoffeeScript Highlighting
set_hl("coffeeRepeat", c.wine, nil, {})
set_hl("coffeeConditional", c.wine, nil, {})
set_hl("coffeeKeyword", c.wine, nil, {})
set_hl("coffeeObject", c.yellow, nil, {})

-- HTML Highlighting
set_hl("htmlTag", c.blue, nil, {})
set_hl("htmlEndTag", c.blue, nil, {})
set_hl("htmlTagName", c.wine, nil, { bold = true })
set_hl("htmlArg", c.green, nil, { italic = true })
set_hl("htmlScriptTag", c.wine, nil, {})

-- Diff Highlighting
set_hl("diffAdd", nil, "#4c4e39", {})
set_hl("diffDelete", c.bg, c.red, {})
set_hl("diffChange", nil, "#2B5B77", {})
set_hl("diffText", c.dfg, c.pantone, {})

-- ShowMarks Highlighting
set_hl("ShowMarksHLl", c.orange, c.bg, {})
set_hl("ShowMarksHLo", c.wine, c.bg, {})
set_hl("ShowMarksHLu", c.yellow, c.bg, {})
set_hl("ShowMarksHLm", c.wine, c.bg, {})

-- Lua Highlighting
set_hl("luaStatement", c.wine, nil, {})
set_hl("luaRepeat", c.wine, nil, {})
set_hl("luaCondStart", c.wine, nil, {})
set_hl("luaCondElseif", c.wine, nil, {})
set_hl("luaCond", c.wine, nil, {})
set_hl("luaCondEnd", c.wine, nil, {})

-- Cucumber Highlighting
set_hl("cucumberGiven", c.blue, nil, {})
set_hl("cucumberGivenAnd", c.blue, nil, {})

-- Go Highlighting
set_hl("goDirective", c.wine, nil, {})
set_hl("goDeclaration", c.wine, nil, {})
set_hl("goStatement", c.wine, nil, {})
set_hl("goConditional", c.wine, nil, {})
set_hl("goConstants", c.orange, nil, {})
set_hl("goTodo", c.red, nil, {})
set_hl("goDeclType", c.blue, nil, {})
set_hl("goBuiltins", c.wine, nil, {})
set_hl("goRepeat", c.wine, nil, {})
set_hl("goLabel", c.wine, nil, {})

-- Clojure Highlighting
set_hl("clojureConstant", c.orange, nil, {})
set_hl("clojureBoolean", c.orange, nil, {})
set_hl("clojureCharacter", c.orange, nil, {})
set_hl("clojureKeyword", c.green, nil, {})
set_hl("clojureNumber", c.orange, nil, {})
set_hl("clojureString", c.green, nil, {})
set_hl("clojureRegexp", c.green, nil, {})
set_hl("clojureParen", c.wine, nil, {})
set_hl("clojureVariable", c.yellow, nil, {})
set_hl("clojureCond", c.blue, nil, {})
set_hl("clojureDefine", c.wine, nil, {})
set_hl("clojureException", c.red, nil, {})
set_hl("clojureFunc", c.blue, nil, {})
set_hl("clojureMacro", c.blue, nil, {})
set_hl("clojureRepeat", c.blue, nil, {})
set_hl("clojureSpecial", c.wine, nil, {})
set_hl("clojureQuote", c.blue, nil, {})
set_hl("clojureUnquote", c.blue, nil, {})
set_hl("clojureMeta", c.blue, nil, {})
set_hl("clojureDeref", c.blue, nil, {})
set_hl("clojureAnonArg", c.blue, nil, {})
set_hl("clojureDispatch", c.blue, nil, {})

-- Scala Highlighting
set_hl("scalaKeyword", c.wine, nil, {})
set_hl("scalaKeywordModifier", c.wine, nil, {})
set_hl("scalaOperator", c.blue, nil, {})
set_hl("scalaPackage", c.wine, nil, {})
set_hl("scalaFqn", c.fg, nil, {})
set_hl("scalaFqnSet", c.fg, nil, {})
set_hl("scalaImport", c.wine, nil, {})
set_hl("scalaBoolean", c.orange, nil, {})
set_hl("scalaDef", c.wine, nil, {})
set_hl("scalaVal", c.wine, nil, {})
set_hl("scalaVar", c.wine, nil, {})
set_hl("scalaClass", c.wine, nil, {})
set_hl("scalaObject", c.wine, nil, {})
set_hl("scalaTrait", c.wine, nil, {})
set_hl("scalaDefName", c.blue, nil, {})
set_hl("scalaValName", c.fg, nil, {})
set_hl("scalaVarName", c.fg, nil, {})
set_hl("scalaClassName", c.fg, nil, {})
set_hl("scalaType", c.yellow, nil, {})
set_hl("scalaTypeSpecializer", c.yellow, nil, {})
set_hl("scalaAnnotation", c.orange, nil, {})
set_hl("scalaNumber", c.orange, nil, {})
set_hl("scalaDefSpecializer", c.yellow, nil, {})
set_hl("scalaClassSpecializer", c.yellow, nil, {})
set_hl("scalaBackTick", c.green, nil, {})
set_hl("scalaRoot", c.fg, nil, {})
set_hl("scalaMethodCall", c.blue, nil, {})
set_hl("scalaCaseType", c.yellow, nil, {})
set_hl("scalaLineComment", c.comment, nil, {})
set_hl("scalaComment", c.comment, nil, {})
set_hl("scalaDocComment", c.comment, nil, {})
set_hl("scalaDocTags", c.comment, nil, {})
set_hl("scalaEmptyString", c.green, nil, {})
set_hl("scalaMultiLineString", c.green, nil, {})
set_hl("scalaUnicode", c.orange, nil, {})
set_hl("scalaString", c.green, nil, {})
set_hl("scalaStringEscape", c.green, nil, {})
set_hl("scalaSymbol", c.orange, nil, {})
set_hl("scalaChar", c.orange, nil, {})
set_hl("scalaXml", c.green, nil, {})
set_hl("scalaConstructorSpecializer", c.yellow, nil, {})
set_hl("scalaBackTick", c.blue, nil, {})
