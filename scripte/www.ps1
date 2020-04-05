<#------------------------------------------------------ 
	PowerShell Script
	update: 1-Apr-20
  (c) 2020 Jan Unger 
  * www/ Websiten in HTML5 u. CMS Wordpress
  * Start.html
------------------------------------------------------#>
Clear-Host # cls

#---------------------------------
# code/ ?
# Codeformate: c, cpp, sh, py, tex 
$codeformat = "c" 

# img/ ?
# Bildformate: svg, jpg, png, webp
$bildformat = "webp"  
#---------------------------------

# variablen
$www = "www"
$cms = "cms"
$css = "css"
$img = "images"
$pdf = "pdf"
$webDesign = "$css/design.css"
$code = "code"
$pdfs = "pdfs"
$latex = "latex"

# kopie
cp ./$latex/*.pdf  ./$www/$pdfs/ 

# www/
robocopy css/ www/css/ /mir /e /NFL /NDL /NJH /TEE 
robocopy code/ www/code/ /mir /e /NFL /NDL /NJH /TEE
robocopy images/ www/images/ /mir /e /NFL /NDL /NJH /TEE 

if(test-path www/images/fallback){
  rm -r www/images/*.eps -force
  rm -r www/images/*.pdf -force
  rm -r www/images/*.tex -force
  rm -r www/images/fallback -force
}

robocopy md/ www/md/ /mir /e /NFL /NDL /NJH /TEE 
cp *.html  www/ 
cp *cms.html www/cms/ 
if(test-path $www/Start.html){rm -r $www/Start.html -force} 

# html
function suchenErsetzenHTML{
  $filter = "html"
  #$www = "www"
  [array]$array = ls "./$www/*.$filter"
	#$array 
  # array auslesen
  for($n=0; $n -lt $array.length; $n++){   # kleiner
    #$name = "$($array[$n])"              # file.tex
    $basename = "$($array.BaseName[$n])" # file
    #"--------------"
    #"$n - $basename"
    #"--------------"
    
    # <embed src=`"img
    $suchen = "<embed src=`"img" # regulaerer Ausdruck
    $ersetzen = "<img class=`"scaled`" src=`"img"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
    
    # alt u. Bildgröße
    $suchen = "/><figcaption" # regulaerer Ausdruck
    $ersetzen = "alt=`"Bildname`" class=`"scaled`" /><figcaption"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
    
    # <img
    $suchen = "<embed" # regulaerer Ausdruck
    $ersetzen = "<img"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
    

    # $www/$img/logo.svg o. logo.webp
    # if(test-path *.svg){pdf in svg o. eps in svg}
    [array]$array_2 = ls "./$www/$img/*.svg" 
    # array auslesen
    for($m=0; $m -lt $array_2.length; $m++){   # kleiner
      #$name_2 = "$($array_2[$m])"             # file.svg
      $basename_2 = "$($array_2.BaseName[$m])" # file
      #"$m - $basename_2"
      if(test-path "./$www/$img/${basename_2}.svg"){
        # bildformat: eps -> svg
        $suchen = "${basename_2}.eps" # regulaerer Ausdruck
        $ersetzen = "${basename_2}.svg"
        # regulaerer Ausdruck
        (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
        # bildformat: pdf -> svg
        $suchen = "${basename_2}.pdf" # regulaerer Ausdruck
        $ersetzen = "${basename_2}.svg"
        # regulaerer Ausdruck
        (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
      }
    }

    # if(test-path *.webp){pdf in webp o. eps in webp}
    [array]$array_3 = ls "./$www/$img/*.webp"
    # array auslesen
    for($k=0; $k -lt $array_3.length; $k++){   # kleiner
      #$name_3 = "$($array_3[$k])"             # file.webp
      $basename_3 = "$($array_3.BaseName[$k])" # file
      #"$k - $basename_3"
      if(test-path "./$www/$img/${basename_3}.webp"){
        # bildformat: pdf -> webp
        $suchen = "${basename_3}.pdf" # regulaerer Ausdruck
        $ersetzen = "${basename_3}.webp"
        # regulaerer Ausdruck
        (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
        # bildformat: eps -> webp
        $suchen = "${basename_3}.eps" # regulaerer Ausdruck
        $ersetzen = "${basename_3}.webp"
        # regulaerer Ausdruck
        (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter" 
      }
    }

    # <style type="text/css">
    $suchen = "<style type=`"text/css`">" # regulaerer Ausdruck
    $ersetzen = "<style>"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
    
    # <html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
    $suchen = "<html xmlns=`"http://www.w3.org/1999/xhtml`" lang=`"`" xml:lang=`"`">" # regulaerer Ausdruck
    $ersetzen = "<html lang=`"de`">"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
  
    # <meta name="generator" content="pandoc" />
    $suchen = "<meta name=`"generator`" content=`"pandoc`" />" # regulaerer Ausdruck
    $ersetzen = "<!---->"
    # regulaerer Ausdruck
    (Get-Content "./$www/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$basename.$filter"
    
  }
}

  
## Funktionsaufruf: 
suchenErsetzenHTML



### Funktionsaufruf: htmlFiles $fileTitel $fileHTML $fileTyp $filter
function htmlFiles{
  param( 
    [string]$fileTitel,
    [string]$fileHTML,
    [string]$fileTyp,
    [string]$filter
  ) 
  $textHTML = "<!DOCTYPE html>
<html lang=`"de`"><head>
  <meta charset=`"UTF-8`" />
  <title>$fileTitel</title>                         <!-- Titel        -->
  <meta name=`"description`" content=`"Keywords`" /><!-- Beschreibung -->
  <meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0, user-scalable=yes`" />
  <link rel=`"stylesheet`" href=`"$webDesign`" />
</head><body>
<!-- Inhalt -->
<h1>$fileTitel</h1>
<p>Inhalt</p>
<ul class=`"nav`"><!-- Liste -->"
  # schreibe in datei 
  $textHTML | Set-Content ./$www/$fileHTML
  #$filter = "*.pdf"
  [array]$array = ls "./$fileTyp/*.$filter" -Force 
  # array auslesen
  #$picnummer = 1
  for($n=0; $n -lt $array.length; $n++){   # kleiner
    #$name = "$($array[$n])"              # file.tex
    $basename = "$($array.BaseName[$n])" # file
    #"$n - $basename"
    $textHTML = "   <li><a href=`"$fileTyp/$basename.$filter`">$basename.$filter</a></li>"
    # schreibe in datei hinzu
    $textHTML | Add-Content ./$www/$fileHTML
    #$picnummer++ 
  }
  $textHTML = "</ul>`n<!-- Ende -->`n</body></html>"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$fileHTML
}


# html: alle-PDF-files.html
"+++ alle-PDF-files.html"
$titel = "PDFs"
$fileHTML  = "alle-PDF-files.html"
$textHTML = "<!DOCTYPE html>
<html lang=`"de`"><head>
  <meta charset=`"UTF-8`" />
  <title>$titel</title>                         <!-- Titel        -->
  <meta name=`"description`" content=`"Keywords`" /><!-- Beschreibung -->
  <meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0, user-scalable=yes`" />
  <link rel=`"stylesheet`" href=`"$webDesign`" />
</head><body>
<!-- Inhalt -->
<h1>$fileHTML</h1>
<p>Inhalt</p>
<ul class=`"nav`"><!-- Liste -->"

# schreibe in datei 
$textHTML | Set-Content ./$www/$fileHTML  
$filter = $pdf 
[array]$array = ls "./$www/$pdfs/*.$filter" -Force 
# array auslesen
for($n=0; $n -lt $array.length; $n++){   # kleiner
  #$name = "$($array[$n])"              # file.tex
  $basename = "$($array.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "   <li><a href=`"$pdfs/$basename.$filter`">$basename.$filter</a></li>"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$fileHTML
}
$textHTML = "</ul>`n<!-- Ende -->`n</body></html>"
# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$fileHTML


# html: alle-Code-files.html
"+++ alle-Code-files.html"
$fileTitel = "Quellcode"
$fileHTML  = "alle-Code-files.html"
$fileTyp   = $code
$filter    = $codeformat   # Codeformate: c, cpp, sh, py, tex
### Funktionsaufruf: 
htmlFiles $fileTitel $fileHTML $fileTyp $filter


# html: alle-Abb-files.html
"+++ alle-Abb-files.html"
$fileTitel = "Abbildungen"
$fileHTML  = "alle-Abb-files.html"
$fileTyp   = $img
$filter    = $bildformat # Bildformate: svg, jpg, png, webp
### Funktionsaufruf: 
htmlFiles $fileTitel $fileHTML $fileTyp $filter

"+++ alle-Pics.html"
$titel = "Pics"
$fileHTML =  "alle-Pics.html"
$textHTML = "<!DOCTYPE html>
<html lang=`"de`"><head>
  <meta charset=`"UTF-8`" />
  <title>$titel</title>                           <!-- Titel -->
  <meta name=`"description`" content=`"$titel`" /><!-- Beschreibung -->
  <meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0, user-scalable=yes`" />
  <link rel=`"stylesheet`" href=`"$webDesign`" />
</head><body>
<!-- Inhalt -->
<h1>$titel</h1>
<p>Inhalt</p>"

# schreibe in datei 
$textHTML | Set-Content ./$www/$fileHTML  
$filter = $bildformat # Bildformate: svg, jpg, png, webp
[array]$arrayAbb = ls "./$img/*.$filter" -Force 
# array auslesen
$picnummer = 1
for($n=0; $n -lt $arrayAbb.length; $n++){   # kleiner
  #$name = "$($arrayAbb[$n])"              # file.tex
  $basename = "$($arrayAbb.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "<!-- Abb. $picnummer -->
<a href=`"$img/$basename.$filter`"> 
  <figure> <img class=`"scaled`" src=`"$img/$basename.$filter`" alt=`"$basename`" />
    <figcaption>Abb. $picnummer : $basename</figcaption>
  </figure>
</a>"

  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$fileHTML
  $picnummer++ 
}
$textHTML = "<!-- Ende -->`n</body></html>"
# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$fileHTML


"+++ Start.html - alle html-Seiten"
$titel = "Start"
$fileHTML =  "Start.html"
$textHTML = "<!DOCTYPE html>
<html lang=`"de`"><head>
  <meta charset=`"UTF-8`" />
  <title>$titel</title>                             <!-- Titel -->
  <meta name=`"description`" content=`"Keywords`" /><!-- Beschreibung -->
  <meta name=`"viewport`" content=`"width=device-width, initial-scale=1.0, user-scalable=yes`" />
  <link rel=`"stylesheet`" href=`"$webDesign`" />
</head><body>
<!-- Inhalt -->
<h1>$titel</h1>
<p>Inhalt</p>
<ul class=`"nav`"><!-- Liste -->"

# schreibe in datei 
$textHTML | Set-Content $fileHTML  
$filter = "html"
[array]$arrayHTML = ls "./$www/*.$filter" -Force 
# array auslesen
for($n=0; $n -lt $arrayHTML.length; $n++){   # kleiner
  #$name = "$($arrayHTML[$n])"              # file.tex
  $basename = "$($arrayHTML.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "   <li><a href=`"$www/$basename.html`">$basename</a></li>"
  # schreibe in datei hinzu
  $textHTML | Add-Content $fileHTML
}
$textHTML = "</ul>`n<!-- Ende -->`n</body></html>"
# schreibe in datei hinzu
$textHTML | Add-Content $fileHTML


"www u. Start.html erstellt."

