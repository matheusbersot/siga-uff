<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	buffer="64kb"%>
<%@ taglib tagdir="/WEB-INF/tags/mod" prefix="mod"%>
<%@ taglib uri="/WEB-INF/tld/func.tld" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table width="100%" align="left" border="0" cellpadding="0"
	cellspacing="0" bgcolor="#FFFFFF">
	<tr bgcolor="#FFFFFF">
		<td width="100%">
		<table width="100%" border="0" cellpadding="2">
			<tr>
				<td width="100%" align="center" valign="bottom"><img
					src="contextpath/imagens/brasaoemarf.jpg" /></td>
			</tr>
			<tr>
				<td width="100%" align="center">
				<p style="font-family: AvantGarde Bk BT, Arial; font-size: 11pt; font-weight: bold;"></p>
				</td>
			</tr>
			<tr>
				<td width="100%" align="center">
				<p style="font-family: Arial; font-size: 10pt; font-weight: bold;"></p>
				</td>
			</tr>
			<tr>
				<td width="100%" align="center">
				<p style="font-family: Arial; font-size: 10pt; font-weight: bold;"></p>
				</td>
			</tr>
			<tr>
			<tr>
				<td width="100%" align="center">
				<p style="font-family: Arial; font-size: 10pt; font-weight: bold;"><c:choose>
					<c:when test="${empty mov}"></c:when>
					<c:otherwise></c:otherwise>
				</c:choose></p>
				</td>
			</tr>
			</tr>
			
		</table>
		</td>
	</tr>
</table>
