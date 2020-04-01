<#------------------------------------------------------ 
	PowerShell Script 
	update: 30-Mrz-20
	(c) 2020 Jan Unger 
  Abbildungen in LaTeX
------------------------------------------------------#>
Clear-Host # cls   

# variablen
$save = "images"    
$file = "abb.tex" 
$filter = "eps" # anpassen

cd $save

[array]$array = ls "*.$filter" 
for($n=0; $n -lt $array.length; $n++){# kleiner
  #$name = "$($array[$n])"            # file.tex
  $basename = "$($array.BaseName[$n])"# file
  #"$n - $basename"
  if($n -eq 0){# anpassen
    $temp = "\section{Abbildungen}\label{abbildungen} `n`n" # leer  
  }
  $temp += ">>$basename<< (vgl. Abb.~\ref{fig:$basename}).% Referenz
  % Abb.
\begin{figure}[H]% hier: hbtp 
  \centering
  \includegraphics[width=0.7\textwidth]{$save/$basename}
  \caption{$basename}%  Name
  \label{fig:$basename}% Ref.
\end{figure}
  `n`n"
  }

# schreibe in datei
$temp | Out-File $file -Encoding UTF8 
cp $file ../latex/tex

cd ..