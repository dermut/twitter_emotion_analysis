package dev.mvc.board;

public class Categrp_BoardVO {
  // categrp table
  private int categrpno;
  private String categrp_name;
  
  // board table
  private int boardno;
  private String board_name;
  private String rdate;
  private int memberno;
  
  
  public Categrp_BoardVO() {
    super();
  }
  public Categrp_BoardVO(int categrpno, String categrp_name, int boardno, String board_name, String rdate,
      int memberno) {
    super();
    this.categrpno = categrpno;
    this.categrp_name = categrp_name;
    this.boardno = boardno;
    this.board_name = board_name;
    this.rdate = rdate;
    this.memberno = memberno;
  }
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }
  public String getCategrp_name() {
    return categrp_name;
  }
  public void setCategrp_name(String categrp_name) {
    this.categrp_name = categrp_name;
  }
  public int getBoardno() {
    return boardno;
  }
  public void setBoardno(int boardno) {
    this.boardno = boardno;
  }
  public String getBoard_name() {
    return board_name;
  }
  public void setBoard_name(String board_name) {
    this.board_name = board_name;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
}
 
