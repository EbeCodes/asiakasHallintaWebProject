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
<title>Asiakashallinta - Lis�ys</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="menuitem"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>S�hk�posti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lis��"></td>
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
	
	//Validoidaan kenttiin sy�tettyj� arvoja
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
			lisaaTiedot();
		}		
	}); 	
});
//Vied��n tiedot rest:iin
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) {
		//Dao:sta tuleva result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan lis��minen onnistui.");
      	//Tyhjennet��n kent�t jos lis��minen onnistui
      	$("#etunimi").val("");
      	$("#sukunimi").val("");
      	$("#puhelin").val("");
      	$("#sposti").val("");
      	
		}
  }});	
}

</script>
</html>