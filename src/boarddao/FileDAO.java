package boarddao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import boarddto.FileDTO;

public class FileDAO {
	private FileDAO() {}
	private static FileDAO instance;
	public synchronized static FileDAO getInstance() {
		if(instance==null) {
			instance = new FileDAO();
		}return instance;
	}
	
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		return ds.getConnection();
	}
	
	
	
	
	public int fileWrite(FileDTO dto) throws Exception {
		String sql ="insert into files values(file_seq.nextval, ?,?,sysdate,?)";
		try(Connection con = this.getConnection(); 
			PreparedStatement pstat = con.prepareStatement(sql)){
			pstat.setString(1,dto.getOriName());
			pstat.setString(2,dto.getSysName());
			pstat.setInt(3, dto.getBoard_seq());
			
			int result =pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	
}
