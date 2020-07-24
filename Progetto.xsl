<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    LLL1.30
                </title>
                <link rel="stylesheet" type="text/css" href="./mycss.css"/>
                <script src="./myjs.js"></script>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="//tei:idno[@type='inventory']" />
                </h1>
                <div class="first-container">
                    <div id="div-button" onclick="showHiddenDescription('informazioni')">
                        <button>Informazioni</button>
                    </div>
                    <div id="div-button" onclick="showHiddenDescription('collocazione')">
                        <button>Collocazione</button>
                    </div>
                    <div id="div-button" onclick="showHiddenDescription('caratteristiche')">
                        <button>Caratteristiche</button>
                    </div>
                    <div id="div-button" onclick="showHiddenDescription('note')">
                        <button>LL1.30</button>
                    </div>
                    <div id="div-contenuto">
                        <div id="descrizione">
                            <xsl:apply-templates select="//tei:msItem" />
                            <xsl:apply-templates select="//tei:msIdentifier" />                        
                            <xsl:apply-templates select="//tei:supportDesc" />
                        </div>

                        <div id="note">
                            <xsl:apply-templates select="//tei:additional" />
                        </div>
                    </div>
                </div>

                <div class="contenitore-grid">
                    <div id="immagini">
                        <xsl:apply-templates select="//tei:facsimile" />
                    </div>

                    <div>
                        <div id="apertura">
                            <xsl:apply-templates select="//tei:div[@type='opener']" />
                        </div>
                        
                        <div id="corpo">
                            <xsl:apply-templates select="//tei:div[@type='letter-body']" />
                        </div>    
                    </div>
                </div>

                <!-- bibliografia -->
                <div class="liste">
                    <div id="bottone1">
                        <button id="uno" onclick="showProfile('Bellini')">Vincenzo Bellini</button>
                    </div>
                    <div id="bottone2">
                        <button id="due" onclick="showProfile('Florimo')">Francesco Florimo</button>
                    </div>
                    <xsl:apply-templates select="//tei:listPerson" />
                </div>

                <!-- footer -->
                <div id="footer">
                    <div id="bibliography">
                        <xsl:apply-templates select="//tei:div[@type='bibliography']" />
                    </div>
                    <div id="edizione">
                        <xsl:apply-templates select="//tei:editionStmt"/>
                        <xsl:apply-templates select="//tei:publicationStmt"/>
                    </div>
                </div>  
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//tei:msItem">
        <div id="informazioni">
            <ul> 
                <span style="color:crimson; font-weight: bold;">Informazioni lettera:</span>
                <li>Autore: <xsl:value-of select="tei:author" /></li>
                <li>Destinatario:  <xsl:value-of select="tei:title/tei:persName[@ref='#FF']" /></li>
                <li>Data:  <xsl:value-of select="tei:title/tei:date" /> </li>
                <li>Lingua lettera: <xsl:value-of select="tei:textLang" /></li>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="//tei:msIdentifier">
        <div id="collocazione">
            <ul>
                <span style="color:crimson; font-weight: bold;">Collocazione lettera:</span>
                <li>Paese: <xsl:value-of select="tei:country" /></li>
                <li>Città: <xsl:value-of select="tei:settlement" /></li>
                <li>Presso: <xsl:value-of select="tei:repository" /></li>
                <li>Inventario: <xsl:value-of select="tei:idno" /></li>
                <li><xsl:value-of select="tei:altIdentifier/tei:idno" /></li>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="//tei:supportDesc">
        <div id="caratteristiche">
            <ul> 
                <span style="color:crimson; font-weight: bold;">Caratteristiche lettera:</span>
                <li><xsl:value-of select="tei:support/tei:material" /></li>
                <li><xsl:value-of select="tei:support/tei:stamp" /></li>
                <li><xsl:value-of select="tei:support/tei:p" /></li>
                <li><xsl:value-of select="tei:foliation" /></li>
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="//tei:handDesc">
        <p> 
            <xsl:apply-templates select="tei:note"/> 
        </p>
    </xsl:template>

    <xsl:template match="//tei:facsimile">
        <xsl:variable name="map">
            map
        </xsl:variable>
        <div class="slideshow-container">
            <div class="immagine uno">
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="tei:surface[@n='1']/tei:graphic/@url" />
                    </xsl:attribute>
                    <xsl:attribute name="usemap">
                        #<xsl:copy-of select="$map" />
                    </xsl:attribute>
                </xsl:element>           
                    
                <xsl:element name="map">
                    <xsl:attribute name="name">
                        <xsl:copy-of select="$map" />
                    </xsl:attribute>
                    <xsl:for-each select="//tei:zone">
                        <xsl:element name="area">
                            <xsl:attribute name="shape">
                                rect
                            </xsl:attribute>                                    
                            <xsl:attribute name="coords">
                                <xsl:value-of select="@ulx*0.35" />,
                                <xsl:value-of select="@uly*0.35" />,
                                <xsl:value-of select="@lrx*0.35" />,
                                <xsl:value-of select="@lry*0.35" />
                            </xsl:attribute>
                            <xsl:attribute name="onMouseOver">selectText("#<xsl:value-of select="@xml:id" />")
                            </xsl:attribute>
                            <xsl:attribute name="onMouseOut">deselectText("#<xsl:value-of select="@xml:id" />")
                            </xsl:attribute> 
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </div>
        
            <div class="immagine due">
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="tei:surface[@n='2']/tei:graphic/@url" />
                    </xsl:attribute>
                </xsl:element>
            </div>
        
            <div class="immagine tre">
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="tei:surface[@n='3']/tei:graphic/@url" />
                    </xsl:attribute>
                </xsl:element>
            </div>
        
            <div class="immagine quattro">
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="tei:surface[@n='4']/tei:graphic/@url" />
                    </xsl:attribute>
                </xsl:element>
            </div>
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
            <div style="text-align:center">
                <span class="dot" onclick="currentSlide(1)"></span> 
                <span class="dot" onclick="currentSlide(2)"></span> 
                <span class="dot" onclick="currentSlide(3)"></span> 
                <span class="dot" onclick="currentSlide(4)"></span> 
            </div>
        </div>
    </xsl:template>

    <xsl:template match="//tei:div[@type='opener']">
        <br />
        <span class="portionText">
            <xsl:attribute name="name"> 
                <xsl:value-of select="tei:dateline/tei:s/tei:lb/@facs" /> 
            </xsl:attribute>
            <xsl:value-of select="tei:dateline/tei:s/tei:date" />
            <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:addrLine/tei:placeName" />
        </span>
        <br />
        <span class="portionText">
            <xsl:attribute name="name"> 
                <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:lb[@n='2']/@facs" />                
            </xsl:attribute>
            <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:addrLine/tei:hi/tei:placeName" />
            <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:addrLine/tei:hi/tei:hi/tei:placeName" />
            <xsl:element name="img">
                <xsl:attribute name="usemap">
                    #mappa
                </xsl:attribute>
            </xsl:element>
        </span>
        <br />
        <span>
            <xsl:attribute name="name"> 
                <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:lb[@n='3']/@facs" /> 
            </xsl:attribute>
            <xsl:value-of select="tei:dateline/tei:s/tei:address/tei:addrLine[@n='2']" />
        </span>
        <br />
    </xsl:template>

    <xsl:template match="//tei:div[@type='letter-body']">   
            <p>
                <span>
                    <xsl:attribute name="name"> 
                        <xsl:value-of select="tei:salute/tei:s/tei:lb/@facs" />                
                    </xsl:attribute>
                    <xsl:value-of select="tei:salute/tei:s/tei:hi" />
                </span>
                <br />
                <xsl:for-each select="tei:ab/tei:s">
                    <span>
                        <xsl:attribute name="name">#LL1.30_line_1fr_0<xsl:value-of select="position()*4 -position()" />
                        </xsl:attribute>
                    <xsl:value-of select="child::text()[1]" />
                    </span>
                    <span class="portionText">
                        <xsl:attribute name="name">#LL1.30_line_1fr_0<xsl:value-of select="position()*4 -position()+1" />
                        </xsl:attribute>
                    <xsl:value-of select="child::text()[2]" />
                    </span>
                    <span class="portionText">
                        <xsl:attribute name="name">#LL1.30_line_1fr_0<xsl:value-of select="position()*4 -position()+2" />
                        </xsl:attribute>
                    <xsl:value-of select="child::text()[3]" />
                    </span>
                    <span>
                        <xsl:attribute name="name">#LL1.30_line_1fr_0<xsl:value-of select="position()*4 -position()+3" />
                        </xsl:attribute>
                    <xsl:value-of select="child::text()[4]" />
                    </span>
                </xsl:for-each>
            </p>
    </xsl:template>

    <xsl:template match="//tei:listPerson">
        <div id="listaPersone">
            <div id="Bellini">
                <img src="VB.jpg" id="vbellini"></img>
                <ul>
                    Nome:<br /><li class="li"><xsl:apply-templates select="tei:person[@xml:id='VB']/tei:persName/tei:forename" /></li>
                    Cognome: <br /><li class="li"><xsl:value-of select="tei:person[@xml:id='VB']/tei:persName/tei:surname" /> </li>
                    Alias: <br /><li class="li"><xsl:value-of select="tei:person[@xml:id='VB']/tei:persName/tei:addName" /></li>
                    Onorificenze: <br /><li class="li"><xsl:value-of select="tei:person[@xml:id='VB']/tei:persName/tei:roleName" /></li>
                    Data e luogo di nascita: <br />
                        <li class="li">
                            <xsl:value-of select="tei:person[@xml:id='VB']/tei:birth/tei:date"/> <br />
                            <xsl:value-of select="tei:person[@xml:id='VB']/tei:birth/tei:placeName/tei:settlement[@type='municipality']" />
                        </li>
                    Data e luogo di morte: <br />
                        <li class="li">
                            <xsl:value-of select="tei:person[@xml:id='VB']/tei:death/tei:date" /> <br />
                            <xsl:value-of select="tei:person[@xml:id='VB']/tei:death/tei:settlement[@type='municipality']" /> 
                            <xsl:value-of select="tei:person[@xml:id='VB']/tei:death/tei:placeName/tei:settlement[@type='department']" /> 
                        </li>
                    Links: <br />
                        <li class="li">
                            <xsl:apply-templates select="tei:person[@xml:id='VB']/tei:persName/tei:ref/@target" />
                        </li>
                </ul>
            </div>

            <div id="Florimo">
                <img src="FF.jpg" id="fflorimo"></img>
                <ul>
                    Nome:<br /> <li class="li"><xsl:value-of select="tei:person[@xml:id='FF']/tei:persName/tei:forename" /></li>
                    Cognome: <br /><li class="li"><xsl:value-of select="tei:person[@xml:id='FF']/tei:persName/tei:surname" /></li>
                    Data e luogo di nascita: <br />    
                        <li class="li">
                            <xsl:value-of select="tei:person[@xml:id='FF']/tei:birth/tei:date" /> <br />
                            <xsl:value-of select="tei:person[@xml:id='FF']/tei:birth/tei:placeName/tei:settlement[@type='municipality']" /> <br />
                            <xsl:value-of select="tei:person[@xml:id='FF']/tei:birth/tei:placeName/tei:settlement[@type='provincia']/@key" /> 
                        </li>
                    Data e luogo di morte: <br />    
                        <li class="li">
                            <xsl:value-of select="tei:person[@xml:id='FF']/tei:death/tei:date" /> <br />
                            <xsl:value-of select="tei:person[@xml:id='FF']/tei:death/tei:placeName/tei:settlement[@type='municipality']" />
                        </li>
                    Links:<br /><li class="li"><xsl:apply-templates select="tei:person[@xml:id='FF']/tei:persName/tei:ref/@target" /></li>
                </ul>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="//tei:div[@type='bibliography']">
        <footer>
            <span class="bibliografia">
                <h3><xsl:value-of select="tei:listBibl/tei:head" /></h3>
                <xsl:apply-templates select="//tei:bibl[@xml:id='LL1_30_Amore']" /> <br />
                <xsl:apply-templates select="//tei:bibl[@xml:id='LL1_30_Cambi']" /> <br />
                <xsl:apply-templates select="//tei:bibl[@xml:id='LL1_30_Neri']" />  <br />
                <xsl:apply-templates select="//tei:bibl[@xml:id='LL1_30_Seminara']" /> <br />
            </span>
        </footer>
    </xsl:template>

    <xsl:template match="//tei:editionStmt">
        <footer>
            <span id="finePaginaDestra">
                <xsl:value-of select="tei:edition" /> <br />
                <xsl:value-of select="tei:respStmt/tei:resp" /> <br />
                <xsl:value-of select="tei:respStmt/tei:name" /> <br />
            </span>
        </footer>
    </xsl:template>

    <xsl:template match="//tei:publicationStmt">
        <footer>             
            <span id="finePaginaSinistra">
                <img src="unipi.png" id="logo"></img>
                <br />
                <xsl:value-of select="tei:publisher" />                
            </span>
        </footer>
    </xsl:template>    
</xsl:stylesheet>     