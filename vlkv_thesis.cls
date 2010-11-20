%%%%%%%%%%%%%%%%%%%%%
%% Author: Vitaly V. Volkov
%% Email: vitvlkv@gmail.com
%% 
%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e} %В XeLaTeX этот класс тоже можно использовать
\ProvidesClass{vlkv_thesis}[2010/03/29 My custom document class for my thesis writing]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Мой класс основан на стандартном report
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Устанавливаем размеры шрифтов
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\tiny}{\fontsize{7}{7}\selectfont}
\renewcommand{\scriptsize}{\fontsize{10}{10}\selectfont}
\renewcommand{\footnotesize}{\fontsize{12}{12}\selectfont}
\renewcommand{\small}{\fontsize{12}{12}\selectfont}
\renewcommand{\normalsize}{\fontsize{14}{14}\selectfont}
\renewcommand{\large}{\fontsize{16}{16}\selectfont}
\renewcommand{\Large}{\fontsize{20}{20}\selectfont}
\renewcommand{\LARGE}{\fontsize{20}{20}\selectfont}
\renewcommand{\huge}{\fontsize{28}{28}\selectfont}
\renewcommand{\Huge}{\fontsize{30}{30}\selectfont}
%Команда \fontsize{size}{baselineskip}
%вторым параметром задает интервал между строками. Обычно его делают 
%на 15--20% больше размера шрифта. Я делаю одинаковым.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Межстрочный интервал (интерлиньяж, кажется)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\baselinestretch}{1.5}
%Это еще можно делать при помощи пакета setspace
%А еще можно измениться значение для linespread
%Однако переназначить baselinestretch --- по-моему более правильно. Хотя точно почему, не могу сказать!
%Также в документации LaTeX не рекомендуют изменять значение по умолчанию для linespread


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Размер отступа (красной строки)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{indentfirst}
\setlength{\parindent}{1cm}


%%%%%%%%%%%%%%%%%%%
% Размер бумаги A4
%%%%%%%%%%%%%%%%%%%
\setlength\paperheight{297mm}
\setlength\paperwidth{210mm}

%%%%%%%
% Поля
%%%%%%%
\RequirePackage{geometry}
\geometry{left=3cm} %левое поле
\geometry{right=1cm} %правое поле
\geometry{top=2cm} %верхнее поле
\geometry{bottom=2cm} %нижнее поле
\geometry{marginpar=2.6cm} %чтобы todonotes заметки помещались
\reversemarginpar %Заметки на полях отображать слева (по умолчанию, справа)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Настройки оглавления (содержания)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{tocdepth}{3} %Какие заголовки надо включать в содержание (сколько уровней, начиная с верхнего)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Настройка стилей заголовков
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{secnumdepth}{3} %Какие заголовки нужно нумеровать (сколько уровней, начиная с верхнего)

%Стили заголовков довольно просто настраиваются при помощи пакета titlesec
\RequirePackage[calcwidth]{titlesec} %Толком не знаю, зачем эта опция calcwidth

%Главы (команда \chapter)
\titleformat{\chapter}[display]%Какой заголовок и какую "заготовку" оформления для него выбрать
{\Large\rmfamily\bfseries}%Это семейство и стиль шрифта для всего заголовка
{\chaptertitlename~\thechapter}%Это непосредственно формат номера заголовка. \chaptertitlename это слово "Глава"
{1em}%Расстояние между номером и текстом заголовка
{}%Это применяется до текста заголовка
[]%Это применяется после текста заголовка. Можно, например, полоску под заголовком нарисовать...

%Разделы (команда \section)
\titleformat{\section}[hang]
{\large\rmfamily\bfseries} 
{\thesection}
{1em}
{} 
[]			 

%Подразделы (команда \subsection)
\titleformat{\subsection}[hang]
{\normalsize\rmfamily\bfseries}
{\thesubsection}
{1em}
{}
[]

%Подподразделы (команда \subsubsection)
\titleformat{\subsubsection}[hang]
{\normalsize\rmfamily\bfseries\itshape}
{\thesubsubsection}
{1em}
{}
[]
%Параграфы (команда \paragraph)
\titleformat{\paragraph}[runin]
{\normalsize\rmfamily\bfseries}
{\theparagraph}
{1em}
{\hspace{\parindent}}
[.{ }]

% Кстати пакет titlesec позволяет кажется настраивать стили заголовков в содержании.
% Также он может настраивать разные отступы после заголовков и т.п. Вобщем на CTAN можно почитать документацию к нему.

%%%%%%%%%%%%%
% Приложения
%%%%%%%%%%%%%
%Для приложений я сделал собственную команду \appchapter
%Еще надо бы сделать команду \appsection, чтобы ее счетчик был
%связан со счетчиком appchapter
%Поэтому, не нужно пользоваться стандартной LaTeX-овской \appendix !!!
\newcounter{appchapter} %Счётчик для нумерации приложений (буквами)
\renewcommand{\theappchapter}{\Asbuk{appchapter}} 
%\Asbuk это команда из пакета babel (с опцией russian)
%Я вроде как babel нигде не подключал еще, откуда LaTeX уже знает про эту команду???

