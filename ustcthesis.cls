%
%   University of Science and Technology of China
%   Thesis Template for bachelor, master and doctor
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ustcthesis}
    [2015/06/28 Thesis Template for University of Science and Technology of China]

\RequirePackage{kvoptions}
\RequirePackage{xparse}
\SetupKeyvalOptions{family=USTC, prefix=USTC@opt@, setkeys=\kvsetkeys}
\DeclareBoolOption[false]{doctor}
\DeclareBoolOption[false]{master}
\DeclareBoolOption[false]{bachelor}
\DeclareBoolOption[true]{twoside}   % 默认双页打印
\DeclareComplementaryOption{oneside}{twoside}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*\relax

\ifUSTC@opt@twoside
    \PassOptionsToClass{twoside}{ctexbook}
\else
    \PassOptionsToClass{oneside}{ctexbook}
\fi


\LoadClass[a4paper, UTF8, zihao=-4]{ctexbook}[2015/06/19]
% 英文字体
\setmainfont{Times New Roman}
\setsansfont[Scale=MatchLowercase]{Arial}
\IfFileExists{/System/Library/Fonts/Monaco.dfont}{
    \setmonofont[Scale=MatchLowercase]{Monaco}}{
    \setmonofont[Scale=MatchLowercase]{Courier New}}

\RequirePackage[
    left=3.17cm, right=3.17cm,
    top=2.54cm, bottom=2.54cm,
    headsep=0.74cm,
    headheight=0.5cm,
    footskip=0.79cm,
%   showframe=true,
]{geometry}

% 超链接与书签
\RequirePackage[
    CJKbookmarks=true,
    colorlinks,
    linkcolor=blue,
    citecolor=blue,
    bookmarksnumbered=true,
    bookmarksopen=true,
]{hyperref}
\AtBeginDocument{
    \hypersetup{
        pdftitle={\ustc@title},
        pdfauthor={\ustc@author}
    }
}

% useful definitions
\def\ustc@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{
        \expandafter\gdef\csname ustc@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}
