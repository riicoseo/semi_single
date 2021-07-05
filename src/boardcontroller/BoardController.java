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
import boardconfig.FileConfig;
import boarddao.BoardDAO;
import boarddao.CommentsDAO;
import boarddao.FileDAO;
import boarddto.BoardDTO;
import boarddto.CommentsDTO;
import boarddto.FileDTO;

@WebServlet("*.bor")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		
		String cmd = uri.substring(ctxPath.length());
		
		System.out.println("요청온 곳은  ==> "+cmd);
		
		BoardDAO dao = BoardDAO.getInstance();
		CommentsDAO cdao = CommentsDAO.getInstance();
		FileDAO fdao= FileDAO.getInstance();
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
			
			dao.view_count(board_seq); // 조회수 올리는 코드
			BoardDTO dto = dao.detail(board_seq);  //게시글의 디테일 내용 가져오기
			List<CommentsDTO> cmtlist = cdao.getCommentsList(board_seq); // 댓글 목록을 가져오는 코드
			List<FileDTO> flist = fdao.fileList(board_seq);  //게시글의 첨부파일 리스트 가져오기
			
			String login = "ee";
			request.getSession().setAttribute("login", login);
			request.setAttribute("list", dto);    //게시글의 디테일 내용 전달하기
			request.setAttribute("cmt", cmtlist);  // 댓글 리스트 전달하기
			request.setAttribute("flist", flist);  //게시글의 첨부파일 리스트 전달하기
			request.getRequestDispatcher("board/boardDetailPage.jsp").forward(request, response);
			
		}else if(cmd.contentEquals("/save.bor")) {
			// MemberDTO dto = request.getSession().getAttribute("login");
			//String id =dto.getId();
			
			
			String filePath = request.getServletContext().getRealPath("files");
			
			File fileFolder = new File(filePath);
			
			if(!fileFolder.exists()) { fileFolder.mkdir();}
			
			MultipartRequest multi = new MultipartRequest(request,filePath, FileConfig.uploadMaxSize,"utf8",new DefaultFileRenamePolicy());
			
			
			
			
			
			// 게시판 글쓰기 저장
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			String notice = multi.getParameter("notice");
			//String notice = "N";
			title = dao.XSSFilter(title);
			content = dao.XSSFilter(content);
			
			int board_seq= dao.getSeq();
			String id="ee";
			
			int result = dao.insert(new BoardDTO(board_seq,id,title,content,null,0,notice));

			
			//파일 첨부 저장
			Set<String> fileNames = multi.getFileNameSet();
			for(String fileName :fileNames) {
				
				String oriName = multi.getOriginalFileName(fileName);
				String sysName = multi.getFilesystemName(fileName);
				
				if(oriName!=null) {
					fdao.fileWrite(new FileDTO(0,oriName,sysName,null,board_seq));
				}
			}
			
			response.sendRedirect("detail.bor?board_seq="+board_seq);
			
			
		}else if(cmd.contentEquals("/delete.bor")) {
            int board_seq = Integer.parseInt(request.getParameter("board_seq"));
            int result = dao.delete(board_seq);
            
            response.sendRedirect(ctxPath + "/list.bor?cpage=1");
         
            
            
            
            
            //=================
            
            
		}else if(cmd.contentEquals("/modifyPage.bor")) {
			int board_seq = Integer.parseInt(request.getParameter("board_seq"));
			BoardDTO dto = dao.detail(board_seq);
			List<FileDTO> flist = fdao.fileList(board_seq);
			
			request.setAttribute("dto", dto);
			request.setAttribute("flist", flist);
			request.getRequestDispatcher("board/boardModifyPage.jsp").forward(request, response);
			
		}else if(cmd.contentEquals("/modify.bor")) {
			String filePath= request.getServletContext().getRealPath("files");
			
			MultipartRequest multi = new MultipartRequest(request,filePath,FileConfig.uploadMaxSize,"utf-8",new DefaultFileRenamePolicy());
			
			// 1번. 게시글 내용 수정
			int board_seq = Integer.parseInt(multi.getParameter("board_seq"));
			String reTitle = dao.XSSFilter(multi.getParameter("title"));
			String reContent = dao.XSSFilter(multi.getParameter("content"));
			String notice = multi.getParameter("notice");
			
			dao.modify(board_seq,reTitle,reContent,notice);
			
			
			// 2번. 삭제된 첨부파일을 실제로 DB와 폴더에서 삭제하기 
			String[] delFiles = multi.getParameterValues("delFiles");
			if(delFiles!=null) {
			for(String delTargetSeq : delFiles) {
				//String oriName = multi.getOriginalFileName(delTarget);
				String sysName = fdao.getSysName(Integer.parseInt(delTargetSeq));
				
				
				File delTargetFile = new File(filePath+"/"+sysName);
				System.out.println(delTargetFile);
				boolean delResult = delTargetFile.delete();
				System.out.println(delResult);
				if(delResult) {
					fdao.delete(Integer.parseInt(delTargetSeq));
				}
			}				
			}
			
			
			// 3번. 새로 추가된 첨부파일을 실제로 DB와 폴더에 추가하기
			Set<String> newFiles = multi.getFileNameSet();
			for(String newfile :newFiles) {
				String oriName = multi.getOriginalFileName(newfile);
				String sysName = multi.getFilesystemName(newfile);
				if(oriName!=null) {
				int result = fdao.fileWrite(new FileDTO(0,oriName,sysName,null,board_seq));
				System.out.println("새로 추가된 첨부파일을 실제 DB에 저장한 결과는? "+result);
				}
			}
			
			//4번. 모든 수정, 삭제 과정 마무리 후, board_seq 가지고 detail.bor 을 통해서 boardDetailPage.jsp 로 넘어가기
			response.sendRedirect("detail.bor?board_seq="+ board_seq);
			
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
