local function apply(C)
  local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  local function link(from, to)
    vim.api.nvim_set_hl(0, from, { link = to })
  end

  ---------------------------------------------------------------------------
  -- TERMINAL COLORS
  ---------------------------------------------------------------------------
  vim.g.terminal_color_0 = C.BACKGROUND
  vim.g.terminal_color_1 = C.RED
  vim.g.terminal_color_2 = C.GREEN
  vim.g.terminal_color_3 = C.YELLOW
  vim.g.terminal_color_4 = C.SKY
  vim.g.terminal_color_5 = C.WINE
  vim.g.terminal_color_6 = C.TEAL
  vim.g.terminal_color_7 = C.FOREGROUND
  vim.g.terminal_color_8 = C.DARK_04
  vim.g.terminal_color_9 = C.RED
  vim.g.terminal_color_10 = C.GREEN
  vim.g.terminal_color_11 = C.GOLD
  vim.g.terminal_color_12 = C.SKY
  vim.g.terminal_color_13 = C.PINK
  vim.g.terminal_color_14 = C.TEAL
  vim.g.terminal_color_15 = C.FOREGROUND

  ---------------------------------------------------------------------------
  -- EDITOR UI
  ---------------------------------------------------------------------------

  -- Core
  hl("Normal", { fg = C.FOREGROUND, bg = C.BACKGROUND })
  hl("NormalNC", { fg = C.FOREGROUND, bg = C.BACKGROUND })
  hl("NormalFloat", { bg = C.DARK_02 })
  hl("LineNr", { fg = C.DARK_04, bg = C.BACKGROUND })
  hl("SignColumn", { bg = C.BACKGROUND })
  hl("EndOfBuffer", { fg = C.DARK_01 })
  hl("Conceal", { fg = C.DARK_04 })
  hl("NonText", { fg = C.DARK_04 })
  hl("Whitespace", { fg = C.DARK_03 })
  hl("SpecialKey", { fg = C.DARK_01 })
  hl("Directory", { fg = C.ORANGE })

  -- Cursor
  hl("CursorLine", { bg = C.DARK_02 })
  hl("CursorLineNr", { fg = C.ORANGE })
  hl("CursorColumn", { bg = C.DARK_01 })
  hl("ColorColumn", { bg = C.DARK_01 })
  hl("Cursor", { fg = C.BACKGROUND, bg = C.YELLOW })
  hl("TermCursor", { fg = C.BACKGROUND, bg = C.YELLOW })
  hl("Visual", { bg = C.DARK_03 })
  hl("VisualNOS", { bg = C.DARK_03 })

  -- Matching
  hl("MatchParen", { fg = C.FOREGROUND, bg = C.RED })

  -- Windows and splits
  hl("WinSeparator", { fg = C.DARK_01 })
  hl("FloatBorder", { fg = C.DARK_03 })
  hl("FloatTitle", { fg = C.ORANGE, bold = true })
  hl("FloatFooter", { fg = C.DARK_04 })
  hl("Title", { fg = C.DARK_04, bold = true })
  hl("WinBar", { fg = C.FOREGROUND, bg = C.DARK_01, bold = true })
  hl("WinBarNC", { fg = C.DARK_04, bg = C.DARK_01 })

  -- Status line and tabs
  hl("StatusLine", { fg = C.DARK_01, bg = C.YELLOW, reverse = true })
  hl("StatusLineNC", { fg = C.DARK_01, bg = C.FOREGROUND, reverse = true })
  hl("StatusLineTerm", { fg = C.DARK_01, bg = C.YELLOW, reverse = true })
  hl("StatusLineTermNC", { fg = C.DARK_01, bg = C.FOREGROUND, reverse = true })
  hl("TabLine", { fg = C.DARK_01, bg = C.FOREGROUND, reverse = true })
  hl("TabLineFill", { fg = C.DARK_01, bg = C.FOREGROUND, reverse = true })
  hl("TabLineSel", { fg = C.FOREGROUND, bg = C.BACKGROUND, bold = true })

  -- Completion menu
  hl("Pmenu", { bg = C.DARK_01 })
  hl("PmenuSel", { fg = C.FOREGROUND, bg = C.DARK_01, reverse = true })
  hl("PmenuSbar", { bg = C.DARK_02 })
  hl("PmenuThumb", { bg = C.DARK_04 })
  hl("PmenuMatch", { fg = C.YELLOW, bg = C.DARK_01 })
  hl("PmenuMatchSel", { fg = C.YELLOW, bg = C.DARK_03 })

  -- Folding
  hl("Folded", { fg = C.DARK_04, bg = C.BACKGROUND })
  hl("FoldColumn", { bg = C.BACKGROUND })

  -- Search and replace
  hl("Search", { fg = C.BACKGROUND, bg = C.YELLOW })
  hl("IncSearch", { fg = C.BACKGROUND, bg = C.RED })
  hl("CurSearch", { fg = C.BACKGROUND, bg = C.RED })
  hl("Substitute", { fg = C.BACKGROUND, bg = C.PINK })

  -- Messages and prompts
  hl("ModeMsg", { fg = C.GREEN })
  hl("MoreMsg", { fg = C.GREEN })
  hl("Question", { fg = C.GREEN })
  hl("WarningMsg", { fg = C.ORANGE, bold = true })
  hl("Error", { fg = C.RED, bold = true })
  hl("ErrorMsg", { fg = C.RED, bold = true })
  hl("Todo", { fg = C.RED, bg = C.BACKGROUND, bold = true })

  -- Spell checking
  hl("SpellBad", { fg = C.RED, underline = true })
  hl("SpellCap", { fg = C.YELLOW, underline = true })
  hl("SpellRare", { fg = C.BLUE, underline = true })
  hl("SpellLocal", { fg = C.GREEN, underline = true })

  ---------------------------------------------------------------------------
  -- SYNTAX
  ---------------------------------------------------------------------------
  hl("Comment", { fg = C.DARK_04 })
  hl("Identifier", { fg = C.FOREGROUND })
  hl("Statement", { fg = C.RED })
  hl("Conditional", { fg = C.RED })
  hl("Repeat", { fg = C.RED })
  hl("Keyword", { fg = C.RED })
  hl("Include", { fg = C.RED })
  hl("Function", { fg = C.GREEN, bold = true })
  hl("Constant", { fg = C.ORANGE })
  hl("String", { fg = C.YELLOW })
  hl("Type", { fg = C.ORANGE })
  hl("Structure", { fg = C.ORANGE })
  hl("Operator", { fg = C.PINK })
  hl("Delimiter", { fg = C.ORANGE })
  hl("Special", { fg = C.ORANGE })
  hl("PreProc", { fg = C.BLUE })
  hl("Define", { fg = C.GREEN })
  hl("Tag", { fg = C.ORANGE, bold = true })
  hl("Underlined", { fg = C.ORANGE, underline = true })
  hl("QuickFixLine", { fg = C.RED, bold = true })
  hl("Bold", { bold = true })
  hl("Italic", { italic = true })

  -- Custom semantic groups
  hl("SpecialKeyword", { fg = C.ORANGE, italic = true })
  hl("AccessModifier", { fg = C.RED, italic = true })
  hl("TypeParameter", { fg = C.GREEN, italic = true })

  ---------------------------------------------------------------------------
  -- DIFF
  ---------------------------------------------------------------------------
  hl("DiffAdd", { fg = C.GREEN, bg = C.BACKGROUND })
  hl("DiffChange", { fg = C.YELLOW, bg = C.BACKGROUND })
  hl("DiffDelete", { fg = C.RED, bg = C.BACKGROUND })
  hl("DiffText", { fg = C.YELLOW, bg = C.DARK_02 })
  hl("DiffLine", { fg = C.BLUE, bg = C.BACKGROUND, italic = true })
  hl("DiffSubname", { fg = C.FOREGROUND, bg = C.BACKGROUND })
  link("DiffAdded", "DiffAdd")
  link("diffAdded", "DiffAdd")
  link("diffAdd", "DiffAdd")
  link("diffChange", "DiffChange")
  link("diffDelete", "DiffDelete")
  link("DiffRemoved", "DiffDelete")
  link("diffRemoved", "DiffDelete")
  link("diffLine", "DiffLine")
  link("diffSubname", "DiffSubname")
  hl("Added", { fg = C.GREEN })
  hl("Changed", { fg = C.YELLOW })
  hl("Removed", { fg = C.RED })

  ---------------------------------------------------------------------------
  -- DIAGNOSTICS
  ---------------------------------------------------------------------------
  hl("DiagnosticError", { fg = C.RED, bold = true })
  hl("DiagnosticWarn", { fg = C.YELLOW, bold = true })
  hl("DiagnosticInfo", { fg = C.BLUE, bold = true })
  hl("DiagnosticHint", { fg = C.BLUE, bold = true })
  hl("DiagnosticOk", { fg = C.GREEN })

  hl("DiagnosticUnderlineError", { undercurl = true, sp = C.RED })
  hl("DiagnosticUnderlineWarn", { undercurl = true, sp = C.YELLOW })
  hl("DiagnosticUnderlineInfo", { undercurl = true, sp = C.BLUE })
  hl("DiagnosticUnderlineHint", { undercurl = true, sp = C.BLUE })
  hl("DiagnosticUnderlineOk", { undercurl = true, sp = C.GREEN })

  hl("DiagnosticDeprecated", { strikethrough = true })
  hl("DiagnosticUnnecessary", { fg = C.DARK_04 })

  ---------------------------------------------------------------------------
  -- LSP
  ---------------------------------------------------------------------------
  hl("LspReferenceText", { bg = C.DARK_02 })
  hl("LspReferenceRead", { bg = C.DARK_02 })
  hl("LspReferenceWrite", { bg = C.DARK_02 })
  hl("LspInlayHint", { fg = C.DARK_04, italic = true })
  hl("LspCodeLens", { fg = C.DARK_04 })
  hl("LspSignatureActiveParameter", { fg = C.ORANGE, bold = true })

  ---------------------------------------------------------------------------
  -- PLUGINS
  ---------------------------------------------------------------------------

  -- Telescope
  hl("TelescopeBorder", { fg = C.DARK_03 })
  hl("TelescopeTitle", { fg = C.RED, bold = true })
  hl("TelescopePromptTitle", { fg = C.FOREGROUND, bold = true })
  hl("TelescopePreviewTitle", { fg = C.GREEN, bold = true })

  -- NvimTree
  hl("NvimParenthesis", { fg = C.ORANGE })
  hl("NvimTreeNormal", { fg = C.FOREGROUND, bg = C.DARK_00 })
  hl("NvimTreeRootFolder", { fg = C.RED })
  hl("NvimTreeFolderName", { fg = C.ORANGE, bold = true })
  hl("NvimTreeExecFile", { fg = C.RED, bold = true })
  hl("NvimTreeOpenedFile", { fg = C.FOREGROUND })
  hl("NvimTreeWindowPicker", { fg = C.FOREGROUND, bg = C.DARK_01, bold = true })
  link("NvimTreeFolderIcon", "Directory")
  link("NvimTreeEmptyFolderName", "NvimTreeFolderName")
  link("NvimTreeOpenedFolderName", "NvimTreeFolderName")

  -- BlinkCmp
  hl("BlinkCmpMenuBorder", { fg = C.DARK_03 })
  link("BlinkCmpDocBorder", "BlinkCmpMenuBorder")

  ---------------------------------------------------------------------------
  -- TREESITTER
  ---------------------------------------------------------------------------

  -- Variables & Properties
  link("@variable", "Identifier")
  link("@variable.builtin", "SpecialKeyword")
  link("@variable.parameter", "Identifier")
  link("@variable.parameter.builtin", "Identifier")
  link("@variable.member", "Identifier")
  link("@property", "Identifier")

  -- Constants & Literals
  link("@constant", "Constant")
  link("@constant.builtin", "Constant")
  link("@constant.macro", "Constant")
  link("@number", "Constant")
  link("@number.float", "Constant")
  link("@boolean", "Constant")
  link("@character", "String")
  link("@character.special", "Special")

  -- Strings
  link("@string", "String")
  link("@string.documentation", "Comment")
  link("@string.escape", "Special")
  link("@string.regexp", "Special")
  link("@string.special", "Special")
  link("@string.special.symbol", "Special")
  link("@string.special.url", "Underlined")
  link("@string.special.path", "Underlined")

  -- Types & Classes
  link("@type", "Type")
  link("@type.builtin", "Type")
  link("@type.definition", "Type")
  link("@type.qualifier", "Keyword")

  -- Functions & Methods
  link("@function", "Function")
  link("@function.builtin", "Function")
  link("@function.call", "Function")
  link("@function.macro", "PreProc")
  link("@function.method", "Function")
  link("@function.method.call", "Function")
  link("@constructor", "Function")

  -- Keywords & Control Flow
  link("@keyword", "Keyword")
  link("@keyword.coroutine", "Keyword")
  link("@keyword.function", "Keyword")
  link("@keyword.operator", "Keyword")
  link("@keyword.return", "Keyword")
  link("@keyword.import", "Include")
  link("@keyword.type", "Keyword")
  link("@keyword.modifier", "AccessModifier")
  link("@keyword.conditional", "Conditional")
  link("@keyword.conditional.ternary", "Conditional")
  link("@keyword.repeat", "Repeat")
  link("@keyword.exception", "Keyword")
  link("@keyword.debug", "Keyword")
  link("@keyword.directive", "PreProc")
  link("@keyword.directive.define", "Define")

  -- Operators & Punctuation
  link("@operator", "Operator")
  link("@punctuation.delimiter", "Delimiter")
  link("@punctuation.bracket", "Delimiter")
  link("@punctuation.special", "Special")

  -- Modules & Labels
  link("@module", "Type")
  link("@module.builtin", "Type")
  link("@label", "Keyword")

  -- Comments & Documentation
  link("@comment", "Comment")
  link("@comment.documentation", "Comment")
  link("@comment.error", "Error")
  link("@comment.warning", "WarningMsg")
  link("@comment.note", "Todo")
  link("@comment.todo", "Todo")

  -- Tags (HTML/JSX)
  link("@tag", "Tag")
  link("@tag.builtin", "Tag")
  link("@tag.attribute", "Identifier")
  link("@tag.delimiter", "Delimiter")

  -- Attributes & Decorators
  link("@attribute", "Special")
  link("@attribute.builtin", "Special")

  -- Markup (Markdown, etc.)
  link("@markup.strong", "Bold")
  link("@markup.italic", "Italic")
  link("@markup.strikethrough", "Comment")
  link("@markup.underline", "Underlined")
  link("@markup.heading", "Title")
  link("@markup.quote", "Comment")
  link("@markup.math", "Special")
  link("@markup.link", "Identifier")
  link("@markup.link.label", "Special")
  link("@markup.link.url", "Underlined")
  link("@markup.raw", "String")
  link("@markup.raw.block", "String")
  link("@markup.list", "Delimiter")
  link("@markup.list.checked", "DiagnosticOk")
  link("@markup.list.unchecked", "Comment")

  -- Diff
  link("@diff.plus", "DiffAdd")
  link("@diff.minus", "DiffDelete")
  link("@diff.delta", "DiffChange")

  -- Type parameters
  link("@lsp.type.typeParameter", "TypeParameter")

  -- Special keywords (this, self, super)
  link("@keyword.this", "SpecialKeyword")
  link("@keyword.self", "SpecialKeyword")
  link("@keyword.super", "SpecialKeyword")
  link("@lsp.type.selfKeyword", "SpecialKeyword")

  -- LSP Semantic Tokens
  link("@lsp.type.class", "Type")
  link("@lsp.type.interface", "Type")
  link("@lsp.type.struct", "Type")
  link("@lsp.type.enum", "Type")
  link("@lsp.type.type", "Type")
  link("@lsp.type.enumMember", "Constant")
  link("@lsp.type.function", "Function")
  link("@lsp.type.method", "Function")
  link("@lsp.type.variable", "Identifier")
  link("@lsp.type.parameter", "Identifier")
  link("@lsp.type.property", "Identifier")
  link("@lsp.type.namespace", "Type")
  link("@lsp.type.decorator", "Special")
  link("@lsp.type.macro", "PreProc")
  link("@lsp.type.comment", "Comment")
  link("@lsp.type.modifier", "AccessModifier")
  link("@lsp.typemod.keyword.modifier", "AccessModifier")

  -- LSP Modifiers
  hl("@lsp.mod.deprecated", { strikethrough = true })
end

return apply