\newcommand\ustc@underline[2][6em]{
    \hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt
}
% 定义了直接调用磅数设置字体大小的命令，用法为
% 1. \setfontsize{15bp} 设置字号15磅，默认单倍行距
% 2. \setfontsize{15bp}[30bp] 设置字号15磅，行距30磅
\DeclareDocumentCommand \setfontsize { m o } {
    \IfValueTF {#2}
        { \fontsize{#1}{#2}\linespread{1} }
        { \fontsize{#1}{1.2 \dimexpr#1} }
    \selectfont}
\newenvironment{cnabstract}{\chapter{摘\quad 要}}{}
\newenvironment{enabstract}{\chapter{Abstract}}{}
\newcommand\keywords[1]{\vspace{3.5ex}\noindent{\textbf{关键词：} #1}}
\newcommand\enkeywords[1]{\vspace{3.5ex}\noindent{\textbf{Key Words：} #1}}
\ustc@define@term{title}
\ustc@define@term{secrettext}
\ustc@define@term{author}
\ustc@define@term{depart}
\ustc@define@term{major}
\ustc@define@term{advisor}
\ustc@define@term{coadvisor}
\ustc@define@term{studentid}
\ustc@define@term{submitdate}
\ustc@define@term{entitle}
\ustc@define@term{ensecrettext}
\ustc@define@term{enauthor}
\ustc@define@term{enmajor}
\ustc@define@term{enadvisor}
\ustc@define@term{encoadvisor}
\ustc@define@term{ensubmitdate}

% 仅供测试使用
%\RequirePackage{pagegrid}
%\pagegridsetup{enable, tl, step=1cm, double}

% 封面
\input{ustcthesis-statement.def}
\renewcommand\maketitle{
    \pagestyle{empty}
    \make@cntitle
    \cleardoublepage
    \make@entitle
    \cleardoublepage
    \ifUSTC@opt@bachelor\relax\else
        \make@statement \cleardoublepage
    \fi
}

\RequirePackage{setspace}
% 标题设置
\ctexset{
    % chapter
    chapter/format += \bfseries\linespread{1}\selectfont\zihao{3},
    chapter/nameformat = {},   % 由于nameformat和titleformat的bug，这两行必须
    chapter/titleformat = {},
    chapter/number = \arabic{chapter},
    chapter/beforeskip = 24bp,
    chapter/afterskip = 18bp,
    % section
    section/format += \bfseries\raggedright\linespread{1}\selectfont\zihao{4},
    section/beforeskip = 24bp,
    section/afterskip = 6bp,
    % subsection
    subsection/format+= \bfseries\raggedright\linespread{1}\selectfont
                        \fontsize{13bp}{\baselineskip}\selectfont,
    subsection/beforeskip = 12bp,
    subsection/afterskip = 6bp,
    % subsubsection
    subsubsection/format+= \bfseries\raggedright\linespread{1}\selectfont\zihao{-4},
    subsubsection/beforeskip = 12bp,
    subsubsection/afterskip = 6bp,
}
\setcounter{secnumdepth}{3}  % subsubsection numbering
% 汉化
\ctexset{
    contentsname = {目\quad 录},
}

% 段落设置
\setlength{\parskip}{0bp}           % 段前段后间距0磅
\setlength{\baselineskip}{20bp}     % 行间距20磅

% 图表标题
\RequirePackage[format=hang, labelsep=quad,
    labelfont={small,bf}, textfont=small]{caption}
\captionsetup[figure]{position = bottom, aboveskip = 6bp, belowskip = 12bp}
\captionsetup[table]{position = top, aboveskip = 6bp, belowskip = 6bp}

% 目录
\RequirePackage{titletoc}
\setcounter{tocdepth}{3}
\titlecontents{chapter}[0em]
    {\vspace{6bp}\zihao{4}}{\thecontentslabel\hspace*{0.5em}}
    {}{\titlerule*[0.5pc]{$\cdot$}\contentspage}
\titlecontents{section}[\ccwd]
    {\vspace{1bp}\zihao{-4}}{\thecontentslabel\hspace*{0.5em}}
    {}{\titlerule*[0.5pc]{$\cdot$}\contentspage}
\titlecontents{subsection}[2\ccwd]
    {\vspace{1bp}\zihao{5}}{\thecontentslabel\hspace*{0.5em}}
    {}{\titlerule*[0.5pc]{$\cdot$}\contentspage}
\titlecontents{figure}[\ccwd]
    {\zihao{-4}}{\thecontentslabel\hspace*{0.5em}}
    {}{\titlerule*[0.5pc]{$\cdot$}\contentspage}
\titlecontents{table}[\ccwd]
    {\zihao{-4}}{\thecontentslabel\hspace*{0.5em}}
    {}{\titlerule*[0.5pc]{$\cdot$}\contentspage}

% 页眉页脚
\RequirePackage{titleps}
\ifUSTC@opt@bachelor
    \input{ustcthesis-bachelor.def}
\else
    \input{ustcthesis-doctor.def}
\fi

% 中文封面
% 封面为了排版``距离顶边xx厘米''，使用了tabular嵌套parbox的方法。使用vpace会有额外空隙，叠parbox也不行。
% 这里没有严格按照《规范》的格式范例的尺寸，其中``学位论文''向上调整了0.7cm，
% 论文标题和作者姓名部分分别在parbox内部进行了垂直居中处理。两个eps图片为手工测量所得。
\newcommand\make@cntitle{
    \newgeometry{
        top=3.8cm, bottom=3.8cm,
        left=3.2cm, right=3.2cm,
        headheight=0cm, headsep=0.8cm,
        footskip=0.8cm
    }
    \begin{titlepage}
    \pdfbookmark[-1]{\ustc@title}{title}
    \begin{center}
    \renewcommand{\arraystretch}{0}
    \begin{tabular}{@{}c@{}}
        \\[0.2cm]
        \parbox[t][1.2cm][t]{\textwidth}{\raggedleft\fangsong\setfontsize{14bp}\ustc@secrettext} \\
        \parbox[t][2.7cm][t]{\textwidth}{\centering\includegraphics[width=11cm]{ustc_logo_text.eps}} \\
        \parbox[t][3cm][t]{\textwidth}{\centering\bfseries\setfontsize{56bp}
            \ifUSTC@opt@doctor 博士学位论文 \fi
            \ifUSTC@opt@master 硕士学位论文 \fi
            \ifUSTC@opt@bachelor 学士学位论文 \fi} \\
        \includegraphics[height=4.9cm]{ustc_logo_fig.eps} \\
        \parbox[t][4.7cm][c]{\textwidth}{\centering\bfseries\setfontsize{26bp}\ustc@title} \\
        \parbox[t][4.2cm][c]{\textwidth}{\setfontsize{16bp}
            \hspace*{2.8cm}{\bfseries 作者姓名：}\hfill \ustc@author \hfill\mbox{} \\
            \hspace*{2.8cm}{\bfseries 学科专业：}\hfill \ustc@major \hfill\mbox{} \\
            \hspace*{2.8cm}{\bfseries 导师姓名：}\hfill \ustc@advisor \hfill\mbox{} \\
            \hspace*{2.8cm}{\bfseries 完成时间：}\hfill \ustc@submitdate \hfill\mbox{}}
    \end{tabular}
    \end{center}
    \end{titlepage}
    \restoregeometry
}

% 英文封面
% Supervisor 一栏放不下两个英文名称
\newcommand\make@entitle{
    \newgeometry{
        top=3.8cm, bottom=3.8cm,
        left=3.2cm, right=3.2cm,
        headheight=0cm, headsep=1cm,
        footskip=0.8cm
    }
    \begin{titlepage}
    \begin{center}
    \renewcommand{\arraystretch}{0}
    \begin{tabular}{@{}c@{}}
        \\[0.2cm]
        \parbox[t][1cm][t]{\textwidth}{\raggedleft\setfontsize{14bp}\ustc@ensecrettext} \\
        \parbox[t][1cm][t]{\textwidth}{\centering\sffamily\setfontsize{20bp}[30bp]
            University of Science and Technology of China} \\
        \parbox[t][2.2cm][t]{\textwidth}{\centering\bfseries\setfontsize{26bp}[30bp]
            \ifUSTC@opt@doctor A dissertation for doctor's degree \fi
            \ifUSTC@opt@master A dissertation for master's degree \fi
            \ifUSTC@opt@bachelor A dissertation for bachelor's degree \fi} \\
        \includegraphics[height=4.9cm]{ustc_logo_fig.eps} \\
        \\[2.9cm]
        \parbox[t][4.7cm][t]{\textwidth}{\centering\bfseries\setfontsize{26bp}[30bp]\ustc@entitle} \\
        \parbox[t][4cm][c]{\textwidth}{\setfontsize{16bp}[30bp]
            \hspace*{2.8cm} Author: \hspace{1.6cm}\hfill \ustc@enauthor \hfill\mbox{} \\
            \hspace*{2.8cm} Speciality: \hspace{0.8cm}\hfill \ustc@enmajor \hfill\mbox{} \\
            \hspace*{2.8cm} Supervisor: \hspace{0.8cm}\hfill \ustc@enadvisor \hfill\mbox{} \\
            \hspace*{2.8cm} Finished Time: \hfill \ustc@ensubmitdate \hfill\mbox{}}
    \end{tabular}
    \end{center}
    \end{titlepage}
    \restoregeometry
}

\endinput