package boarddao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
				
				list.add(new BoardDTO(board_seq,id,title,content,write_date,view_count));
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
		String sql = "insert into board values(board_seq.nextval,?,?,?,sysdate,0)";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, dto.getId());
			pstat.setString(2, dto.getTitle());
			pstat.setString(3, dto.getContent());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	
	
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
		// 페이지 네이게이터
		// int recordTotalCount = 148; // 전체 레코드의 개수 → 원래 DB에서 뽑아와야 하지만, 현재는 그냥 임시로 숫자
		// 기입!
		
		int recordTotalCount ;
		
		if(searchWord==null) {
			recordTotalCount=this.getRecordCount();
		}else {
			recordTotalCount=this.getRecordCount(category,searchWord);
		}
		
		int recordCountPerPage = 10; // 한 페이지 당 보여줄 게시글의 개수
		int naviCountPerPage = 10; // 내 위치 페이지를 기준으로 시작부터 끝까지의 페이지가 총 몇개인지

		int pageTotalCount = 0;
		// 전체 레코드를 페이지당 보여줄 게시글 수 로 나눠서, 나머지가 0보다 크다면 1페이지를 더 추가해줘라!
		if (recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = (recordTotalCount / recordCountPerPage) + 1;
		} else {
			// 전체 레코드를 페이지당 보여줄 게시글 수 로 나눠서, 나머지가 0이면
			// 페이지의 게시글 수와 레코드 개수가 딱 맞아 떨어지니까, 총 만들어야 할 전체 페이지 개수도 딱 맞아 떨어진다!
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		// 현재 내가 위치하는 페이지 번호 → 내가 현재 4페이지에 있다고 가정해보자!
		// int currentPage = 13;
		// getPageNavi 메서드가 매개변수로 currentPage를 받아오니까 임의 숫자로 지정했던 currentPage는 삭제

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
		String sql = "select * from " + "(select " + "row_number() over(order by board_seq desc) rnum," + "board_seq,"+"id," + "title,"
				+ "content," + "write_date," + "view_count " + "from board) " + "where " + "rnum between ? and ?";
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
					list.add(new BoardDTO(board_seq,id,title,content,write_date,view_count));
				}
				return list;
			}
		}
	}
	// 검색 후, 페이지 리스트를 가져오는 메서드를 오버로딩해서 한번 더 만들기!
		public List<BoardDTO> getPageList(int startNum, int endNum, String category, String keyword) throws Exception {
			String sql = "select * from " + "(select " + "row_number() over(order by seq desc) rnum," + "board_seq,"+"id," + "title,"
					+ "content," + "write_date," + "view_count " + "from board where "+category+" like ?) " + "where " + "rnum between ? and ?";
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
						list.add(new BoardDTO(board_seq, id,title,content,write_date,view_count));
					}
					return list;
				}
			}
		}
	
}
