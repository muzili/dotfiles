-- LaTeX Snippets
-- TODO: set options for matrix and table snippets (either auto generate or user input)
-- TODO: fix env function; make it for tikz
local postfix = require("luasnip.extras.postfix").postfix


-- env stuff
local function math()
    -- global p! functions from UltiSnips
    return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

--[[ local function env(name) ]]
--[[     if vim.api.nvim_eval("vimtex#env#is_inside('tikzpicture')") ~= nil then ]]
--[[         return 1 ]]
--[[     end ]]
--[[     return 0 ]]
--[[ end ]]
--[[]]
--[[ local function tikz() ]]
--[[     return env("tikzpicture") ]]
--[[ end ]]

-- test
local function env(name) 
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local function tikz()
    return env("tikzpicture")
end

local function bp()
    return env("itemize") or env("enumerate")
end


-- table of greek symbols 
griss = {
    alpha = "alpha", beta = "beta", delta = "delta", gam = "gamma", eps = "epsilon",
    mu = "mu", lmbd = "lambda", sig = "sigma"
}

-- brackets
brackets = {
    a = {"<", ">"}, b = {"[", "]"}, c = {"{", "}"}, m = {"|", "|"}, p = {"(", ")"}
}

-- LFG tables and matrices work
local tab = function(args, snip)
	local rows = tonumber(snip.captures[1])
    local cols = tonumber(snip.captures[2])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
        if j == 1 then
            table.insert(nodes, t{"\\midrule", ""})
        end
	end
    return sn(nil, nodes)
end

-- yes this is a ripoff
local mat = function(args, snip)
	local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j).."x1", i(1)))
		ins_indx = ins_indx+1
		for k = 2, cols do
			table.insert(nodes, t" & ")
			table.insert(nodes, r(ins_indx, tostring(j).."x"..tostring(k), i(1)))
			ins_indx = ins_indx+1
		end
		table.insert(nodes, t{"\\\\", ""})
	end
	-- fix last node.
	-- nodes[#nodes] = t""
	return sn(nil, nodes)
end

-- TODO: itemize/enumerate
--[[ rec_ls = function() ]]
--[[ 	return sn(nil, { ]]
--[[ 		c(1, { ]]
--[[ 			-- important!! Having the sn(...) as the first choice will cause infinite recursion. ]]
--[[ 			t({""}), ]]
--[[ 			-- The same dynamicNode as in the snippet (also note: self reference). ]]
--[[ 			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}), ]]
--[[ 		}), ]]
--[[ 	}); ]]
--[[ end ]]
--[[]]

-- snippets go here

