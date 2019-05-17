package dev.mvc.board;

public class Categrp_Board_MemberVO {
  // categrp table
  private int categrpno;
  private String categrp_name;
  
  // board table
  private int boardno;
  private String board_name;
  private String rdate;
  private int board_memberno;
  
  // member table 
  private String id;
  private int member_memberno;
  
  public Categrp_Board_MemberVO() {
    super();
  }
  public Categrp_Board_MemberVO(int categrpno, String categrp_name, int boardno, String board_name, String rdate,
      int board_memberno, int member_memberno, String id) {
    super();
    this.categrpno = categrpno;
    this.categrp_name = categrp_name;
    this.boardno = boardno;
    this.board_name = board_name;
    this.rdate = rdate;
    this.board_memberno = board_memberno;
    this.member_memberno = member_memberno;
    this.id = id;
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
  public int getBoard_memberno() {
    return board_memberno;
  }
  public void setBoard_memberno(int board_memberno) {
    this.board_memberno = board_memberno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public int getMember_memberno() {
    return member_memberno;
  }
  public void setMember_memberno(int member_memberno) {
    this.member_memberno = member_memberno;
  }
  
  
}
 
