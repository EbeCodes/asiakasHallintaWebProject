package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.util.ArrayList;
import java.io.PrintWriter;
import model.Asiakas;
import model.dao.Dao;

/**
 * Servlet implementation class Asiakkaat
 */
@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.asiakas()");
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		//Kaivetaan hakusanaa PathInfosta
		String hakusana = "";
		String pathInfo = request.getPathInfo();
		if(pathInfo!=null) {
			//Tiputetaan pois ensimm‰inen merkki hausta, joka on siis kauttaviiva
			hakusana = pathInfo.substring(1, pathInfo.length());
		}
		//Her‰tet‰‰n Dao ja pyydet‰‰n sielt‰ autot ArrayList
		Dao dao = new Dao();
		//Pyydet‰‰n listaamaan kaikki autot ja v‰litet‰‰n hakusana parametri
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);
		System.out.println(asiakkaat);
		//Muutetaan Arraylist JSON:iksi.
		//K‰ytet‰‰n JSON objektia ja laitetaan sinne uusi elementti nimelt‰‰n asiakkaat.
		//Pit‰‰ sis‰ll‰‰n autot ArrayListin
		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		//Kirjoitetaan JSON servletin html rajapintaan
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		//Komento tulostaa selaimeen printwriterin avulla
		out.println(strJSON);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		//Muutetaan kutsun mukana tuleva json-string json-objektiksi
		JSONObject jsonObj = new JsonStrToObj().convert(request);	
		//Luodaan uusi asiakas olio johon tiedot tulevat json objektista
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.lisaaAsiakas(asiakas)){ //metodi palauttaa true/false
			//Asiakkaan lis‰‰minen onnistui {"response":1}
			out.println("{\"response\":1}");
		}else{
			//Asiakakan lis‰‰minen ep‰onnistui {"response":0}
			out.println("{\"response\":0}"); 
		}
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, /<asiakas_id>		
		String poistettavaAsiakas_id = pathInfo.substring(1, pathInfo.length());	
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		//Kutsutaan postamista ja v‰litet‰‰n asiakas_id
		if(dao.poistaAsiakas(poistettavaAsiakas_id)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Asiakkaan poistaminen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Asiakkaan poistaminen ep‰onnistui {"response":0}
		}	
	}
}
