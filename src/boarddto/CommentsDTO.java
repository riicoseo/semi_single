package boarddto;

import java.sql.Date;

public class CommentsDTO {
	   private int cmt_seq;
	   private String id;
	   private String cmt_content;
	   private Date cmt_date;
	   private int board_seq;
	   
	   public CommentsDTO() {
	      super();
	   }
	   public CommentsDTO(int cmt_seq, String id, String cmt_content, Date cmt_date, int board_seq) {
	      super();
	      this.cmt_seq = cmt_seq;
	      this.id = id;
	      this.cmt_content = cmt_content;
	      this.cmt_date = cmt_date;
	      this.board_seq = board_seq;
	   }
	   public int getCmt_seq() {
	      return cmt_seq;
	   }
	   public void setCmt_seq(int cmt_seq) {
	      this.cmt_seq = cmt_seq;
	   }
	   public String getId() {
	      return id;
	   }
	   public void setId(String id) {
	      this.id = id;
	   }
	   public String getCmt_content() {
	      return cmt_content;
	   }
	   public void setCmt_content(String cmt_content) {
	      this.cmt_content = cmt_content;
	   }
	   public Date getCmt_date() {
	      return cmt_date;
	   }
	   public void setCmt_date(Date cmt_date) {
	      this.cmt_date = cmt_date;
	   }
	   public int getBoard_seq() {
	      return board_seq;
	   }
	   public void setBoard_seq(int board_seq) {
	      this.board_seq = board_seq;
	   }
	   
	   

	}