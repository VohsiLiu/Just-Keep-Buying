\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TheLatteFactor}

\newif\if@twopages

\DeclareOption{twopages}{
  \@twopagestrue
}

\ProcessOptions\relax

% 设置纸张为A4，字号
\LoadClass[cs4size,a4paper,12pt,twoside]{ctexart}   

% 设置页边距
\usepackage[top=3.2cm, bottom=2.7cm, left=3.18cm, right=3.18cm]{geometry}

\usepackage{color}
\usepackage{xcolor}

% 设置中文支持
\usepackage[AutoFallBack=true]{xeCJK}
\setCJKmainfont[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]{FZShuSong-Z01} 
\setCJKsansfont[BoldFont={FZHei-B01}]{FZKai-Z03} 
\setCJKmonofont[BoldFont={FZHei-B01}]{FZFangSong-Z02}
\setCJKfamilyfont{zhsong}{FZShuSong-Z01}
\setCJKfamilyfont{zhhei}{FZHei-B01} 
\setCJKfamilyfont{zhkai}[BoldFont={FZHei-B01}]{FZKai-Z03} 
\setCJKfamilyfont{zhfs}[BoldFont={FZHei-B01}]{FZFangSong-Z02}
\newCJKfontfamily\xbsong{FZXiaoBiaoSong-B05S}
\newCJKfontfamily\cusong{FZCuSong-B09S}
\setCJKfallbackfamilyfont{\CJKrmdefault}{TH-Sy-P0,FZSongS--GB1-5,FZSONG_ZHSJ_02--GB1-5}

% 英文修改为Times New Roman字体
\setmainfont{Times New Roman}[SmallCapsFont=TeX Gyre Termes:+smcp]

% 设置页眉页脚
\usepackage{fancyhdr}
\usepackage{emptypage}
\fancypagestyle{tocstyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0.35pt}
    \fancyhead[C]{{\kaishu{\small{目录}}}}
    \fancyfoot[C]{\small{\thepage}}
}
\fancypagestyle{tocblankstyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
}
\fancypagestyle{docstyle}{
    \fancyhf{}
    \let\@mkboth\markboth
    \renewcommand{\headrulewidth}{0.35pt}
    \fancyhead[CO]{{\kaishu{\small{\leftmark}}}} % 奇数页页眉为当前章节标题
    \fancyhead[CE]{{\kaishu{\small{持续买入}}}} % 偶数页页眉
    \fancyfoot[C]{\small{\thepage}}
}
\renewcommand{\sectionmark}[1]{\markboth{#1}{#1}}
\fancypagestyle{appendixstyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0.35pt}
    \fancyhead[CO]{{\kaishu{\small{附录}}}}
    \fancyhead[CE]{{\kaishu{\small{持续买入}}}}
    \fancyfoot[C]{\small{\thepage}}
}
\setlength{\headheight}{15pt}

% 避免页面底部对可伸缩间距进行强制拉伸
\raggedbottom

% 设置段落缩进
\usepackage{indentfirst}
\setlength{\parindent}{2em}

% 设置行距
\usepackage{setspace}
\setstretch{1.5}
\setlength{\parskip}{0.25em}

\usepackage[stable]{footmisc}
% 正文引用链接到书末连续编号的尾注。
\newcommand{\booknoteref}[1]{\textsuperscript{\hyperlink{endnote:#1}{#1}}}
\newcommand{\bookchapter}{0}
\renewcommand{\thefigure}{\bookchapter.\arabic{figure}}
\renewcommand{\thetable}{\bookchapter.\arabic{table}}

\usepackage{hyperref}
\hypersetup{
	colorlinks=true,
	linkcolor=black,
    urlcolor=black,
    linktoc=all
}
\usepackage{etoolbox}
\pretocmd{\section}{\phantomsection}{}{}

% 设置标题格式
% 设置标题格式
\usepackage{titlesec}
\titleformat{\section}[block]{\centering\xbsong\zihao{-2}\xeCJKsetup{CJKglue=\hskip 1.5pt}}{\thesection}{0em}{\phantomsection}[]

\titleformat{\subsection}[block]{\heiti \setstretch{1.35} \zihao{-3} }{\thesubsection}{0em}{\phantomsection}[]

% 书籍分部分：目录中的部分标题顶格并略大；正文 20 章保持原 section 字号，
% 但在目录中缩进到所属部分之下。前置章节与结尾部分维持原缩进。
\makeatletter
\newif\ifbooktocbody
\booktocbodyfalse
\newcommand{\BookTOCBodyOn}{\booktocbodytrue}
\newcommand{\BookTOCBodyOff}{\booktocbodyfalse}
\renewcommand*{\l@section}[2]{%
  \ifbooktocbody
    \@dottedtocline{1}{2em}{2.3em}{#1}{#2}%
  \else
    \@dottedtocline{1}{0em}{2.3em}{#1}{#2}%
  \fi}
\newcommand{\l@bookpart}[2]{%
  \vskip 0.7em\@plus\p@
  {\zihao{-3}\bfseries\@dottedtocline{0}{0em}{0em}{#1}{#2}}%
  \vskip 0.2em\@plus\p@}
\newcommand{\l@bookback}[2]{\@dottedtocline{1}{0em}{2.3em}{#1}{#2}}
\makeatother
\newcommand{\bookpart}[2]{%
  \cleardoublepage
  \phantomsection
  \markboth{#1\quad #2}{#1\quad #2}%
  \addcontentsline{toc}{bookpart}{#1\quad #2}%
  \thispagestyle{docstyle}%
  \begin{center}\vspace*{2em}{\xbsong\zihao{-1} #1\quad #2}\end{center}%
  \vspace{1.5em}}
\newcommand{\bookbacksection}[2]{%
  \section*{#2}%
  \markboth{#1}{#1}%
  \phantomsection
  \addcontentsline{toc}{bookback}{#1}}

% 两个空格大小
\newcommand{\q}{\ \ }

\usepackage{float}
\usepackage{array}
\usepackage{tabularx}
\usepackage{longtable}
\usepackage{enumitem}
\usepackage[font=small,labelfont=small]{caption}

% 无序列表沿用正文的行距，列表项之间不额外增加间距。
\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}
\setlist[enumerate]{topsep=0pt,itemsep=0pt,parsep=0pt,partopsep=0pt}

\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}


\newenvironment{poem}{\setlength{\leftskip}{1em} \setlength{\rightskip}{1em} \kaishu}

% 引用中用楷书
\AtBeginEnvironment{quotation}{\kaishu}

\endinput
