Markdown
========

<!--update: 1-Apr-20-->
Überschriften
-------------

    # Überschrift   1
    ## Überschrift  2
    ### Überschrift 3

Code
----

`Quellcode`

    #include <stdio.h>
    int main(void) {
        printf("Hallo Welt!\n");
        return 0;
    }

Quellenangabe
-------------

Zitat: vgl. u.

    \cite{monk_action_buch:2016}  
    \cite{kofler_linux:2017} 
    \footnote{\url{https://de.wikipedia.org/wiki/LaTeX}}.  

Listen
------

**ungeordnete Liste**

-   a
-   b
    -   bb
-   c

<!-- -->

        -   a
        -   b
            -   bb
        -   c

**Sortierte Liste**

1.  eins
2.  zwei
3.  drei

<!-- -->

        1.  eins
        2.  zwei
        3.  drei

**Sortierte Liste**

1.  a
2.  b
3.  c

<!-- -->

        1.  a
        2.  b
        3.  c

Links
-----

<https://google.de> oder [Google](https://google.de)

    <https://google.de> 
    [Google](https://google.de)

Absätze
-------

Dies hier ist ein Blindtext zum Testen von Textausgaben. Wer diesen Text
liest, ist selbst schuld. Der Text gibt lediglich den Grauwert der
Schrift an. Ist das wirklich so? Ist es gleichgültig, ob ich schreibe:
“Dies ist ein Blindtext” oder “Huardest gefburn”? Kjift - mitnichten!
Ein Blindtext bietet mir wichtige Informationen.

Dies hier ist ein Blindtext zum Testen von Textausgaben. Wer diesen Text
liest, ist selbst schuld. Der Text gibt lediglich den Grauwert der
Schrift an. Ist das wirklich so? Ist es gleichgültig, ob ich schreibe:
“Dies ist ein Blindtext” oder “Huardest gefburn”? Kjift - mitnichten!
Ein Blindtext bietet mir wichtige Informationen.

Texthervorhebung
----------------

**fett** *kursiv* “Anführungsstriche”

    **fett** 
    *kursiv* 
    "Anführungsstriche" 

Bild
----

Bilder in eps o. pdf speichern, empfehlenswert für Latex.

Für das Web webp, png, jpg o. svg.

![Sport-Winter: erfolgt auto. eps -&gt; pdf](images/Sport-Winter.eps)

    ![Sport-Winter](images/Sport-Winter.eps)

Tabelle
-------

[Tabellengenerator aus \*.csv
files](https://www.tablesgenerator.com/markdown_tables)

|  **Nr.**| **Begriffe** | **Erklärung** |
|--------:|:-------------|:--------------|
|        1| a1           | a2            |
|        2| b1           | b2            |
|        3| c1           | c2            |

    |**Nr.**|**Begriffe**|**Erklärung**|
    |------:|:-----------|:------------|
    | 1     | a1         | a2          |
    | 2     | b1         | b2          |
    | 3     | c1         | c2          |

Mathe
-----

\[*V*\] = \[*Ω*\] ⋅ \[*A*\] o. *U* = *R* ⋅ *I*

    $[ V ] = [ \Omega ] \cdot [ A ]$ o. $U = R \cdot I$ 

$R = \\frac{U}{I}$

    $R = \frac{U}{I}$
