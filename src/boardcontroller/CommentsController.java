package boardcontroller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

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
      Gson g = new Gson();
      
      try {
         if(cmd.contentEquals("/write.cmt")) {
//            MemberDTO str = ((MemberDTO)request.getSession().getAttribute("login"));
            String id = "test";
            String cmt_content = request.getParameter("cmt_content");
            cmt_content = dao.XSSFilter(cmt_content);
            int board_seq = Integer.parseInt(request.getParameter("board_seq"));
            
            int cmt_seq = cdao.getcmt_seq();
            cdao.insert(cmt_seq, id, cmt_content, board_seq);
            CommentsDTO cdto = cdao.getComments(cmt_seq);
            
            String result = g.toJson(cdto);
            response.getWriter().append(result);      
//            request.setAttribute("cmt",board_seq);
//            response.sendRedirect("detail.bor?board_seq="+board_seq);
            
         }else if(cmd.contentEquals("/delete.cmt")) {
            
            System.out.println("delete");
            
            int board_seq = Integer.parseInt(request.getParameter("board_seq"));
            System.out.println(board_seq);
            int cmt_seq = Integer.parseInt(request.getParameter("cmt_seq"));
            System.out.println(cmt_seq);
            cdao.delete(cmt_seq);
            
            response.sendRedirect("/detail.bor?board_seq="+board_seq);
            
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
