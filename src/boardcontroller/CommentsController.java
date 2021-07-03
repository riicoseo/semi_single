package boardcontroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import boarddao.BoardDAO;
import boarddao.CommentsDAO;
import boarddto.CommentsDTO;



@WebServlet("*.cmt")
public class CommentsController extends HttpServlet {
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   
      request.setCharacterEncoding("utf-8");

      String requestURI = request.getRequestURI();
      String ctxPath = request.getContextPath();
      String cmd = requestURI.substring(ctxPath.length());
      System.out.println("요청된 url :" + cmd);
      
      CommentsDAO cdao = CommentsDAO.getInstance();
      BoardDAO dao = BoardDAO.getInstance();
      
      try {
         if(cmd.contentEquals("/write.cmt")) {
//            MemberDTO str = ((MemberDTO)request.getSession().getAttribute("login"));
            String id = "ee";
            String cmt_content = request.getParameter("cmt_content");
            cmt_content = dao.XSSFilter(cmt_content);
            int board_seq = Integer.parseInt(request.getParameter("board_seq"));
            
            int result = cdao.insert(new CommentsDTO(0,id,cmt_content,null,board_seq));
            
            request.setAttribute("cmt",board_seq);
            response.sendRedirect("detail.bor?board_seq="+board_seq);
            
         }else if(cmd.contentEquals("/delete.cmt")) {
            
            String id ="test";
            
            
         }else if(cmd.contentEquals("/update.cmt")){
            
         }
      
      }catch(Exception e) {
         e.printStackTrace();
         
      }
   }


   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}
