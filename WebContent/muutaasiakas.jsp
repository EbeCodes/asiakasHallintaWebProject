<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakashallinta - Muuta</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="6" class="menuitem"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>ID</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="asiakas_id" id="asiakas_id" style="color: gray; background-color: rgb(220,220,220);" readonly></td>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Muuta"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo" class="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	//Kuunnellaan paluulinkin klikkausta ja ohjataan listaukseen
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	//Haetaan muutettavan asiakkaan tiedot lomakkeen kenttiin.
	//Kutsutaan backin GET-metodia ja välitetään kutsun mukana asiakas_id
	//GET /asiakkaat/haeyksi/<asiakas_id>
	var asiakas_id = requestURLParam("asiakas_id"); //Tallenetaan muuttuja URL:sta. Funktio löytyy scripts/main.js 	
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#asiakas_id").val(asiakas_id);
		$("#etunimi").val(result.etunimi);		
		$("#sukunimi").val(result.sukunimi);	
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);
    }});
	
	//Validoidaan kenttiin syötetyt arvot
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 1				
			},	
			sukunimi:  {
				required: true,
				minlength: 1				
			},
			puhelin:  {
				required: true,
				minlength: 1
			},	
			sposti:  {
				required: true,
				email: true
			}	
		},
		messages: {
			etunimi: {     
				required: "<br>Puuttuu",
				minlength: "<br>Liian lyhyt"			
			},
			sukunimi: {
				required: "<br>Puuttuu",
				minlength: "<br>Liian lyhyt"
			},
			puhelin: {
				required: "<br>Puuttuu",
				minlength: "<br>Liian lyhyt"
			},
			sposti: {
				required: "<br>Puuttuu",
				email: "<br>Ei kelpaa"
			}
		},			
		submitHandler: function(form) {	
			muutaTiedot();
		}		
	}); 	
});

//funktio tietojen päivittämistä varten. Kutsutaan backin PUT-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//PUT /autot/
function muutaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
      	//Nollataan arvot
      	$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
};

</script>
</html>