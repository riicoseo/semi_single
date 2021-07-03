package boarddao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import boardconfig.BoardConfig;
import boarddto.BoardDTO;

public class BoardDAO {
	
	private BoardDAO() {}
	private static BoardDAO instance;
	public synchronized static BoardDAO getInstance() {
		if(instance ==null) {
			instance = new BoardDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	
	
//========= 게시판 기본 메서드 ======================================================================	
	public List<BoardDTO> selectAll() throws Exception {
		String sql ="select * from board";
		List<BoardDTO> list = new ArrayList<>();
		try(Connection con = this.getConnection(); 
			PreparedStatement pstat = con.prepareStatement(sql);
			ResultSet rs = pstat.executeQuery();){
			while(rs.next()) {
				int board_seq = rs.getInt("board_seq");
				String id = rs.getNString("id");
				String title = rs.getNString("title");
				String content =rs.getNString("content");
				Date write_date = rs.getDate("write_date");
				int view_count = rs.getInt("view_count");
				String notice = rs.getNString("notice");
				list.add(new BoardDTO(board_seq,id,title,content,write_date,view_count,notice));
			}
			return list;
		}
	}
	
	
	public BoardDTO detail(int board_seq) throws Exception {
		String sql ="select * from board where board_seq=?";
		BoardDTO dto = new BoardDTO();
		try(Connection con = this.getConnection();
				PreparedStatement pstat =con.prepareStatement(sql)){
			pstat.setInt(1, board_seq);
			try(ResultSet rs =pstat.executeQuery();){
				if(rs.next()) {
					dto.setBoard_seq(rs.getInt("board_seq"));
					dto.setId(rs.getNString("id"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setWrite_date(rs.getDate("write_date"));
					dto.setView_count(rs.getInt("view_count"));
					dto.setNotice(rs.getNString("notice"));
				}
				return dto;
			}
		}	
	}
	
	public String XSSFilter(String target) {
		if(target!=null){
			target = target.replaceAll("<","&lt;");	
			target = target.replaceAll(">","&gt;");		
			target = target.replaceAll("&","&amp;");		
		}
		return target;
	}
	
	
	public int insert(BoardDTO dto) throws Exception {
		String sql = "insert into board values(?,?,?,?,sysdate,0,?)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, dto.getBoard_seq());
			pstat.setString(2, dto.getId());
			pstat.setString(3, dto.getTitle());
			pstat.setString(4, dto.getContent());
			pstat.setString(5, dto.getNotice());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<BoardDTO> search(String category, String searchWord) throws Exception {
		String sql ="select * from board where "+category +" like ?";
		List<BoardDTO> list = new ArrayList<BoardDTO>();		
		try(Connection con = this.getConnection(); 
					PreparedStatement pstat = con.prepareStatement(sql);){
					pstat.setString(1, "%"+searchWord+"%");
					try(ResultSet rs = pstat.executeQuery();){
						while(rs.next()) {
						  int board_seq = rs.getInt("board_seq");
						  String id = rs.getNString("id");
						  String title = rs.getString("title");
						  String content = rs.getString("content");
						  Date write_date = rs.getDate("write_date");
					      int view_count = rs.getInt("view_count");
					      String notice = rs.getNString("notice");
							list.add(new BoardDTO(board_seq,id, title, content,write_date, view_count,notice));
						}
					}return list;
				}
	}
	
	
	
	
	
	
	
//========= 게시판  페이징 처리 ======================================================================
	
	private int getRecordCount() throws Exception {
		String sql = "select count(*) from board";
		try (Connection con = this.getConnection();
			 PreparedStatement pstat = con.prepareStatement(sql);
			 ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);

		}
	}
	// 오버 로딩해서 다시 하나 더 만들기
		private int getRecordCount(String category, String keyword) throws Exception {
			String sql = "select count(*) from board where " + category + " like ?";
			try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
				pstat.setString(1, "%" + keyword + "%");
				try (ResultSet rs = pstat.executeQuery();) {
					rs.next();
					return rs.getInt(1);
				}
			}
		}
		
		
	public List<String> getPageNavi(int currentPage, String category, String searchWord) throws Exception {
		
		int recordTotalCount ;
		
		if(searchWord==null||searchWord.contentEquals("")) {
			recordTotalCount=this.getRecordCount();
		}else {
			recordTotalCount=this.getRecordCount(category,searchWord);
		}
		
		int recordCountPerPage = BoardConfig.RECORD_COUNT_PER_PAGE; // 한 페이지 당 보여줄 게시글의 개수
		int naviCountPerPage = BoardConfig.NAVI_COUNT_PER_PAGE; // 내 위치 페이지를 기준으로 시작부터 끝까지의 페이지가 총 몇개인지

		int pageTotalCount = 0;   
		// 전체 레코드를 페이지당 보여줄 게시글 수 로 나눠서, 나머지가 0보다 크다면 1페이지를 더 추가해줘라!
		if (recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = (recordTotalCount / recordCountPerPage) + 1;
		} else {
			// 전체 레코드를 페이지당 보여줄 게시글 수 로 나눠서, 나머지가 0이면
			// 페이지의 게시글 수와 레코드 개수가 딱 맞아 떨어지니까, 총 만들어야 할 전체 페이지 개수도 딱 맞아 떨어진다!
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		
		if (currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		} else if (currentPage < 1) {
			currentPage = 1;
		}

		// 페이지 네비게이터의 첫번째 시작 숫자를 알 수 있는 코드
		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1;
		// 페이지 네비게이터의 마지막 숫자를 알 수 있는 코드
		int endNavi = startNavi + (naviCountPerPage - 1);
		if (endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		// 페이지 < 1 2 3 4 5> 처럼 이전, 이후 표시 만드는 코드
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		List<String> pageNavi = new ArrayList<>();

		if (needPrev) {
			pageNavi.add("<");
		}

		for (int i = startNavi; i <= endNavi; i++) {
			pageNavi.add(String.valueOf(i)); // 숫자 i를 string으로 변환해서 add 해주기!
		}
		if (needNext) {
			pageNavi.add(">");
		}

		return pageNavi;

	}
	
	public List<BoardDTO> getPageList(int startNum, int endNum) throws Exception {
		String sql = "select * from " + "(select " + "row_number() over(order by notice desc, board_seq desc) rnum," + "board_seq,"+"id," + "title,"
				+ "content," + "write_date," + "view_count, notice " + "from board) " + "where " + "rnum between ? and ?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setInt(1, startNum);
			pstat.setInt(2, endNum);

			try (ResultSet rs = pstat.executeQuery();) {
				List<BoardDTO> list = new ArrayList<BoardDTO>();

				while (rs.next()) {
					int board_seq = rs.getInt("board_seq");
					String id = rs.getNString("id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					Date write_date = rs.getDate("write_date");
					int view_count = rs.getInt("view_count");
					String notice = rs.getNString("notice");
					list.add(new BoardDTO(board_seq,id,title,content,write_date,view_count,notice));
				}
				return list;
			}
		}
	}
	// 검색 후, 페이지 리스트를 가져오는 메서드를 오버로딩해서 한번 더 만들기!
		public List<BoardDTO> getPageList(int startNum, int endNum, String category, String keyword) throws Exception {
			String sql = "select * from " + "(select " + "row_number() over(order by notice desc, board_seq desc) rnum," + "board_seq,"+"id," + "title,"
					+ "content," + "write_date," + "view_count, notice " + "from board where "+category+" like ?) " + "where " + "rnum between ? and ?";
			try (Connection con = this.getConnection(); 
				PreparedStatement pstat = con.prepareStatement(sql);) {
				
				
				pstat.setString(1, "%" + keyword + "%");
				pstat.setInt(2, startNum);
				pstat.setInt(3, endNum);

				try (ResultSet rs = pstat.executeQuery();) {
					List<BoardDTO> list = new ArrayList<BoardDTO>();

					while (rs.next()) {
						int board_seq = rs.getInt("board_seq");
						String id = rs.getNString("id");
						String title = rs.getString("title");
						String content = rs.getString("content");
						Date write_date = rs.getDate("write_date");
						int view_count = rs.getInt("view_count");
						String notice = rs.getNString("notice");
						list.add(new BoardDTO(board_seq, id,title,content,write_date,view_count,notice));
					}
					return list;
				}
			}
		}
		
//========= 게시판  페이징 처리 끝! ======================================================================
	
		
		public int getSeq() throws Exception {
			String sql ="select board_seq.nextval from dual";
			try (Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					ResultSet rs = pstat.executeQuery();) {
				rs.next();
				return rs.getInt(1);
			}
		}
		
		// 조회수 출력 ---------------------------------------------------------------
		   public int view_count(int board_seq) throws Exception{
		      String sql="update board set view_count = view_count+1 where board_seq=?";
		      try(Connection con = this.getConnection(); 
		            PreparedStatement pstat = con.prepareStatement(sql);){
		         pstat.setInt(1,board_seq);

		         int result = pstat.executeUpdate();
		         con.commit();
		         return result;
		      }
		   }
		   // 게시글 삭제 -------------------------------------------------------------------
		   public int delete(int board_seq) throws Exception{
		      String sql = "delete from board where board_seq = ?";
		      try(
		            Connection con = this.getConnection();
		            PreparedStatement pstat = con.prepareStatement(sql);
		            ){
		         pstat.setInt(1, board_seq);
		   
		         int result = pstat.executeUpdate();
		         con.commit();
		         return result;
		      }
		   }
}
