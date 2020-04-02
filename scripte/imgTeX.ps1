<#------------------------------------------------------ 
	PowerShell Script 
	update: 2-Apr-20
	(c) 2020 Jan Unger 
  web optimierte Fotos aus jpg:
	* quer: 1600x1200 
	* hoch: 800x1200
	* kontakt: 1920x1080 
	* footer: 1920x180
	* logo: 340x180
	* Icon: 512x512
	* Beitragsbild: 2560x1440
  * Verkaufsfoto: 5760x3840 bzw. Original
  
  mogrify -filter Triangle 
    -define filter:support=2 
    -thumbnail 1600x1200
    -unsharp 0.25x0.25+8+0.065 
    -dither None 
    -posterize 136 
    -quality 82 
    -define jpeg:fancy-upsampling=off 
    -define png:compression-filter=5 
    -define png:compression-level=9 
    -define png:compression-strategy=1 
    -define png:exclude-chunk=all 
    -interlace none 
    -colorspace sRGB 
    -strip 
    -path ../$fallback/ ./*.jpg


------------------------------------------------------#>
Clear-Host # cls

$tmp = 'temp' # bildname anpassen
#$aufloesungTex = '960'  # B5 = 728x516
$aufloesung = '1600' # 1920x1080 1600x1100 
$qualitaet = '82%'  # ImageMagik: 82% = Photoshop: 60%
$img_in = 'img_orig'
$img_out = 'img_auto'
$fallback = "fallback"

# optimiert Fotos für Web und TeX
## Funktionsaufruf: imgTeX
function imgTeX{
  # Usereingabe
  "+ Sind 'Bilder' im Ordner '$img_in' ?"
  $var = Read-Host 'Eingabe - [j/n]' 
  if($var -eq  "n"){# gleich
    ".\scripte\imgTeX.ps1 PS-Script wird beendet"
    "mehrere Bilderordner möglich"
    exit
  }
  else{
    "`n+ Verzeichnis erstellen oder loeschen"
    # loescht ordner, wenn vorhanden, recursiv, schreibgeschützt, versteckt (unix)
    if (test-path ./$img_out) { rm -r ./$img_out/* -force} 


    # ordner erstellen
    md ./$img_out/$tmp
    md ./$img_out/fallback

    "`n+ Kopie erstellen: $img_in => $img_out/$tmp"
    cp -r  ./$img_in/* ./$img_out/$tmp -Force

    cd $img_out


    # exiftool
    # https://www.benjamin-rosemann.de/blog/bilder-in-unterordnern-durchnumerieren-mit-exiftool.html
    
    #"+ pics umbenennen - Ordner-001.jpg"
    #exiftool -fileOrder datetimeoriginal '-fileName<${directory}%-.3nc.%le' -r -P $tmp/*
    
    "+ pics umbenennen - Ordner-file.jpg"
    exiftool -fileOrder datetimeoriginal '-fileName<${directory}-%f.%le' -r -P $tmp/*

    
    # 2019/2019-09-20-Ordner-file.jpg
    #1) exiftool -fileOrder datetimeoriginal '-fileName<${directory}-%f.%le' -r -P $tmp/*
    #2) exiftool -fileOrder datetimeoriginal '-FileName<${DateTimeOriginal}-%f.%le' -d '%Y/%Y-%m-%d' -r -P $tmp/*


    cd $tmp

    # jpg -> qualität u. auflösung
    mogrify -filter Triangle -define filter:support=2 -thumbnail $aufloesung -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality $qualitaet -define jpeg:fancy-upsampling=off  -interlace none -colorspace sRGB -strip -path ../$fallback/ ./*.jpg
 
    # png -> qualität
    mogrify -strip +set date:create +set date:modify -define png:color-type=3 -depth 8 +dither -colors 256 -type Palette -format png -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -quality $qualitaet -path ../$fallback/ ./*.png
    

    cd ../$fallback

    "+ LaTeX - Bilder in pdf umwandeln"
    mogrify -path ../ -format eps *.jpg
    mogrify -path ../ -format eps *.png
    mogrify -path ../$fallback -format pdf *.jpg
    mogrify -path ../$fallback -format pdf *.png

    # WebP
    "+ jpg in webp Format konvertieren"
    $filter = "*.jpg"
    [array]$array = ls $filter 
    # array auslesen
    for($n=0; $n -lt $array.length; $n++){   # kleiner
        #$name = "$($array[$n])"             # file.jpg
        $basename = "$($array.BaseName[$n])" # file
        #"$n - $name"
        # lossless = false codiert das Bild verlustfrei
        convert "./$basename.jpg" -quality 50 -define webp:lossless=false "../$basename.webp"
    }
    
    "+ png in webp Format konvertieren"
    $filter = "*.png"
    [array]$array = ls $filter 
    # array auslesen
    for($n=0; $n -lt $array.length; $n++){   # kleiner
        #$name = "$($array[$n])"             # file.jpg
        $basename = "$($array.BaseName[$n])" # file
        #"$n - $name"
        # lossless = false codiert das Bild verlustfrei
        convert "./$basename.png" -quality 50 -define webp:lossless=true "../$basename.webp"
    }

    cd ..

  }

}

# Funktionsaufruf
imgTeX

"#---------------------------------------"
"Fotos wurden optimiert fuer Web und TeX."
# Kopie
rm -r $tmp/ -Force
cp -r *  ../images/ -Force
  

cd ..