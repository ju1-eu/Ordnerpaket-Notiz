<#------------------------------------------------------ 
	PowerShell Script 
	update: 1-Apr-20
	(c) 2020 Jan Unger 
  web optimierte Fotos:
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

# variablen
$tmp = 'temp' # bildname anpassen
$aufloesungTex = '728x516'  # B5 = 728x516
$aufloesungWeb = '1600x1200' # 1920x1080 1600x1100 
$qualitaetWeb = '75%' # ImageMagik: 82% = Photoshop: 60%
$img_orig = 'img_orig'
$img_auto = 'img_auto'

# optimiert Fotos für Web und TeX
## Funktionsaufruf: imgTeX
function imgTeX{
  # Usereingabe
  "+++ Sind Bilder im Ordner '$img_orig' ?"
  $var = Read-Host 'Eingabe - [j/n]' 
  if($var -eq  "n"){# gleich
    ".\scripte\imgTeX.ps1 PS-Script wird beendet"
    exit
  }
  else{
    "`n+++ Verzeichnis erstellen oder loeschen"
    # loescht ordner, wenn vorhanden, recursiv, schreibgeschützt, versteckt (unix)
    if (test-path ./$img_auto) { remove-item ./$img_auto/* -force -recurse} 


    # ordner erstellen
    md ./$img_auto/$tmp
    md ./$img_auto/$aufloesungTex

    "`n+++ Kopie erstellen: $img_orig => $img_auto/$tmp"
    cp -Recurse -Force ./$img_orig/* ./$img_auto/$tmp

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
      mogrify -path $out/ -filter Triangle -define filter:support=2 -auto-orient  -thumbnail  $aufloesung  -unsharp 0.25x0.25+8+0.065  -dither None -posterize 136 -quality $qualitaet -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB  -strip $in/*
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
      mogrify -format pdf $aufloesungTex/*.jpg 
      mogrify -format pdf $aufloesungTex/*.png
      cp $aufloesungTex/*.pdf ./

      # Komprimiert den Inhalt eines Verzeichnisses
      #ls $ordner | Compress-Archive -Update -dest "$archiv/$ordner.zip"

      # Kopie loeschen
      rm $tmp -force -recurse
      rm $aufloesungTex -force -recurse


    # WebP
    "+++ jpg & png in webp Format konvertieren"
    #"+++ Wasserzeichen"
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

    cd ..
  }
}

# Funktionsaufruf
imgTeX

"#---------------------------------------"
"Fotos wurden optimiert fuer Web und TeX."
# Kopie
cp ./img_auto/*  ./images/
