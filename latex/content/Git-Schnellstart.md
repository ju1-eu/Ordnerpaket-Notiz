Git - Schnellstart
==================

<!--update: 1-Apr-20-->
**Befehle**

-   Git: download <https://git-scm.com/download/win>
-   GitHub: Projekt anlegen <https://github.com/ju1-eu/>
-   git clone “Repository\_name”
-   git add “file” oder git add .
-   git commit -a oder git commit
-   git push u. git pull
-   git status
-   git log oder git lg
-   git stash
-   git reset

Git konfigurieren
-----------------

      # Git konfigurieren
      #----------------------
      git version

      # gitconfig anpassen
      git config --global user.name "jan_wlap"
      git config --global user.email "esel573@gmail.com"
      
      # gitconfig ansehen
      git config --global --list
      # cd C:\Users\jan\
        .gitconfig
        .gitattributes
        .gitignore

Projekt mit GitHub einrichten
-----------------------------

Auf GitHub ein Repository erstellen: <https://github.com/ju1-eu/>

-   **Repository\_name**: “prj-dummy”  
-   **Clone with HTTPS**: https://github.com/ju1-eu/prj-dummy.git
-   weiter mit “Projekt von GitHub downloaden”
-   oder
-   weiter mit “Projekt lokal einrichten”

Projekt von GitHub downloaden
-----------------------------

      pwd

      $THEMA="prj-dummy"
      rm $THEMA -Recurse -Force
      git clone https://github.com/ju1-eu/$THEMA.git
      #git clone https://github.com/ju1-eu/$THEMA.git prj1

      # weiter mit ...
      # Git Workflow / PROJEKT bearbeiten

Projekt lokal einrichten
------------------------

      pwd 

      # lokales Repository: master
      $THEMA="prj-dummy" # Repository_name auf Github erstellen
      #rm $THEMA -Recurse -Force
      mkdir $THEMA
      cd $THEMA
      # Repository anlegen
      git init # rm -rf .git oder rm .git -Recurse -Force
      echo "# prj-dummy" > README.md 
      git add .
      git commit -m"init"
      git status
      git remote add origin https://github.com/ju1-eu/$THEMA.git
      git push --set-upstream origin master

      # weiter mit ...
      # Git Workflow / PROJEKT bearbeiten

Git Workflow
------------

### Arbeitsverzeichnis

      pwd
        # /c/daten/projekte/git/git-kurs/prj
        # C:\daten\projekte\git\git-kurs\prj

### PROJEKT bearbeiten

      git status

      # README.md erstellen
      echo "# prj-dummy" > README.md 
      echo "<!-- update: 20-Dez-19 -->" >> README.md
      cat README.md
      
      # .gitignore erstellen
      echo "# ju update: 20-Dez-19 .gitignore" > .gitignore
      echo "!.gitignore" >> .gitignore
      cat .gitignore

### git add - Arbeitsverzeichnis =&gt; Stagingbereich

      git add .
      git add README.md

### git commit - Stagingbereich =&gt; Repository

      git commit -m"projekt init"
      git commit
      git commit -a

### git push - Repository =&gt; Github Repository

      # Voraussetzung
      $THEMA="prj-dummy" # Repository_name auf Github erstellen
      git remote add origin https://github.com/ju1-eu/$THEMA.git
      git push --set-upstream origin master

      git status
      git push
      git pull

### git status - sauberes Arbeitsverzeichnis prüfen!

      git status
        On branch master
        Your branch is up to date with 'origin/master'.

        nothing to commit, working tree clean

git log - history
-----------------

      git status
      git log
      git log --abbrev-commit --pretty=oneline --graph
      git lg

Branch neu erstellen - PROJEKT bearbeiten
-----------------------------------------

      # sauberes Arbeitsverzeichnis prüfen!
      git checkout master
      git status
      # wenn lokale Änderungen vorliegen, wird der Merge abgebrochen
      git pull --ff-only

      git branch
      # Branch neu erstellen
      git checkout -b feature/a1
      # Feature-Branch zentral sichern
      git push --set-upstream origin feature/a1
      # Änderungen können zukünftig gesichert werden
      git push

      # PROJEKT bearbeiten
      code README.md
      git add .
      git commit
      
      # Branch wechseln
      git status 
      git branch
      git checkout master

      # Branch zusammenführen
      git merge feature/a1

      git branch
      # nutzlosen Branch löschen
      git push -d origin feature/a1
      git branch -d feature/a1
     
      # sauberes Arbeitsverzeichnis prüfen!
      git status

git tag - Version erstellen
---------------------------

      # sauberes Arbeitsverzeichnis prüfen!
      git status

      git tag
      git tag -a v1.0
        # stabile Version

      git checkout v1.0
      git checkout master

git blame - Wer hat was und wann geändert?
------------------------------------------

      git blame README.md

Datei umbenennen o. löschen - .git o. Repository löschen
--------------------------------------------------------

      git mv file_alt file_neu
      git commit -am"Datei umbenannt"

      git rm file_neu
      git commit -am"Datei gelöscht"
      git status

      # .git löschen
      rm -rf .git 
      rm .git -Recurse -Force

      # Repository löschen
      git remote -v
        git remote rm backupHD 
      git remote rm origin

