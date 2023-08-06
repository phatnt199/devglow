set background=dark

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name = "devglow"

" Default GUI Colours
let s:fg = "EEE2DE"
let s:dim_fg = 'BBBBBB'
let s:bg = "080808"
let s:minimal_bg = "1D2021"

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

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  if exists("g:devglow_minimal_bg")
    let bg = s:minimal_bg
  else
    let bg = s:bg
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
  fun <SID>X(group, fg, bg, attr)
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

  " by default: toggled on (backcompatibility with g:devglow_italic_comments)
  " option g:devglow_use_italics
  if exists("g:devglow_use_italics") && !g:devglow_use_italics
    let italic = ""
  else
    " make the global variable available to command mode
    let g:devglow_use_italics = 1
    let italic = "italic"
  endif

  " option g:devglow_italic_comments
  if exists("g:devglow_italic_comments") && g:devglow_italic_comments
    call <SID>X("Comment", s:comment, "", italic)
  else
    " make the global variable available to command mode
    let g:devglow_italic_comments = 0
    call <SID>X("Comment", s:comment, "", "")
  endif
  
  " Vim Highlighting
  call <SID>X("NonText", s:dark0, "", "")
  call <SID>X("SpecialKey", s:dark0, "", "")
  call <SID>X("Search", bg, s:yellow, "")
  call <SID>X("TabLine", s:dark0, s:fg, "reverse")
  call <SID>X("TabLineFill", s:dark0, s:fg, "reverse")
  call <SID>X("StatusLine", s:dark0, s:yellow, "reverse")
  call <SID>X("StatusLineNC", s:dark0, s:fg, "reverse")
  call <SID>X("VertSplit", s:dark0, bg, "")
  call <SID>X("Visual", "", s:pantone, "")
  call <SID>X("Directory", s:dim_yellow, "", "")
  call <SID>X("ModeMsg", s:green, "", "")
  call <SID>X("MoreMsg", s:green, "", "")
  call <SID>X("Question", s:green, "", "")
  call <SID>X("WarningMsg", s:orange, "", "bold")
  call <SID>X("MatchParen", "", s:wine, "")
  call <SID>X("Folded", s:comment, bg, "")
  call <SID>X("FoldColumn", "", bg, "")
  call <SID>X("Pmenu", "", s:dark0, "")

  if version >= 700
    call <SID>X("CursorLine", "", s:dark0, "NONE")
    call <SID>X("CursorLineNR", s:orange, "", "NONE")
    call <SID>X("CursorColumn", "", s:dark0, "NONE")
    call <SID>X("PMenu", "", s:dark0, "NONE")
    call <SID>X("PMenuSel", s:fg, s:dark0, "reverse")
    end

    if version >= 703
      call <SID>X("ColorColumn", "", s:dark0, "NONE")
      end

      " Standard Highlighting
      call <SID>X("Title", s:comment, "", "bold")
      call <SID>X("Identifier", s:fg, "", "")
      call <SID>X("Statement", s:red, "", "")
      call <SID>X("Conditional", s:red, "", "")
      call <SID>X("Repeat", s:red, "", "")
      call <SID>X("Structure", s:green, "", "")
      call <SID>X("Function", s:green, "", "bold")
      call <SID>X("Constant", s:orange, "", "")
      call <SID>X("Keyword", s:red, "", "")
      call <SID>X("String", s:yellow, "", "")
      call <SID>X("Special", s:orange, "", "")
      call <SID>X("PreProc", s:blue, "", "")
      call <SID>X("Operator", s:purple, "", "")
      call <SID>X("Type", s:orange, "", "")
      call <SID>X("Define", s:green, "", "")
      call <SID>X("Include", s:red, "", "")
      call <SID>X("Tag", s:orange, "", "bold")
      call <SID>X("Underlined", s:orange, "", "underline")

      syntax match commonOperator "\(+\|=\|-\|*\|\^\|\/\||\)"
      hi! link commonOperator Operator

      " Vim Highlighting
      call <SID>X("vimCommand", s:wine, "", "NONE")

      " C Highlighting
      call <SID>X("cType", s:wine, "", "")
      call <SID>X("cStorageClass", s:orange, "", "")
      call <SID>X("cConditional", s:wine, "", "")
      call <SID>X("cRepeat", s:wine, "", "")

      " PHP Highlighting
      call <SID>X("phpVarSelector", s:wine, "", "")
      call <SID>X("phpKeyword", s:wine, "", "")
      call <SID>X("phpRepeat", s:wine, "", "")
      call <SID>X("phpConditional", s:wine, "", "")
      call <SID>X("phpStatement", s:wine, "", "")
      call <SID>X("phpMemberSelector", s:fg, "", "")

      " Ruby Highlighting
      call <SID>X("rubySymbol", s:blue, "", "")
      call <SID>X("rubyConstant", s:green, "", "")
      call <SID>X("rubyAccess", s:yellow, "", "")
      call <SID>X("rubyAttribute", s:blue, "", "")
      call <SID>X("rubyInclude", s:blue, "", "")
      call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
      call <SID>X("rubyCurlyBlock", s:orange, "", "")
      call <SID>X("rubyStringDelimiter", s:yellow, "", "")
      call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
      call <SID>X("rubyConditional", s:wine, "", "")
      call <SID>X("rubyRepeat", s:wine, "", "")
      call <SID>X("rubyControl", s:wine, "", "")
      call <SID>X("rubyException", s:wine, "", "")

      " Crystal Highlighting
      call <SID>X("crystalSymbol", s:green, "", "")
      call <SID>X("crystalConstant", s:yellow, "", "")
      call <SID>X("crystalAccess", s:yellow, "", "")
      call <SID>X("crystalAttribute", s:blue, "", "")
      call <SID>X("crystalInclude", s:blue, "", "")
      call <SID>X("crystalLocalVariableOrMethod", s:orange, "", "")
      call <SID>X("crystalCurlyBlock", s:orange, "", "")
      call <SID>X("crystalStringDelimiter", s:green, "", "")
      call <SID>X("crystalInterpolationDelimiter", s:orange, "", "")
      call <SID>X("crystalConditional", s:wine, "", "")
      call <SID>X("crystalRepeat", s:wine, "", "")
      call <SID>X("crystalControl", s:wine, "", "")
      call <SID>X("crystalException", s:wine, "", "")

      " Python Highlighting
      call <SID>X("pythonInclude", s:green, "", italic)
      call <SID>X("pythonStatement", s:blue, "", "")
      call <SID>X("pythonConditional", s:wine, "", "")
      call <SID>X("pythonRepeat", s:wine, "", "")
      call <SID>X("pythonException", s:orange, "", "")
      call <SID>X("pythonFunction", s:green, "", italic)
      call <SID>X("pythonPreCondit", s:wine, "", "")
      call <SID>X("pythonExClass", s:orange, "", "")
      call <SID>X("pythonBuiltin", s:blue, "", "")
      call <SID>X("pythonOperator", s:wine, "", "")
      call <SID>X("pythonNumber", s:purple, "", "")
      call <SID>X("pythonString", s:yellow, "", "")
      call <SID>X("pythonRawString", s:yellow, "", "")
      call <SID>X("pythonDecorator", s:wine, "", "")
      call <SID>X("pythonDoctest", s:yellow, "", "")
      call <SID>X("pythonImportFunction", s:orange, "", "")
      call <SID>X("pythonImportModule", s:orange, "", "")
      call <SID>X("pythonImportObject", s:orange, "", "")
      call <SID>X("pythonImportedClassDef", s:orange, "", "")
      call <SID>X("pythonImportedFuncDef", s:orange, "", "")
      call <SID>X("pythonImportedModule", s:orange, "", "")
      call <SID>X("pythonImportedObject", s:orange, "", "")

      " JavaScript Highlighting
      call <SID>X("javaScriptEndColons", s:fg, "", "")
      call <SID>X("javaScriptOpSymbols", s:fg, "", "")
      call <SID>X("javaScriptLogicSymbols", s:fg, "", "")
      call <SID>X("javaScriptBraces", s:fg, "", "")
      call <SID>X("javaScriptParens", s:fg, "", "")
      call <SID>X("javaScriptFunction", s:orange, "", "")
      call <SID>X("javaScriptComment", s:comment, "", "")
      call <SID>X("javaScriptLineComment", s:comment, "", "")
      call <SID>X("javaScriptDocComment", s:comment, "", "")
      call <SID>X("javaScriptCommentTodo", s:red, "", "")
      call <SID>X("javaScriptString", s:yellow, "", "")
      call <SID>X("javaScriptRegexpString", s:yellow, "", "")
      call <SID>X("javaScriptTemplateString", s:yellow, "", "")
      call <SID>X("javaScriptNumber", s:purple, "", "")
      call <SID>X("javaScriptFloat", s:purple, "", "")
      call <SID>X("javaScriptGlobal", s:purple, "", "")
      call <SID>X("javaScriptCharacter", s:blue, "", "")
      call <SID>X("javaScriptPrototype", s:blue, "", "")
      call <SID>X("javaScriptConditional", s:blue, "", "")
      call <SID>X("javaScriptBranch", s:blue, "", "")
      call <SID>X("javaScriptIdentifier", s:orange, "", "")
      call <SID>X("javaScriptRepeat", s:blue, "", "")
      call <SID>X("javaScriptStatement", s:blue, "", "")
      call <SID>X("javaScriptMessage", s:blue, "", "")
      call <SID>X("javaScriptReserved", s:blue, "", "")
      call <SID>X("javaScriptOperator", s:blue, "", "")
      call <SID>X("javaScriptNull", s:dim_fg, "", "")
      call <SID>X("javaScriptBoolean", s:purple, "", "")
      call <SID>X("javaScriptLabel", s:blue, "", "")
      call <SID>X("javaScriptSpecial", s:blue, "", "")
      call <SID>X("javaScriptExceptions", s:red, "", "")
      call <SID>X("javaScriptDeprecated", s:red, "", "")
      call <SID>X("javaScriptError", s:red, "", "")

      " LaTeX
      call <SID>X("texStatement",s:blue, "", "")
      call <SID>X("texMath", s:wine, "", "NONE")
      call <SID>X("texMathMacher", s:yellow, "", "NONE")
      call <SID>X("texRefLabel", s:wine, "", "NONE")
      call <SID>X("texRefZone", s:blue, "", "NONE")
      call <SID>X("texComment", s:comment, "", "NONE")
      call <SID>X("texDelimiter", s:purple, "", "NONE")
      call <SID>X("texMathZoneX", s:purple, "", "NONE")

      " CoffeeScript Highlighting
      call <SID>X("coffeeRepeat", s:wine, "", "")
      call <SID>X("coffeeConditional", s:wine, "", "")
      call <SID>X("coffeeKeyword", s:wine, "", "")
      call <SID>X("coffeeObject", s:yellow, "", "")

      " HTML Highlighting
      call <SID>X("htmlTag", s:blue, "", "")
      call <SID>X("htmlEndTag", s:blue, "", "")
      call <SID>X("htmlTagName", s:wine, "", "bold")
      call <SID>X("htmlArg", s:green, "", italic)
      call <SID>X("htmlScriptTag", s:wine, "", "")

      " Diff Highlighting
      call <SID>X("diffAdd", "", "4c4e39", "")
      call <SID>X("diffDelete", bg, s:red, "")
      call <SID>X("diffChange", "", "2B5B77", "")
      call <SID>X("diffText", s:dim_fg, s:blue, "")

      " ShowMarks Highlighting
      call <SID>X("ShowMarksHLl", s:orange, bg, "NONE")
      call <SID>X("ShowMarksHLo", s:wine, bg, "NONE")
      call <SID>X("ShowMarksHLu", s:yellow, bg, "NONE")
      call <SID>X("ShowMarksHLm", s:wine, bg, "NONE")

      " Lua Highlighting
      call <SID>X("luaStatement", s:wine, "", "")
      call <SID>X("luaRepeat", s:wine, "", "")
      call <SID>X("luaCondStart", s:wine, "", "")
      call <SID>X("luaCondElseif", s:wine, "", "")
      call <SID>X("luaCond", s:wine, "", "")
      call <SID>X("luaCondEnd", s:wine, "", "")

      " Cucumber Highlighting
      call <SID>X("cucumberGiven", s:blue, "", "")
      call <SID>X("cucumberGivenAnd", s:blue, "", "")

      " Go Highlighting
      call <SID>X("goDirective", s:wine, "", "")
      call <SID>X("goDeclaration", s:wine, "", "")
      call <SID>X("goStatement", s:wine, "", "")
      call <SID>X("goConditional", s:wine, "", "")
      call <SID>X("goConstants", s:orange, "", "")
      call <SID>X("goTodo", s:red, "", "")
      call <SID>X("goDeclType", s:blue, "", "")
      call <SID>X("goBuiltins", s:wine, "", "")
      call <SID>X("goRepeat", s:wine, "", "")
      call <SID>X("goLabel", s:wine, "", "")

      " Clojure Highlighting
      call <SID>X("clojureConstant", s:orange, "", "")
      call <SID>X("clojureBoolean", s:orange, "", "")
      call <SID>X("clojureCharacter", s:orange, "", "")
      call <SID>X("clojureKeyword", s:green, "", "")
      call <SID>X("clojureNumber", s:orange, "", "")
      call <SID>X("clojureString", s:green, "", "")
      call <SID>X("clojureRegexp", s:green, "", "")
      call <SID>X("clojureParen", s:wine, "", "")
      call <SID>X("clojureVariable", s:yellow, "", "")
      call <SID>X("clojureCond", s:blue, "", "")
      call <SID>X("clojureDefine", s:wine, "", "")
      call <SID>X("clojureException", s:red, "", "")
      call <SID>X("clojureFunc", s:blue, "", "")
      call <SID>X("clojureMacro", s:blue, "", "")
      call <SID>X("clojureRepeat", s:blue, "", "")
      call <SID>X("clojureSpecial", s:wine, "", "")
      call <SID>X("clojureQuote", s:blue, "", "")
      call <SID>X("clojureUnquote", s:blue, "", "")
      call <SID>X("clojureMeta", s:blue, "", "")
      call <SID>X("clojureDeref", s:blue, "", "")
      call <SID>X("clojureAnonArg", s:blue, "", "")
      call <SID>X("clojureRepeat", s:blue, "", "")
      call <SID>X("clojureDispatch", s:blue, "", "")

      " Scala Highlighting
      call <SID>X("scalaKeyword", s:wine, "", "")
      call <SID>X("scalaKeywordModifier", s:wine, "", "")
      call <SID>X("scalaOperator", s:blue, "", "")
      call <SID>X("scalaPackage", s:wine, "", "")
      call <SID>X("scalaFqn", s:fg, "", "")
      call <SID>X("scalaFqnSet", s:fg, "", "")
      call <SID>X("scalaImport", s:wine, "", "")
      call <SID>X("scalaBoolean", s:orange, "", "")
      call <SID>X("scalaDef", s:wine, "", "")
      call <SID>X("scalaVal", s:wine, "", "")
      call <SID>X("scalaVar", s:wine, "", "")
      call <SID>X("scalaClass", s:wine, "", "")
      call <SID>X("scalaObject", s:wine, "", "")
      call <SID>X("scalaTrait", s:wine, "", "")
      call <SID>X("scalaDefName", s:blue, "", "")
      call <SID>X("scalaValName", s:fg, "", "")
      call <SID>X("scalaVarName", s:fg, "", "")
      call <SID>X("scalaClassName", s:fg, "", "")
      call <SID>X("scalaType", s:yellow, "", "")
      call <SID>X("scalaTypeSpecializer", s:yellow, "", "")
      call <SID>X("scalaAnnotation", s:orange, "", "")
      call <SID>X("scalaNumber", s:orange, "", "")
      call <SID>X("scalaDefSpecializer", s:yellow, "", "")
      call <SID>X("scalaClassSpecializer", s:yellow, "", "")
      call <SID>X("scalaBackTick", s:green, "", "")
      call <SID>X("scalaRoot", s:fg, "", "")
      call <SID>X("scalaMethodCall", s:blue, "", "")
      call <SID>X("scalaCaseType", s:yellow, "", "")
      call <SID>X("scalaLineComment", s:comment, "", "")
      call <SID>X("scalaComment", s:comment, "", "")
      call <SID>X("scalaDocComment", s:comment, "", "")
      call <SID>X("scalaDocTags", s:comment, "", "")
      call <SID>X("scalaEmptyString", s:green, "", "")
      call <SID>X("scalaMultiLineString", s:green, "", "")
      call <SID>X("scalaUnicode", s:orange, "", "")
      call <SID>X("scalaString", s:green, "", "")
      call <SID>X("scalaStringEscape", s:green, "", "")
      call <SID>X("scalaSymbol", s:orange, "", "")
      call <SID>X("scalaChar", s:orange, "", "")
      call <SID>X("scalaXml", s:green, "", "")
      call <SID>X("scalaConstructorSpecializer", s:yellow, "", "")
      call <SID>X("scalaBackTick", s:blue, "", "")

      " Git
      call <SID>X("gitFile", s:orange, "", "")
      call <SID>X("gitcommitSummary", "", "", "bold")

      " Option g:devglow_no_terminal_background
      if !exists("g:devglow_inherit_background")
        let g:devglow_inherit_background = 0
      endif

      " Background behavior inference here
      if g:devglow_inherit_background && has("gui_running")
        echohl WarningMsg | echom "Inherit background is ignored in GUI." | echohl NONE
        let g:devglow_inherit_background = 0
      endif

      call <SID>X("Normal", s:fg, bg, "")
      call <SID>X("LineNr", s:comment, bg, "")

      if version >= 700
        call <SID>X("SignColumn", "", bg, "NONE")
        end
        call <SID>X("Todo", s:red, bg, "bold")

        " Diffs
        " Plugin GitGutter uses highlight link to some of the groups below
        call <SID>X("DiffAdded", s:green, bg, "")
        call <SID>X("DiffChange", s:yellow, bg, "")
        call <SID>X("DiffDelete", s:red, bg, "")
        call <SID>X("DiffLine", s:blue, bg, italic)
        call <SID>X("DiffSubname", s:fg, bg, "")
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
        call <SID>X("ALEWarningSign", s:orange, bg, "bold")
        call <SID>X("ALEErrorSign", s:red, bg, "bold")

        " Diagnostic 
        call <SID>X("DiagnosticError", s:error, "", "bold")
        call <SID>X("DiagnosticWarn", s:warn, "", "bold")
        call <SID>X("DiagnosticInfo", s:info, "", "bold")
        call <SID>X("DiagnosticHint", s:blue, "", "bold")

        " Nvim tree 
        call <SID>X("NvimTreeNormal", s:dim_fg, bg, "")
        call <SID>X("NvimTreeRootFolder", s:red, "", "")
        call <SID>X("NvimTreeFolderName", s:dim_yellow, "", "bold")
        call <SID>X("NvimTreeExecFile", s:red, "", "bold")
        call <SID>X("NvimTreeOpenedFile", s:fg, "", "")
        call <SID>X("NvimTreeWindowPicker", s:dim_fg, s:dark0, "bold")

        hi! link NvimTreeFolderIcon Directory
        hi! link NvimTreeEmptyFolderName  NvimTreeFolderName
        hi! link NvimTreeOpenedFolderName NvimTreeFolderName

        " Delete Functions
        delf <SID>X
        delf <SID>rgb
        delf <SID>colour
        delf <SID>rgb_colour
        delf <SID>rgb_level
        delf <SID>rgb_number
        delf <SID>grey_colour
        delf <SID>grey_level
        delf <SID>grey_number
      endif
