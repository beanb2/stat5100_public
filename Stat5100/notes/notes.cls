\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2019/12/06 notes class]

% Load standard article class. 
\LoadClass[twoside]{article}
\parindent=0pt
\pagestyle{empty} \oddsidemargin  0in \evensidemargin -0.25in
\textwidth 6.5in \headheight -.75in \topmargin 0.0in
\textheight=10in

\RequirePackage{xcolor}
\RequirePackage{comment}
\RequirePackage{enumitem}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{graphicx}
\RequirePackage{comment}

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



