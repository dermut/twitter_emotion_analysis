package dev.mvc.board;

/*
  boardno INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  content VARCHAR(1000) NOT NULL,
  size INT DEFAULT 0,
  views INT DEFAULT 0 NOT NULL,
  photo VARCHAR(100),
  thumb VARCHAR(100),
  rdate DATETIME NOT NULL,
  categrpno INT NOT NULL,
  memberno INT NOT NULL,
  PRIMARY KEY(boardno),
  FOREIGN KEY(categrpno) REFERENCES categrp(categrpno),
  FOREIGN KEY(memberno) REFERENCES member(memberno)
 */

public class BoardVO {
  private int boardno;
  private String name;
  private String rdate;
  private int categrpno;
  private int memberno;
  
  
  public BoardVO() {
    super();
  }


  public BoardVO(int boardno, String name, String rdate, int categrpno, int memberno) {
    super();
    this.boardno = boardno;
    this.name = name;
    this.rdate = rdate;
    this.categrpno = categrpno;
    this.memberno = memberno;
  }


  public int getBoardno() {
    return boardno;
  }


  public void setBoardno(int boardno) {
    this.boardno = boardno;
  }


  public String getName() {
    return name;
  }


  public void setName(String name) {
    this.name = name;
  }


  public String getRdate() {
    return rdate;
  }


  public void setRdate(String rdate) {
    this.rdate = rdate;
  }


  public int getCategrpno() {
    return categrpno;
  }


  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }


  public int getMemberno() {
    return memberno;
  }


  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  
}