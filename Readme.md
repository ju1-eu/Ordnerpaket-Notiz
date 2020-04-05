Readme
======

<!--update: 1-Apr-20-->
`(c)` 2020 Jan Unger

<https://bw-ju.de>

Inhalt - Ordnerpaket-Notiz
--------------------------

    code/*              Quellcode
    css/*               Webdesign anpassen
    images/             Bilder optimiert
    img_auto/           temp
    img_orig/           Bilder in Original: min. 2x *.jpg o. *.png
    latex/              LaTeX files -> pdfs
        Grafiken/           logo u. titelbild
        content/            präambel, metadata, header, literatur.bib
    md/                 Notizen erstellen in Markdown
    md_gfm/             GitHub Flavored Markdown
    scripte/            PS-Scripte werden von projekt.ps1 aufgerufen
    www/                CMS Wordpress u. HTML5 files
    .gitattributes      Git
    .gitconfig
    .gitignore
    --------------------------------------------
    projekt.ps1         PS-Script ausführen => 
        erstellt pdfs u. HTML, Backup, Git, opti. Bilder ...
    Readme.md           lesen!
    Start.html          Projekt - Website öffnen
    --------------------------------------------
        
    # Backup files
    cd ..
    DATUM_Thema-Notiz_vVERSION.zip
    Thema-Notiz.zip
    git_log.txt

Erste Schritte
--------------

    # Projektordner öffnen
    git clone https://github.com/ju1-eu/Ordnerpaket-Notiz.git notiz
    cd notiz

	**Readme.txt** lesen

    **Thema** anpassen und Speicherpfade und Git!
    * 'projekt.ps1 '
    * scripte/'git.ps1', 'backup.ps1', 'cms.ps1', 'pdf-erstellen.ps1'

    **LaTeX** anpassen
    * latex/content/'metadata.tex', 'literatur.bib'
    * latex/content/'zusammenfassung.tex' -> latex/'book.tex' 
    * latex/Grafiken/'titelbild.pdf'

    **Notizen** in Markdown erstellen: min. 2x! 'md/*.md'

    **PS-Script** ausführen: PS >_ '.\projekt.ps1'

    **Projekt - Website** öffnen: 'Start.html'

Git
---

### Repository clonen

    # Github
    $THEMA      = "Ordnerpaket-Notiz" # Repository
    $ADRESSE    = "https://github.com/ju1-eu"
    git clone $ADRESSE/${THEMA}.git  

    # USB
    $USB   = "E:\repos\notizenWin10"    
    $THEMA = "Ordnerpaket-Notiz" # Repository
    git clone $USB/${THEMA}.git 

    # RPI
    $RPI   = "\\RPI4\nas\repos\notizenWin10"    
    $THEMA = "Ordnerpaket-Notiz" # Repository
    git clone $RPI/${THEMA}.git 

### Repository neu anlegen

    # Github 
    $THEMA   = "Ordnerpaket-Notiz" # Repository
    $ADRESSE = "https://github.com/ju1-eu"
    git remote add origin $ADRESSE/${THEMA}.git
    git push --set-upstream origin master

    # backupUSB
    $USB   = "E:\repos\notizenWin10"    
    $THEMA = "Ordnerpaket-Notiz" # Repository
    $LESEZ = "backupUSB"
    git clone --no-hardlinks --bare . $USB/${THEMA}.git
    git remote add $LESEZ $USB/${THEMA}.git
    git push --all $LESEZ

    # backupRPI
    $RPI   = "\\RPI4\nas\repos\notizenWin10"   
    $THEMA = "Ordnerpaket-Notiz" # Repository
    $LESEZ = "backupRPI"
    git clone --no-hardlinks --bare . $RPI/${THEMA}.git
    git remote add $LESEZ $RPI/${THEMA}.git
    git push --all $LESEZ

### Versionsverwaltung git

sichern - löschen - umbenennen

    cd notiz
    #git init  # Repository neu erstellen
    git add .
    #git commit -am "Projekt start"
    git commit -a
    # letzten Commit rueckgaengig 
    git commit --amend 

        # sichern
    git push     # github
    git push --all backupUSB
    git push --all backupRPI

    # löschen
    git rm datei o. ordner
    git rm -rf ordner
    git rm ordner -Recurse -Force
    git remote -v
    git remote rm backupHD 

    # umbenennen
    git mv datei datei_neu

## CMS - Wordpress

<https://de.wordpress.org/download/>
