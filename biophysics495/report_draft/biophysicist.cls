%%
%% This is file biophysicist.cls
%% Author: Tom Hejda for Overleaf and The Biophysicist
%% Email: tom.hejda@overleaf.com or support+tex-dev@overleaf.com
%% This is released under the Creative Commons CC BY 4.0 license.
%%

\RequirePackage{expl3}

\ProvidesExplClass{biophysicist}{2022-10-11}{1.0}{The Biophysicist Journal}

\bool_new:N \g__overleaf_biophysicist_narrowtitlepage_bool
\DeclareOption { narrowtitle } { 
    \bool_gset_true:N \g__overleaf_biophysicist_narrowtitlepage_bool
}

\ProcessOptions\relax

\LoadClass [ 11pt, twoside ] { article }

% EXPL, GENERIC PACKAGES

\RequirePackage { xparse }
\RequirePackage { mathtools }
\RequirePackage { graphicx }
\RequirePackage { tikz }

\cs_generate_variant:Nn \clist_map_inline:nn { x }
\cs_generate_variant:Nn \prop_gput:Nnn { Nx }
\cs_generate_variant:Nn \clist_map_inline:nn { Vn }

\bool_new:N \g__overleaf_biophysicist_tempa_bool
\tl_new:N \l__overleaf_biophysicist_tempa_tl
\tl_new:N \g__overleaf_biophysicist_tempb_tl
\int_new:N \g__overleaf_biophysicist_tempa_int

% LANGAUGES

\RequirePackage [ english ] { babel }

% GEOMETRY, PAGE LAYOUT

\RequirePackage [ letterpaper ] { geometry }
\RequirePackage { fancyhdr }
\RequirePackage { lastpage }
\RequirePackage { eso-pic }

\geometry {
    hmargin = { 0.77in , 0.91in } ,
    vmargin = { 0.76in , 1.00in } ,
    columnsep = 0.18in ,
    footskip = 0.42in ,
    headsep = 0.16in,
    headheight = 0.16in,
}

\cs_new_protected:Nn \overleaf_biophysicist_almostraggedbottom: {
    \def \@textbottom { \vskip \z@ \@plus .005in } 
    \let \@texttop \relax
}
\overleaf_biophysicist_almostraggedbottom:

\fancyhf{}
\pagestyle{fancy}
\tl_gset:Nn \headrulewidth { 0pt }
\fancyhead [ RO , LE ] {
    \leavevmode \footnotesize \color{bioltblue}
    \g__overleaf_biophysicist_shorttitle_tl
}
\fancyfoot [ R ] {
    \leavevmode \footnotesize \color{biodkgray}
    \thepage{} ~ of ~ \pageref{LastPage}
}
\fancyfoot [ C ] {
    \leavevmode \color{biodkgray}
    \clap { \rule[0.30in]{\textwidth}{0.8pt} }
}
\fancypagestyle { plain } {
    \ps@fancy
    \fancyhead{}
    \fancyhead [ R ] {
        \leavevmode \footnotesize \color{bioltgray}
        RESEARCH ~ ARTICLE
    }
}

% FONTS, VERTICAL SPACING

%\RequirePackage [ default, defaultsans = 1.003 ] { opensans }

\RequirePackage { fontspec }
\setmainfont { MyriadPro } [
    Path = ./fonts/,
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    BoldItalicFont = *-BoldItalic,
    ItalicFont = *-Italic,
]
\newfontfamily \condfont { MyriadPro } [
    Path = ./fonts/,
    Extension = .otf,
    UprightFont = *-Cond,
    BoldFont = *-BoldCond,
    BoldItalicFont = *-BoldItalicCond,
    ItalicFont = *-ItalicCond,
]
\newfontfamily \lightfont { MyriadPro } [
    Path = ./fonts/,
    Extension = .otf,
    UprightFont = *-Light,
    BoldFont = *-SemiBold,
    BoldItalicFont = *-SemiBoldItalic,
]

\RequirePackage [ scaled = 1.155 ] { newtxsf }
\RequirePackage { microtype }
\linespread { 1.005 }

% COLORS

\RequirePackage { xcolor }

\definecolor { biodkblue } { cmyk } { 1, .58, .09, .46 }
\definecolor { bioltblue } { cmyk } { .89, .24, 0, .15 }
\definecolor { biolink } { cmyk } { 1, 1, 0, 0 }
\definecolor { biodkgray } { cmyk } { .02, .01, 0, 0.49 }
\definecolor { bioltgray } { cmyk } { .01, .005, 0, 0.19 }
\definecolor { biologoblack } { cmyk } { .0, .11, .09, 0.86 }
\definecolor { biologoblue } { cmyk } { .94, .37, 0, 0.45 }