%Команда \appchapter для форматирования заголовков приложений
\providecommand{\appchapter}[1]{%
    \refstepcounter{appchapter}%
	\addcontentsline{toc}{chapter}{\appendixname\ \theappchapter. #1}    
	\clearpage	
    \vspace*{24 pt}
    {
        \parindent=0pt
        \LARGE\sffamily\bfseries
        \appendixname\ \theappchapter. 
        #1
        \par
        \nopagebreak
        \vspace{16 pt}
    }
}

\newcounter{appsection}[appchapter]
\renewcommand{\theappsection}{{\theappchapter}.\arabic{appsection}}
% \providecommand\appsection{\@startsection {appsection}{1}{\z@}%
%                                    {-3.5ex \@plus -1ex \@minus -.2ex}%
%                                    {2.3ex \@plus.2ex}%
%                                    {\normalfont\Large\bfseries}}
\providecommand{\appsection}[1]{%
    \refstepcounter{appsection}%
	\addcontentsline{toc}{section}{\theappsection \hspace{1em} #1}
    \vspace{18 pt}{
        \parindent=0pt
        \Large\sffamily\bfseries
        \theappsection \hspace{1em} #1
        \par
        \nopagebreak
        \vspace{10 pt}        
    }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Нумерация и подписи картинок и таблиц
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ccaption,remreset}
\captiondelim{. } %По умолчанию пишется "Рис: 1", а нужно "Рис. 1"
\captionnamefont{\small}
\captiontitlefont{\small}
\captionstyle{\centering}

%Почему-то, если подключить пакет subfig, то captiondelim снова устанавливается в ": "

%Делаем сквозную нумерацию (по умолчанию в report нумерация начинается 
%заново в каждой главе (chapter)
\@removefromreset{figure}{chapter}
\renewcommand{\thefigure}{\arabic{figure}}

%Делаем сквозную нумерацию и для таблиц
\@removefromreset{table}{chapter}
\renewcommand{\thetable}{\arabic{table}}

%Специальная команда для подписей таблиц. 
%Для подписи рисунков использовать обычную команду \caption
%Эта команда сделана на основе примера из ccaption.pdf
\providecommand{\tabcaption}[2][\@empty]{%
    \precaption{\hfill}
    \captiondelim{.\newline}
    \captionnamefont{\small}
    \captiontitlefont{\small}
    \captionstyle{\raggedleft}
    \setlength{\belowcaptionskip}{5pt}
    \ifx{\@empty}{#1}
        \caption{#2}
    \else
        \caption[#1]{#2}
}





%%%%%%%%%%%%%%%%%%%
% Нумерация формул
%%%%%%%%%%%%%%%%%%%
%Делаем сквозную нумерацию формул (по умолчанию в report нумерация начинается заново в каждой главе (chapter)
\@removefromreset{equation}{chapter}%Это команда из пакета remreset
\renewcommand{\theequation}{\arabic{equation}}





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Защита от "висячих" строк (однако, не 100%-ая)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\clubpenalty=9999  %Почему-то очень не советуют ставить 10000
\widowpenalty=9999 %Почему-то очень не советуют ставить 10000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Параметр, задающий степень максимальной разреженности строк
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tolerance=500 %По умолчанию вроде-ка стоит 200
%Этот параметр позволяет иногда избежать ситуации, когда внутритекстовая формула
%вылезает на поля страницы (вместо того, чтобы перенестись на следующую строку).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Стили нумерованных и маркированных списков
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Пока еще не знаю, как мне нужно... Вот заготовка:
%\renewcommand{\theenumi}{\arabic{enumi}}% Меняем везде перечисления на цифра.цифра
%\renewcommand{\labelenumi}{\arabic{enumi}}% Меняем везде перечисления на цифра.цифра
%\renewcommand{\theenumii}{\arabic{enumii}}% Меняем везде перечисления на цифра.цифра
%\renewcommand{\labelenumii}{\arabic{enumi}.\arabic{enumii}.}% Меняем везде перечисления на цифра.цифра
%\renewcommand{\theenumiii}{\arabic{enumiii}}% Меняем везде перечисления на цифра.цифра
%\renewcommand{\labelenumiii}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}.}% Меняем везде перечисления на цифра.цифра




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Переименование стандартных названий, таких как "Оглавление", 
%"Литература" и пр.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Если используется babel, то переименовывать стандартные названия нужно после начала
%документа, \AtBeginDocument
%\AtBeginDocument{
%   \addto\captionsrussian{%
%		\renewcommand{\contentsname}%
%		{\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}%
%   }
%}
%Это не работает с xelatex, он не знает команд \cyr
%Возможно лучше всего разместить переименование стандартных названий в 
%преамбуле главного .tex документа



%%%%%%%%%%%%%%%%%%%%%%%%%%
% Настройка отображения сносок \footnote
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Нумерация сносок начинается заново на каждой странице
\RequirePackage[perpage]{footmisc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Настройка формата нумерации страниц
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{% Модифицируем стиль plain, который используется в LaTeX по умолчанию на каждой странице, где начинается новая глава chapter или section
\fancyhf{} % clear all header and footer fields
\fancyhead[C]{\thepage} %Номер страницы вверху по центру
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\pagestyle{plain}