Versionskonflikt lösen
----------------------

      # sauberes Arbeitsverzeichnis prüfen!
      git status

      git branch -a

      # Voraussetzung: Branch muss vorhanden sein
      # siehe Branch neu erstellen
      git checkout feature/a1

      # PROJEKT bearbeiten auf feature/a1 Branch
      code README.md
        # file: README.md bearbeiten
      git commit -am"README.md bearbeitet"
      git push
      git diff master feature/a1

      git checkout master

      # PROJEKT bearbeiten auf master Branch
      code README.md
        # file: README.md bearbeiten
      git commit -am"README.md bearbeitet master"
      git push
      git status

      # zusammenführen mit master-Branch 
      git merge feature/a1
        # Fehler, weil auf unterschiedlichen Branches gearbeitet wurde
        #----------------------
        Auto-merging README.md
        CONFLICT (content): Merge conflict in README.md
        Automatic merge failed; fix conflicts and then commit the result.
        #----------------------
      # Konflikt bearbeiten
      code README.md
        # file bereinigen: <<<<<<<, ======= und >>>>>>>
      
      git commit -am"Konflikt behoben"
      git push
      
      git branch -a
      git push -d origin feature/a1
      git branch -d feature/a1

      # sauberes Arbeitsverzeichnis prüfen!
      git status

Lokales Wiederherstellen
------------------------

      # Änderungen zwischenspeichern
      git stash --include-untracked
      # Letzte gespeicherte Änderungen zurückholen
      git stash pop

      pwd

      # PROJEKT bearbeiten
      echo "neu" > file.txt
      git add .
      git commit -m"neu" 
      echo "Fehler" >> file.txt
      # Achtung: noch kein git commit!
      git status

      # Möglichkeit 1
      git log
      cat .\file.txt
      git checkout HEAD file.txt
      cat .\file.txt
      git status

      # Möglichkeit 2
      git log
      cat .\file.txt
      git reset --hard HEAD
      cat .\file.txt
      git status

Repository Wiederherstellen
---------------------------

      pwd

      # PROJEKT bearbeiten
      echo "Fehler 2" >> file.txt
      git commit -am"Fehler provoziert" 
      # Achtung: noch kein git push!
      git status

      # Möglichkeit 1
      git log
      git reset --hard d446456
      git log
      git status

      # Möglichkeit 2
      git log
      git revert c3b6fab
      git log
      git status

      git push
      git status

Git Backup - Repository ohne einen Workspace
--------------------------------------------

Backup auf USB-Stick

      pwd

      # backup Repository: backup_wlap/master
        # anpassen
      $PFAD="E:/backup-Repos/notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_wlap"

      #cd $THEMA
      git clone --no-hardlinks --bare . $PFAD/$THEMA.git 
      git remote add $REPO $PFAD/$THEMA.git 
      # gelegentlich sichern
      git status
      git push --all $REPO

      # löschen
      rm -rf $PFAD/$THEMA
      rm $PFAD/$THEMA -Recurse -Force

Backup auf Raspberry Pi

      pwd

      # backup Repository: backup_rpi4/master
        # anpassen
      $PFAD="\\RPI4\usbstick\backup-Repos\notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_rpi4"

      #cd $THEMA
      git clone --no-hardlinks --bare . $PFAD/$THEMA.git 
      git remote add $REPO $PFAD/$THEMA.git 
      # gelegentlich sichern
      git status
      git push --all $REPO

      # löschen
      rm -rf $PFAD/$THEMA
      rm $PFAD/$THEMA -Recurse -Force

lokales Repository clonen
-------------------------

      pwd
      cd C:\daten\projekte\git\git-kurs\prj

      # löschen
      rm -rf $THEMA
      rm $THEMA -Recurse -Force

      $PFAD="E:/backup-Repos/notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_wlap"

      git clone $PFAD/$THEMA.git
      cd $THEMA
        
      # oder

      $PFAD="\\RPI4\usbstick\backup-Repos\notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_rpi4"
      git clone $PFAD/$THEMA.git 
      cd $THEMA

Git Workflow - Bereiche
-----------------------

-   Datei bearbeiten
-   Datei hinzufügen
-   Datei Umbenennen
-   Datei löschen

<!-- -->

                         Lokal                             Remote Server 
      <----------------------------------------------->|<------------------>
      Arbeitsverzeichnis | Stagingbereich | Repository | Github Repository
          bearbeiten
                      git add
                      git mv
                      git rm                       
                                      git commit
                                                    git push
      <-------------------------------------------- -->|<------------------>         

Wiederherstellen
----------------

### Ordner für Experimente erstellen - löschen

      pwd

      mkdir repoWork 
      mkdir repoNeu 
      mkdir repoAlt

      # löschen
      rm repoWork -Recurse -Force
      rm repoNeu -Recurse -Force
      rm repoAlt -Recurse -Force

### bestehendes Repository clonen

      cd prj-dummy # Repository
      git clone . ../repoWork

