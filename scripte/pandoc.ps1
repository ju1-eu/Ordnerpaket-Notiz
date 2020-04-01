<#------------------------------------------------------ 
	PowerShell Script 
	update: 1-Apr-20
  (c) 2020 Jan Unger 
  * Markdown - Pandoc: md -> html, tex, 
  * Markdown - Pandoc: md -> beamer, slidy, docx
------------------------------------------------------#>
Clear-Host # cls

#-------------------------------
$webDesign = "css/design.css"
#$webDesign  = "css/buch.css"
#$header    = "latex/header.tex"
#-------------------------------

# Markdown - Pandoc: md -> html, tex
cd md/
[array]$array = ls "*.md" 
for ($x=0; $x -lt $array.length; $x++) {# -lt = kleiner
  $name = "$($array[$x])"               # file.md
  $basename = "$($array.BaseName[$x])"  # file
  # GitHub Flavored Markdown - gfm
  pandoc -t markdown_github $name -o "../md_gfm/$basename.md"
  # latex
  pandoc -t latex --listings "$basename.md" -o "../$basename.tex"
  # html5
  pandoc -s -t html5 --from markdown+smart  --strip-comments --toc -c $webDesign "$basename.md" -o "../$basename.html"
  pandoc -t html5 --from markdown+smart  --strip-comments "$basename.md" -o "../$basename-cms.html"
}

<#
# Markdown - Pandoc: md -> beamer, slidy, docx
[array]$array = ls "*.md" 
for ($x=0; $x -lt $array.length; $x++) {# -lt = kleiner
  $name = "$($array[$x])"               # file.md
  $basename = "$($array.BaseName[$x])"  # file
  # latex - beamer
  pandoc --slide-level 2 --listings -t beamer -H $header "$basename.md" -o "../$basename-beamer.pdf"
  # Word
  pandoc "$basename.md" -o "../$basename.docx"
  # html5 - slidy + slidy-sc (offline)
  pandoc -s -t slidy --webtex "$basename.md" -o "../$basename-slidy.html"
  pandoc -s -t slidy --webtex --self-contained  "$basename.md" -o "../$basename-slidy-sc.html"
}
#>

cd ..