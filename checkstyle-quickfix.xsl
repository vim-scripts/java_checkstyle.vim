<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>

<xsl:template match="checkstyle">
    <xsl:apply-templates select="file"/>
</xsl:template>

<xsl:template match="file">
<Root-Element>
    <xsl:apply-templates select="error"/>
</Root-Element>
</xsl:template>

<!--
    This will output errors, 1 per line, in the form:

        [checkstyle-errors]:filename:linenumber:column:errormessage

    This format can be parsed with the VIM setting:

        errorformat=[checkstyle-errors]:%f:%l:%c:%m
-->
<xsl:template match="error">
    <xsl:text>[checkstyle-errors]:</xsl:text>
    <xsl:value-of select="parent::file/@name"/>
    <xsl:text>:</xsl:text>
    <xsl:value-of select="@line"/>
    <xsl:text>:</xsl:text>
    <xsl:choose>
        <xsl:when test="@column != ''">
             <xsl:value-of select="@column"/>
        </xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="@message"/>
    <xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
