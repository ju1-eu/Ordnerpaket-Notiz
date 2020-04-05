<#------------------------------------------------------ 
	PowerShell Script
	update: 3-Apr-20
  (c) 2020 Jan Unger 
  * Seiten für CMS Wordpress
------------------------------------------------------#>
Clear-Host # cls

#---------------------------------------
$thema  = "Ordnerpaket-Notiz" # anpassen
# 
# Bildformate: svg, jpg, png
#---------------------------------------

# variablen
$www = "www"
$cms = "cms"
$img = "images"
$jahr = Get-Date -Format 'yyyy' # 2020
$monat = Get-Date -Format 'MM'  # 04
$timestamp = "$jahr/$monat"      

function suchenErsetzenCMS{
  $filter = "html"
  #$www = "www"
  [array]$array = ls "./$www/$cms/*.$filter"
	#$array 
  # array auslesen
  for($n=0; $n -lt $array.length; $n++){   # kleiner
    #$name = "$($array[$n])"              # file.tex
    $basename = "$($array.BaseName[$n])" # file
    "--------------"
    "$n - $basename"
    "--------------"
    
    # <embed src=`"img
    $suchen = "<embed src=`"img" # regulaerer Ausdruck
    $ersetzen = "<img class=`"scaled`" src=`"img"
    # regulaerer Ausdruck
    (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
    
    # alt u. Bildgröße
    $suchen = "/><figcaption" # regulaerer Ausdruck
    $ersetzen = "alt=`"Bildname`" class=`"scaled`" /><figcaption"
    # regulaerer Ausdruck
    (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
    
    # <img
    $suchen = "<embed" # regulaerer Ausdruck
    $ersetzen = "<img"
    # regulaerer Ausdruck
    (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
    

    # $www/$img/logo.svg o. logo.webp
    # if(test-path *.svg){pdf in svg o. eps in svg}
    [array]$array_2 = ls "./$www/$img/*.svg" 
    # array auslesen
    for($m=0; $m -lt $array_2.length; $m++){   # kleiner
      #$name_2 = "$($array_2[$m])"             # file.svg
      $basename_2 = "$($array_2.BaseName[$m])" # file
      "$m - $basename_2"
      if(test-path "./$www/$img/${basename_2}.svg"){
        # bildformat: eps -> svg
        $suchen = "${basename_2}.eps" # regulaerer Ausdruck
        $ersetzen = "${basename_2}.svg"
        # regulaerer Ausdruck
        (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
        # bildformat: pdf -> svg
        $suchen = "${basename_2}.pdf" # regulaerer Ausdruck
        $ersetzen = "${basename_2}.svg"
        # regulaerer Ausdruck
        (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
      }
    }

    # if(test-path *.webp){pdf in webp o. eps in webp}
    [array]$array_3 = ls "./$www/$img/*.webp"
    # array auslesen
    for($k=0; $k -lt $array_3.length; $k++){   # kleiner
      #$name_3 = "$($array_3[$k])"             # file.webp
      $basename_3 = "$($array_3.BaseName[$k])" # file
      "$k - $basename_3"
      if(test-path "./$www/$img/${basename_3}.webp"){
        # bildformat: pdf -> webp
        $suchen = "${basename_3}.pdf" # regulaerer Ausdruck
        $ersetzen = "${basename_3}.webp"
        # regulaerer Ausdruck
        (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter"
        # bildformat: eps -> webp
        $suchen = "${basename_3}.eps" # regulaerer Ausdruck
        $ersetzen = "${basename_3}.webp"
        # regulaerer Ausdruck
        (Get-Content "./$www/$cms/$basename.$filter") | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content "./$www/$cms/$basename.$filter" 
      }
    }
  }
}
  
## Funktionsaufruf: 
suchenErsetzenCMS


"+ Links-auf-Bilder.txt"
$fileHTML =  "Links-auf-Bilder.txt"
$textHTML = "# Thema - $thema

## Links auf Bilder

Pfad - lokaler Server: 
http://localhost/wordpress/wp-content/uploads/$timestamp/

Pfad - Webhoster:
https://bw-ju.de/wp-content/uploads/$timestamp/

*.svg o. *.png o. *.jpg

## Medien in Wordpress öffnen

Bilder hinzufügen.
"

# erstelle datei 
$textHTML | Set-Content ./$www/$cms/$fileHTML  

# alle Bilder
[array]$arrayAbb = ls "./$www/$img/*.*" -Force 
# array auslesen
for($n=0; $n -lt $arrayAbb.length; $n++){ # kleiner
  $name = "$($arrayAbb[$n])"             # file.tex
  #$basename = "$($arrayAbb.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "* $name"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}
$textHTML = "`n~~~"
# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 

# suchen und ersetzen
# pwd
# regulaerer Ausdruck
$suchen = "C:\\daten\\tex\\Ordnerpaket-Notiz\\www\\images\\"
$ersetzen = ""
(Get-Content ./$www/$cms/$fileHTML) | Foreach-Object {$_ -replace "$suchen", "$ersetzen"} | Set-Content ./$www/$cms/$fileHTML



# svg
$filter = "svg" # Bildformate: svg, jpg, png
[array]$arrayAbb = ls "./$www/$img/*.$filter" -Force 
# array auslesen
for($n=0; $n -lt $arrayAbb.length; $n++){ # kleiner
  #$name = "$($arrayAbb[$n])"             # file.tex
  $basename = "$($arrayAbb.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "<figure>
  <a href=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename.$filter`">
  <img src=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename.$filter`" 
    alt=`"$basename`" width=`"300`"></a>
  <figcaption>Abb. : $basename</figcaption>
</figure>
"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}

# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 

# jpg
$filter = "jpg" # Bildformate: svg, jpg, png
[array]$arrayAbb_2 = ls "./$www/$img/*.$filter" -Force 
# array auslesen
for($n=0; $n -lt $arrayAbb_2.length; $n++){ # kleiner
  #$name = "$($arrayAbb_2[$n])"             # file.tex
  $basename_2 = "$($arrayAbb_2.BaseName[$n])" # file
  #"$n - $basename_2"
  $textHTML = "<figure>
  <a href=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename_2.$filter`">
  <img src=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename_2.$filter`" 
    alt=`"$basename_2`" width=`"300`"></a>
  <figcaption>Abb. : $basename_2</figcaption>
</figure>
"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}

# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 

# png
$filter = "png" # Bildformate: svg, jpg, png
[array]$arrayAbb_3 = ls "./$www/$img/*.$filter" -Force 
# array auslesen
for($n=0; $n -lt $arrayAbb_3.length; $n++){ # kleiner
  #$name = "$($arrayAbb_3[$n])"             # file.tex
  $basename_3 = "$($arrayAbb_3.BaseName[$n])" # file
  #"$n - $basename_3"
  $textHTML = "<figure>
  <a href=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename_3.$filter`">
  <img src=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$basename_3.$filter`" 
    alt=`"$basename_3`" width=`"300`"></a>
  <figcaption>Abb. : $basename_3</figcaption>
</figure>
"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}

$textHTML = "~~~"

# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 



"+ Links-auf-Seiten.txt"
$fileHTML =  "Links-auf-Seiten.txt"
$textHTML = "# Thema - $thema

## Links auf Seiten

* Pfad - lokaler Server: http://localhost/wordpress
* Pfad - Webhoster:      https://bw-ju.de

## Erstelle Seiten in Wordpress

* $thema"

# erstelle datei 
$textHTML | Set-Content ./$www/$cms/$fileHTML 

# webseiten
$filter = "html"
[array]$arrayHTML = ls "./$www/$cms/*.$filter" 
# array auslesen
for($n=0; $n -lt $arrayHTML.length; $n++){ # kleiner
  #$name = "$($arrayHTML[$n])"             # file.tex
  $basename = "$($arrayHTML.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "* $basename"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}
$textHTML = "
~~~
<h1>$thema</h1>

<h2>Inhalt</h2>   

<ul>"

# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 

# Links auf Seiten
$filter = "html"
[array]$arrayHTML = ls "./$www/$cms/*.$filter" 
# array auslesen
for($n=0; $n -lt $arrayHTML.length; $n++){ # kleiner
  #$name = "$($arrayHTML[$n])"             # file.tex
  $basename = "$($arrayHTML.BaseName[$n])" # file
  #"$n - $basename"
  $textHTML = "  <li><a href=`"http://localhost/wordpress/$basename`">$basename</a></li>"
  # schreibe in datei hinzu
  $textHTML | Add-Content ./$www/$cms/$fileHTML 
}
$textHTML = "</ul>

<h2>Download</h2>

<ul>
 	<li><a href=`"http://localhost/wordpress/wp-content/uploads/$timestamp/$thema-book.pdf`">$thema-book.pdf</a></li>
</ul>
~~~"

# schreibe in datei hinzu
$textHTML | Add-Content ./$www/$cms/$fileHTML 

# suchen und ersetzen
(Get-content ./$www/$cms/$fileHTML -Encoding UTF8) -replace '-cms','' | Out-File ./$www/$cms/$fileHTML -Encoding UTF8



"+ Bilderordner-images.txt"
$fileHTML =  "Bilderordner-images.txt"
$textHTML = "# Thema - $thema

## Bilderordner - images

Web optimierte Fotos aus jpg o.png:

* quer: 1600x1200 
* hoch: 800x1200
* 1600x
* 960x
* Kontakt: 1920x1080 
* Footer: 1920x180
* Logo: 340x180
* Icon: 512x512
* Beitragsbild: 2560x1440
* Verkaufsfoto: Original ACHTUNG: Auflösung wird nicht verändert!
"

# erstelle datei 
$textHTML | Set-Content ./$www/$cms/$fileHTML 


"CMS - Wordpress => 
* Links-auf-Bilder.txt
* Links-auf-Seiten.txt
* Bilderordner-images.txt  erstellt."

