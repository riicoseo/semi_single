package boardcontroller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import boarddao.BoardDAO;
import boarddto.BoardDTO;

@WebServlet("*.bor")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		
		String cmd = uri.substring(ctxPath.length());
		System.out.println("요청온 곳은  ==> "+cmd);
		BoardDAO dao = BoardDAO.getInstance();
		Gson g = new Gson();
		
		try {
		if(cmd.contentEquals("/boardlist.bor")) {
			List<BoardDTO> list = dao.selectAll();
			
			String slist = g.toJson(list);
			response.setCharacterEncoding("utf-8");
			response.getWriter().append(slist);
		
		}else if(cmd.contentEquals("/")) {
			
		}
		
		
		
		
		
		
		
		
		}catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
