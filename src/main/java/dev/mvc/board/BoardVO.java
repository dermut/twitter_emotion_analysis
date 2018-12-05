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
  private int baordno;
  private String name;
  private String content;
  private int size;
  private String views;
  private String photo;
  private String thumb;
  private String rdate;
  private int categrpno;
  private int memberno;
  
  public BoardVO() {
    super();
  }
  public BoardVO(int baordno, String name, String content, int size, String views, String photo, String thumb,
      String rdate, int categrpno, int memberno) {
    super();
    this.baordno = baordno;
    this.name = name;
    this.content = content;
    this.size = size;
    this.views = views;
    this.photo = photo;
    this.thumb = thumb;
    this.rdate = rdate;
    this.categrpno = categrpno;
    this.memberno = memberno;
  }
  public int getBaordno() {
    return baordno;
  }
  public void setBaordno(int baordno) {
    this.baordno = baordno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public int getSize() {
    return size;
  }
  public void setSize(int size) {
    this.size = size;
  }
  public String getViews() {
    return views;
  }
  public void setViews(String views) {
    this.views = views;
  }
  public String getPhoto() {
    return photo;
  }
  public void setPhoto(String photo) {
    this.photo = photo;
  }
  public String getThumb() {
    return thumb;
  }
  public void setThumb(String thumb) {
    this.thumb = thumb;
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
 
 