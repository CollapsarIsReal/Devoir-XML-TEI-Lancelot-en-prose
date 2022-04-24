<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- Attention une sortie HTML => exclusion du préfixe tei des résultats -->
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/> <!-- pour éviter les espaces non voulus -->
    <xsl:template match="/">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
            <!-- récupération du nom et du chemin du fichier courant -->
        </xsl:variable>
        
        <!-- DEFINITION DES VARIABLES DE NOMS DE FICHIERS DE SORTIE -->
        
        <xsl:variable name="pathAllo">
            <xsl:value-of select="concat($witfile,'allograph','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAllo2">
            <xsl:value-of select="concat($witfile,'allograph2','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNorm">
            <xsl:value-of select="concat($witfile,'norm','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNorm2">
            <xsl:value-of select="concat($witfile,'norm2','.html')"/>
        </xsl:variable>
        <!--<xsl:variable name="pathIndexLieux">
            <xsl:value-of select="concat($witfile,'indexLieux','.html')"/>
        </xsl:variable>-->
        <xsl:variable name="pathIndexPers">
            <xsl:value-of select="concat($witfile,'indexPers','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile, 'accueil','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathnoticems">
            <xsl:value-of select="concat($witfile, 'noticems','.html')"/>
        </xsl:variable>
        <!--<xsl:variable name="pathchap">
            <xsl:value-of select="concat($witfile, 'chap','.html')"/>
        </xsl:variable>-->
        
        <!--<xsl:variable name="titre_manuscrit">
            <xsl:value-of select="concat(.//head/title, ' ', '(',.//head/origDate, ')', ' de ', .//name[@xml:id='Gauthier_Map'] )"/>
        </xsl:variable>-->
        
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
            <xsl:value-of select="concat(./respStmt/persName/forename, ' ', ./respStmt/persName/surname)"/>
        </xsl:variable>
        <!--<xsl:variable name="ENC"> NOTE : apparemment il n'est pas possible de créer un lien dans une variable XSL ?
            <a>
                <xsl:attribute name="href">
                    <xsl:text>https://www.chartes.psl.eu/fr/rubrique-admissions/master-technologies-numeriques-appliquees-histoire</xsl:text>
                </xsl:attribute>
                    <xsl:value-of select="replace(//publicationStmt/publisher, 'Edition par l', '')"/>
            </a>
        </xsl:variable>-->

        <!-- PAGE D'ACCUEIL -->
       
        <xsl:result-document href="{$pathAccueil}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="$titre"/>
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
                        }
                        
                       img {
                       display: block;
                       text-align: center;
                       margin: 50px;
                       }
                    </style>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_dev"/></h1>
                    <div class="container">
                        <div class="colonne" n='1'>
                    <p><xsl:value-of select="concat('Cette édition en ligne a été réalisée à partir du manuscrit ', $num_ms, ' conservé à la ', .//institution, '. ')"/>                    
                        Une feuille de transformation XSL a été rédigée dans le cadre d une évalutation du cours de XSLT du <a href="https://www.chartes.psl.eu/fr/rubrique-admissions/master-technologies-numeriques-appliquees-histoire">Master 2 TNAH</a> de l 
                        Ecole nationale des Chartes réalisés par <xsl:value-of select="concat(./respStmt/persName/forename, ' ', ./respStmt/persName/surname)"/></p>
                    <p>Cette édition propose d'explorer deux des <xsl:value-of select="//foliation"/> du <xsl:value-of select="$titre"/>.</p>
                            <p>On y trouvera différentes exploitation notamment <em>une transcription allographétique</em>, une <em> autre version modernisée</em>,
                            , un rapide <em>index des personnages</em> présents dans les deux feuillets édités ainsi que la <em>notice du manuscrit</em>.</p>
                            <p>Malheureusement certaisns choix effectués lors de l'encodage XML du manuscrit ont rendu compliqué la transformation
                            HTML (par exemple celui de traiter les lignes du texte uniquement dans des balises <em>lb</em> autofermantes, rendant l'accès au texte complexe, ou
                                bien encore en ce qui concerne l'encodage de la forme normalisée qui n'avait pas pris en compte la normalisation des espaces, majuscules,
                            voyelles (u,i) et autres spécificités).</p>
                            </div>
                            <div class="colonne" n='2'>
                                <h2>Sommaire</h2>
                        <ul>
                            <li><a href="{$pathnoticems}"><xsl:value-of select="concat('Notice du manucrit ', $num_ms)"/></a></li>
                            <li><b>La transcription allographétique</b></li>
                            <ul>
                                <li><a href="{$pathAllo}">
                                    <xsl:text>premier feuillet (103v): </xsl:text></a>
                                    <em>- <xsl:value-of select="replace(.//ab[@n='1']/cb[@n='1'], 'chlřchevalierqui cil estoit qui li māan', 'chlř qui cil estoit qui li mā-... ')"/></em>
                                </li>
                                <li><a href="{$pathAllo2}">
                                    <xsl:text>deuxième feuillet (104r): </xsl:text></a>
                                    <em>- <xsl:value-of select="substring-before(replace(.//ab[@n='2']/cb[@n='1'], 'chlřchevalier', 'chlř'), 'la')"/>...</em></li> <!-- pas réussi à intégrer les "..."-->
                            </ul>
                            <li><b>La transcription normalisée</b></li>
                            <ul>
                                <li><a href="{$pathNorm}">
                                    <xsl:text>premier feuillet (103v): </xsl:text></a>
                                    <em>- <xsl:value-of select="replace(.//ab[@n='1']/cb[@n='1'], 'chlřchevalierqui cil estoit qui li māan', 'chevalier qui cil estoit qui li man-...')"/></em>
                                </li>
                                <li>
                                    <a href="{$pathNorm2}">
                                        <xsl:text>deuxième feuillet (104r): </xsl:text></a>
                                    <em>- <xsl:value-of select="substring-before(replace(.//ab[@n='2']/cb[@n='1'], 'chlřchevalier', 'chevalier'), 'la')"/>...</em> <!-- pas réussi à intégrer les "..."-->
                                </li>
                            </ul>
                            <li><a href="{$pathIndexPers}">L'index des noms de personnages</a></li>
                        </ul>
                    </div>
                        <div class="colonne" n='3'>
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
                        <xsl:value-of select="$titre"/>
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
        <xsl:result-document href="{$pathNorm}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($titre, ': f.103v normalisé')"/>
                    </title>
                    <style>
                     div {
                     display: flex;
                     width: 100%;
                     text-align: justify;
                     }
                        
                    div.colonne {
                    display: flex;
                    justify-content: space-between;
                    width: 100%;
                    padding: 20px;
                    border-style: double;
                    margin: 10px;
                    border-color: tan;
                    }
                    
                    span.initiale {
                    font-size: larger;
                    font-weight: bolder
                    }
                    </style>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                   
                    
                    
                    <h3>La transcription normalisée</h3>
                    
                    <div class="row">
                        <xsl:apply-templates select="//ab[@n='1']" mode="reg"/>
                    </div>      
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- EDITION NORMALISEE 2-->
        
        <xsl:result-document href="{$pathNorm2}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                    <style>
                        div {
                        display: flex;
                        width: 100%;
                        text-align: justify;
                        }
                        
                        div.colonne {
                        display: flex;
                        justify-content: space-between;
                        width: 100%;
                        padding: 20px;
                        border-style: double;
                        margin: 10px;
                        border-color: blue;
                        }
                        
                        
                        span.initiale {
                        font-size: larger;
                        font-weight: bolder
                        }
                    </style>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                   
                    
                    
                    <h3>La transcription normalisée</h3>
                    
                    <div class="flexblox">
                        <xsl:apply-templates select=".//ab[@n='2']" mode="reg"/>
                    </div>       
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- EDITION ALLOGRAPHETIQUE -->
        <xsl:result-document href="{$pathAllo}"
            method="html" indent="yes">       
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                    <style>
                        div {
                        display: flex;
                        width: 100%;
                        text-align: justify;
                        }
                        
                        div.colonne {
                        display: flex;
                        justify-content: space-between;
                        width: 100%;
                        padding: 20px;
                        border-style: double;
                        margin: 10px;
                        border-color: tan;
                        }
                        
                        
                        span.initiale {
                        font-size: larger;
                        font-weight: bolder
                        }
                    </style>
                </head>
                <body>
                    
                    <h1><xsl:value-of select="$titre"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    
                    
                    <h3>Transcription allographétique</h3>
                    <div class="row">
                        
                        <xsl:apply-templates select=".//ab[@n='1']" mode="orig"/>
                        
                    </div>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- EDITION ALLOGRAPHETIQUE 2-->
        
        <xsl:result-document href="{$pathAllo2}"
            method="html" indent="yes">       
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="$titre"/>
                    </title>
                    <style>
                        div {
                        display: flex;
                        width: 100%;
                        text-align: justify;
                        }
                        
                        div.colonne {
                        display: flex;
                        justify-content: space-between;
                        width: 100%;
                        padding: 20px;
                        border-style: double;
                        margin: 10px;
                        border-color: blue;
                        }
                        
                        
                        span.initiale {
                        font-size: larger;
                        font-weight: bolder
                        }
                    </style>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    
                    
                    <h3>Transcription allographétique</h3>
                    
                    <div class="flexblox">
                        <xsl:apply-templates select=".//ab[@n='2']" mode="orig"/>
                    </div>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- INDEX DES PERSONNAGES -->
        
        <xsl:result-document href="{$pathIndexPers}"
            method="html" indent="yes">          
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index des personnages</h2>
                    <div>
                        <ul><xsl:call-template name="indexPers"/></ul>
                    </div>     
                </body>
            </html>
        </xsl:result-document>
        </xsl:template>
    <!--Fin des pages HTML -->

    <!-- page de notice du manuscrit -->
    <xsl:template name="notice_manuscrit">
                    <h1><xsl:value-of select=".//titleStmt/title"/></h1>
                    <h2>
                        <xsl:text>Manuscrit </xsl:text>
                        <em>
                            <xsl:value-of select="TEI//msIdentifier/idno"/>
                        </em>
                    </h2>
                    
                    <div><h3>Identification :</h3></div>
                    <dl>
                        <dt><b>Institution de conservation :</b></dt><dd><xsl:value-of select="concat(.//country, ' - ', .//institution, ' (', .//settlement, ') ', .//repository )"/></dd>
                        <dt><b>Cote :</b></dt><dd><xsl:value-of select=".//msIdentifier/idno"/></dd>
                        <dt><b>Ancienne cote : </b></dt><dd><xsl:value-of select="replace(.//altIdentifier[1]/idno, '(Ancienne cote)', '')"/></dd>
                    </dl>
                    
                    <h3>Histoire de la conservation du manuscrit :</h3>
                    <p><xsl:value-of select=".//provenance/p"/></p>
                    
                    <h3>Mentions de responsabilité :</h3>
                    
                    <dl>
                        <dt><b>Auteur :</b></dt>
                        <dd><xsl:value-of select="replace(//msItem/note, 'Walter', ' et/ou Walter')"/></dd>
                        <dt><b>Enlumineur :</b></dt>
                        <dd><xsl:value-of select=".//msItem//respStmt//persName"/></dd>
                    </dl>
                    
                    <h3>Description physique :</h3>
                    
                    <dl>
                        <dt><b>Langue :</b></dt><dd><xsl:value-of select=".//textLang"/></dd>
                        <dt><b>Support :</b></dt><dd><xsl:value-of select=".//support"/></dd>
                        <dt><b>Format :</b></dt><dd><xsl:value-of select="concat(.//width/@unit, ' x ', .//height/@unit)"/></dd>
                        <dt><b>Foliation :</b></dt><dd><xsl:value-of select=".//foliation"/></dd>
                        <dt><b>Disposition du texte :</b></dt>
                        <dd><xsl:value-of select=".//layout"/></dd>
                        <dt><b>Décorations :</b></dt>
                        <dd><xsl:apply-templates select="//decoDesc/decoNote"/></dd>
                        <!--<dd><xsl:value-of select="concat(.//decoDesc/decoNote[1]/@type, ', ', .//decoDesc/decoNote[2]/@type, ' ornées')"/></dd>
                        <dd>Les décorations sont davantages détaillées dans la présentation de chaque chapitre/rubrique du manuscrit qui précède les transcriptions.</dd>-->
                        <div class="column">
                        <dt><b>Reliure :</b></dt>
                        <p><xsl:value-of select=".//decoNote[@type='plats'] |.//decoNote[@type='dos'] |.//decoNote[@type='contreplats']"/></p>
                        <p><img src="armoiries.jpg" width="150px"/></p>
                        </div>
                        
                        
                    </dl>
                    
                    <h3>Les différentes parties :</h3>
                    
                    <dl>
                        <dd><xsl:value-of select=".//msContents/summary"/></dd>
                        <dt><b>Incipit :</b></dt><dd><xsl:value-of select="concat(' ''', .//incipit, '''')"/></dd>
                        <dt><b>Explicit :</b></dt><dd><xsl:value-of select="concat(' ''', .//explicit, '''')"/></dd>
                    </dl>
                    
        
    </xsl:template>

    <!-- gestion des dates 
    <xsl:template match="//date">
        <xsl:choose>
            <xsl:when test="parent::persName">
                <xsl:text>(</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template> -->
    
    <!-- gestion des decoNote -->
    <xsl:template match="decoNote">
        <xsl:choose>
            <xsl:when test="parent::decoDesc">
                <li><xsl:apply-templates/></li>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- gestion des lb -->
    <xsl:template match="lb">
        <xsl:apply-templates/>
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
        <meta name="description" content="Édition numérique du {$titre} dans le manuscrit {$num_ms} du {$depart} de la {$bibli}"/>
        <meta name="keywords" content="XSLT,XML,TEI"/>
        
        <link rel="icon" type="image/png" href="IMAGES/Lancelot_IMG_f.103v.jpeg" />
        
        
    </xsl:template>
    
    <!-- TEXTE TRANSCRIT -->
    <!-- - - - -VERSION ALLOGRAPHETIQUE - - - - -->
    
    
    
    <xsl:template match="choice" mode="orig">
        
        <xsl:value-of select=".//orig/text() |
            .//abbr/text()| .//sic/text()"/>
        
    </xsl:template>
    <!-- - - - -VERSION MODERNISÉE - - - - -->
    <!-- lettrines en couleur : il faudrait l'améliorer en passant la couleur dans une variable pour
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
    
    <xsl:template match="choice" mode="reg">
        
        <xsl:value-of select=".//reg/text() |
            .//expan//text() | .//ex/text() |.//corr/text()"/>
        
    </xsl:template>
    
    <!-- création d'attribut class="colonne" pour gérer l'affichage css par la suite -->
    <xsl:template match="text/body//cb" mode="#all">
        <xsl:element name="div">
            <xsl:attribute name="class"><xsl:text>colonne</xsl:text></xsl:attribute>
            <xsl:attribute name="id">
                <xsl:number count="cb" format="1" level="multiple"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    

    <!-- L'index des personnages
    <xsl:template name="indexPers">
        <xsl:for-each select=".//listPerson/person/persName">
            <li>
                <xsl:value-of select="."/>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <em><xsl:text> : (</xsl:text>
                    <xsl:value-of select="replace(following-sibling::note, 'R', 'r')"/>
                    Comment mettre deux fonctions replace en me^me temps ? le deuxième replace 'C' en 'c' ne fonctionne pas.
                        De toute façon il faudrait plutôt avoir une règle qui mette en lower-case
                        la première lettre des éléments <note>, ça serait plus efficace sur le long terme
                <xsl:text>)</xsl:text></em>
                <ul>
                    <li>
                        <xsl:for-each select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]">
                        <xsl:apply-templates mode="reg"/>
                        <xsl:text> (col.</xsl:text>
                        <xsl:choose>
                            <xsl:when test="ancestor::said">
                                <xsl:value-of select="count(ancestor::lb/preceding-sibling::cb) + 1"/>
                            </xsl:when>
                            <xsl:otherwise><xsl:value-of select="count(parent::lb/preceding-sibling::cb) + 1"/></xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>)</xsl:text>
                        <xsl:choose>
                            <xsl:when test="position()!= last()">, </xsl:when>
                            <xsl:otherwise>.</xsl:otherwise>
                        </xsl:choose>
                        </xsl:for-each>
                    </li>
                </ul>
            </li>
        </xsl:for-each>
    </xsl:template> -->
    
    <!-- L'index des personnages -->
    <xsl:template name="indexPers">
        <xsl:for-each select="//listPerson/person/persName">
            <li>
                <i><xsl:value-of select="."/></i>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <xsl:variable name="nb-occurrence">
                    <xsl:value-of
                        select="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson])"
                    />
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <em>(<xsl:value-of select="ancestor::person/note"/>)</em>
                <div><xsl:text>Nombre d'occurences : </xsl:text><xsl:value-of select="$nb-occurrence"/></div>
                <p>
                    <xsl:value-of select="//milestone[position()=1]"/>
                    <xsl:for-each select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]">
                        <xsl:choose>
                            <xsl:when test="parent::cb">
                                
                                Feuillet n° <xsl:value-of select="ancestor::ab/@n"/>
                                Colonne n° <xsl:value-of select="parent::cb/@n"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </p>
            </li>
        </xsl:for-each>
    </xsl:template>
  
    
</xsl:stylesheet>
    
