import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;

public class PongServlet extends HttpServlet {

	// Map value
	public String dir;
	public String axe;
	public String aip;
	public String scoreA;
	public String scoreB;
	public String vit;
	public String speed;
	public String lancement;

	// Ball value
	public String ballx;
	public String bally;
	public String ballSpeed;

	// Player X value
	public String pxPlayerX;
	public String pyPlayerX;
	public String pheighPlayerX;
	public String pwidthPlayerX;

	// Player Y value
	public String pxPlayerY;
	public String pyPlayerY;
	public String pheighPlayerY;
	public String pwidthPlayerY;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		if (req.getAttribute("dir") == null) {
			this.getServletContext().getRequestDispatcher("/WEB-INF/classes/PongJSP.jsp").forward(req, res);
		} else {
			res.setContentType("text/xml");
			System.out.println("toto");
			PrintWriter pw=res.getWriter();
			pw.println("<dir>ntm</dir>");
			pw.close();
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		if (req.getAttribute("userX") != null) {
			if (req.getAttribute("username") != null && !req.getAttribute("username").equals("")) {
				String nameIsX = req.getAttribute("username").toString();
				req.setAttribute("isX", nameIsX);
			}
		}

		else if (req.getAttribute("userY") != null) {
			if (req.getAttribute("username") != null && !req.getAttribute("username").equals("")) {
				String nameIsX = req.getAttribute("username").toString();
				req.setAttribute("isY", nameIsX);
			}
		}

		this.getServletContext().getRequestDispatcher("/WEB-INF/classes/PongJSP.jsp").forward(req, res);
	}

}
