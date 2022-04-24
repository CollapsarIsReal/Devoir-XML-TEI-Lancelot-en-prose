<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    
    
    <xsl:template match="TEI|text|body|ab">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="ab|persName">
        <b><xsl:call-template name="indexPers"/></b>
    </xsl:template>
    
    <!-- L'index des personnages -->
    <xsl:template name="indexPers">
        <xsl:for-each select="//listPerson/person/persName">
            <li>
                <xsl:value-of select="."/>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <xsl:variable name="nb-occurrence">
                    <xsl:value-of
                        select="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson])"
                    />
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <em><xsl:value-of select="concat('(', ancestor::person/note, ')')"/></em>
                <div><xsl:text>Nombre d'occurences :</xsl:text><xsl:value-of select="$nb-occurrence"/></div>
                PLOP<p>
                    
                    <xsl:for-each select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]">
                        <xsl:choose>
                            <xsl:when test="ancestor::ab">
                                <div>Feuillet n° <xsl:value-of select="ancestor::ab/@n[position()=last()]"/>
                                    Colonne n° <xsl:value-of select="parent::cb/@n"/></div>
                                    <xsl:choose>
                                        <xsl:when test="position()!= last()">, </xsl:when>
                                        <xsl:otherwise>.</xsl:otherwise>
                                    </xsl:choose> 
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </p>
            </li>
        </xsl:for-each>
    </xsl:template>
    

    <xsl:template match="teiHeader"/>
    
</xsl:stylesheet>