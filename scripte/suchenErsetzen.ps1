<#------------------------------------------------------ 
	PowerShell Script
	update: 1-Apr-20
	(c) 2020 Jan Unger 
  * Suchen und Ersetzen von Latex files
------------------------------------------------------#>
Clear-Host # cls

#----------------------------------------------
# anpassen: Latex / lstlisting ?
# Latex-Code:  HTML5, Python, Bash, C, C++, TeX
$language = "C++"    
#----------------------------------------------

# suchen und ersetzen in latex
## Funktionsaufruf: suchenErsetzenTeX
function suchenErsetzenTeX{
  [array]$array = ls "*.tex"
  # array auslesen
  for($n=0; $n -lt $array.length; $n++){   # kleiner
    $name = "$($array[$n])"              # file.tex
    #$basename = "$($array.BaseName[$n])" # file
    #"$n - $name"
# \tightlist
$suchen = "\\tightlist" # regulaerer Ausdruck
$ersetzen = "% Liste"
# regulaerer Ausdruck
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# \hypertarget
$suchen = "\\hypertarget{" # regulaerer Ausdruck
$ersetzen = "% "
# regulaerer Ausdruck
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# }{%
$suchen = "}{%" # regulaerer Ausdruck
$ersetzen = ""
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# }}
$suchen = "}}" # regulaerer Ausdruck
$ersetzen = "}"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Bilder
$suchen = "includegraphics" # regulaerer Ausdruck
$ersetzen = "includegraphics[width=0.7\textwidth]"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# \begin{figure}[hb]% hier: htbp
$suchen = "\\begin{figure}" # regulaerer Ausdruck
$ersetzen = "% Abbildung
%(vgl.~\ref{fig: }).% Referenz
\begin{figure}[hb]% hier: htbp"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\\end{figure}" # regulaerer Ausdruck
$ersetzen = "%\label{fig: }% Bildname
\end{figure}"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
# Quellcode
$suchen = "\\begin{lstlisting}" # regulaerer Ausdruck
$ersetzen = "% Quellcode (HTML5, Python, Bash, C, C++, TeX)
%(vgl.~\ref{code:}). % Referenz 
\begin{lstlisting}[language=$language,
%caption={ }, label={code: }% Codename
]"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name


# Tabelle
$suchen = "\[\]\{\@\{\}" # regulaerer Ausdruck
$ersetzen = ""
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\@\{\}" # regulaerer Ausdruck
# regulaerer Ausdruck
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\\begin\{longtable\}" # regulaerer Ausdruck
$ersetzen = "% Tabelle
%(vgl.~\ref{tab:}).% Referenz
\begin{table}[ht]% hier: htbp    
\centering
%\resizebox{\textwidth}{!}{%
\begin{tabular}{"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\\end\{longtable\}" # regulaerer Ausdruck
$ersetzen = "\end{tabular}
%} % resizebox_ENDE
%\caption{} \label{tab:}% Tabellenname
\end{table}"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\\toprule" # regulaerer Ausdruck
$ersetzen = "}% Ausrichten
\toprule"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
$suchen = "\\endhead" # regulaerer Ausdruck
$ersetzen = "% Inhalt"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: \tabularnewline
$suchen = "\\tabularnewline" # regulaerer Ausdruck
$ersetzen = " \\"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
#
# Ersetze: Ü uxfc-1 Ue
$suchen = "uxfc-1" # regulaerer Ausdruck
$ersetzen = "Ue"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: Ö uxf6-1 Oe
$suchen = "uxf6-1" # regulaerer Ausdruck
$ersetzen = "Oe"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: Ä uxe4-1 Ae
$suchen = "uxe4-1" # regulaerer Ausdruck
$ersetzen = "Ae"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: ü uxfc ue
$suchen = "uxfc" # regulaerer Ausdruck
$ersetzen = "ue"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: ö uxf6 oe
$suchen = "uxf6" # regulaerer Ausdruck
$ersetzen = "oe"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: ä uxe4 ae
$suchen = "uxe4" # regulaerer Ausdruck
$ersetzen = "ae"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: ß uxdf ss
$suchen = "uxdf" # regulaerer Ausdruck
$ersetzen = "ss"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: Anführungszeichen ``Text'' \flqq Text\frqq >>Text<<
$suchen = "``" # regulaerer Ausdruck
$ersetzen = ">"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# Ersetze: Anführungszeichen
$suchen = "''" # regulaerer Ausdruck
$ersetzen = "<< "
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name

# \textasciitilde{}
$suchen = "\\textasciitilde{}" # regulaerer Ausdruck
$ersetzen = "~"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name

# \def\labelenumi{\arabic{enumi}.}  \def\labelenumi{\alph{enumi})}
$suchen = "\\def\\labelenumi{\\arabic{enumi}.}" # regulaerer Ausdruck
$ersetzen = "% sortiert"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# \def\labelenumi{\alph{enumi})}
$suchen = "\\def\\labelenumi{\\alph{enumi}\)}" # regulaerer Ausdruck
$ersetzen = "% sortiert"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name

# Mathe
$suchen = "\\\(" # regulaerer Ausdruck
$ersetzen = "$"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
$suchen = "\\\)" # regulaerer Ausdruck
$ersetzen = "$"
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name
# \passthrough
$suchen = "\\passthrough" # regulaerer Ausdruck
$ersetzen = ""
(Get-Content $name) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content $name

}
}

# Funktionsaufruf
suchenErsetzenTeX

"Suchen und Ersetzen: fertig"