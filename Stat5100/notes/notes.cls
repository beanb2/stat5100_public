\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2019/12/06 notes class]



% Commands to set font sizes.
\def\@@ptsize{12pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Load standard article class. 
\LoadClass[\@@ptsize]{article}

\parindent=0pt
\pagestyle{empty} 
% Assumes a default of 1 inch margins, this makes the margins slightly more narrow. 
\oddsidemargin  -0.25in \evensidemargin -0.25in
% Adjusts height margins to make the notes flow more continuously. 
\textwidth 7in \headheight -.75in \topmargin 0.0in
\textheight=10in

\RequirePackage{xcolor}
\RequirePackage{comment}
\RequirePackage{enumitem}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
\RequirePackage{comment}
\RequirePackage{float}
\RequirePackage{url}

\newcommand*{\ntitle}[1]{%
\begin{center}
\large{\textbf{#1}}
\end{center}

\normalsize
Dr. Bean - Stat 5100

\vspace{0.25cm}
}

\newcommand*{\question}[1]{%
\vspace{0.25cm}
{\color{blue} \textbf{#1}}
}

\newcommand*{\note}[1]{%
{\color{red} #1}
}

\newcommand*{\nspace}{\vspace{0.3cm}}



