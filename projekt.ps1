<#------------------------------------------------------ 
	PowerShell Script
	update: 1-Apr-20
	(c) 2020 Jan Unger 
	* Markdown - Pandoc: md -> docx, html, pdf, beamer, slidy
	* Git
	* Latex - pdflatex
	* HTML5 - css
	* Beamer
	* Backup - zip
------------------------------------------------------#>
Clear-Host # cls

#---------------------------------------
$thema = "Ordnerpaket-Notiz" # anpassen
$USB = "E:\repos\notizenWin10"
$RPI = "\\RPI4\nas\repos\notizenWin10"
#---------------------------------------
# imgTex.ps1
$orginal = "Orginalfoto"  
$beitrag = "Beitragsbild"
$kontakt = "Kontakt"
$footer = "Footer"
$logo = "Logo"
$icon = "Icon"

# Info
$info = "**Readme.txt** lesen

**Thema** anpassen und Speicherpfade und Git!
* 'projekt.ps1 '
* scripte/'git.ps1', 'backup.ps1', 'cms.ps1', 'pdf-erstellen.ps1'

**LaTeX** anpassen
* latex/content/'metadata.tex', 'literatur.bib'
* latex/content/'zusammenfassung.tex' -> latex/'book.tex' 
* latex/Grafiken/'titelbild.pdf'

**Notizen** in Markdown erstellen: min. 2x! 'md/*.md'

**PS-Script** ausführen: PS >_ '.\projekt.ps1'

**Projekt - Website** öffnen: 'Start.html'"


$info
"`n---------------------------------------"
"+ Projekt neu erstellen? .git loeschen?"
"---------------------------------------"
$var = Read-Host 'Eingabe - [j/n]' 
if($var -eq  "n"){# gleich
  "Viel Spaß"
}
else{
	if(test-path .git){
		".git Ordner wurde geloescht"
		rm -r .git -Force
		if(test-path img_auto/){ rm -r img_auto/ -force} 
		if(test-path word/)    { rm -r word/ -force} 
		if(test-path latex/images){ rm -r latex/images/ -force} 
		if(test-path latex/md) { rm -r latex/md/ -force}  
		if(test-path latex/tex){ rm -r latex/tex/ -force} 
		if(test-path latex/code){ rm -r latex/code/ -force} 
		if(test-path www/)     { rm -r www/ -force} 
		if(test-path md_gfm/)  { rm -r md_gfm/ -force} 

		"wenn Ordner löschen"
		if(test-path images/$orginal/){       rm -r images/$orginal/ -force} 
		if(test-path images/$beitrag/){       rm -r images/$beitrag/ -force} 
		if(test-path images/$kontakt/){       rm -r images/$kontakt/ -force} 
		if(test-path images/$footer/){        rm -r images/$footer/ -force} 
		if(test-path images/$logo/){          rm -r images/$logo/ -force} 
		if(test-path images/$icon/){          rm -r images/$icon/ -force} 
		if(test-path images/$aufloesungWeb/){ rm -r images/$aufloesungWeb/ -force} 

		if(test-path $HD/${thema}.git) { rm -r $HD/${thema}.git -force} 
		if(test-path $USB/${thema}.git){ rm -r $USB/${thema}.git -force} 
		if(test-path $RPI/${thema}.git){ rm -r $RPI/${thema}.git -force} 
	}

	# lokales Repository: HEAD -> master
	git init 
	git add .
	git commit -m"Projekt init"

<#
	# Repository auf Github erstellen
	$thema   = "Ordnerpaket-Notiz" # Repository
	$ADRESSE = "https://github.com/ju1-eu"
	git remote add origin $ADRESSE/${thema}.git
	git push --set-upstream origin master
#>

	# backupUSB
	if(test-path $USB/){ 
		$LESEZ = "backupUSB"
		git clone --no-hardlinks --bare . $USB/${thema}.git
		git remote add $LESEZ $USB/${thema}.git
		git push --all $LESEZ
	}
	
	# backupRPI
	if(test-path $RPI/){ 
		$LESEZ = "backupRPI"
		git clone --no-hardlinks --bare . $RPI/${thema}.git
		git remote add $LESEZ $RPI/${thema}.git
		git push --all $LESEZ
	}	
}	

# ordner neu erstellen
#if(!(test-path word/)){ md word/ -force} 
if(!(test-path img_auto/)){ md img_auto/ -force} 
if(!(test-path img_orig/)){ md img_orig/ -force} 
if(!(test-path latex/images)){ md latex/images -force} 
if(!(test-path latex/md)) { md latex/md -force} 
if(!(test-path latex/tex)){ md latex/tex -force} 
if(!(test-path latex/code)){ md latex/code -force}
if(!(test-path www/cms)){ md www/cms -force} 
if(!(test-path www/css)){ md www/css -force} 
if(!(test-path www/images)){ md www/images -force} 
if(!(test-path www/md)) { md www/md -force}  
if(!(test-path www/pdfs)){ md www/pdfs -force}
if(!(test-path www/code)){ md www/code -force}
if(!(test-path md_gfm/))  { md md_gfm/ -force} 

# bilder optimieren
.\scripte\imgTeX.ps1

# Alle Abb. in Latex speichern: images/abb.tex
.\scripte\abb-in-eps-TeX.ps1
# Alle *.c in Latex speichern: code/code.tex
.\scripte\quellcode-in-TeX.ps1

# pandoc markdown in docx, tex, html
.\scripte\pandoc.ps1

# suchen und ersetzen
.\scripte\suchenErsetzen.ps1

# pdf erstellen
.\scripte\pdf-erstellen.ps1

# aufräumen
.\scripte\clean-tex.ps1

# start.html
.\scripte\www.ps1

# cms - wordpress
.\scripte\cms.ps1

# git
.\scripte\git.ps1

# backup
.\scripte\backup.ps1

