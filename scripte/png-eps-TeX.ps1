<#------------------------------------------------------ 
	PowerShell Script 
	update: 30-Mrz-20
	(c) 2020 Jan Unger 
  web optimierte Fotos aus png:
	* quer: 1600x1200 
	* hoch: 800x1200
	* kontakt: 1920x1080 
	* footer: 1920x180
	* logo: 340x180
	* Icon: 512x512
	* Beitragsbild: 2560x1440
	* Verkaufsfoto: 5760x3840 bzw. Original
------------------------------------------------------#>
Clear-Host # cls

# optimiert Fotos für Web und TeX
## Funktionsaufruf: imgTeX
function imgTeX{
  $tmp = 'temp' # bildname anpassen
  $aufloesungTex = '1600x1200'  # B5 = 728x516
  $aufloesungWeb = '1600x1200' # 1920x1080 1600x1100 
  $qualitaetWeb = '75%' # ImageMagik: 82% = Photoshop: 60%
  $img_orig = 'img_orig'
  $img_auto = 'img_auto'

  # Usereingabe
  "+++ Sind >>PNG<< im Ordner '$img_orig' ?"
  $var = Read-Host 'Eingabe - [j/n]' 
  if($var -eq  "n"){# gleich
    ".\scripte\imgTeX.ps1 PS-Script wird beendet"
    exit
  }
  else{
    "`n+++ Verzeichnis erstellen oder loeschen"
    # loescht ordner, wenn vorhanden, recursiv, schreibgeschützt, versteckt (unix)
    if (test-path ./$img_auto) { rm -r ./$img_auto/* -force} 


    # ordner erstellen
    md ./$img_auto/$tmp
    md ./$img_auto/$aufloesungTex
    md ./$img_auto/fallback

    "`n+++ Kopie erstellen: $img_orig => $img_auto/$tmp"
    cp -r  ./$img_orig/* ./$img_auto/$tmp -Force

    cd ./$img_auto

    "+++ files umbennen"
    #cd $tmp
    # Dateiendung
    #ls -r | ren -NewName {$_.fullname -replace ".JPG", ".jpg"} -ea SilentlyContinue
    #ls -r | ren -NewName {$_.fullname -replace ".jpeg", ".jpg"} -ea SilentlyContinue
    # Leerzeichen
    #ls -r | ren -NewName {$_.name -replace "_", "-"} -ea SilentlyContinue
    #ls -r | ren -NewName {$_.name -replace " ", ""} -ea SilentlyContinue
    # webserver
    #ls -r | ren -NewName {$_.name -replace "-", "_"} -ea SilentlyContinue
    # Umlaute
    # ergaenzen
    #cd ..

    # Funktionen
    # Funktion: Bildqualitaet optimieren
    # Funktionsaufruf: imgOpti $out/ $qualitaet $in/*
    function imgOpti() {
      param ( 
        [string] $out, 
        [string] $aufloesung,
        [string] $qualitaet, 
        [string] $in
      )  
      #mogrify -path $out/ -resize 300 $in/*
      # Einstellungen mit Optimierung
      # automatisch drehen: -auto-orient
      # Exif-Infos aus dem Bild entfernen = -strip
      mogrify -path $out/ -auto-orient  -thumbnail  $aufloesung -quality $qualitaet -interlace none  -strip $in/*
     }


    # Funktion: Bildaufloesung aendern
    # Funktionsaufruf: imgResize $out/ $aufloesung $in/*
    function imgResize() {
      param ( 
        [string] $out, 
        [string] $aufloesung, 
        [string] $in
      )  
      #mogrify -path $out/ -resize 300 $in/*
      # Einstellungen mit Optimierung
      mogrify -path $out/ -thumbnail $aufloesung $in/*
    }

      "+++ pics umbenennen - Ordner-001.jpg"
      #exiftool -P -fileOrder datetimeoriginal '-fileName<${directory}%-.3nc.%le' $tmp/* -r
      #"+++ pics umbenennen - Ordner-filename-001.jpg"
      #exiftool -P -fileOrder datetimeoriginal '-fileName<${directory}-%f%-.3nc.%e' $tmp/* -r
      

      ### Web und Latex
      # Bildqualitaet optimieren
      # Funktionsaufruf: imgOpti $out/ $qualitaet $in/*
      "+++ Web - Bildaufloesung $aufloesungWeb Bildqualitaet  $qualitaetWeb"
      imgOpti ./ $aufloesungWeb $qualitaetWeb $tmp

      cd ..

      # Bildaufloesung aendern
      # Funktionsaufruf: imgResize $out/ $aufloesung $in/*
      "+++ LaTeX - Bildaufloesung $aufloesungTex"
      #imgResize "$img_auto/$aufloesung" $aufloesung $img_auto
      imgResize ./$img_auto/$aufloesungTex $aufloesungTex $img_auto

      cd $img_auto/

      "+++ LaTeX - Bilder in pdf umwandeln"
      #mogrify -format pdf $aufloesungTex/*.jpg 
      mogrify -format pdf $aufloesungTex/*.png
      cp $aufloesungTex/*.pdf ./
      mogrify -format eps $aufloesungTex/*.png
      cp $aufloesungTex/*.eps ./

      # Komprimiert den Inhalt eines Verzeichnisses
      #ls $ordner | Compress-Archive -Update -dest "$archiv/$ordner.zip"

      # Kopie loeschen
      rm -r $tmp -force
      rm -r $aufloesungTex -force


    # WebP
    <#
    "+ jpg in webp Format konvertieren"
    $filter = "*.jpg"
    [array]$array = ls ./ $filter 
    # array auslesen
    for($n=0; $n -lt $array.length; $n++){   # kleiner
        #$name = "$($array[$n])"              # file.jpg
        $basename = "$($array.BaseName[$n])" # file
        #"$n - $name"
        # lossless = true, false codiert das Bild verlustfrei.
        convert "$basename.jpg" -quality 75 -define webp:lossless=true "$basename.webp"
        #convert "./$basename.jpg" -quality 75 "./$basename.webp"
        # wasserzeichen
        #composite -watermark 15% -geometry +5+5 -gravity SouthEast "../images/logo.svg" "./$basename.webp" "./$basename-Wasserzeichen.webp"
        #composite -watermark 15% -geometry +5+5 -gravity SouthEast "../images/logo.svg" "./$basename.jpg" "./$basename-Wasserzeichen.jpg"
    }
    #>
    "+ png in webp Format konvertieren"
    $filter = "*.png"
    [array]$array = ls ./ $filter 
    # array auslesen
    for($n=0; $n -lt $array.length; $n++){   # kleiner
        #$name = "$($array[$n])"              # file.jpg
        $basename = "$($array.BaseName[$n])" # file
        #"$n - $name"
        # lossless = true, false codiert das Bild verlustfrei.
        #convert "$basename.jpg" -quality 50 -define webp:lossless=true "$basename.webp"
        convert "./$basename.png" -quality 75 "./$basename.webp"
    }
  }
}

# Funktionsaufruf
imgTeX

"#---------------------------------------"
"Fotos wurden optimiert fuer Web und TeX."
# Kopie
mv *.png fallback/
mv *.pdf fallback/
cp -r ./*  ../images/ -Force
  

cd ..