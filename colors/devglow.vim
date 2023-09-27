set background=dark

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

" Colorscheme name
let g:colors_name = "devglow"

let s:fg = "EEE2DE"
let s:dim_fg = 'BBBBBB'
let s:bg = "080808"
let s:mbg0 = "111111"
let s:mbg1 = "1D2021"

let s:comment = "797979"
let s:red = "AF5F5F"
let s:orange = "D59572"
let s:yellow = "E5B567"
let s:dim_yellow = 'C09838'
let s:green = "87AFAF"
let s:blue = "7EAAC7"
let s:wine = "924653"
let s:purple = "9E86C8"
let s:pantone = "424242"

let s:dark0 = "181818"
let s:dark1 = "282828"
let s:dark2 = "383838"
let s:error = "EA5455"
let s:warn = "FFA500"
let s:info = "7DB9B6"

let bg = exists("g:devglow_minimal_bg") ? s:mbg1 : s:bg

if exists("g:devglow_use_italics") && !g:devglow_use_italics
  let italic = ""
else
  let g:devglow_use_italics = 1
  let italic = "italic"
endif
  
" Returns an approximate grey index for the given grey level
fun <SID>grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual grey level represented by the grey index
fun <SID>grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" Returns the palette index for the given grey index
fun <SID>grey_colour(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" Returns an approximate colour index for the given colour level
fun <SID>rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" Returns the actual colour level for the given colour index
fun <SID>rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" Returns the palette index for the given R/G/B colour indices
fun <SID>rgb_colour(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" Returns the palette index to approximate the given R/G/B colour levels
fun <SID>colour(r, g, b)
  " Get the closest grey
  let l:gx = <SID>grey_number(a:r)
  let l:gy = <SID>grey_number(a:g)
  let l:gz = <SID>grey_number(a:b)

  " Get the closest colour
  let l:x = <SID>rgb_number(a:r)
  let l:y = <SID>rgb_number(a:g)
  let l:z = <SID>rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " There are two possibilities
    let l:dgr = <SID>grey_level(l:gx) - a:r
    let l:dgg = <SID>grey_level(l:gy) - a:g
    let l:dgb = <SID>grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = <SID>rgb_level(l:gx) - a:r
    let l:dg = <SID>rgb_level(l:gy) - a:g
    let l:db = <SID>rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " Use the grey
      return <SID>grey_colour(l:gx)
    else
      " Use the colour
      return <SID>rgb_colour(l:x, l:y, l:z)
    endif
  else
    " Only one possibility
    return <SID>rgb_colour(l:x, l:y, l:z)
  endif
endfun

" Returns the palette index to approximate the 'rrggbb' hex string
fun <SID>rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

  return <SID>colour(l:r, l:g, l:b)
endfun

" Sets the highlighting for the given group
fun s:color(group, fg, bg, attr)
  if a:fg != ""
    if a:fg == "NONE"
      exec "hi " . a:group . " guifg=NONE ctermfg=NONE"
    else
      exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
  endif
  if a:bg != ""
    if a:bg == "NONE"
      exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
    else
      exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  " option g:devglow_italic_comments
  if exists("g:devglow_italic_comments") && g:devglow_italic_comments
    call s:color("Comment", s:comment, "", italic)
  else
    let g:devglow_italic_comments = 0
    call s:color("Comment", s:comment, "", "")
  endif

  " Vim Highlighting
  call s:color("NonText", s:dark0, "", "")
  call s:color("SpecialKey", s:dark0, "", "")
  call s:color("Search", bg, s:yellow, "")
  call s:color("TabLine", s:dark0, s:fg, "reverse")
  call s:color("TabLineFill", s:dark0, s:fg, "reverse")
  call s:color("StatusLine", s:dark0, s:yellow, "reverse")
  call s:color("StatusLineNC", s:dark0, s:fg, "reverse")
  call s:color("VertSplit", s:dark0, bg, "")
  call s:color("Visual", "", s:pantone, "")
  call s:color("Directory", s:dim_yellow, "", "")
  call s:color("ModeMsg", s:green, "", "")
  call s:color("MoreMsg", s:green, "", "")
  call s:color("Question", s:green, "", "")
  call s:color("WarningMsg", s:orange, "", "bold")
  call s:color("MatchParen", "", s:wine, "")
  call s:color("Folded", s:comment, bg, "")
  call s:color("FoldColumn", "", bg, "")
  call s:color("Pmenu", "", s:dark0, "")

  if version >= 700
    call s:color("CursorLine", "", s:dark0, "NONE")
    call s:color("CursorLineNR", s:orange, "", "NONE")
    call s:color("CursorColumn", "", s:dark0, "NONE")
    call s:color("PMenu", "", s:dark0, "NONE")
    call s:color("PMenuSel", s:fg, s:dark0, "reverse")
  endif

  if version >= 703
    call s:color("ColorColumn", "", s:dark0, "NONE")
  endif

  " Standard Highlighting
  call s:color("Title", s:comment, "", "bold")
  call s:color("Identifier", s:fg, "", "")
  call s:color("Statement", s:red, "", "")
  call s:color("Conditional", s:red, "", "")
  call s:color("Repeat", s:red, "", "")
  call s:color("Structure", s:orange, "", "")
  call s:color("Function", s:green, "", "bold")
  call s:color("Constant", s:orange, "", "")
  call s:color("Keyword", s:red, "", "")
  call s:color("String", s:yellow, "", "")
  call s:color("Special", s:orange, "", "")
  call s:color("PreProc", s:blue, "", "")
  call s:color("Operator", s:purple, "", "")
  call s:color("Type", s:orange, "", "")
  call s:color("Define", s:green, "", "")
  call s:color("Include", s:red, "", "")
  call s:color("Tag", s:orange, "", "bold")
  call s:color("Underlined", s:orange, "", "underline")

  syntax match commonOperator "\(+\|=\|-\|*\|\^\|\/\||\)"
  hi! link commonOperator Operator

  " Vim Highlighting
  call s:color("vimCommand", s:wine, "", "NONE")

  " C Highlighting
  call s:color("cType", s:wine, "", "")
  call s:color("cStorageClass", s:orange, "", "")
  call s:color("cConditional", s:wine, "", "")
  call s:color("cRepeat", s:wine, "", "")

  " PHP Highlighting
  call s:color("phpVarSelector", s:wine, "", "")
  call s:color("phpKeyword", s:wine, "", "")
  call s:color("phpRepeat", s:wine, "", "")
  call s:color("phpConditional", s:wine, "", "")
  call s:color("phpStatement", s:wine, "", "")
  call s:color("phpMemberSelector", s:fg, "", "")

  " Ruby Highlighting
  call s:color("rubySymbol", s:blue, "", "")
  call s:color("rubyConstant", s:green, "", "")
  call s:color("rubyAccess", s:yellow, "", "")
  call s:color("rubyAttribute", s:blue, "", "")
  call s:color("rubyInclude", s:blue, "", "")
  call s:color("rubyLocalVariableOrMethod", s:orange, "", "")
  call s:color("rubyCurlyBlock", s:orange, "", "")
  call s:color("rubyStringDelimiter", s:yellow, "", "")
  call s:color("rubyInterpolationDelimiter", s:orange, "", "")
  call s:color("rubyConditional", s:wine, "", "")
  call s:color("rubyRepeat", s:wine, "", "")
  call s:color("rubyControl", s:wine, "", "")
  call s:color("rubyException", s:wine, "", "")

  " Crystal Highlighting
  call s:color("crystalSymbol", s:green, "", "")
  call s:color("crystalConstant", s:yellow, "", "")
  call s:color("crystalAccess", s:yellow, "", "")
  call s:color("crystalAttribute", s:blue, "", "")
  call s:color("crystalInclude", s:blue, "", "")
  call s:color("crystalLocalVariableOrMethod", s:orange, "", "")
  call s:color("crystalCurlyBlock", s:orange, "", "")
  call s:color("crystalStringDelimiter", s:green, "", "")
  call s:color("crystalInterpolationDelimiter", s:orange, "", "")
  call s:color("crystalConditional", s:wine, "", "")
  call s:color("crystalRepeat", s:wine, "", "")
  call s:color("crystalControl", s:wine, "", "")
  call s:color("crystalException", s:wine, "", "")

  " Python Highlighting
  call s:color("pythonInclude", s:green, "", italic)
  call s:color("pythonStatement", s:blue, "", "")
  call s:color("pythonConditional", s:wine, "", "")
  call s:color("pythonRepeat", s:wine, "", "")
  call s:color("pythonException", s:orange, "", "")
  call s:color("pythonFunction", s:green, "", italic)
  call s:color("pythonPreCondit", s:wine, "", "")
  call s:color("pythonExClass", s:orange, "", "")
  call s:color("pythonBuiltin", s:blue, "", "")
  call s:color("pythonOperator", s:wine, "", "")
  call s:color("pythonNumber", s:purple, "", "")
  call s:color("pythonString", s:yellow, "", "")
  call s:color("pythonRawString", s:yellow, "", "")
  call s:color("pythonDecorator", s:wine, "", "")
  call s:color("pythonDoctest", s:yellow, "", "")
  call s:color("pythonImportFunction", s:orange, "", "")
  call s:color("pythonImportModule", s:orange, "", "")
  call s:color("pythonImportObject", s:orange, "", "")
  call s:color("pythonImportedClassDef", s:orange, "", "")
  call s:color("pythonImportedFuncDef", s:orange, "", "")
  call s:color("pythonImportedModule", s:orange, "", "")
  call s:color("pythonImportedObject", s:orange, "", "")

  " JavaScript Highlighting
  call s:color("javaScriptEndColons", s:fg, "", "")
  call s:color("javaScriptOpSymbols", s:fg, "", "")
  call s:color("javaScriptLogicSymbols", s:fg, "", "")
  call s:color("javaScriptBraces", s:fg, "", "")
  call s:color("javaScriptParens", s:fg, "", "")
  call s:color("javaScriptFunction", s:green, "", "")
  call s:color("javaScriptComment", s:comment, "", "")
  call s:color("javaScriptLineComment", s:comment, "", "")
  call s:color("javaScriptDocComment", s:comment, "", "")
  call s:color("javaScriptCommentTodo", s:red, "", "")
  call s:color("javaScriptString", s:yellow, "", "")
  call s:color("javaScriptRegexpString", s:yellow, "", "")
  call s:color("javaScriptTemplateString", s:yellow, "", "")
  call s:color("javaScriptNumber", s:purple, "", "")
  call s:color("javaScriptFloat", s:purple, "", "")
  call s:color("javaScriptGlobal", s:purple, "", "")
  call s:color("javaScriptCharacter", s:blue, "", "")
  call s:color("javaScriptPrototype", s:blue, "", "")
  call s:color("javaScriptConditional", s:blue, "", "")
  call s:color("javaScriptBranch", s:blue, "", "")
  call s:color("javaScriptIdentifier", s:orange, "", "")
  call s:color("javaScriptRepeat", s:blue, "", "")
  call s:color("javaScriptStatement", s:blue, "", "")
  call s:color("javaScriptMessage", s:blue, "", "")
  call s:color("javaScriptReserved", s:blue, "", "")
  call s:color("javaScriptOperator", s:blue, "", "")
  call s:color("javaScriptNull", s:dim_fg, "", "")
  call s:color("javaScriptBoolean", s:purple, "", "")
  call s:color("javaScriptLabel", s:blue, "", "")
  call s:color("javaScriptSpecial", s:blue, "", "")
  call s:color("javaScriptExceptions", s:red, "", "")
  call s:color("javaScriptDeprecated", s:red, "", "")
  call s:color("javaScriptError", s:red, "", "")

  " Typescript Highlighting
  call s:color("typescriptReserved", s:blue, "", "")
  call s:color("typescriptLabel", s:blue, "", "")
  call s:color("typescriptFunction", s:green, "", "")
  call s:color("typescriptIdentifier", s:orange, "", "")
  call s:color("typescriptBraces", s:fg, "", "")
  call s:color("typescriptEndColons", s:blue, "", "")
  call s:color("typescriptDOMObjects", s:orange, "", "")
  call s:color("typescriptAjaxMethods", s:orange, "", "")
  call s:color("typescriptLogicSymbols", s:fg, "", "")
  call s:color("typescriptDocComment", s:comment, "", "")
  call s:color("typescriptDocSeeTag", s:comment, "", "")
  call s:color("typescriptDocParam", s:comment, "", "")
  call s:color("typescriptDocTags", s:comment, "", "")
  call s:color("typescriptGlobalObjects", s:purple, "", "")
  call s:color("typescriptParens", s:fg, "", "")
  call s:color("typescriptOpSymbols", s:fg, "", "")
  call s:color("typescriptHtmlElemProperties", s:fg, "", "")
  call s:color("typescriptNull", s:dim_fg, "", "")
  call s:color("typescriptInterpolationDelimiter", s:orange, "", "")

  " LaTeX
  call s:color("texStatement",s:blue, "", "")
  call s:color("texMath", s:wine, "", "NONE")
  call s:color("texMathMacher", s:yellow, "", "NONE")
  call s:color("texRefLabel", s:wine, "", "NONE")
  call s:color("texRefZone", s:blue, "", "NONE")
  call s:color("texComment", s:comment, "", "NONE")
  call s:color("texDelimiter", s:purple, "", "NONE")
  call s:color("texMathZoneX", s:purple, "", "NONE")

  " CoffeeScript Highlighting
  call s:color("coffeeRepeat", s:wine, "", "")
  call s:color("coffeeConditional", s:wine, "", "")
  call s:color("coffeeKeyword", s:wine, "", "")
  call s:color("coffeeObject", s:yellow, "", "")

  " HTML Highlighting
  call s:color("htmlTag", s:blue, "", "")
  call s:color("htmlEndTag", s:blue, "", "")
  call s:color("htmlTagName", s:wine, "", "bold")
  call s:color("htmlArg", s:green, "", italic)
  call s:color("htmlScriptTag", s:wine, "", "")

  " Diff Highlighting
  call s:color("diffAdd", "", "4c4e39", "")
  call s:color("diffDelete", bg, s:red, "")
  call s:color("diffChange", "", "2B5B77", "")
  call s:color("diffText", s:dim_fg, s:blue, "")

  " ShowMarks Highlighting
  call s:color("ShowMarksHLl", s:orange, bg, "NONE")
  call s:color("ShowMarksHLo", s:wine, bg, "NONE")
  call s:color("ShowMarksHLu", s:yellow, bg, "NONE")
  call s:color("ShowMarksHLm", s:wine, bg, "NONE")

  " Lua Highlighting
  call s:color("luaStatement", s:wine, "", "")
  call s:color("luaRepeat", s:wine, "", "")
  call s:color("luaCondStart", s:wine, "", "")
  call s:color("luaCondElseif", s:wine, "", "")
  call s:color("luaCond", s:wine, "", "")
  call s:color("luaCondEnd", s:wine, "", "")

  " Cucumber Highlighting
  call s:color("cucumberGiven", s:blue, "", "")
  call s:color("cucumberGivenAnd", s:blue, "", "")

  " Go Highlighting
  call s:color("goDirective", s:wine, "", "")
  call s:color("goDeclaration", s:wine, "", "")
  call s:color("goStatement", s:wine, "", "")
  call s:color("goConditional", s:wine, "", "")
  call s:color("goConstants", s:orange, "", "")
  call s:color("goTodo", s:red, "", "")
  call s:color("goDeclType", s:blue, "", "")
  call s:color("goBuiltins", s:wine, "", "")
  call s:color("goRepeat", s:wine, "", "")
  call s:color("goLabel", s:wine, "", "")

  " Clojure Highlighting
  call s:color("clojureConstant", s:orange, "", "")
  call s:color("clojureBoolean", s:orange, "", "")
  call s:color("clojureCharacter", s:orange, "", "")
  call s:color("clojureKeyword", s:green, "", "")
  call s:color("clojureNumber", s:orange, "", "")
  call s:color("clojureString", s:green, "", "")
  call s:color("clojureRegexp", s:green, "", "")
  call s:color("clojureParen", s:wine, "", "")
  call s:color("clojureVariable", s:yellow, "", "")
  call s:color("clojureCond", s:blue, "", "")
  call s:color("clojureDefine", s:wine, "", "")
  call s:color("clojureException", s:red, "", "")
  call s:color("clojureFunc", s:blue, "", "")
  call s:color("clojureMacro", s:blue, "", "")
  call s:color("clojureRepeat", s:blue, "", "")
  call s:color("clojureSpecial", s:wine, "", "")
  call s:color("clojureQuote", s:blue, "", "")
  call s:color("clojureUnquote", s:blue, "", "")
  call s:color("clojureMeta", s:blue, "", "")
  call s:color("clojureDeref", s:blue, "", "")
  call s:color("clojureAnonArg", s:blue, "", "")
  call s:color("clojureRepeat", s:blue, "", "")
  call s:color("clojureDispatch", s:blue, "", "")

  " Scala Highlighting
  call s:color("scalaKeyword", s:wine, "", "")
  call s:color("scalaKeywordModifier", s:wine, "", "")
  call s:color("scalaOperator", s:blue, "", "")
  call s:color("scalaPackage", s:wine, "", "")
  call s:color("scalaFqn", s:fg, "", "")
  call s:color("scalaFqnSet", s:fg, "", "")
  call s:color("scalaImport", s:wine, "", "")
  call s:color("scalaBoolean", s:orange, "", "")
  call s:color("scalaDef", s:wine, "", "")
  call s:color("scalaVal", s:wine, "", "")
  call s:color("scalaVar", s:wine, "", "")
  call s:color("scalaClass", s:wine, "", "")
  call s:color("scalaObject", s:wine, "", "")
  call s:color("scalaTrait", s:wine, "", "")
  call s:color("scalaDefName", s:blue, "", "")
  call s:color("scalaValName", s:fg, "", "")
  call s:color("scalaVarName", s:fg, "", "")
  call s:color("scalaClassName", s:fg, "", "")
  call s:color("scalaType", s:yellow, "", "")
  call s:color("scalaTypeSpecializer", s:yellow, "", "")
  call s:color("scalaAnnotation", s:orange, "", "")
  call s:color("scalaNumber", s:orange, "", "")
  call s:color("scalaDefSpecializer", s:yellow, "", "")
  call s:color("scalaClassSpecializer", s:yellow, "", "")
  call s:color("scalaBackTick", s:green, "", "")
  call s:color("scalaRoot", s:fg, "", "")
  call s:color("scalaMethodCall", s:blue, "", "")
  call s:color("scalaCaseType", s:yellow, "", "")
  call s:color("scalaLineComment", s:comment, "", "")
  call s:color("scalaComment", s:comment, "", "")
  call s:color("scalaDocComment", s:comment, "", "")
  call s:color("scalaDocTags", s:comment, "", "")
  call s:color("scalaEmptyString", s:green, "", "")
  call s:color("scalaMultiLineString", s:green, "", "")
  call s:color("scalaUnicode", s:orange, "", "")
  call s:color("scalaString", s:green, "", "")
  call s:color("scalaStringEscape", s:green, "", "")
  call s:color("scalaSymbol", s:orange, "", "")
  call s:color("scalaChar", s:orange, "", "")
  call s:color("scalaXml", s:green, "", "")
  call s:color("scalaConstructorSpecializer", s:yellow, "", "")
  call s:color("scalaBackTick", s:blue, "", "")

  " Git
  call s:color("gitFile", s:orange, "", "")
  call s:color("gitcommitSummary", "", "", "bold")

  " Option g:devglow_no_terminal_background
  if !exists("g:devglow_inherit_background")
    let g:devglow_inherit_background = 0
  endif

  " Background behavior inference here
  if g:devglow_inherit_background && has("gui_running")
    echohl WarningMsg | echom "Inherit background is ignored in GUI." | echohl NONE
    let g:devglow_inherit_background = 0
  endif

  call s:color("Normal", s:fg, bg, "")
  call s:color("LineNr", s:comment, bg, "")

  if version >= 700
    call s:color("SignColumn", "", bg, "NONE")
  endif

  call s:color("Todo", s:red, bg, "bold")

  " Diffs
  " Plugin GitGutter uses highlight link to some of the groups below
  call s:color("DiffAdded", s:green, bg, "")
  call s:color("DiffChange", s:yellow, bg, "")
  call s:color("DiffDelete", s:red, bg, "")
  call s:color("DiffLine", s:blue, bg, italic)
  call s:color("DiffSubname", s:fg, bg, "")
  " Aliases
  " For plugins compatibility and some backcompatibility
  " cf. https://github.com/vim/vim-history/blob/c2257f84a000fd08d3ba80d6b1a5d1c0148a39ea/runtime/syntax/diff.vim#L13
  hi! link diffAdded DiffAdded
  hi! link diffChange DiffChange
  hi! link diffDelete DiffDelete
  hi! link diffLine DiffLine
  hi! link diffSubname DiffSubname
  hi! link DiffRemoved DiffDelete
  hi! link diffRemoved DiffDelete
  hi! link GitGutterChangeLineDefault DiffDelete
  hi! link DiffAdd DiffAdded
  hi! link diffAdd DiffAdded

  " ALE (plugin)
  call s:color("ALEWarningSign", s:orange, bg, "bold")
  call s:color("ALEErrorSign", s:red, bg, "bold")

  " Diagnostic 
  call s:color("DiagnosticError", s:error, "", "bold")
  call s:color("DiagnosticWarn", s:warn, "", "bold")
  call s:color("DiagnosticInfo", s:info, "", "bold")
  call s:color("DiagnosticHint", s:blue, "", "bold")

  " Nvim tree 
  call s:color("NvimTreeNormal", s:dim_fg, s:mbg0, "")
  call s:color("NvimTreeRootFolder", s:red, "", "")
  call s:color("NvimTreeFolderName", s:dim_yellow, "", "bold")
  call s:color("NvimTreeExecFile", s:red, "", "bold")
  call s:color("NvimTreeOpenedFile", s:fg, "", "")
  call s:color("NvimTreeWindowPicker", s:dim_fg, s:dark0, "bold")

  hi! link NvimTreeFolderIcon Directory
  hi! link NvimTreeEmptyFolderName  NvimTreeFolderName
  hi! link NvimTreeOpenedFolderName NvimTreeFolderName
endif

" Delete Functions
delf s:color
delf <SID>rgb
delf <SID>colour
delf <SID>rgb_colour
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_colour
