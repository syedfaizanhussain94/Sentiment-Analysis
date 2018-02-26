<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt'%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
	<meta name="description" content="Prediction elections 2012">
	<title>Tendance 2012</title>
	<link href="./resources/styles/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="container">
		<div id="contentNoJs">
			<h1>Si vous avez des probl�mes avec l'affichage graphique, voici une version texte simplifi� des donn�es :</h1>
			<h2>Voici les r�sultas pr�visionnels pour le premier tour des presidentielles de 2012, par candidat.</h2>
			<br />
			<c:forEach var='candidat' items='${candidats}'>
				<c:out value='${candidat.candidatName}'/> :
				<fmt:formatNumber var="val" value="${(candidat.report.tendance / maxTendance) * 100}"  maxFractionDigits="1" />
				<c:out value='${val}'/> %
				<br />
			</c:forEach>
			<br />
			<h2>Informations sur les candidats :</h2>
			<h3>L�gende :</h3>
			<span class="bold">la tendance : </span>Repr�sente le r�sultat pr�visionnel des �lections de 2012, avec les donn�es du web<br />
			<span class="bold">le buzz : </span>Repr�sente de combien on parle de ce candidat<br />
			<span class="bold">les avis n�gatifs : </span>Repr�sente de combien on parle en mauvais termes de ce candidat<br />
			<span class="bold">les avis positifs : </span>Repr�sente de combien on parle en bon termes de ce candidat<br />
			<span class="bold">les d�sinteress�s : </span>Repr�sente � quel point les fran�ais ne s'interessent pas � ce candidat<br /><br />
			<h2>D�tail journalier des analyses.</h2>
			<TABLE>
			  <CAPTION>Donn�es pour les elections de 2012</CAPTION>
			  <TR>
				 <TH>Date</TH>
				 <TH>Candidat</TH>
				 <TH>Tendance</TH>
				 <TH>Buzz</TH>
				 <TH>Avis n�gatifs</TH>
				 <TH>Avis positifs</TH>
				 <TH>D�sinteress�s</TH>
			  </TR>
			 <c:forEach var='report' items='${reports}'>
		  		<jsp:useBean id="newsDate" class="java.util.Date" />
			    <jsp:setProperty name="newsDate" property="time" value="${report.timestamp}" />
				<c:forEach var='candidat' items='${candidats}'>
				    <TD><fmt:formatDate pattern="dd/MM/yyyy" value="${newsDate}" /></TD>
					 <TD><c:out value='${candidat.candidatName}'/></TD>
					 <fmt:formatNumber var="val" value="${report.candidats[candidat.candidatName].tendance}"  maxFractionDigits="1" />
					 <TD><c:out value='${val}'/>%</TD>
					 <fmt:formatNumber var="val" value="${report.candidats[candidat.candidatName].buzz}"  maxFractionDigits="1" />
					 <TD><c:out value='${val}'/>%</TD>
					 <fmt:formatNumber var="val" value="${report.candidats[candidat.candidatName].neg}"  maxFractionDigits="1" />
					 <TD><c:out value='${val}'/>%</TD>
					 <fmt:formatNumber var="val" value="${report.candidats[candidat.candidatName].pos}"  maxFractionDigits="1" />
					 <TD><c:out value='${val}'/>%</TD>
					 <fmt:formatNumber var="val" value="${report.candidats[candidat.candidatName].none}"  maxFractionDigits="1" />
					 <TD><c:out value='${val}'/>%</TD>					 
				 </TR>
				 </c:forEach>
			</c:forEach>
			</TABLE> 
			<h2>Informations sur les themes, par candidat :</h2>
			<TABLE>
			  <CAPTION>Donn�es pour les elections de 2012</CAPTION>
			  <TR>
				 <TH>Date</TH>
				 <TH>Candidat</TH>
				 <TH>S�curit�</TH>
				 <TH>Europe</TH>
				 <TH>economie</TH>
				 <TH>Ecologie</TH>
				 <TH>Immigration</TH>
				 <TH>Social</TH>
			  </TR>
			 <c:forEach var='report' items='${reports}'>
					<c:forEach var='candidat' items='${candidats}'>
			  		<TR>
			    		<jsp:setProperty name="newsDate" property="time" value="${report.timestamp}" />
			    		<TH><fmt:formatDate pattern="dd/MM/yyyy" value="${newsDate}" /></TH>
						 <TD><c:out value='${candidat.candidatName}'/></TD>
						<c:forEach var='theme' items='${themes}'>
							 <TD><c:out value='${report.candidats[candidat.candidatName].themes[theme]}'/></TD>
						 </c:forEach>
				 </TR>
				 </c:forEach>
			</c:forEach>
			</TABLE>
		</div>
	</div>
</body> 
</html>

<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-27563713-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