### Arbeitsverzeichnis bearbeiten

**bearbeiten 1**

      cd ../repoWork
      code test.md
      # file
      basis

      # git versionieren
      git add .
      git commit -a
      git status

**bearbeiten 2**

      code test.md
      # file
      Basis
      Version2

      # git versionieren
      git commit -a
      git status

**bearbeiten 3**

      code test.md
      # file
      Basis
      Version2
      Version3

      # git versionieren
      git commit -a
      git status
      git log --graph --oneline

### Wiederherstellen: Repository in ein temp. Verzeichnis klonen

      cd repoWork
      git clone . ../repoNeu
      git clone . ../repoAlt

### Wechsel auf den gewünschten Git-Branch

      cd ../repoNeu/
      git stash
      git log --graph --oneline
        * 0aa9744 (HEAD -> master, origin/master, origin/HEAD) version3
        * 44aba18 version2
        * 81ac502 basis
      # wechsel auf version2
      git reset --hard 44aba18

### Verschiebe .git in den Workspace der alten Versionsverwaltung

      # win10
      Suchen: git bash
      cd /c/daten/projekte/git/git-kurs/prj/repoNeu

      git archive master | tar -x -C ../repoAlt/
      #git archive master | gzip > ../latest.tgz

### Ergebnis prüfen

      cd ..
      kdiff3 repoAlt/ repoNeu/

Repositorys auf unterschiede prüfen
-----------------------------------

### Ordner für Experimente erstellen - löschen

      pwd

      mkdir repoLokal 
      mkdir repoGithub 
      mkdir repoBackup_wlap
      mkdir repoBackup_rpi4

      # löschen
      rm repoLokal -Recurse -Force
      rm repoGithub -Recurse -Force
      rm repoBackup_wlap -Recurse -Force
      rm repoBackup_rpi4 -Recurse -Force

### bestehendes Repository clonen

      cd prj-dummy # Repository
      git status 
      git lg
      git push

      # Git Backup - Repository ohne einen Workspace
      $REPO="backup_rpi4"
      git push --all $REPO

      $REPO="backup_wlap"
      git push --all $REPO

      git clone . ../repoWork

### lokales Repository

HEAD -&gt; master

      cd repoWork
      # repository clonen
      git clone . ../repoLokal

      # backup
      cd ../repoLokal
      #ls . | Compress-Archive -Update -dest ../repoLokal.zip
      $verz="repoLokal"
      $ID=$(git rev-parse --short HEAD) # git commit (hashwert)
      $timestamp = Get-Date -Format 'd-MMM-y'  # 10-Jun-19
      $archiv = "$verz-$ID-$timestamp"
      ls . | Compress-Archive -dest ../$archiv.zip
      cd ..

### Github Repository

origin/master

      cd repoGithub
      # repository clonen
      $THEMA="prj-dummy"
      git clone https://github.com/ju1-eu/$THEMA.git .

      # backup
      #ls . | Compress-Archive -Update -dest ../repoLokal.zip
      $verz="repoGithub"
      $ID=$(git rev-parse --short HEAD) # git commit (hashwert)
      $timestamp = Get-Date -Format 'd-MMM-y'  # 10-Jun-19
      $archiv = "$verz-$ID-$timestamp"
      ls . | Compress-Archive -dest ../$archiv.zip
      cd ..

### lokales backup Repository

backup\_wlap/master

      cd repoBackup_wlap
      # repository clonen
      $PFAD="E:/backup-Repos/notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_wlap"

      git clone $PFAD/$THEMA.git .

      # backup
      #ls . | Compress-Archive -Update -dest ../repoBackup_wlap.zip
      $verz="repoBackup_wlap"
      $ID=$(git rev-parse --short HEAD) # git commit (hashwert)
      $timestamp = Get-Date -Format 'd-MMM-y'  # 10-Jun-19
      $archiv = "$verz-$ID-$timestamp"
      ls . | Compress-Archive -dest ../$archiv.zip
      cd ..

backup\_rpi4/master

      cd repoBackup_rpi4
      # repository clonen
      $PFAD="\\RPI4\usbstick\backup-Repos\notizenWin10"
      $THEMA="prj-dummy"
      $REPO="backup_rpi4"

      git clone $PFAD/$THEMA.git .

      # backup
      #ls . | Compress-Archive -Update -dest ../repoBackup_rpi4.zip
      $verz="repoBackup_rpi4"
      $ID=$(git rev-parse --short HEAD) # git commit (hashwert)
      $timestamp = Get-Date -Format 'd-MMM-y'  # 10-Jun-19
      $archiv = "$verz-$ID-$timestamp"
      ls . | Compress-Archive -dest ../$archiv.zip
      cd ..

### Ergebnis prüfen

      pwd
      
      # verzeichnisse vergleichen
      kdiff3 repoLokal/ repoGithub/ 
      kdiff3 repoLokal/ repoBackup_rpi4/ repoBackup_wlap/

      # files vergleichen
      kdiff3 repoLokal/test.md repoGithub/test.md
      kdiff3 repoLokal/test.md repoBackup_rpi4/test.md repoBackup_wlap/test.md
