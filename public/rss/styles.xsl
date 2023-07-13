<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:content="http://purl.org/rss/1.0/modules/content/">
    <xsl:template match="/">
        <html>
            <body>
                <h2><xsl:value-of select="rss/channel/title" /></h2>
                <p><xsl:value-of select="rss/channel/description" /></p>
                <a href="{rss/channel/link}">Website</a>
                <p>Language: <xsl:value-of select="rss/channel/language" /></p>
                <xsl:for-each select="rss/channel/item">
                    <div>
                        <h3><xsl:value-of select="title"/></h3>
                        <p><xsl:value-of select="description"/></p>
                        <a href="{link}">Read More</a>
                        <p>Date Published: <xsl:value-of select="pubDate"/></p>
                        <div>
                            <xsl:value-of select="content:encoded" disable-output-escaping="yes" />
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
