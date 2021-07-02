package boardcontroller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import boardconfig.BoardConfig;
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
		if(cmd.contentEquals("/list.bor")) {
		
			String category = request.getParameter("category");
			String searchWord = request.getParameter("searchWord");
			
			int cpage =Integer.parseInt(request.getParameter("cpage"));
			
			int endNum =cpage*BoardConfig.RECORD_COUNT_PER_PAGE;
			int startNum =endNum -(BoardConfig.RECORD_COUNT_PER_PAGE-1);
			
			
			List<BoardDTO> list ;
			if(searchWord==null||searchWord.contentEquals("")) {
				list = dao.getPageList(startNum,endNum);
			}else {
				list = dao.getPageList(startNum,endNum,category,searchWord);
			}
					
			List<String> pageNavi = dao.getPageNavi(cpage,category,searchWord);
			
			if(searchWord!=null&&!searchWord.contentEquals("")) {
				List<BoardDTO> searchlist= dao.search(category, searchWord);
			}
			request.setAttribute("searchList", list);
			request.setAttribute("list", list);
			request.setAttribute("navi", pageNavi);
			request.setAttribute("category", category);
			request.setAttribute("searchWord", searchWord);
			request.getRequestDispatcher("/board/boardMainPage.jsp").forward(request, response);
			
		
		
		}else if(cmd.contentEquals("/write.bor")) {
			response.sendRedirect("board/boardWritePage.jsp");
		
		}else if(cmd.contentEquals("/detail.bor")) {
			int board_seq = Integer.parseInt(request.getParameter("board_seq"));
			BoardDTO dto = dao.detail(board_seq);
			
			String login = "ee";
			request.getSession().setAttribute("login", login);
			request.setAttribute("list", dto);
			request.getRequestDispatcher("board/boardDetailPage.jsp").forward(request, response);
			
		}else if(cmd.contentEquals("/save.bor")) {
			// MemberDTO dto = request.getSession().getAttribute("login");
			//String id =dto.getId();
			String id="practice1";
			
			String filePath = request.getServletContext().getRealPath("files");
			
			
			
			
			
			
			
			
			
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			title = dao.XSSFilter(title);
			content = dao.XSSFilter(content);
			
			int result = dao.insert(new BoardDTO(0,id,title,content,null,0));
			
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
