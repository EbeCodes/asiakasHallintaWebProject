<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Asiakashallinta - Listaus</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="6" class="menuitem"><span id="uusiAsiakas">Lis�� uusi asiakas</span></th>
		</tr>
		<tr>
			<th>Hakusana</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th>Asiakas_id</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>S�hk�posti</th>
			<!-- Tyhj� solu muuta- ja poista-linkille -->
			<th></th>
		</tr>
	</thead>
	<tbody>
		<!-- Document readyss� appendilla lis�t��n t�h�n kohtaan table bodyyn rivej� ja sarakkeita -->
	</tbody>
</table>
<script>

$(document).ready(function(){
	//Haetaan asiakkaat kutsumalla funktiota
	haeAsiakkaat();
	//Uuden asiakkaan klikkaaminen
	$("#uusiAsiakas").click(function(){
	document.location="lisaaasiakas.jsp";
	});
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
			//Rivin id:ksi annetaan asiakas_id joka mahdollistaa kohdentamisen riviin
			htmlStr+="<tr id='rivi_" +field.asiakas_id+"'>";
			htmlStr+="<td>"+field.asiakas_id+"</td>"
			htmlStr+="<td>"+field.etunimi+"</td>"
			htmlStr+="<td>"+field.sukunimi+"</td>"
			htmlStr+="<td>"+field.puhelin+"</td>"
			htmlStr+="<td>"+field.sposti+"</td>"
			//Luodaan muuta linkki, joka kutsuu muuta-funktiota johon v�litet��n asiakas_id
			htmlStr+="<td><span class='muuta' onclick=muuta('"+field.asiakas_id+"')>Muuta</span>&nbsp;&nbsp;"
			//Luodaan posita linkki, joka kutsuu poista-funktiota johon v�litet��n asiakas_id
			htmlStr+="<span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>"
			htmlStr+="</tr>"
			//Lis�t��n listaus eli html stringi htmlStr tbodyyn
			$("#listaus tbody").append(htmlStr);
		});
	}});
}

//Kuunnellaan poista linkin klikkausta
function poista(asiakas_id){
	//Vahvistetaan k�ytt�j�lt� poisto
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) {
			//result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto ep�onnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //V�rj�t��n poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
	        	//Listataan asiakkaat uudelleen jolloin poisto p�ivittyy
				haeAsiakkaat();        	
			}
	    }});
	}
}

//Kuunnellaan muuta linkin klikkausta
function muuta(asiakas_id){
	document.location="muutaasiakas.jsp?asiakas_id=" + asiakas_id;
}

</script>
</body>
</html>