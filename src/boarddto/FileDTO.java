package boarddto;

import java.sql.Date;

public class FileDTO {
	private int file_seq;
	private String oriName;
	private String sysName;
	private Date file_date;
	private int board_seq;
	
	
	public FileDTO() {
		super();
	}
	
	
	public FileDTO(int file_seq, String oriName, String sysName, Date file_date, int board_seq) {
		super();
		this.file_seq = file_seq;
		this.oriName = oriName;
		this.sysName = sysName;
		this.file_date = file_date;
		this.board_seq = board_seq;
	}


	public int getFile_seq() {
		return file_seq;
	}


	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}


	public String getOriName() {
		return oriName;
	}


	public void setOriName(String oriName) {
		this.oriName = oriName;
	}


	public String getSysName() {
		return sysName;
	}


	public void setSysName(String sysName) {
		this.sysName = sysName;
	}


	public Date getFile_date() {
		return file_date;
	}


	public void setFile_date(Date file_date) {
		this.file_date = file_date;
	}


	public int getBoard_seq() {
		return board_seq;
	}


	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	
	
	
	
	
	
	
}
