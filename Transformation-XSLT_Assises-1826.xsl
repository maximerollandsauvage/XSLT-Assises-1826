<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : HTML -->
    <xsl:output method="html" indent="yes"/>
    
    
    <!-- 2. DÉBUT DES DÉCLARATIONS DES VARIABLES -->
    
    <!-- CHEMINS DES FICHIERS DE SORTIE -->
    
    <xsl:variable name="home">
        <xsl:value-of select="concat('Accueil','.html')"/>
        <!-- variable pour le contenu du home  -->
    </xsl:variable>
    <xsl:variable name="compte_rendu">
        <xsl:value-of select="concat('Compte-Rendu','.html')"/>
        <!-- variable pour le contenu du compte-rendu  -->
    </xsl:variable>
    <xsl:variable name="glossaire">
        <xsl:value-of select="concat('Glossaire','.html')"/>
        <!-- variable pour le contenu du glossaire  -->
    </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('Index','.html')"/>
        <!-- variable pour le contenu dde l'index  -->
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE <HEAD> -->
    <xsl:variable name="header">
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title><xsl:value-of select="//titleStmt/title"/></title>
                <h1>Adressé au Ministre de la Justice</h1>
            <meta name="description">
                <xsl:attribute name="content">
                    <xsl:value-of select="//creation/date"/><xsl:text> par </xsl:text><xsl:value-of select="//titleStmt/author"/>
                </xsl:attribute>
            </meta>
            <meta name="author">
                <xsl:attribute name="content">
                    <xsl:value-of select="//fileDesc/titleStmt/author/concat(surname, ' ', forename, ', ',affiliation)"/>
                </xsl:attribute>
            </meta>
        </head>
    </xsl:variable>
        
    <!-- VARIABLE AVEC LE <FOOTER> -->
    <xsl:variable name="footer">
        <footer>
            <!-- INTEGRATION DU CSS DANS LA BALISE DU FOOTER -->
            <p style="text-align: justify; font-family: cascadia code;"><i><xsl:value-of select="//respStmt/resp"/>.</i></p>
        </footer>
    </xsl:variable>
    
    <!-- VARIABLE AVEC LE CSS DU <BODY> -->
    <xsl:variable name="body_css">
        <xsl:text>margin-right: 20%; margin-left: 20%; margin-top: 6%;font-family: cascadia mono; text-align: justify; background-color: lightgrey</xsl:text>
    </xsl:variable>
        
    <!-- VARIABLES AVEC LES LIENS DE RETOUR -->
    <xsl:variable name="return_home">
        <i><a href="{concat('./', $home)}">Revenir à l'accueil</a></i>
    </xsl:variable>
    
    <xsl:variable name="return_glossaire">
        <i><a href="{concat('./', $glossaire)}">Glossaire des termes juridiques</a></i>
    </xsl:variable>
    
    <xsl:variable name="return_cr">
        <i><a href="{concat('./', $compte_rendu)}">Revenir au compte-rendu</a></i>
    </xsl:variable>
    
    <xsl:variable name="return_index">
        <i><a href="{concat('./', $index)}">Revenir à l'index</a></i>
    </xsl:variable>
    
    <!-- VARIABLE AVEC L'EN-TÊTE DU <BODY> DES PAGES -->
    <xsl:variable name="body_header">
        <!-- INTEGRATION DU CSS DANS LA BALISE DE LA DIV -->
        <div style="text-align: center; margin-bottom: 8%; font-size: 10px; font-family: cascadia code SemiBold">
            <h1><xsl:value-of select="//titleStmt/title"/></h1>
            <h1>Adressé au Ministre de la Justice</h1>
            <h2><xsl:value-of select="//creation/date"/></h2>
            <h3><xsl:value-of select="//fileDesc/titleStmt/author/concat(surname, ' ', forename, ', ',affiliation)"/></h3>
        </div>
    </xsl:variable>
    
    <!-- FIN DES DÉCLARATIONS DES VARIABLES -->
    
    
    <!-- 3. TEMPLATE MATCH SUR LA RACINE AVEC LES CALL TEMPLATES DES PAGES -->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="compte_rendu"/>
        <xsl:call-template name="glossaire"/>
        <xsl:call-template name="index"/>
    </xsl:template>
    
    <!-- FIN DU TEMPLATE MATCH SUR LA RACINE -->
    
    <!-- TEMPLATE DE LA PAGE HOME -->
    <!-- TEMPLATE POUR LA STRUCTURE GLOBALE DE LA PAGE HOME AVEC APPEL DES VARIABLES -->
    <xsl:template name="home">
        <xsl:result-document href="{$home}" method="html">
            <html lang="fr">
                <body>    
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div style="text-align: justify"><!-- INSERTION DU CSS DANS LA BALISE POUR UN TEXTE JUSTIFIE -->  
                        <!-- COPIE DU CONTENU DE LA BALISE QUI RESUME LE MIEUX LE MANUSCRIT --> 
                        <p><b>Résumé : </b><xsl:value-of select="//msContents/p"/></p>
                    </div>
                    <div>
                        <!-- INSERTION DES RETOURS SANS FAIRE APPEL AUX VARIABLES CAR UTILISATION DE TERMES DIFFERENTS (SANS LA MENTION "REVENIR A ...) -->
                        <!-- RETOURS PLACES AU DESSUS DE L'IMAGE ET NON PAS A LA FIN DE LA PAGE POUR PLUS DE FACILITE DE NAVIGATION -->
                        <p><a href="./{$compte_rendu}">Compte-Rendu</a> – <a href="./{$glossaire}">Glossaire</a> - <a href="./{$glossaire}">Index</a></p>
                    </div>
                    
                    <!-- INSERTION D'UNE IMAGE POUR HABILLER LA PAGE D'ACCUEIL + LEGENDE ET CREDIT -->
                    <img src="https://www.radiofrance.fr/s3/cruiser-production/2022/11/514d858f-d43a-4339-abaa-fe9fa59b3f00/870x489_the-jury-by-john-morgan.webp" alt="The Jury by John Morgan"/>
                    <p style="font-size:8px"><em>The Jury</em> by John Morgan - 1861 - © Bucks County Museum</p>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- FIN DU TEMPLATE SUR LA PAGE HOME -->
    
    <!-- TEMPLATES DE LA PAGE COMPTE RENDU -->
    <!-- TEMPLATE POUR LA STRUCTURE GLOBALE DE LA PAGE COMPTE-RENDU AVEC APPEL DES VARIABLES-->
    <xsl:template name="compte_rendu">    
        <xsl:result-document href="{$compte_rendu}" method="html">
            <html lang="fr">
                
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$body_css"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
            
                    <!-- INSERTION DE L'OPENER ET L'INTRODUCTION; UTILISATION D'UNE BOUCLE POUR ASSURER UN RETOUR A LA LIGNE  -->
                    <xsl:for-each select="//opener | //div[@type='introduction']"> 
                        <xsl:apply-templates select="."/>
                        <p><br/></p>
                    </xsl:for-each>
                    
                    <!-- INSERTION DES DIFFERENTES PARTIES; UTILISATION D'UNE BOUCLE POUR ASSURER UN RETOUR A LA LIGNE  -->
                    <xsl:for-each select="//div[@type='part']">
                        <xsl:apply-templates select="."/>
                        <p><br/></p>
                    </xsl:for-each>
                
                    <p><br/></p>
                    
                    <!-- INSERTION DE LA CONCLUSION; UTILISATION D'UNE BOUCLE POUR ASSURER UN RETOUR A LA LIGNE  -->
                    <xsl:for-each select="//div[@type='conclusion']">
                        <xsl:apply-templates select="."/>
                        <br/>
                    </xsl:for-each>
                    
                    <p><br/></p>
                   
                    <!-- INSERTION DE LA SIGNATURE; UTILISATION D'UNE BOUCLE POUR ASSURER UN RETOUR A LA LIGNE -->                   
                    <xsl:for-each select="//closer"> 
                        <xsl:apply-templates select="."/>
                        <br/>
                    </xsl:for-each>    
                    
                    <!-- INSERTION DES RETOURS ET DU FOOTER -->
                    <div>
                        <p><xsl:copy-of select="$return_home"/> – <xsl:copy-of select="$return_glossaire"/> - <xsl:copy-of select="$return_index"/></p>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- TEMPLATE POUR ASSURER LE RESPECT DES lb ET S'ASSURER QUE LE RETOUR A LA LIGNE RESPECTE LE MANUSCRIT ORIGINAL -->
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    
    <!-- TEMPLATES POUR METTRE EN COULEUR CERTAINS MOTS SELON LEUR ATTRIBUT. CES COULEURS SONT REPRISES DANS LE GLOSSAIRE -->
    <xsl:template match="term[@type='verdict']">
            <span style="color: blue;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="term[@type='accusation']">
        <span style="color: red;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="term[@type='duree']">
       <span style="color: green;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="term[@type='ca']">
        <span style="color: purple;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- TEMPLATES POUR METTRE EN GRAS LE NOM DES ACCUSEES POUR PLUS DE LISIBILITE -->
    <xsl:template match="rs[@type='person']">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <!-- FIN DU TEMPLATE DE LA PAGE COMPTE-RENDU -->
    
    <!-- TEMPLATES DE LA PAGE GLOSSAIRE -->
    <!-- TEMPLATE POUR LA STRUCTURE GLOBALE DE LA PAGE GLOSSAIRE AVEC APPEL DES VARIABLES-->
    <xsl:template name="glossaire">
        <xsl:result-document href="{$glossaire}">
            <html lang="fr">
                
                <body style="{$body_css}">
                    <xsl:copy-of select="$body_header"/>
                    <h1 style="{$body_css}; text-align: center;">Glossaire des termes juridiques</h1> <!-- iCI, MODIFICATION DU STYLE DU BODY CSS POUR LE TITRE DE LA PAGE-->
                    
                    <!-- UTILISATION DE DIV POUR ASSURER UN SAUT DE LIGNE ENTRE CHAQUE LISTES-->
                    <div>
                        <!-- CREATION DU TITRE DE LA LISTE EN REPRENANT LE CONTENU DE LA BALISE DE LA TAXONOMY; 
                            STYLE EN MAJUSCULES ET AJOUT D'UN "S" POUR COMPENSER LE STYLE TÉLÉGRAPHIQUE D'UN ID ET AJOUT D'UNE COULEUR CORRESPONDANT A L'ATTRIBUT DANS LE COMPTE-RENDU-->
                        <span style="color: red;"><xsl:value-of select="upper-case(//taxonomy[@xml:id = 'accusation']/@xml:id)"/>S: <xsl:copy-of select="//classDecl/taxonomy[@xml:id = 'accusation']/desc"/></span> 
                    </div>
                    <div>
                        <ul>
                            <!-- CREATION DE LA LISTE "ACCUSATIONS" -->
                            <xsl:apply-templates select="//taxonomy[@xml:id = 'accusation']/category/catDesc"/>
                        </ul>
                    </div>
                    <div>
                        <!-- CREATION DU TITRE DE LA LISTE EN REPRENANT LE CONTENU DE LA BALISE DE LA TAXONOMY; 
                             STYLE EN MAJUSCULES ET AJOUT D'UN "S" POUR COMPENSER LE STYLE TÉLÉGRAPHIQUE D'UN ID ET AJOUT D'UNE COULEUR CORRESPONDANT A L'ATTRIBUT DANS LE COMPTE-RENDU-->
                        <span style="color: blue;"><xsl:value-of select="upper-case(//taxonomy[@xml:id = 'verdict']/@xml:id)"/>S: <xsl:copy-of select="//classDecl/taxonomy[@xml:id = 'verdict']/desc"/></span>
                    </div>
                    <div>
                        <ul>
                            <!-- CEATION DE LA LISTE "VERDICTS" -->
                            <xsl:apply-templates select="//taxonomy[@xml:id = 'verdict']/category/catDesc"/>
                        </ul>
                    </div>
                    <div>
                        <!-- CREATION DU TITRE DE LA LISTE EN REPRENANT LE CONTENU DE LA BALISE DE LA TAXONOMY; 
                            STYLE EN MAJUSCULES ET AJOUT D'UN "S" POUR COMPENSER LE STYLE TÉLÉGRAPHIQUE D'UN ID ET AJOUT D'UNE COULEUR CORRESPONDANT A L'ATTRIBUT DANS LE COMPTE-RENDU-->
                        <span style="color: green;"><xsl:value-of select="upper-case(//taxonomy[@xml:id = 'duree']/@xml:id)"/>S: <xsl:copy-of select="//classDecl/taxonomy[@xml:id = 'duree']/desc"/></span>
                    </div>
                    <div>
                        <ul>
                            <!-- CREATION DE LA LISTE "DUREES" -->
                            <xsl:apply-templates select="//taxonomy[@xml:id = 'duree']/category/catDesc"/>
                        </ul>
                    </div>
                    <div>
                        <!-- ICI, NOUS N'AVONS PAS PU REPRENDRE DIRECTEMENT L'ID CONTENU DANS LA BALISE CAR IL ETAIT SIMLIFIE SOUS LE TERME "CA"; 
                            NOUS AVONS DONC AJOUTER LE TEXTE DIRECTEMENT EN UTILISANT UNE BALISE span ET NOUS AVONS AJOUTE LA COULEUR CORRESPONDANTE A L'ATTRIBUT DANS LE COMPTE-RENDU-->
                        <span style="color: purple;"><p style="upper-case; display: inline;">CIRCONSTANCES AGGRAVANTES</p>:<xsl:copy-of select="//classDecl/taxonomy[@xml:id = 'duree']/desc"/></span>
                    </div>
                    <div>
                        <ul>
                            <!-- CREATION DE LA LISTE "CIRCONSTANCES AGGRAVANTES" -->
                            <xsl:apply-templates select="//taxonomy[@xml:id = 'duree']/category/catDesc"/>
                        </ul>
                    </div>
                    
                    <!-- INSERTION DES RETOURS ET DU FOOTER -->
                    <div>
                        <p><xsl:copy-of select="$return_home"/> – <xsl:copy-of select="$return_cr"/> - <xsl:copy-of select="$return_index"/></p>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <!-- UTILISATION D'UN xsl-template POUR CREER UNE LISTE AVEC LES CAT DESC -->
    <xsl:template match="catDesc">
        <li><xsl:value-of select="."/></li>
    </xsl:template>
    
    <!-- FIN TEMPLATES DE LA PAGE GLOSSAIRE -->
    
    <!-- TEMPLATES DE LA PAGE INDEX -->
    <!-- TEMPLATE POUR LA STRUCTURE GLOBALE DE LA PAGE INDEX AVEC APPEL DES VARIABLES -->
    <xsl:template name="index">
        <xsl:result-document href="index.html" method="html">
            <html lang="fr">
                
                <body style="{$body_css}">
                    <xsl:copy-of select="$body_header"/>
                    <h1 style="{$body_css}; text-align: center;">Index des accusés</h1> <!-- iCI, MODIFICATION DU STYLE DU BODY CSS POUR LE TITRE DE LA PAGE-->
                    
                    <!-- EXLUSION DE LA PREMIERE ENTREE DE LA listPesrson (DESTINATAIRE DU COMPTE-RENDU DONC PAS UN DES ACCUSES) -->
                    <ul>
                        <xsl:apply-templates select="//particDesc/listPerson/person[position() &gt; 1]"/>
                    </ul>
                    <!-- INSERTION DES RETOURS ET DU FOOTER -->
                    <div>
                        <p><xsl:copy-of select="$return_home"/> – <xsl:copy-of select="$return_cr"/> - <xsl:copy-of select="$return_glossaire"/></p>
                    </div>
                    <xsl:copy-of select="$footer"/>
                 </body>
             </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- UTILISATION D'UN xsl-template POUR CREER UNE LISTE POUR CHAQUE ELEMENT DE LA BALISE person -->
    
    <xsl:template match="person">
        <li>
            <xsl:for-each-group select="*" group-adjacent="name()"><!-- RÈGLE QUI PARCOURT TOUS LES ÉLÉMENTS ENFANTS DE L'ÉLÉMENT ACTUEL. ELLE LES REGROUPE EN FONCTION DU NOM DE LEUR BALISE POUR QUE LES ÉLÉMENTS AYANT LE MÊME NOM DE BALISE SONT RASSEMBLÉS ENSEMBLE -->
                <xsl:apply-templates select="current-group()"/>
                <br/> <!-- RETOUR A LA LIGNE ENTRE CHAQUE CATEGORIE DE LA LISTE -->
            </xsl:for-each-group>
            <br/> <!-- SAUT DE LIGNE ENTRE CHAQUE ENTRÉE DE LA LISTE -->
        </li>
    </xsl:template>
    
    <xsl:template match="persName">
        <span style="font-weight: bold">
            <xsl:value-of select="concat('Nom', ': ', .)"/>
        </span>
    </xsl:template>
    
    <xsl:template match="gender">
        <span>
            <xsl:value-of select="concat('Genre', ': ', .)"/>
        </span>
    </xsl:template>
    
    <xsl:template match="age">
        <span>
            <xsl:value-of select="concat('Âge', ': ', ., ' ans')"/>
        </span>
    </xsl:template>
    
    <xsl:template match="trait">
        <span style="color: red">
            <xsl:value-of select="concat('Accusation', ': ', .)"/>
        </span>
    </xsl:template>
    
    <xsl:template match="state">
        <span style="color: blue">
            <xsl:value-of select="concat('Verdict', ': ', .)"/>
        </span>
    </xsl:template>
    
    <!-- FIN TEMPLATES DE LA PAGE INDEX -->
    
</xsl:stylesheet>