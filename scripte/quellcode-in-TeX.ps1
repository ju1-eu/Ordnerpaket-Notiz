<#------------------------------------------------------ 
	PowerShell Script 
	update: 25-Apr-20
	(c) 2020 Jan Unger 
  Quellcode in LaTeX
------------------------------------------------------#>
Clear-Host # cls   

# variablen
$save = "code"    
$file = "code.tex" 
$filter = "c"       # anpassen Codeformate: c, cpp, sh, py, tex 
$language = "C" # anpassen Sprache: C, TeX, Bash, Python

cd $save

[array]$array = ls "*.$filter" 
for($n=0; $n -lt $array.length; $n++){# kleiner
  #$name = "$($array[$n])"             # file.tex
  $basename = "$($array.BaseName[$n])"# file
  #"$n - $basename"
  if($n -eq 0){# anpassen
    $temp = "\section{Quellcode}\label{quellcode} `n`n" # leer  
  }
  $temp += "Programm >>$basename.$filter<< (vgl. Quelltext~\ref{code:$basename}).% Referenz
  % Code
\lstinputlisting[language=$language,% C, TeX, Bash, Python
  caption={$basename.$filter},% Name
  label={code:$basename}% Ref.
]{$save/$basename.$filter}% file
  `n`n"
  }

# schreibe in datei
$temp | Out-File $file -Encoding UTF8 

cp $file ../latex/tex

cd ..