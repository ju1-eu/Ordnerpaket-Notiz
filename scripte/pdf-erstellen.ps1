<#------------------------------------------------------ 
	PowerShell Script
	update: 1-Apr-20
  (c) 2020 Jan Unger 
  * PDFs erstellen
  * LaTeX - pdflatex o. latexmk
------------------------------------------------------#>
Clear-Host # cls

# variablen
$autor  = "Jan Unger"
$inhalt = "inhalt.tex"
$timestamp = Get-Date -Format 'yyyy' # 2020
$text = "% Inhalt `n% (c) $timestamp $autor"

# latex/
robocopy images/ latex/images/ /mir /e /NFL /NDL /NJH /TEE 
robocopy code/ latex/code/ /mir /e /NFL /NDL /NJH /TEE 
robocopy md/ latex/md/ /mir /e /NFL /NDL /NJH /TEE
cp *.tex latex/tex/  

# Beamer u. Word
#cp *.docx  word/ 
#cp *beamer.pdf  latex/
#if(test-path ./*beamer.pdf){rm ./*beamer.pdf -force -recurse}

# www/
robocopy css/ www/css/ /mir /e /NFL /NDL /NJH /TEE 
robocopy code/ www/code/ /mir /e /NFL /NDL /NJH /TEE
robocopy images/ www/images/ /mir /e /NFL /NDL /NJH /TEE 
robocopy md/ www/md/ /mir /e /NFL /NDL /NJH /TEE 
cp *.html  www/ 
cp *cms.html www/cms/ 

# Funktion: erstellt inhalt.tex
# Aufruf:   inhaltTeX
function inhaltTeX{
  # schreibe in datei: inhalt.tex 
  $text | Set-Content $inhalt 

  [array]$array = ls "tex/*.tex"
  # array auslesen
  for($n=0; $n -lt $array.length; $n++){  # kleiner
    #$name = "$($array[$n])"              # file.tex
    $basename = "$($array.BaseName[$n])"  # file
    #"$n - $basename"
    $text = "%\chapter{$basename} `n\input{tex/$basename}`n\clearpage" 
    # schreibe in datei 
    $text | Add-Content ./$inhalt
  }
}


# pdfs erstellen
cd latex/

# Funktionsaufruf
inhaltTeX

# LaTeX - latexmk
latexmk -pdf artikel.tex
#latexmk -pdf print.tex

# LaTeX - pdflatex
# Usereingabe
"+++ Book erstellen ?"
$var = Read-Host 'Eingabe - [j/n]' 
if($var -eq  "n"){# gleich
  "PS-Script .\scripte\pdf-erstellen.ps1 wird beendet"
}
else{
  #pdflatex artikel.tex
  #bibtex   artikel
  #pdflatex artikel.tex
  #pdflatex artikel.tex

  pdflatex book.tex
  bibtex   book
  pdflatex book.tex
  pdflatex book.tex

  pdflatex print.tex
  bibtex   print
  pdflatex print.tex
  pdflatex print.tex
}

cd ..