return {
    -- templates
    s({ trig='elegantbook', name='elegant book', dscr='tex template for ctexbook'},
    fmt([[
      \documentclass[lang=cn,10pt,newtx]{elegantbook}

      \title{<>}
      \subtitle{<>}

      \author{Zhiguang Li}
      \institute{Viitrix}
      \date{Aug 15, 2022}
      \version{4.4}
      %\bioinfo{自定义}{信息}

      \extrainfo{要让一群人团结起来，需要的不是英明的领导，而是共同的敌人。—— 比企谷八幡}

      \setcounter{tocdepth}{3}

      %\logo{logo-blue.png}
      %\cover{cover.jpg}

      % 本文档命令
      \usepackage{array}
      \newcommand{\ccr}[1]{\makecell{{\color{#1}\rule{1cm}{1cm}}}}

      % 修改标题页的橙色带
      \definecolor{customcolor}{RGB}{32,178,170}
      \colorlet{coverlinecolor}{customcolor}
      \usepackage{cprotect}

      % \addbibresource[location=local]{reference.bib} % 参考文献，不要删除

      \begin{document}

      \maketitle
      \frontmatter

      \tableofcontents

      \mainmatter

      \chapter{<>}

      \section{<>}

    \end{document}
    ]],
    { i(1, "Title"), i(2, "Subtitle"), i(3, "Chapter"), i(4, "Section")},
    { delimiters='<>' }
    )),
    s({ trig='elegantnote', name='elegant note', dscr='tex template for ctexnote'},
    fmt([[
    %!TEX program = xelatex
    \documentclass[cn,hazy,blue,14pt,screen]{elegantnote}
    \title{<>}

    \author{Zhiguang Li}
    \institute{Viitrix}

    \version{2.40}
    \date{\zhtoday}

    \usepackage{array}

    % graphics path
    \graphicspath{
      {./figure/}
      {./figures/}
      {./image/}
      {./images/}
      {./graphics/}
      {./graphic/}
      {./pictures/}
      {./picture/}
    }

    \begin{document}

    \maketitle

    \centerline{
      \includegraphics[width=0.2\textwidth]{logo-blue.png}
    }

    \tableofcontents

    \section{<>}

    \end{document}
    ]],
    { i(1, "Title"), i(2, "Section")},
    { delimiters='<>' }
    )),
    s({ trig='texdoc', name='new tex doc', dscr='Create a general new tex document'},
    fmt([[
    \documentclass{article}
    \usepackage{iftex}
    \ifluatex
    \directlua0{
    pdf.setinfo (
        table.concat (
        {
           "/Title (<>)",
           "/Author (Evelyn Koo)",
           "/Subject (<>)",
           "/Keywords (<>)"
        }, " "
        )
    )
    }
    \fi
    \usepackage{graphicx}
    \graphicspath{{figures/}}
    \usepackage[lecture]{random}
    \pagestyle{fancy}
    \fancyhf{}
    \rhead{\textsc{Evelyn Koo}}
    \chead{\textsc{<>}}
    \lhead{<>}
    \cfoot{\thepage}
    \begin{document}
    \title{<>}
    \author{Evelyn Koo}
    \date{<>}
    \maketitle
    \tableofcontents
    \section*{<>}
    \addcontentsline{toc}{section}{<>}
    <>
    \subsection*{Remarks}
    <>
    \end{document}
    ]],
    { i(3), i(2), i(7), i(1), rep(2), rep(3), i(4), i(5), rep(5), i(6), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='hwtex', name='texdoc for hw', dscr='tex template for my homeworks'},
    fmt([[ 
    \documentclass{article}
    \usepackage{iftex}
    \ifluatex
    \directlua0{
    pdf.setinfo (
        table.concat (
        {
           "/Title (<> <>)",
           "/Author (Evelyn Koo)",
           "/Subject (<>)",
           "/Keywords (<>)"
        }, " "
        )
    )
    }
    \fi
    \usepackage{graphicx}
    \graphicspath{{figures/}}
    \usepackage[lecture]{random}
    \pagestyle{fancy}
    \fancyhf{}
    \rhead{\textsc{Evelyn Koo}}
    \chead{\textsc{Homework <>}}
    \lhead{<>}
    \cfoot{\thepage}
    \begin{document}
    \homework[<>]{<>}{<>}
    <>
    \end{document}
    ]],
    { t("Homework"), i(1), i(2), i(3), rep(1), rep(2), t(os.date("%d-%m-%Y")), rep(2), rep(1), i(0) },
    { delimiters='<>' }
    )),
    -- semantic snippets from markdown
    -- sections
    s({trig="#", hidden=true},
    fmt([[
    \section{<>}
    <>]],
    { i(1), i(0) },
    { delimiters="<>" }
    )),
    s({trig="#*", hidden=true},
    fmt([[
    \section*{<>}
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({trig="#2", hidden=true},
    fmt([[
    \subsection{<>}
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({trig="#2*", hidden=true},
    fmt([[
    \subsection*{<>}
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({trig="#3", hidden=true},
    fmt([[ 
    \subsubsection{<>}
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({trig="#3*", hidden=true},
    fmt([[ 
    \subsubsection*{<>}
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    -- special sections 
    s({ trig='#l', name='lecture', dscr='fancy section header - lecture #'},
    fmt([[ 
    \lecture[<>]{<>}
    <>]],
    { t(os.date("%d-%m-%Y")), i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='#ch', name='chap', dscr='fancy section header - chapter #'},
    fmt([[ 
    \bookchap[<>]{<>}{<>}
    <>]],
    { t(os.date("%d-%m-%Y")), i(1, "dscr"), i(2, "\\thesection"), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='#f', name='fancy section', dscr='fancy section header - vanilla'},
    fmt([[ 
    \fancysec[<>}{<>}{<>}
    <>]],
    { t(os.date('%d-%m-%Y')), i(1, "dscr"), i(2, "title"), i(0) },
    { delimiters='<>' }
    )),
    -- links images figures
    s({trig="!l", name="link", dscr="Link reference", hidden=true},
    fmt([[\href{<>}{\color{<>}<>}<>]],
    { i(1, "link"), i(3, "blue"), i(2, "title"), i(0) },
    { delimiters='<>' }
    )),
    s({trig="!i", name="image", dscr="Image (no caption, no float)"},
    fmt([[ 
    \begin{center}
    \includegraphics[width=<>\textwidth]{<>}
    \end{center}
    <>]],
    { i(1, "0.5"), i(2), i(0) },
    { delimiters='<>' }
    )),
    s({trig="!f", name="figure", dscr="Float Figure"},
    fmt([[ 
    \begin{figure}[<>] 
    <>
    \end{figure}]],
    { i(1, "htb!"), i(0) },
    { delimiters='<>' }
    )),
    s({trig="gr", name="figure image", dscr="float image"},
    fmt([[
    \centering
    \includegraphics[width=<>\textwidth]{<>}\caption{<>}<>]],
    { i(1, "0.5"), i(2), i(3), i(0) },
    { delimiters='<>' }
    )),
    -- code
    s({ trig='qw', name='inline code', dscr='inline code'},
    fmt([[\mintinline{<>}{<>}<>]],
    { i(1, "text"), i(2), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='qe', name='code', dscr='Code with minted.'},
    fmt([[ 
    \begin{minted}{<>}
    <>
    \end{minted}
    <>]],
    { i(1, "python"), i(2), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='mp', name='minipage', dscr='create minipage env'}, -- choice node
    fmt([[
    \begin{minipage}{<>\textwidth}
    <>
    \end{minipage}]],
    { c(1, {t("0.5"), t("0.33"), i(nil)}), i(0) },
    { delimiters='<>' }
    )),
    -- quotes
    s({ trig='sq', name='single quotes', dscr='single quotes', hidden=true},
    fmt([[`<>'<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='qq', name='double quotes', dscr='double quotes', hidden=true},
    fmt([[``<>''<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    -- text changes
    s({ trig='bf', name='bold', dscr='bold text', hidden=true},
    fmt([[\textbf{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='it', name='italic', dscr='italic text', hidden=true},
    fmt([[\textit{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='tu', name='underline', dscr='underline text', hidden=true},
    fmt([[\underline{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='sc', name='small caps', dscr='small caps text', hidden=true},
    fmt([[\textsc{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='tov', name='overline', dscr='overline text'},
    fmt([[\overline{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    -- environments
    s({trig="beg", name="begin env", dscr="begin/end environment"},
    fmt([[
    \begin{<>}
    <>
    \end{<>}]],
    { i(1), i(0), rep(1) },
    { delimiters="<>" }
    )),
    s({ trig='-i', name='itemize', dscr='bullet points (itemize)'},
    fmt([[ 
    \begin{itemize}
    \item <>
    \end{itemize}]],
    { i(1) },
    { delimiters='<>' }
    )),
    s({ trig='-e', name='enumerate', dscr='numbered list (enumerate)'},
    fmt([[ 
    \begin{enumerate}
    \item <>
    \end{enumerate}]],
    { i(1) },
    { delimiters='<>' }
    )),
    -- item but i cant get this to work
    s({trig="-", hidden=true}, {t('\\item')},
    { condition=bp, show_condition=bp }),
    s({ trig='adef', name='add definition', dscr='add definition box'},
    fmt([[ 
    \begin{definition}[<>]{<>
    }
    \end{definition}]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='aex', name='add example', dscr='add example box'},
    fmt([[ 
    \begin{example}[<>]{<>
    }
    \end{example}]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='athm', name='add theorem', dscr='add theorem box'},
    fmt([[ 
    \begin{theorem}[<>]{<>
    }
    \end{theorem}]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='nb', name='notebox', dscr='add notebox idk why this format is diff'},
    fmt([[ 
    \begin{notebox}[<>]
    <>
    \end{notebox}]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='sol', name='solution', dscr='solution box for homework'},
    fmt([[ 
    \begin{solution}
    <>
    \end{solution}]],
    { i(0) },
    { delimiters='<>' }
    )),
    s({ trig='tab(%d+)x(%d+)', regTrig=true, name='test for tabular', dscr='test'},
    fmt([[
    \begin{tabular}{@{}<>@{}}
    \toprule
    <>
    \bottomrule
    \end{tabular}]],
    { f(function(_, snip)
        return string.rep("c", tonumber(snip.captures[2]))
    end), d(1, tab) },
    { delimiters='<>' }
    )),
    s({ trig='([bBpvV])mat(%d+)x(%d+)([ar])', regTrig=true, name='matrix', dscr='matrix trigger lets go'},
    fmt([[
    \begin{<>}<>
    <>
    \end{<>}]],
    { f(function (_, snip) return snip.captures[1] .. "matrix" end),
    f(function (_, snip)
        if snip.captures[4] == "a" then
            out = string.rep("c", tonumber(snip.captures[3]) - 1)
            return "[" .. out .. "|c]"
        end
        return ""
    end),
    d(1, mat),
    f(function (_, snip) return snip.captures[1] .. "matrix" end)},
    { delimiters='<>' }
    )),
    -- parentheses
    s({ trig='lr', name='left right', dscr='left right'},
    fmt([[\left(<>\right)<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    ), { condition=math }),
    s({ trig='lrv', name='left right', dscr='left right'},
    fmt([[\left(<>\right)<>]],
    { f(function(args, snip)
      local res, env = {}, snip.env
      for _, val in ipairs(env.LS_SELECT_RAW) do table.insert(res, val) end
      return res
      end, {}), i(0) },
    { delimiters='<>' }
    ), { condition=math, show_condition=math }),
    s('tikztest', {t('this works only in tikz')},
    { condition=tikz, show_condition=tikz}),
    
}, {
    -- math mode
    s({ trig='mk', name='math', dscr='inline math'},
    fmt([[$<>$<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='dm', name='math', dscr='display math'},
    fmt([[ 
    \[ 
    <>
    .\]
    <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='ali', name='align', dscr='align math'},
    fmt([[ 
    \begin{align<>}
    <>
    .\end{align<>}
    <>]],
    { i(1, "*"), i(2), rep(1), i(0) },
    { delimiters='<>' }
    )),
    s({ trig='gat', name='gather', dscr='gather math'},
    fmt([[ 
    \begin{gather<>}
    <>
    .\end{gather<>}
    <>]],
    { i(1, "*"), i(2), rep(1), i(0) },
    { delimiters='<>' }
    )),
    -- operators, symbols
    s({trig='**', priority=100}, {t('\\cdot')},
    { condition=math }),
    s('xx', {t('\\times')},
    { condition=math }),
    s({ trig='//', name='fraction', dscr='fraction (autoexpand)'},
    fmt([[\frac{<>}{<>}<>]],
    { i(1), i(2), i(0) },
    { delimiters='<>' }),
    { condition=math }),
    s('==', {t('&='), i(1), t("\\\\")},
    { condition=math }),
    s('!=', {t('\\neq')},
    { condition=math }),
    s({ trig='conj', name='conjugate', dscr='conjugate would have been useful in eecs 126'},
    fmt([[\overline{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' },
    { condition=math })),
    s('<=', {t('\\leq')},
    { condition=math }),
    s('>=', {t('\\geq')},
    { condition=math }),
    s('>>', {t('\\gg')},
    { condition=math }),
    s('<<', {t('\\ll')},
    { condition=math }),
    s('~~', {t('\\sim')},
    { condition=math }),
    -- sub super scripts
    s({ trig='(%a)(%d)', regTrig=true, name='auto subscript', dscr='hi'},
    fmt([[<>_<>]],
    { f(function(_, snip) return snip.captures[1] end),
    f(function(_, snip) return snip.captures[2] end) },
    { delimiters='<>' }),
    { condition=math }),
    s({ trig='(%a)_(%d%d)', regTrig=true, name='auto subscript 2', dscr='auto subscript for 2+ digits'},
    fmt([[<>_{<>}]],
    { f(function(_, snip) return snip.captures[1] end),
    f(function(_, snip) return snip.captures[2] end)},
    { delimiters='<>' }),
    { condition=math }),
    s('xnn', {t('x_n')},
    { condition=math }),
    s('xii', {t('x_i')},
    { condition=math }),
    s('xjj', {t('x_j')},
    { condition=math}),
    s('ynn', {t('y_n')},
    { condition=math }),
    s('yii', {t('y_i')},
    { condition=math }),
    s('yjj', {t('y_j')},
    { condition=math }),
    s({trig='sr', wordTrig=false}, {t('^2')},
    { condition=math }),
    s({trig='cb', wordTrig=false}, {t('^3')},
    { condition=math }),
    s({trig='compl', wordTrig=false}, {t('^{c}')},
    { condition=math }),
    s({trig='vtr', wordTrig=false}, {t('^{T}')},
    { condition=math }),
    s({trig="inv", wordTrig=false}, {t('^{-1}')},
    { condition=math }),
    s({ trig='td', name='superscript', dscr='superscript', wordTrig=false},
    fmt([[^{<>}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    ), { condition=math }),
    s({ trig='sq', name='square root', dscr='square root'},
    fmt([[\sqrt{<>}]],
    { i(1) },
    { delimiters='<>' }
    ), { condition=math }),
    -- hats and bars (postfixes) 
    postfix("bar", {l("\\bar{" .. l.POSTFIX_MATCH .. "}")}, { condition=math }),
    postfix("hat", {l("\\hat{" .. l.POSTFIX_MATCH .. "}")}, { condition=math }),
    postfix(",.", {l("\\vec{" .. l.POSTFIX_MATCH .. "}")}, { condition=math }),
    postfix("vr", {l("$" .. l.POSTFIX_MATCH .. "$")}),
    postfix("mbb", {l("\\mathbb{" .. l.POSTFIX_MATCH .. "}")}, { condition=math }),
    postfix("vc", {l("\\mintinline{text}{" .. l.POSTFIX_MATCH .. "}")}),
    -- etc
    s({ trig='([clvd])%.', regTrig=true, name='dots', dscr='generate some dots'},
    fmt([[\<>dots]],
    { f(function(_, snip) 
      return snip.captures[1]
      end)},
    { delimiters='<>' }),
    { condition=math }),
    s({ trig='bnc', name='binomial', dscr='binomial (nCR)'},
    fmt([[\binom{<>}{<>}<>]],
    { i(1), i(2), i(0) },
    { delimiters='<>' }),
    { condition=math }),
    -- a living nightmare worth of greek symbols
    -- TODO: replace with regex
    s({ trig='(alpha|beta|delta)', regTrig=true,
    name='griss symbol', dscr='greek letters hi'},
    fmt([[\<>]],
    { f(function(_, snip)
        return griss[snip.captures[1]]
    end) },
    { delimiters='<>' }),
    { condition=math }),
    s("alpha", {t("\\alpha")},
    {condition = math}),
    s('beta', {t('\\beta')},
    { condition=math }),
    s('delta', {t('\\delta')},
    { condition=math }),
    s('gam', {t('\\gamma')},
    { condition=math }),
    s('eps', {t('\\epsilon')},
    { condition=math }),
    s('lmbd', {t('\\lambda')},
    { condition=math }),
    s('mu', {t('\\mu')},
    { condition=math }),
    -- stuff i need for m110
    s({ trig='set', name='set', dscr='set'},
    fmt([[\{<>\}<>]],
    { i(1), i(0) },
    { delimiters='<>' }
    ), { condition=math }),
    s('cc', {t('\\subset')},
    { condition=math }),
    s('cq', {t('\\subseteq')},
    { condition=math }),
    s('\\\\\\', {t('\\setminus')},
    { condition=math }),
    s('Nn', {t('\\cap')},
    { condition=math }),
    s('UU', {t('\\cup')},
    { condition=math }),
    -- reals and number sets 
    s('RR', {t('\\mathbb{R}')},
    { condition=math }),
    s('CC', {t('\\mathbb{C}')},
    { condition=math }),
    s('ZZ', {t('\\mathbb{Z}')},
    { condition=math }),
    s('QQ', {t('\\mathbb{Q}')},
    { condition=math }),
    -- quantifiers and cs70 n1 stuff
    s('AA', {t('\\forall')},
    { condition=math }),
    s('EE', {t('\\exists')},
    { condition=math }),
    s('inn', {t('\\in')},
    { condition=math }),
    s('notin', {t('\\not\\in')},
    { condition=math }),
    s('ooo', {t('\\infty')},
    { condition=math }),
    -- utils
    s('||', {t('\\mid')},
    { condition=math }),
    s('lb', {t('\\\\')},
    { condition=math }),
    s('tcbl', {t('\\tcbline')},
    { condition=math }),
    s('ctd', {t('%TODO: '), i(1)}
    ),
    s('->', {t('\\to')},
    { condition=math }),
    s('<->', {t('\\leftrightarrow')},
    { condition=math }),
    s('!>', {t('\\mapsto')},
    { condition=math }),
    s({ trig='floor', name='math floor', dscr='math floor'},
    fmt([[\left\lfloor <> \right\rfloor <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    ), { condition=math }),
    s({ trig='ceil', name='math ceiling', dscr='math ceiling'},
    fmt([[\left\lceil <> \right\rfloor <>]],
    { i(1), i(0) },
    { delimiters='<>' }
    ), { condition=math }),
}