% SECTIONING

\RequirePackage [ compact, bottomtitles ] { titlesec }

\DeclareExpandableDocumentCommand \thesection { } { \Roman{section} }
\DeclareExpandableDocumentCommand \thesubsection { } { \thesection.\Alph{subsection} }

\cs_set_eq:NN \__overleaf_biophysicist_section_Large: \Large

\cs_new_protected:Nn \overleaf_biophysicist_section_infosection:n {
    \cs_gset_eq:NN \__overleaf_biophysicist_section_Large: \large
    \section* { #1 }
    \footnotesize
    \cs_gset_eq:NN \__overleaf_biophysicist_section_section:w \section
    \cs_gset_eq:NN \section \__overleaf_biophysicist_section_afterinfosection:w
}

\cs_new_protected:Npn \__overleaf_biophysicist_section_afterinfosection:w {
    \cs_gset_eq:NN \section \__overleaf_biophysicist_section_section:w
    \normalsize \section
}

\DeclareDocumentCommand \infosection { >{\TrimSpaces}m } {
    \overleaf_biophysicist_section_infosection:n { #1 }
}

\titleformat { \section } {
    \__overleaf_biophysicist_section_Large: 
    \cs_gset_eq:NN \__overleaf_biophysicist_section_Large: \Large
    \bfseries \color{biodkblue} \raggedright \MakeUppercase
} { \thesection. } { 0.75ex } { }

\titleformat { \subsection } {
    \Large \bfseries \selectfont \raggedright
} { \Alph{subsection}. } { 0.75ex } { }

\titlespacing \section { 0pt } { 1.5ex plus 0.5ex minus 0.25ex } { 0.75ex plus 0.4ex minus 0.2ex }
\titlespacing \subsection { 0pt } { 1.25ex plus 0.4ex minus 0.2ex } { 0.5ex plus 0.3ex minus 0.15ex }

% LISTS

\RequirePackage { enumitem }

\setlist[enumerate,1]{label=\arabic*.}
\setlist[enumerate,2]{label=\alph*.}
\setlist[enumerate,3]{label=\roman*.}
\setlist[enumerate,4]{label=\Alph*.}
\setlist{leftmargin=17pt, labelsep=5pt, nosep}
\setlist[1]{topsep=1ex plus 0.4ex minus 0.1ex}

% FLOATS

\tl_set:cn { ver@fixltx2e.sty } { notloaded }
\RequirePackage { dblfloatfix }

\RequirePackage { float }
\RequirePackage { caption }

% default placement for table* and figure*
\def \@dbflt@table #1 { \@xdblfloat { #1 } [ bp ] }
\def \@dbflt@figure #1 { \@xdblfloat { #1 } [ tp ] }
\def \@dbflt #1 {
    \@ifnextchar [ {
        \@xdblfloat { #1 }
    } {
        \csname @dbflt@ #1 \endcsname { #1 }
    }
}

\floatplacement { figure } { tp }
\floatplacement { table } { pb }

\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{dbltopnumber}{2}
\setcounter{dblbotnumber}{2}
\setcounter{totalnumber}{4}

\renewcommand{\floatpagefraction}{0.7}
\renewcommand{\dblfloatpagefraction}{0.7}
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.9}
\renewcommand{\dbltopfraction}{0.9}
\renewcommand{\textfraction}{0.07}

\DeclareCaptionFont { bc } { \condfont \bfseries }
\DeclareCaptionFont { c } { \condfont }
\captionsetup{
    format = plain , justification = raggedright,
    font = {small,c} , labelfont = {bc} , labelsep = period,
    skip = 2pt ,
}%,indent=0pt,labelsep=none,
\captionsetup[table]{position=above}
\captionsetup[figure]{position=bottom}
\tl_gput_right:Nn \@floatboxreset {
    \centering \small \condfont
}

\setlength \tabcolsep { 5pt }

% ERROR MESSAGES

\msg_new:nnnn { biophysicist } { unknown-authorsymbol } {
    The ~ key ~ `#1' ~ is ~ unknown ~ as ~ an ~ affiliation ~
    or ~ an ~ author ~ note.
} {
    Either ~ define ~ the ~ affiliation ~ / ~ author ~ note ~
    or ~ do ~ not ~ use ~ `#1' ~ for ~ an ~ author.
}

\msg_new:nnnn { biophysicist } { long-maketitle } {
    The ~ maketitle ~ block ~ is ~ longer ~ than ~ one ~ page. ~
    Please ~ add ~ the ~ `narrowtitle' ~ class ~ option ~ to ~ ensure ~
    reasonably ~ looking ~ output.
} {
    The ~ maketitle ~ block ~ is ~ typeset ~ with ~ a ~ larger ~ width ~
    and ~ when ~ it ~ goes ~ to ~ the ~ next ~ page, ~ it ~ protrudes ~
    too ~ much ~ to ~ the ~ left. ~ The ~ class ~ option ~ `narrowtitle' ~
    prevents ~ this.
}

% TITLE AND METADATA

\prop_new:N \g__overleaf_biophysicist_affiliations_prop
\seq_new:N \g__overleaf_biophysicist_affiliations_seq
\int_new:N \g__overleaf_biophysicist_affiliation_int
\prop_new:N \g__overleaf_biophysicist_authornotes_prop
\seq_new:N \g__overleaf_biophysicist_authornotes_seq
\int_new:N \g__overleaf_biophysicist_authornote_int
\prop_new:N \g__overleaf_biophysicist_authorsymbols_prop
\prop_new:N \g__overleaf_biophysicist_authors_prop
\int_new:N \g__overleaf_biophysicist_author_int
\tl_new:N \g__overleaf_biophysicist_title_tl
\tl_new:N \g__overleaf_biophysicist_shorttitle_tl
\tl_new:N \g__overleaf_biophysicist_abstract_tl
\tl_new:N \g__overleaf_biophysicist_keywords_tl
\tl_new:N \g__overleaf_biophysicist_date_tl
\tl_new:N \g__overleaf_biophysicist_copydate_tl

\keys_define:nn { overleaf-biophysicist-author } {
    orcid .tl_set:N = \l__overleaf_biophysicist_author_orcid_tl,
}

\cs_new_protected:Nn \overleaf__biophysicist_author_orcid_url:n {
    \url{ https://orcid.org/ #1 }
}
\cs_generate_variant:Nn \overleaf__biophysicist_author_orcid_url:n { V }

\cs_new_protected:Nn \overleaf_biophysicist_author:nnn {
    \int_gincr:N \g__overleaf_biophysicist_author_int
    \prop_gput:Nxn \g__overleaf_biophysicist_authors_prop
        { \int_use:N \g__overleaf_biophysicist_author_int kv } { #1 }
    \prop_gput:Nxn \g__overleaf_biophysicist_authors_prop
        { \int_use:N \g__overleaf_biophysicist_author_int name } { #2 }
    \prop_gput:Nxn \g__overleaf_biophysicist_authors_prop
        { \int_use:N \g__overleaf_biophysicist_author_int sym } { #3 }
}

\cs_new:Nn \overleaf_biophysicist_int_to_repeatedsymbols:nnn {
    \prg_replicate:nn { 1 + \int_div_truncate:nn { #1 - 1 } { #2 } } {
        \int_to_symbols:nnn { 1 + \int_mod:nn { #1 - 1 } { #2 } } { #2 } { #3 }
    }
}

\cs_new:Nn \__overleaf_biophysicist_the_authornote:n {
    \overleaf_biophysicist_int_to_repeatedsymbols:nnn { #1 } { 4 } {
        { 1 } { * }
        { 2 } { \S }
        { 3 } { $\dagger$ }
        { 4 } { $\ddagger$ }
    }
}
\cs_new:Nn \__overleaf_biophysicist_the_authornote: {
    \__overleaf_biophysicist_the_authornote:n {
        \g__overleaf_biophysicist_authornote_int
    }
}

\cs_new:Nn \__overleaf_biophysicist_the_affiliation:n {
    \int_eval:n { #1 }
}
\cs_new:Nn \__overleaf_biophysicist_the_affiliation: {
    \__overleaf_biophysicist_the_affiliation:n { \g__overleaf_biophysicist_affiliation_int }
}

\cs_new_protected:Nn \overleaf_biophysicist_affiliation:nn {
    \int_gincr:N \g__overleaf_biophysicist_affiliation_int
    \prop_gput:Nnn \g__overleaf_biophysicist_affiliations_prop { #1 } { #2 }
    \seq_gput_right:Nn \g__overleaf_biophysicist_affiliations_seq { #1 }
    \prop_gput:Nnx \g__overleaf_biophysicist_authorsymbols_prop
        { #1 } { \__overleaf_biophysicist_the_affiliation: }
}

\cs_new_protected:Nn \overleaf_biophysicist_authornote:nn {
    \int_gincr:N \g__overleaf_biophysicist_authornote_int
    \prop_gput:Nnn \g__overleaf_biophysicist_authornotes_prop { #1 } { #2 }
    \seq_gput_right:Nn \g__overleaf_biophysicist_authornotes_seq { #1 }
    \prop_gput:Nnx \g__overleaf_biophysicist_authorsymbols_prop
        { #1 } { \__overleaf_biophysicist_the_authornote: }
}

\cs_new_protected:Nn \overleaf_biophysicist_title:nn {
    \tl_gset:Nn \g__overleaf_biophysicist_shorttitle_tl { #1 }
    \tl_gset:Nn \g__overleaf_biophysicist_title_tl { #2 }
}

\cs_new_protected:Nn \overleaf_biophysicist_abstract:n {
    \tl_gset:Nn \g__overleaf_biophysicist_abstract_tl { #1 }
}

\cs_new_protected:Nn \overleaf_biophysicist_keywords:n {
    \tl_gset:Nn \g__overleaf_biophysicist_keywords_tl { #1 }
}

\cs_new_protected:Nn \overleaf_biophysicist_date:nn {
    \tl_gset:Nn \g__overleaf_biophysicist_copydate_tl { #1 }
    \tl_gset:Nn \g__overleaf_biophysicist_date_tl { #2 }
}

\cs_new_protected:Nn \overleaf_biophysicist_maketitle: {
    % CLEARPAGE, NEWPAGE
    \clearpage
    \newpage
    \twocolumn[]
    % LEFT COLUMN
    \suppressfloats
    {
        \footnotesize \raggedright
        \bool_if:NF \g__overleaf_biophysicist_narrowtitlepage_bool {
            \setlength \rightskip { 1.6in plus 1fil }
        }
        \__overleaf_biophysicist_logo_tikzpicture:nn { 36pt } { 90 }
        \vfill
        \seq_map_inline:Nn \g__overleaf_biophysicist_authornotes_seq {
            ``
            \prop_item:Nn \g__overleaf_biophysicist_authorsymbols_prop { ##1 }
            '' ~
            \prop_item:Nn \g__overleaf_biophysicist_authornotes_prop { ##1 }
            \par
        }
        \tl_if_empty:NF \g__overleaf_biophysicist_date_tl { \bigskip }
        \clist_map_inline:Vn \g__overleaf_biophysicist_date_tl {
            \tl_if_in:nnTF { ##1 } { = } {
                \tl_gset:Nn \g__overleaf_biophysicist_tempa_tl { ##1 }
                \tl_replace_once:Nnn \g__overleaf_biophysicist_tempa_tl { = } { \unskip : ~ \mdseries \ignorespaces }
                { \fontseries {bc} \selectfont \g__overleaf_biophysicist_tempa_tl }
            } {
                ##1
            }
            \par
        }
        \bigskip
        {
            \color{biodkgray}
            \textcopyright{} ~
            \g__overleaf_biophysicist_copydate_tl \unskip{} ~
            Biophysical ~ Society.
        }
    }
    \newpage
    % RIGHT COLUMN
    \suppressfloats
    \thispagestyle{plain}
    \group_begin:
    \bool_if:NF \g__overleaf_biophysicist_narrowtitlepage_bool {
        \tl_put_right:Nn \raggedright { \leftskip -1.6in }
    }
    % TITLE
    {
        \raggedright \LARGE \bfseries \color{biodkblue} 
        \g__overleaf_biophysicist_title_tl
        \par
    }
    \bigskip
    % AUTHORS
    {
        \raggedright \small
        \int_step_inline:nn { \g__overleaf_biophysicist_author_int } {
            \group_begin:
            \prop_get:NnN \g__overleaf_biophysicist_authors_prop { ##1 kv } \l__overleaf_biophysicist_tempa_tl
            \keys_set:nV { overleaf-biophysicist-author } \l__overleaf_biophysicist_tempa_tl
            \bool_gset_false:N \g__overleaf_biophysicist_tempa_bool
            \tl_clear:N \g__overleaf_biophysicist_tempb_tl
            \clist_map_inline:xn {
                \prop_item:Nn \g__overleaf_biophysicist_authors_prop { ##1 sym }
            } {
                \bool_if:NT \g__overleaf_biophysicist_tempa_bool {
                    \tl_gput_right:Nn \g__overleaf_biophysicist_tempb_tl { , \, }
                }
                \prop_get:NnNTF \g__overleaf_biophysicist_authorsymbols_prop {
                    ####1
                } \l__overleaf_biophysicist_tempa_tl {
                    \tl_gput_right:NV \g__overleaf_biophysicist_tempb_tl \l__overleaf_biophysicist_tempa_tl
                    \bool_gset_true:N \g__overleaf_biophysicist_tempa_bool
                } {
                    \msg_error:nnn { biophysicist } { unknown-authorsymbol } { ####1 }
                }
            }
            \prop_get:NnN \g__overleaf_biophysicist_authors_prop { ##1 name } \l__overleaf_biophysicist_tempa_tl
            \mbox { \bfseries \tl_use:N \l__overleaf_biophysicist_tempa_tl }
            \textsuperscript { \, \bfseries \str_use:N \g__overleaf_biophysicist_tempb_tl }
            \tl_if_empty:NF \l__overleaf_biophysicist_author_orcid_tl {
                \space
                \overleaf__biophysicist_author_orcid_url:V \l__overleaf_biophysicist_author_orcid_tl
            }
            \int_compare:nNnT { ##1 } < { \g__overleaf_biophysicist_author_int } {
                \textbf{ , ~ }
            }
            \group_end:
        }
        \par
    }
    \bigskip
    % AFFILIATIONS
    {
        \raggedright \small
        \seq_map_inline:Nn \g__overleaf_biophysicist_affiliations_seq {
            \textsuperscript {
                \prop_item:Nn \g__overleaf_biophysicist_authorsymbols_prop { ##1 }
                \,
            }
            \prop_item:Nn \g__overleaf_biophysicist_affiliations_prop { ##1 }
            \par
        }
    }
    \bigskip
    % ABSTRACT
    {
        \raggedright
        \setlength \parindent { 17pt }
        { \noindent \large \bfseries \color{ biodkblue } ABSTRACT \quad }
        \small
        \tl_if_empty:NTF \g__overleaf_biophysicist_abstract_tl { --- } {
            \tl_use:N \g__overleaf_biophysicist_abstract_tl
        }
        \par
    }
    \bigskip
    % KEYWORDS
    {
        \raggedright
        { \large \bfseries \color{ biodkblue } KEY ~ WORDS ~ }
        \small
        \tl_if_empty:NTF \g__overleaf_biophysicist_keywords_tl { --- } {
            \tl_use:N \g__overleaf_biophysicist_keywords_tl
        }
        \par
    }
    % CHECK WHETHER THE TITLE FITS IN PAGE ONE
    \bigskip\par
    \int_compare:nNnT { \value{page} } > { 1 } {
        \bool_if:NF \g__overleaf_biophysicist_narrowtitlepage_bool {
            \msg_warning:nn { biophysicist } { long-maketitle }
        }
    }
    % DEBUG
    \@gobble { \ttfamily \raggedright
        AFFILIATIONS: \par
        \meaning \g__overleaf_biophysicist_affiliations_prop \par
        \meaning \g__overleaf_biophysicist_affiliations_seq \par
        AUTHORNOTES: \par
        \meaning \g__overleaf_biophysicist_authornotes_prop \par
        \meaning \g__overleaf_biophysicist_authornotes_seq \par
        AUTHORSYMBOLS: \par
        \meaning \g__overleaf_biophysicist_authorsymbols_prop \par
        AUTHORS: \par
        \meaning \g__overleaf_biophysicist_authors_prop \par
    }
    \group_end:
}

\DeclareDocumentCommand \author { O{} >{\TrimSpaces}m m O{} } {
    \overleaf_biophysicist_author:nnn { #1, #4 } { #2 } { #3 }
}

\DeclareDocumentCommand \affiliation { >{\TrimSpaces}m >{\TrimSpaces}m } {
    \overleaf_biophysicist_affiliation:nn { #1 } { #2 }
}

\DeclareDocumentCommand \authornote { >{\TrimSpaces}m >{\TrimSpaces}m } {
    \overleaf_biophysicist_authornote:nn { #1 } { #2 }
}

\DeclareDocumentCommand \title { >{\TrimSpaces}o >{\TrimSpaces}m } {
    \IfValueTF { #1 } {
        \overleaf_biophysicist_title:nn { #1 } { #2 }
    } {
        \overleaf_biophysicist_title:nn { #2 } { #2 }
    }
}

\DeclareDocumentEnvironment { abstract } { >{\TrimSpaces}+b } {
    \overleaf_biophysicist_abstract:n { #1 }
} { }

\DeclareDocumentCommand \keywords { >{\TrimSpaces}m } {
    \overleaf_biophysicist_keywords:n { #1 }
}

\DeclareDocumentCommand \date { >{\TrimSpaces}O{} >{\TrimSpaces}m } {
    \overleaf_biophysicist_date:nn { #1 } { #2 }
}

\DeclareDocumentCommand \maketitle { } {
    \overleaf_biophysicist_maketitle:
}


% BIBLIOGRAPHY, REFERENCES

\RequirePackage [ numbers, sort&compress, round ] { natbib }
\RequirePackage { url }

\tl_put_right:Nn \url@samestyle {
    \tl_put_right:Nn \UrlFont { \color{biolink} }
}
\urlstyle{same}

\bibliographystyle{unsrtnat}
\renewcommand{\bibnumfmt}[1]{{#1}.}
\renewcommand{\bibfont}{\raggedright\footnotesize\condfont}
\renewcommand{\bibsection}{\infosection{\refname}}
\newcommand{\doi}{doi: ~ \begingroup \Url}

\setlength{\bibsep}{1.5pt}

\RequirePackage { hyperref }


% LOGO

\cs_new_protected:Nn \__overleaf_biophysicist_logo_tikzpicture:nn {
\begin{tikzpicture}[x=#1, y=#1, scale=0.123, inner~sep=0pt, outer~sep=0pt, rotate=#2] \begin{scope}[shift={(1.0895,7.59928)}] \path[fill=biologoblack,nonzero~rule] (0.00000,0.00000) -- (0.00000,-0.41270) -- (1.66630,-0.41270) -- (1.66630,-5.29450) -- (2.11010,-5.29450) -- (2.11010,-0.41270) -- (3.78410,-0.41270) -- (3.78410,0.00000) -- cycle; \end{scope} \begin{scope}[shift={(5.62817,7.98849)}] \path[fill=biologoblack,nonzero~rule] (0.00000,0.00000) -- (0.43600,0.00000) -- (0.43600,-2.39810) .. controls (0.77090,-1.86070) and (1.23030,-1.60390) .. (1.82200,-1.60390) .. controls (2.64730,-1.60390) and (3.06770,-2.10210) .. (3.06770,-3.04430) -- (3.06770,-5.68370) -- (2.63160,-5.68370) -- (2.63160,-3.09100) .. controls (2.63160,-2.35900) and (2.35150,-2.00100) .. (1.75190,-2.00100) .. controls (1.19140,-2.00100) and (0.75530,-2.31240) .. (0.43600,-3.03650) -- (0.43600,-5.68370) -- (0.00000,-5.68370) -- cycle; \end{scope} \begin{scope}[shift={(12.29824,4.57828)}] \path[fill=biologoblack,nonzero~rule] (0.00000,0.00000) -- (0.00000,0.08560) .. controls (0.00000,0.98890) and (-0.39690,1.42490) .. (-1.22240,1.42490) .. controls (-2.04760,1.42490) and (-2.43700,0.98890) .. (-2.43700,0.08560) -- (-2.43700,0.00000) -- cycle(-2.87300,-0.67740) -- (-2.87300,0.11680) .. controls (-2.87300,1.21460) and (-2.28910,1.80640) .. (-1.22240,1.80640) .. controls (-0.15570,1.80640) and (0.42060,1.21460) .. (0.42060,0.11680) -- (0.42060,-0.37380) -- (-2.43700,-0.37380) -- (-2.43700,-0.64640) .. controls (-2.43700,-1.54950) and (-2.03220,-1.98550) .. (-1.19900,-1.98550) .. controls (-0.48270,-1.98550) and (-0.07780,-1.65860) .. (-0.03100,-1.10560) -- (0.38940,-1.10560) .. controls (0.33490,-1.92310) and (-0.24130,-2.36710) .. (-1.18340,-2.36710) .. controls (-2.27340,-2.36710) and (-2.87300,-1.77530) .. (-2.87300,-0.67740); \end{scope} \begin{scope}[shift={(16.34873,3.29347)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) .. controls (0.62290,0.00000) and (0.83320,0.14790) .. (0.83320,0.59190) .. controls (0.83320,1.05110) and (0.59950,1.20690) .. (-0.09350,1.20690) -- (-0.91870,1.20690) -- (-0.91870,0.00000) -- cycle(-0.14020,2.19580) .. controls (0.47500,2.19580) and (0.67740,2.33600) .. (0.67740,2.76420) .. controls (0.67740,3.18460) and (0.49060,3.31680) .. (-0.07780,3.31680) -- (-0.91870,3.31680) -- (-0.91870,2.19580) -- cycle(-2.08670,4.30580) -- (0.03890,4.30580) .. controls (1.28480,4.30580) and (1.82970,3.87750) .. (1.82970,2.92760) .. controls (1.82970,2.34370) and (1.61950,1.97770) .. (1.10560,1.79860) -- (1.10560,1.78310) .. controls (1.74410,1.60410) and (2.00100,1.19130) .. (2.00100,0.49830) .. controls (2.00100,-0.52950) and (1.44050,-0.98890) .. (0.20250,-0.98890) -- (-2.08670,-0.98890) -- cycle; \end{scope} \path[fill=biologoblue,nonzero~rule] (19.14320,6.36900) -- (20.29560,6.36900) -- (20.29560,2.30470) -- (19.14320,2.30470) -- cycle(19.11220,7.92620) -- (20.32680,7.92620) -- (20.32680,6.94500) -- (19.11220,6.94500) -- cycle; \begin{scope}[shift={(23.68218,3.98648)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (0.00000,0.70080) .. controls (0.00000,1.29250) and (-0.20250,1.54170) .. (-0.69310,1.54170) .. controls (-1.18350,1.54170) and (-1.38600,1.29250) .. (-1.38600,0.70080) -- (-1.38600,0.00000) .. controls (-1.38600,-0.59170) and (-1.18350,-0.84090) .. (-0.69310,-0.84090) .. controls (-0.20250,-0.84090) and (0.00000,-0.59170) .. (0.00000,0.00000)(-2.53840,-0.02350) -- (-2.53840,0.72410) .. controls (-2.53840,1.89210) and (-1.92320,2.47590) .. (-0.69310,2.47590) .. controls (0.53720,2.47590) and (1.15240,1.89210) .. (1.15240,0.72410) -- (1.15240,-0.02350) .. controls (1.15240,-1.19140) and (0.53720,-1.77540) .. (-0.69310,-1.77540) .. controls (-1.92320,-1.77540) and (-2.53840,-1.19140) .. (-2.53840,-0.02350); \end{scope} \begin{scope}[shift={(28.18193,3.88526)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (0.00000,0.90310) .. controls (0.00000,1.42490) and (-0.19460,1.64280) .. (-0.56840,1.64280) .. controls (-0.92660,1.64280) and (-1.18340,1.43280) .. (-1.34700,1.02780) -- (-1.34700,-0.11670) .. controls (-1.18340,-0.52950) and (-0.92660,-0.73970) .. (-0.56060,-0.73970) .. controls (-0.19460,-0.73970) and (0.00000,-0.52950) .. (0.00000,0.00000)(-2.49930,2.48370) -- (-1.51830,2.48370) -- (-1.48710,1.99330) .. controls (-1.18340,2.39810) and (-0.80980,2.57710) .. (-0.29580,2.57710) .. controls (0.63070,2.57710) and (1.15240,2.00870) .. (1.15240,0.91100) -- (1.15240,0.00000) .. controls (1.15240,-1.09790) and (0.63070,-1.67400) .. (-0.29580,-1.67400) .. controls (-0.73200,-1.67400) and (-1.07440,-1.54170) .. (-1.34700,-1.25360) -- (-1.34700,-2.99770) -- (-2.49930,-2.99770) -- cycle; \end{scope} \begin{scope}[shift={(30.19028,7.98849)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (1.15240,0.00000) -- (1.15240,-1.94660) .. controls (1.43260,-1.65840) and (1.76740,-1.52600) .. (2.19560,-1.52600) .. controls (3.03660,-1.52600) and (3.47270,-2.02430) .. (3.47270,-2.98980) -- (3.47270,-5.68370) -- (2.32030,-5.68370) -- (2.32030,-3.09100) .. controls (2.32030,-2.70950) and (2.18000,-2.52260) .. (1.86860,-2.52260) .. controls (1.56490,-2.52260) and (1.32370,-2.70180) .. (1.15240,-3.06000) -- (1.15240,-5.68370) -- (0.00000,-5.68370) -- cycle; \end{scope} \begin{scope}[shift={(34.61221,1.79083)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (0.45160,0.00000) .. controls (0.66950,0.00000) and (0.76300,0.06230) .. (0.84090,0.30370) -- (0.92660,0.56050) -- (-0.45940,4.57810) -- (0.76300,4.57810) -- (1.51830,2.03990) -- (2.21120,4.57810) -- (3.37130,4.57810) -- (1.93090,0.16340) .. controls (1.65840,-0.67740) and (1.37800,-0.90330) .. (0.58400,-0.90330) -- (0.00000,-0.90330) -- cycle; \end{scope} \begin{scope}[shift={(38.24775,3.55055)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (1.09790,0.00000) .. controls (1.09790,-0.35050) and (1.28460,-0.50620) .. (1.72830,-0.50620) .. controls (2.11010,-0.50620) and (2.29680,-0.38940) .. (2.29680,-0.14020) .. controls (2.29680,0.14780) and (2.07880,0.27250) .. (1.47150,0.34260) .. controls (0.46720,0.45940) and (0.07010,0.80200) .. (0.07010,1.57270) .. controls (0.07010,2.45260) and (0.66170,2.91180) .. (1.72830,2.91180) .. controls (2.80290,2.91180) and (3.34800,2.46020) .. (3.34800,1.61930) -- (2.25010,1.61930) .. controls (2.25010,1.93880) and (2.09440,2.07890) .. (1.72080,2.07890) .. controls (1.37820,2.07890) and (1.20690,1.94650) .. (1.20690,1.71290) .. controls (1.20690,1.44800) and (1.41700,1.33130) .. (2.00870,1.26130) .. controls (3.03650,1.14450) and (3.43360,0.76300) .. (3.43360,-0.02350) .. controls (3.43360,-0.91100) and (2.87300,-1.33930) .. (1.72080,-1.33930) .. controls (0.54490,-1.33930) and (0.00000,-0.90330) .. (0.00000,0.00000); \end{scope} \path[fill=biologoblue,nonzero~rule] (42.42820,6.36900) -- (43.58060,6.36900) -- (43.58060,2.30470) -- (42.42820,2.30470) -- cycle(42.39720,7.92620) -- (43.61180,7.92620) -- (43.61180,6.94500) -- (42.39720,6.94500) -- cycle; \begin{scope}[shift={(44.4291,3.9398)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (0.00000,0.79420) .. controls (0.00000,1.93880) and (0.59940,2.52260) .. (1.77510,2.52260) .. controls (2.91180,2.52260) and (3.49580,1.98540) .. (3.51140,0.87980) -- (2.41350,0.87980) .. controls (2.39030,1.34690) and (2.22680,1.58830) .. (1.79060,1.58830) .. controls (1.35470,1.58830) and (1.15230,1.34690) .. (1.15230,0.78630) -- (1.15230,0.00000) .. controls (1.15230,-0.55280) and (1.35470,-0.79420) .. (1.79060,-0.79420) .. controls (2.22680,-0.79420) and (2.39800,-0.55280) .. (2.41350,-0.08550) -- (3.51140,-0.08550) .. controls (3.49580,-1.19140) and (2.91180,-1.72860) .. (1.77510,-1.72860) .. controls (0.59940,-1.72860) and (0.00000,-1.14470) .. (0.00000,0.00000); \end{scope} \path[fill=biologoblue,nonzero~rule] (48.67180,6.36900) -- (49.82420,6.36900) -- (49.82420,2.30470) -- (48.67180,2.30470) -- cycle(48.64080,7.92620) -- (49.85540,7.92620) -- (49.85540,6.94500) -- (48.64080,6.94500) -- cycle; \begin{scope}[shift={(50.56357,3.55055)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (1.09790,0.00000) .. controls (1.09790,-0.35050) and (1.28460,-0.50620) .. (1.72830,-0.50620) .. controls (2.11010,-0.50620) and (2.29680,-0.38940) .. (2.29680,-0.14020) .. controls (2.29680,0.14780) and (2.07880,0.27250) .. (1.47150,0.34260) .. controls (0.46720,0.45940) and (0.07010,0.80200) .. (0.07010,1.57270) .. controls (0.07010,2.45260) and (0.66160,2.91180) .. (1.72830,2.91180) .. controls (2.80290,2.91180) and (3.34800,2.46020) .. (3.34800,1.61930) -- (2.25010,1.61930) .. controls (2.25010,1.93880) and (2.09440,2.07890) .. (1.72080,2.07890) .. controls (1.37820,2.07890) and (1.20690,1.94650) .. (1.20690,1.71290) .. controls (1.20690,1.44800) and (1.41700,1.33130) .. (2.00870,1.26130) .. controls (3.03640,1.14450) and (3.43360,0.76300) .. (3.43360,-0.02350) .. controls (3.43360,-0.91100) and (2.87300,-1.33930) .. (1.72080,-1.33930) .. controls (0.54490,-1.33930) and (0.00000,-0.90330) .. (0.00000,0.00000); \end{scope} \begin{scope}[shift={(54.86182,3.62833)}] \path[fill=biologoblue,nonzero~rule] (0.00000,0.00000) -- (0.00000,1.86870) -- (-0.59190,1.86870) -- (-0.59190,2.74050) -- (0.02340,2.74050) -- (0.08550,3.75300) -- (1.15240,3.75300) -- (1.15240,2.74050) -- (1.99330,2.74050) -- (1.99330,1.86870) -- (1.15240,1.86870) -- (1.15240,0.07010) .. controls (1.15240,-0.31140) and (1.24570,-0.42060) .. (1.58060,-0.42060) -- (2.03220,-0.42060) -- (2.03220,-1.32370) -- (1.18350,-1.32370) .. controls (0.35050,-1.32370) and (0.00000,-0.93430) .. (0.00000,0.00000); \end{scope} \end{tikzpicture}
}
