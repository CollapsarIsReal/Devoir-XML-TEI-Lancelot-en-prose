<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- Attention une sortie HTML => exclusion du préfixe tei des résultats -->

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <!-- pour éviter les espaces non voulus -->
    <xsl:template match="/">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
            <!-- récupération du nom et du chemin du fichier courant -->
        </xsl:variable>

        <!-- DEFINITION DES VARIABLES DE NOMS DE FICHIERS DE SORTIE -->

        <xsl:variable name="pathAllo">
            <xsl:value-of select="concat($witfile, 'allograph', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAllo2">
            <xsl:value-of select="concat($witfile, 'allograph2', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNorm">
            <xsl:value-of select="concat($witfile, 'norm', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNorm2">
            <xsl:value-of select="concat($witfile, 'norm2', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathIndexPers">
            <xsl:value-of select="concat($witfile, 'indexPers', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile, 'accueil', '.html')"/>
        </xsl:variable>
        <xsl:variable name="pathnoticems">
            <xsl:value-of select="concat($witfile, 'noticems', '.html')"/>
        </xsl:variable>
        <xsl:variable name="path-biblio">
            <xsl:value-of select="concat($witfile, 'biblio', '.html')"/>
        </xsl:variable>

        <!-- DEFINITION DES VARIABLES UTILES -->
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="titre_dev">
            <xsl:value-of select="//body/head"/>
        </xsl:variable>
        <xsl:variable name="num_ms">
            <xsl:value-of select="//msIdentifier/idno"/>
        </xsl:variable>
        <xsl:variable name="auteur_edition">
            <xsl:value-of
                select="concat(./respStmt/persName/forename, ' ', ./respStmt/persName/surname)"/>
        </xsl:variable>
        <xsl:variable name="feuillet1">
            <!-- il faudrait trouver une formule pour créer une variable en fonction du
            @xml:id des <pb> pour éviter les doublons feuillet1, feuillet2 etc-->
            <xsl:value-of select="replace(//pb[1]/[@xml:id], 'f', '')"/>
        </xsl:variable>
        <xsl:variable name="feuillet2">
            <xsl:value-of select="replace(//pb[2]/[@xml:id], 'f', '')"/>
        </xsl:variable>
        

        <!-- DEBUT DES PAGES HTML -->
        <!-- PAGE D'ACCUEIL OK -->

        <xsl:result-document href="{$pathAccueil}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - accueil')"/>
                    </title>


                    <style>
                        .container {
                            display: flex;
                        }
                        
                        div.colonne {
                            float: left;
                            width: 50%;
                            margin: 10px;
                            border-right: dotted 1px;
                            padding-right: 15px;
                            text-align: justify;
                        }
                        
                        img {
                            display: block;
                            text-align: center;
                            margin: 50px;
                        }</style>
                </head>
                <body>
                    <h1>
                        <xsl:value-of select="$titre_dev"/>
                    </h1>
                    <div>
                        <xsl:attribute name="class">container</xsl:attribute>
                        <div class="colonne" n="1">
                            <p><xsl:value-of
                                    select="concat('Cette édition en ligne a été réalisée à partir du manuscrit ', $num_ms, ' conservé à la ', .//institution, '. ')"
                                /> Une feuille de transformation XSL a été rédigée dans le cadre d
                                une évalutation du cours de XSLT du <a
                                    href="https://www.chartes.psl.eu/fr/rubrique-admissions/master-technologies-numeriques-appliquees-histoire"
                                    >Master 2 TNAH</a> de l Ecole nationale des Chartes réalisés par
                                    <xsl:value-of
                                    select="concat(./respStmt/persName/forename, ' ', ./respStmt/persName/surname)"
                                /></p>
                            <p>Cette édition propose d'explorer deux des <xsl:value-of
                                    select="//foliation"/> du <xsl:value-of select="$titre"/>.</p>
                            <p>On y trouvera différentes exploitation notamment <em>une
                                    transcription allographétique</em>, une <em> autre version
                                    modernisée</em>, , un rapide <em>index des personnages</em>
                                présents dans les deux feuillets édités ainsi que la <em>notice du
                                    manuscrit</em>.</p>
                            <p>Malheureusement certaisns choix effectués lors de l'encodage XML du
                                manuscrit ont rendu compliqué la transformation HTML (par exemple
                                celui de traiter les lignes du texte uniquement dans des balises
                                    <em>lb</em> autofermantes, rendant l'accès au texte complexe, ou
                                bien encore en ce qui concerne l'encodage de la forme normalisée qui
                                n'avait pas pris en compte la normalisation des espaces, majuscules,
                                voyelles (u,i) et autres spécificités).</p>
                            <p> Ce travail est un donc un travail à reprendre depuis sa structure XML.</p>
                        </div>
                        <div class="colonne" n="2">
                            <h2>Sommaire</h2>
                            <ul>
                                <li>
                                    <a href="{$pathnoticems}">
                                        <xsl:value-of
                                            select="concat('Notice du manucrit ', $num_ms)"/>
                                    </a>
                                </li>
                                <li>
                                    <b>La transcription allographétique</b>
                                </li>
                                <ul>
                                    <li>
                                        <a href="{$pathAllo}">
                                            <xsl:value-of select="concat('premier feuillet (', $feuillet1,'): ')"/>
                                        </a>
                                        <xsl:variable name="extrait_orig1">
                                            <xsl:apply-templates select=".//ab[@n = '1']/cb[@n = '1']" mode="orig"/>
                                        </xsl:variable>
                                        <!-- A REPRENDRE : le mieux aurait été de faire un extrait qui se coupe à partir d'un certain nombre de caractères pour
                                            ne pas dépendre du texte en lui même -->
                                        <em>- <xsl:apply-templates select="substring-before($extrait_orig1, 'mā')"/><xsl:text>...</xsl:text></em>
                                    </li>
                                    <li>
                                        <a href="{$pathAllo2}">
                                            <xsl:value-of select="concat('deuxième feuillet (', $feuillet2,'): ')"/>
                                        </a>
                                        <xsl:variable name="extrait_orig2">
                                            <xsl:apply-templates select=".//ab[@n = '2']/cb[@n = '1']" mode="orig"/>
                                        </xsl:variable>
                                        <em>- <xsl:value-of select="substring-before($extrait_orig2, 'la')"/><xsl:text>...</xsl:text></em>
                                    </li>
                                </ul>
                                <li>
                                    <b>La transcription normalisée</b>
                                </li>
                                <ul>
                                    <li>
                                        <a href="{$pathNorm}">
                                            <xsl:value-of select="concat('premier feuillet (', $feuillet1,'): ')"/>
                                        </a>
                                        <xsl:variable name="extrait_reg1">
                                            <xsl:apply-templates select=".//ab[@n = '1']/cb[@n = '1']" mode="reg"/>
                                        </xsl:variable>
                                        <em>- <xsl:value-of select="substring-before($extrait_reg1, 'qui')"/><xsl:text>...</xsl:text></em>
                                    </li>
                                    <li>
                                        <a href="{$pathNorm2}">
                                            <xsl:value-of select="concat('deuxième feuillet (', $feuillet2,'): ')"/>
                                        </a>
                                        <xsl:variable name="extrait_reg2">
                                            <xsl:apply-templates select=".//ab[@n = '2']/cb[@n = '1']" mode="reg"/>
                                        </xsl:variable>
                                        <em>- <xsl:value-of select="substring-before($extrait_reg2, 'la')"/><xsl:text>...</xsl:text></em>
                                    </li>
                                </ul>
                                <li>
                                    <a href="{$pathIndexPers}">L'index des noms de personnages</a>
                                </li>
                                <li>
                                    <a href="{$path-biblio}">Bibliographie évoquant le manuscrit</a>
                                </li>
                            </ul>
                        </div>
                        <div class="colonne" n="3">
                            <img src="favicon.jpg" class="responsive" width="300px" height="auto"/>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- PAGE DE NOTICE DU MANUSCRIT - OK -->
        <xsl:result-document href="{$pathnoticems}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - notice')"/>
                    </title>
                </head>
                <body>
                    <div class="container">
                        <div>
                            <a href="{$pathAccueil}">Retour accueil</a>
                        </div>
                        <xsl:call-template name="notice_manuscrit"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- EDITION NORMALISEE -->
        <xsl:result-document href="{$pathNorm}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - f.103v norm.')"/>
                    </title>
                    <style>
                        div.colonne {
                            justify-content: space-between;
                            width: 100%;
                            padding: 20px;
                            border-style: double;
                            margin: 10px;
                            border-color: tan;
                            text-align: justify;
                        }
                        
                        span.initiale {
                            font-size: larger;
                            font-weight: bolder
                        }</style>
                </head>
                <body>
                    <h1>
                        <xsl:value-of select="$titre"/>
                    </h1>

                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>



                    <h3>
                        <xsl:value-of
                            select="concat('Transcription normalisée du feuillet ', $feuillet1, ' :')"
                        />
                    </h3>
                    <div class="row">
                        <xsl:apply-templates select="//ab[@n = '1']" mode="reg"/>
                    </div>
                    <!-- A REPRENDRE : eviter d'avoir à le remettre à la fin de chaque page HTML de transcription -->
                    <div class="legende">
                        <h4><xsl:text>Légende : </xsl:text></h4>
                        <ul>
                            <li><div class="css_perso">nom_personnage</div></li>
                            <li><div class="illegible">{mot_non_transcrit}</div></li>
                            <li><span class="faded">mot_illisible</span></li>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- EDITION NORMALISEE 2-->

        <xsl:result-document href="{$pathNorm2}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - f.104r norm.')"/>
                    </title>
                    <style>
                        div.colonne {
                            justify-content: space-between;
                            width: 100%;
                            padding: 20px;
                            border-style: double;
                            margin: 10px;
                            border-color: blue;
                            text-align: justify;
                        }
                        
                        
                        span.initiale {
                            font-size: larger;
                            font-weight: bolder
                        }</style>
                </head>
                <body>
                    <h1>
                        <xsl:value-of select="$titre"/>
                    </h1>

                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>




                    <h3>
                        <xsl:value-of
                            select="concat('Transcription normalisée du feuillet ', $feuillet2, ' :')"
                        />
                    </h3>

                    <div class="row">
                        <xsl:apply-templates select=".//ab[@n = '2']" mode="reg"/>
                    </div>
                    <div class="legende">
                        <h4><xsl:text>Légende : </xsl:text></h4>
                        <ul>
                            <li><div class="css_perso">nom_personnage</div></li>
                            <li><div class="illegible">{mot_non_transcrit}</div></li>
                            <li><span class="faded">mot_illisible</span></li>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- EDITION ALLOGRAPHETIQUE -->
        <xsl:result-document href="{$pathAllo}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - f.103v allo.')"/>
                    </title>
                    <style>
                        div.colonne {
                            justify-content: space-between;
                            width: 100%;
                            padding: 20px;
                            border-style: double;
                            margin: 10px;
                            border-color: tan;
                            text-align: justify;
                        }
                        
                        
                        span.initiale {
                            font-size: larger;
                            font-weight: bolder
                        }</style>
                </head>
                <body>

                    <h1>
                        <xsl:value-of select="$titre"/>
                    </h1>

                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>



                    <h3>
                        <xsl:value-of
                            select="concat('Transcription allographétique du feuillet ', $feuillet1, ' :')"
                        />
                    </h3>
                    <div class="row">

                        <xsl:apply-templates select=".//ab[@n = '1']" mode="orig"/>

                    </div>
                    <div class="legende">
                        <h4><xsl:text>Légende : </xsl:text></h4>
                        <ul>
                            <li><div class="css_perso">nom_personnage</div></li>
                            <li><div class="illegible">{mot_non_transcrit}</div></li>
                            <li><span class="faded">mot_illisible</span></li>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- EDITION ALLOGRAPHETIQUE 2-->

        <xsl:result-document href="{$pathAllo2}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - f.104r allo.')"/>
                    </title>
                    <style>
                        div.colonne {
                            justify-content: space-between;
                            width: 100%;
                            padding: 20px;
                            border-style: double;
                            margin: 10px;
                            border-color: blue;
                            text-align: justify;
                        }
                        
                        
                        span.initiale {
                            font-size: larger;
                            font-weight: bolder
                        }</style>
                </head>
                <body>
                    <h1>
                        <xsl:value-of select="$titre"/>
                    </h1>

                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>



                    <h3>
                        <xsl:value-of
                            select="concat('Transcription allographétique du feuillet ', $feuillet2, ' :')"
                        />
                    </h3>

                    <div class="row">
                        <xsl:apply-templates select=".//ab[@n = '2']" mode="orig"/>
                    </div>
                    <div class="legende">
                        <h4><xsl:text>Légende : </xsl:text></h4>
                        <ul>
                            <li><div class="css_perso">nom_personnage</div></li>
                            <li><div class="illegible">{mot_non_transcrit}</div></li>
                            <li><span class="faded">mot_illisible</span></li>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- INDEX DES PERSONNAGES -->

        <xsl:result-document href="{$pathIndexPers}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' - index pers.')"/>
                    </title>
                </head>
                <body>
                    <h1>
                        <xsl:value-of select="$titre"/>
                    </h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index des personnages</h2>
                    <div>
                        <ul>
                            <xsl:call-template name="indexPers"/>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- PAGE DE LA BIBLIOGRAPHIE -->
        <xsl:result-document href="{$path-biblio}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ' | ', 'Références bibliographiques')"/>
                    </title>
                </head>
                <body>
                    <h2>
                        <xsl:value-of select="TEI/teiHeader//listBibl/head"/>
                    </h2><span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <div class="container">
                        <div class="col-md-10 col-md-offset-2">
                            <xsl:call-template name="biblio"/>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <!--FIN DES PAGES HTML-->

    <!-- page de notice du manuscrit -->
    <xsl:template name="notice_manuscrit">
        <h1>
            <xsl:value-of select=".//titleStmt/title"/>
        </h1>
        <h2>
            <xsl:text>Manuscrit </xsl:text>
            <em>
                <xsl:value-of select="TEI//msIdentifier/idno"/>
            </em>
        </h2>

        <div>
            <h3>Identification :</h3>
        </div>
        <dl>
            <dt>
                <b>Institution de conservation :</b>
            </dt>
            <dd>
                <xsl:value-of
                    select="concat(.//country, ' - ', .//institution, ' (', .//settlement, ') ', .//repository)"
                />
            </dd>
            <dt>
                <b>Cote :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//msIdentifier/idno"/>
            </dd>
            <dt>
                <b>Ancienne cote : </b>
            </dt>
            <dd>
                <xsl:value-of select="replace(.//altIdentifier[1]/idno, '(Ancienne cote)', '')"/>
            </dd>
        </dl>

        <h3>Histoire de la conservation du manuscrit :</h3>
        <p>
            <xsl:value-of select=".//provenance/p"/>
        </p>

        <h3>Mentions de responsabilité :</h3>

        <dl>
            <dt>
                <b>Auteur :</b>
            </dt>
            <dd>
                <xsl:value-of select="replace(//msItem/note, 'Walter', ' et/ou Walter')"/>
            </dd>
            <dt>
                <b>Enlumineur :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//msItem//respStmt//persName"/>
            </dd>
        </dl>

        <h3>Description physique :</h3>

        <dl>
            <dt>
                <b>Langue :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//textLang"/>
            </dd>
            <dt>
                <b>Support :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//support"/>
            </dd>
            <dt>
                <b>Format :</b>
            </dt>
            <dd>
                <xsl:value-of select="concat(.//width/@unit, ' x ', .//height/@unit)"/>
            </dd>
            <dt>
                <b>Foliation :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//foliation"/>
            </dd>
            <dt>
                <b>Disposition du texte :</b>
            </dt>
            <dd>
                <xsl:value-of select=".//layout"/>
            </dd>
            <dt>
                <b>Décorations :</b>
            </dt>
            <dd>
                <xsl:apply-templates select="//decoDesc/decoNote"/>
            </dd>
            <div class="column">
                <dt>
                    <b>Reliure :</b>
                </dt>
                <dd>
                    <xsl:value-of
                        select=".//decoNote[@type = 'plats'] | .//decoNote[@type = 'dos'] | .//decoNote[@type = 'contreplats']"
                    />
                </dd>
                <dd>
                    <img class="img" src="armoiries.jpg" width="150px"/>
                </dd>
            </div>


        </dl>

        <h3>Les différentes parties :</h3>

        <dl>
            <dd>
                <xsl:value-of select=".//msContents/summary"/>
            </dd>
            <dt>
                <b>Incipit :</b>
            </dt>
            <dd>
                <xsl:value-of select="concat(' ''', .//incipit, '''')"/>
            </dd>
            <dt>
                <b>Explicit :</b>
            </dt>
            <dd>
                <xsl:value-of select="concat(' ''', .//explicit, '''')"/>
            </dd>
        </dl>


    </xsl:template>
    
    


    <!-- HEADER HTML -->
    <xsl:template name="meta-header">
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="num_ms">
            <xsl:value-of select="//msIdentifier/idno"/>
        </xsl:variable>
        <xsl:variable name="depart">
            <xsl:value-of select="//msIdentifier/repository"/>
        </xsl:variable>
        <xsl:variable name="bibli">
            <xsl:value-of select="//msIdentifier/institution"/>
        </xsl:variable>

        <link rel="stylesheet" href="style.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta charset="UTF-8"/>
        <meta name="author" content="Elsa FALCOZ"/>
        <meta name="description"
            content="Édition numérique du {$titre} dans le manuscrit {$num_ms} du {$depart} de la {$bibli}"/>
        <meta name="keywords" content="XSLT,XML,TEI"/>

        <link rel="icon" type="image/png" href="IMAGES/Lancelot_IMG_f.103v.jpeg"/>


    </xsl:template>

    <!-- LES DIFFERENTES TRANSCRIPTIONS -->
    <!-- affichage de l'édition version normalisée -->
    <xsl:template match="choice" mode="reg">
        
        <xsl:value-of select="
            .//reg/text() |
            .//expan//text() | .//ex/text()"/>
    </xsl:template>
    
    <!-- affichage de l'édition version allographétique -->
    <xsl:template match="choice" mode="orig">

        <xsl:value-of select="
                .//orig/text() |
                .//abbr/text() | .//sic/text()"/>

    </xsl:template>
    
    <!-- gestion des lettrines en couleurs -->
    <!-- A REPRENDRE : il faudrait l'améliorer en passant la couleur dans une variable pour
        prévoir d'autres couleurs que le bleu -->
    <xsl:template match="//hi" mode="#all">
        <xsl:choose>
            <xsl:when test="contains(@rend, 'color(blue)')">
                <span class="initiale" style="color: #0f138e">
                    <xsl:apply-templates mode="reg"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="reg"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- gestion des <persName> pour ajouter une css_perso -->
    <!-- A REPRENDRE : se répète entre la version orig et reg, aurait pu être amélioré -->
    <xsl:template match="TEI//body//persName" mode="reg">
        <span class="css_perso">
            <xsl:apply-templates mode="reg"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI//body//persName" mode="orig">
        <span class="css_perso">
            <xsl:apply-templates mode="orig"/>
        </span>
    </xsl:template>

    <!-- gestion des passages <unclear> et <damage> de la transcription -->
    <xsl:template match="//unclear" mode="#all">
        <xsl:choose>
            <!-- gestion des mots que nous ne sommes pas parvenus à transcrire -->
            <xsl:when test="@reason = 'illegible'">
                <span class="illegible">
                    <xsl:text>{</xsl:text>
                    <xsl:apply-templates mode="reg"/>
                    <xsl:text>}</xsl:text>
                </span>
            </xsl:when>
            <!-- gestion des mots illisibles à cause du support abbimé, création d'une classe
            pour pouvoir les gérer avec de la css-->
            <xsl:when test="@reason = 'faded'">
                <span>
                    <xsl:attribute name="class"><xsl:text>faded</xsl:text>
                    </xsl:attribute> illisible <xsl:apply-templates/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!-- création d'attribut class="colonne" au texte pour gérer l'affichage css par la suite -->
    <!-- A REFPRENDRE : comme dit plus bas, gérer les occurence en les groupant par feuillets pour plus de clarté -->
    <xsl:template match="text/body//cb" mode="#all">
        <xsl:element name="div">
            <xsl:attribute name="class">
                <xsl:text>colonne</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:number count="cb" format="1" level="multiple"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>

    <!-- gestion de l'index des personnages -->
    <xsl:template name="indexPers">
        <xsl:for-each select="//listPerson/person/persName">
            <li>
                <b><xsl:value-of select="."/></b>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <xsl:variable name="nb-occurrence">
                    <xsl:value-of
                        select="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson])"
                    />
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <em>
                    <xsl:value-of select="concat('(', ancestor::person/note, ')')"/>
                </em>
                <div>
                    <xsl:text>Nombre d'occurences :</xsl:text>
                    <xsl:value-of select="$nb-occurrence"/>
                </div>
                <p>

                    <xsl:for-each
                        select="ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson]">
                        <xsl:choose>
                            <xsl:when test="ancestor::ab">
                                <div>
                                    <!-- il aurait été bien de faire un groupe-by par ab[@n] pour éviter les répétitions
                                    de feuillets, mais je n'y suis pas parvenu -->
                                    <xsl:value-of
                                        select="concat('Feuillet n°', ancestor::ab/@n[position() = last()]), ' - '"/>
                                    <xsl:value-of select="concat('Colonne n° ', parent::cb/@n)"/>
                                    <xsl:choose>
                                        <xsl:when test="position() != last()">, </xsl:when>
                                        <xsl:otherwise>.</xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </p>
            </li>
        </xsl:for-each>
    </xsl:template>

    <!-- gestion (très basique) de la bibliographie -->
    <xsl:template name="biblio">
        <div class="container">
            <xsl:apply-templates select="TEI/teiHeader//listBibl/bibl"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI/teiHeader//listBibl/bibl">
        <div class="biblio">
            <p>
                <xsl:apply-templates select=".//author"/>
                <xsl:apply-templates select=".//title"/>
                <xsl:if test=".//pubPlace">
                    <xsl:value-of select="concat(.//pubPlace, ', ')"/>
                </xsl:if>
                <xsl:apply-templates select=".//editor"/>
                <xsl:if test=".//publisher">
                    <xsl:value-of select="concat(.//publisher, ', ')"/>
                </xsl:if>
                <xsl:if test=".//date">
                    <xsl:value-of select=".//date"/>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test=".//biblScope">
                        <xsl:apply-templates select=".//biblScope"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>.</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//author">
        <xsl:choose>
            <xsl:when test="./persName">
                <span>
                    <xsl:apply-templates select="./persName"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:value-of select="."/>
                </span>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//author/persName">
        <xsl:value-of select="concat(., ', ')"/>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//editor">
        <xsl:choose>
            <xsl:when test="./persName">
                <xsl:apply-templates select="./persName"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//title">
        <xsl:choose>
            <xsl:when test="@type='a'">
                <xsl:text>« </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> », </xsl:text>
            </xsl:when>
            <xsl:when test="@type='m'">
                <em><xsl:value-of select="."/></em>
                <xsl:text>, </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//biblScope">
        <xsl:value-of select="concat(', ', .)"/>
        <xsl:if test="position() = last()">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
