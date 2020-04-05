<#------------------------------------------------------ 
	PowerShell Script 
	update: 2-Apr-20
	(c) 2020 Jan Unger 
  web optimierte Fotos aus jpg o.png:
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
$aufloesungWeb   = '1600x' # Web: 1920x1080 1600x1200 960x
$aufloesungLatex =  '960x' # Latex: 960x
$latex = "latex"           # latex: eps - pdf
$qualitaet = '80%'  # ImageMagik: 82% = Photoshop: 60%
$img = "images"
$img_in = 'img_orig'
$img_out = 'img_auto'
$fallback = "fallback"
$orginal = "Orginalfoto"  # ACHTUNG: Auflösung wird nicht verändert!
$beitrag = "Beitragsbild"
$kontakt = "Kontakt"
$footer = "Footer"
$logo = "Logo"
$icon = "Icon"
  



# optimiert Fotos für Web und TeX
## Funktionsaufruf: imgTeX
function imgTeX{
  # Usereingabe
  "`n-------------------------------------"
  "+ Sind 'Bilder' im Ordner '$img_in' ?"
  "+ mehrere Bilderordner möglich"
  "-------------------------------------"
  $var = Read-Host 'Eingabe - [j/n]' 
  if($var -eq  "n"){# gleich
    ".\scripte\imgTeX.ps1 PS-Script wird beendet"
    exit
  }
  else{
    "`n+ Verzeichnis erstellen oder loeschen"
    # loescht ordner, wenn vorhanden, recursiv, schreibgeschützt, versteckt (unix)
    if (test-path ./$img_out) { rm -r ./$img_out/* -force}   

    cd $img_out

    # ordner erstellen
    if(!(test-path $tmp/)){           md $tmp/ -force} 
    if(!(test-path $fallback/)){      md $fallback/ -force}  
    if(!(test-path $latex/)){         md $latex/ -force} 


    "`n+ Kopie erstellen: $img_in => $img_out/$tmp"
    cp -r  ../$img_in/* $tmp -Force


    # exiftool
    # https://www.benjamin-rosemann.de/blog/bilder-in-unterordnern-durchnumerieren-mit-exiftool.html
    
    #"+ pics umbenennen - Ordner-001.jpg"
    #exiftool -fileOrder datetimeoriginal '-fileName<${directory}%-.3nc.%le' -r -P $tmp/*
    
    "+ pics umbenennen - Ordner-file.jpg o. Ordner-file.png"
    exiftool -fileOrder datetimeoriginal '-fileName<${directory}-%f.%le' -r -P $tmp/*

    
    # 2019/2019-09-20-Ordner-file.jpg
    #1) exiftool -fileOrder datetimeoriginal '-fileName<${directory}-%f.%le' -r -P $tmp/*
    #2) exiftool -fileOrder datetimeoriginal '-FileName<${DateTimeOriginal}-%f.%le' -d '%Y/%Y-%m-%d' -r -P $tmp/*


    # jpg -> qualität
    mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.25+8+0.065 -dither None -posterize 136 -quality $qualitaet -define jpeg:fancy-upsampling=off  -interlace none -colorspace sRGB -strip -path ./$fallback/ $tmp/*.jpg
    # ACHTUNG: jpg -> Web: $aufloesungWeb siehe oben!
    mogrify -thumbnail $aufloesungWeb -path ./ ./$fallback/*.jpg
    # ACHTUNG: jpg -> Latex: $aufloesungLatex: eps - pdf
    mogrify -thumbnail $aufloesungLatex -path ./$latex/ ./$fallback/*.jpg

    # png -> qualität
    # ACHTUNG: Auflösung wird nicht verändert!
    mogrify -strip +set date:create +set date:modify -define png:color-type=3 -depth 8 +dither -colors 256 -type Palette -format png -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -quality $qualitaet -path ./ $tmp/*.png
    

    # neue Website - fotograf
    # Usereingabe
    "`n-----------------------------------------------------"
    "+ Bilderordner für neue Website - Fotograf erstellen?"
    "-----------------------------------------------------"
    $var = Read-Host 'Eingabe - [j/n]' 
    if($var -eq  "n"){# gleich
      "wenn Ordner löschen"
      if(test-path ../$img/$orginal/){       rm -r ../$img/$orginal/ -force} 
      if(test-path ../$img/$beitrag/){       rm -r ../$img/$beitrag/ -force} 
      if(test-path ../$img/$kontakt/){       rm -r ../$img/$kontakt/ -force} 
      if(test-path ../$img/$footer/){        rm -r ../$img/$footer/ -force} 
      if(test-path ../$img/$logo/){          rm -r ../$img/$logo/ -force} 
      if(test-path ../$img/$icon/){          rm -r ../$img/$icon/ -force} 
      if(test-path ../$img/$aufloesungWeb/){rm -r ../$img/$aufloesungWeb/ -force} 
    }
    else{
      # wenn nicht ordner erstellen
      if(!(test-path $beitrag/)){       md $beitrag/ -force} 
      if(!(test-path $kontakt/)){       md $kontakt/ -force} 
      if(!(test-path $footer/)){        md $footer/ -force} 
      if(!(test-path $logo/)){          md $logo/ -force} 
      if(!(test-path $icon/)){          md $icon/ -force} 
      if(!(test-path $aufloesungWeb/)){ md $aufloesungWeb/ -force} 
      if(!(test-path $orginal/)){       md $orginal/ -force} 
      # kopie
      cp -r  ../$img_in/* $orginal -Force
      # auflösung 1600x 
      mogrify -thumbnail 1600x -path ./$aufloesungWeb/ ./$fallback/*.jpg
      # Logo: 340x180
      mogrify -thumbnail 340x180 -path ./$logo/ ./$fallback/*.jpg
      # Icon: 512x512
      mogrify -thumbnail 512x512 -path ./$icon/ ./$fallback/*.jpg
      # Kontakt: 1920x1080
      mogrify -thumbnail 1920x1080 -path ./$kontakt/ ./$fallback/*.jpg
      # Beitragsbild: 2560x1440
      mogrify -thumbnail 2560x1440 -path ./$beitrag/ ./$fallback/*.jpg
    }



    "+ LaTeX - Bilder in pdf u. eps umwandeln"
    # $aufloesungLatex  
    # eps
    mogrify -path ./ -format eps ./$latex/*.jpg
    mogrify -path ./ -format eps *.png
    # pdf
    mogrify -path ./$fallback -format pdf ./$latex/*.jpg
    mogrify -path ./$fallback -format pdf *.png


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
        convert "./$basename.jpg" -quality 50 -define webp:lossless=false "./$basename.webp"
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
        convert "./$basename.png" -quality 50 -define webp:lossless=true "./$basename.webp"
    }
  }

}

# Funktionsaufruf
imgTeX

"#---------------------------------------"
"Fotos wurden optimiert fuer Web und TeX."
# Kopie
rm -r $tmp/ -Force
rm -r $latex/ -Force
rm -r $fallback/*jpg -Force
cp -r *  ../$img/ -Force
cd ..  
# loescht ordner, wenn vorhanden, recursiv, schreibgeschützt, versteckt (unix)
if (test-path ./$img_out) { rm -r ./$img_out/* -force}   

