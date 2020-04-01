<#------------------------------------------------------ 
  PowerShell Script
  update: 1-Apr-20
  (c) 2020 Jan Unger  
  * loescht ordner, wenn vorhanden, recursiv, 
      schreibgeschützt, versteckt (unix)
  * räumt Latex files auf
------------------------------------------------------#>
Clear-Host # cls

# loescht ordner
# Funktionsaufruf: aufraeumenTeX
function aufraeumenTeX{
  # latexmk artikel.tex, print.tex
  #if(test-path ./*.aux){rm *.aux -force -recurse}
  #if(test-path ./*.bbl){rm *.bbl -force -recurse}
  #if(test-path ./*.ind){rm *.ind -force -recurse}
  #if(test-path ./*.fdb*){rm *.fdb* -force -recurse}
  #if(test-path ./*.dvi){rm *.dvi -force -recurse}
  # pdflatex book.tex
  if(test-path ./book.aux){rm book.aux -force -recurse}
  if(test-path ./book.bbl){rm book.bbl -force -recurse}
  if(test-path ./*-blx.bib){rm *-blx.bib -force -recurse}
  if(test-path ./*.log){rm *.log -force -recurse}
  if(test-path ./*.out){rm *.out -force -recurse}
  if(test-path ./*.out.ps){rm *.out.ps -force -recurse}
  if(test-path ./*.synctex*){rm *.synctex* -force -recurse}
  if(test-path ./*.bcf){rm *.bcf -force -recurse}
  if(test-path ./*.blg){rm *.blg -force -recurse}
  if(test-path ./*.run*){rm *.run* -force -recurse}
  if(test-path ./*.toc){rm *.toc -force -recurse}
  if(test-path ./*.fls){rm *.fls -force -recurse}
  if(test-path ./*.idx){rm *.idx -force -recurse}
  if(test-path ./*.lof){rm *.lof -force -recurse}
  if(test-path ./*.lot){rm *.lot -force -recurse}
  if(test-path ./*.lol){rm *.lol -force -recurse}
  if(test-path ./*.ilg){rm *.ilg -force -recurse}
  if(test-path ./*.nav){rm *.nav -force -recurse}
  if(test-path ./*.snm){rm *.snm -force -recurse}
  if(test-path ./*.vrb){rm *.vrb -force -recurse}
}

# loescht ordner
# Funktionsaufruf: 
cd latex/
aufraeumenTeX
cd ..

cd www/
if(test-path ./*cms.html){rm *cms.html -force}
cd ..

if(test-path ./*.html){rm ./*.html -force} 
if(test-path ./*.docx){rm ./*.docx -force} 
if(test-path ./*.tex){rm  ./*.tex -force} 
