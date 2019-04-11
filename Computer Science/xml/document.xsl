<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
			    <style type="text/css">
			    	table { border: 1px solid; border-collapse: collapse; }
			    	td { empty-cells: show; height: 35px; width: 100px; }
			    </style>
			</head>
			<body>
				<p align="center" font="Calibri"><b>График работы</b></p>
				<table border="1">
					<xsl:for-each select="Schedule/worker">
						<tr>
							<td><xsl:value-of select="position()"/></td>
							<td colspan="5"><b>
						        <xsl:value-of select="./name/surname"/>
						        <xsl:value-of select="./name/initials"/>
						    </b></td>
						</tr>
						<tr>
							<td colspan="6" style="padding-left: 104;"><xsl:value-of select="./job"/></td>
						</tr>
						<tr>
							<td><b><xsl:value-of select="./work_hours/mon"/></b></td>
							<td><b><xsl:value-of select="./work_hours/tue"/></b></td>
							<td><b><xsl:value-of select="./work_hours/wed"/></b></td>
							<td><b><xsl:value-of select="./work_hours/thu"/></b></td>
							<td><b><xsl:value-of select="./work_hours/fri"/></b></td>
							<td><b><xsl:value-of select="./work_hours/sat"/></b></td>
						</tr>
						<tr>
							<td><b><xsl:value-of select="./work_hours/time"/></b></td>
							<td><b><xsl:value-of select="./work_hours/time"/></b></td>
							<td><b><xsl:value-of select="./work_hours/time"/></b></td>
							<td><b><xsl:value-of select="./work_hours/time"/></b></td>
							<td><b><xsl:value-of select="./work_hours/time"/></b></td>
							<td><b><xsl:value-of select="./work_hours/time_sat"/></b></td>
						</tr>
						<tr>
							<td colspan="6" style="padding-left: 104;"><xsl:value-of select="./notes"/></td>
						</tr>
					    <tr><td colspan="6"></td></tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
