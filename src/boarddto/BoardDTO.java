package boarddto;

import java.sql.Date;

public class BoardDTO {
	private int board_seq;
	private String id;
	private String title;
	private String content;
	private Date write_date;
	private int view_count;

	public BoardDTO() {
		super();
	}

	public BoardDTO(int board_seq, String id, String title, String content, Date write_date, int view_count) {
		super();
		this.board_seq = board_seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.view_count = view_count;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	
	
	
	
	
	
}
