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

import boarddto.CommentsDTO;

public class CommentsDAO {
	 private static CommentsDAO instance = null;
	   public synchronized static CommentsDAO getInstance() {
	      if(instance == null) {
	         instance = new CommentsDAO();
	      }
	      return instance;
	   }

	   private CommentsDAO() {}

	   private Connection getConnection() throws Exception{
	      Context ctx = new InitialContext();
	      DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
	      return ds.getConnection();
	   }

	   public int insert(CommentsDTO dto) throws Exception {
	      String sql = "insert into comments values(cmt_seq.nextval,?,?,sysdate,?)";
	      try(
	            Connection con = this.getConnection();
	            PreparedStatement pstat = con.prepareStatement(sql);
	            ){

	         pstat.setString(1,dto.getId());
	         pstat.setString(2, dto.getCmt_content());
	         pstat.setInt(3, dto.getBoard_seq());

	         int result = pstat.executeUpdate();
	         return result;   

	      }
	   }

	   public List<CommentsDTO> getCommentsList(int board_seq) throws Exception{
	      String sql = "select * from comments where board_seq =?";
	      try(
	            Connection con = this.getConnection();
	            PreparedStatement pstat = con.prepareStatement(sql);){
	         pstat.setInt(1,board_seq);

	         try(ResultSet rs = pstat.executeQuery();){
	            List<CommentsDTO> list = new ArrayList<>();

	            while(rs.next()) {

	               int seq = rs.getInt("cmt_seq");
	               String id = rs.getString("id");
	               String cmt_content = rs.getString("cmt_content");
	               Date cmt_date = rs.getDate("cmt_date");

	               CommentsDTO dto = new CommentsDTO(seq,id,cmt_content,cmt_date,board_seq);
	               list.add(dto);
	            }
	            return list;
	         }
	      }
	   }
	   
	   public int delete(int cmt_seq) throws Exception{
	      String sql = "delete from comments where cmt_seq=?";
	      
	      try(
	            Connection con = this.getConnection();
	            PreparedStatement pstat = con.prepareStatement(sql);){
	         pstat.setInt(1, cmt_seq);
	         
	         int result = pstat.executeUpdate();
	         con.commit();
	         return result;
	      }   
	   }

}
