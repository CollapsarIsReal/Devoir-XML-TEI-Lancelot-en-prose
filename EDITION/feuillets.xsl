<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">


    <xsl:template match="TEI | body">
        <xsl:copy>
            <div>
                <xsl:call-template name="feuillet"/>
            </div>
        </xsl:copy>
    </xsl:template>

    <!--<xsl:variable name="feuillet1">
        <xsl:value-of select="replace(//pb[1]/[@xml:id], 'f', '')"/>
    </xsl:variable>
    <xsl:variable name="feuillet2">
        <xsl:value-of select="replace(//pb[2]/[@xml:id], 'f', '')"/>
    </xsl:variable>-->

    <xsl:template match="pb" name="feuillet">
        <xsl:choose>
            <xsl:when test="self::pb[1]"> Feuillet <xsl:value-of
                    select="replace(//pb[1]/[@xml:id], 'f', '')"/>
            </xsl:when>
            <xsl:when test="self::pb[2]">
                <xsl:value-of select="replace(//pb[2]/[@xml:id], 'f', '')"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


    <!--elect="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson])"-->
    <xsl:template match="teiHeader | facsimile | ab"/>

</xsl:stylesheet>
