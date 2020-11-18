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
			<th>S�hk�posti</th>
		</tr>
	</thead>
	<tbody>
		<!-- Document readyss� appendilla lis�t��n t�h�n kohtaan table bodyyn rivej� ja sarakkeita -->
	</tbody>
</table>
<script>

$(document).ready(function(){
	haeAsiakkaat();
	//Tehd��n hakunapille funktio (kuuntelija)
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	//Jos k�ytt�j� painaa enter joka sattuu olemaan event13 suoritetaan haku
	$(document.body).on("keydown", function(event){
		if(event.which==13) {
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus(); //Vied��n kursori hakukentt��n kun sivu latautuu
});

function haeAsiakkaat(){
	//Ennen hakua taulun tbody on tyhjennett�v�
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		//asiakkaat objektista tehd��n lista, joka loopataan l�pi
		$.each(result.asiakkaat, function(i, field){
			//teh��n html stringi, johon lis�t��n rivej� sarakkeita
			var htmlStr;
			htmlStr+="<tr>"
			htmlStr+="<td>"+field.asiakas_id+"</td>"
			htmlStr+="<td>"+field.etunimi+"</td>"
			htmlStr+="<td>"+field.sukunimi+"</td>"
			htmlStr+="<td>"+field.puhelin+"</td>"
			htmlStr+="<td>"+field.sposti+"</td>"
			htmlStr+="</tr>"
			//Lis�t��n listaus eli html stringi htmlStr tbodyyn
			$("#listaus tbody").append(htmlStr);
		});
	}});
}



</script>
</body>
</html>