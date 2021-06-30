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
		String sql ="select * from board2";
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
	
	
	
	
	
	
}
