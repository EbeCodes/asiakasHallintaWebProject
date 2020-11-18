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
		String pathInfo = request.getPathInfo();
		//Tiputetaan pois ensimm‰inen merkki hausta, joka on siis kauttaviiva
		String hakusana = pathInfo.substring(1, pathInfo.length());
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
		out.println(strJSON);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		doGet(request, response);
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
	}

}
