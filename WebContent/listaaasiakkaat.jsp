<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Hae asiakkaat</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th>Hakusana</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th>Asiakas_id</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>Sähköposti</th>
		</tr>
	</thead>
	<tbody>
		<!-- Document readyssä appendilla lisätään tähän kohtaan table bodyyn rivejä ja sarakkeita -->
	</tbody>
</table>
<script>

$(document).ready(function(){
	haeAsiakkaat();
	//Tehdään hakunapille funktio (kuuntelija)
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	//Jos käyttäjä painaa enter joka sattuu olemaan event13 suoritetaan haku
	$(document.body).on("keydown", function(event){
		if(event.which==13) {
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus(); //Viedään kursori hakukenttään kun sivu latautuu
});

function haeAsiakkaat(){
	//Ennen hakua taulun tbody on tyhjennettävä
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		//asiakkaat objektista tehdään lista, joka loopataan läpi
		$.each(result.asiakkaat, function(i, field){
			//tehään html stringi, johon lisätään rivejä sarakkeita
			var htmlStr;
			htmlStr+="<tr>"
			htmlStr+="<td>"+field.asiakas_id+"</td>"
			htmlStr+="<td>"+field.etunimi+"</td>"
			htmlStr+="<td>"+field.sukunimi+"</td>"
			htmlStr+="<td>"+field.puhelin+"</td>"
			htmlStr+="<td>"+field.sposti+"</td>"
			htmlStr+="</tr>"
			//Lisätään listaus eli html stringi htmlStr tbodyyn
			$("#listaus tbody").append(htmlStr);
		});
	}});
}



</script>
</body>
</html>