package dev.mvc.contents;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ContentsVO {
/*
  contentsno INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,            
  content VARCHAR(1000) NOT NULL,
  views INT DEFAULT 0 NOT NULL,
  replies INT NOT NULL,
  fsize VARCHAR(1000),
  photo VARCHAR(1000),
  thumb VARCHAR(1000),
  rdate DATETIME NOT NULL,
  boardno INT NOT NULL,
  memberno INT NOT NULL,
  PRIMARY KEY(contentsno),
  FOREIGN KEY(boardno) REFERENCES board(boardno),
  FOREIGN KEY(memberno) REFERENCES member(memberno) 
*/
  /** ���̵�, member */
  private String id = "";
  
  private int contentsno;
  private String name;
  private String content;
  private int views;
  private int replies;
  private String fsize;
  private String photo;
  private String thumb;
  private String rdate;
  private int boardno;
  private int memberno;
  
  /** ù��° preview �̹��� */
  private String thumbnail;
  
  /** 
    Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
    DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
    �ϳ��� ���� ���ε�
  */  
  // private MultipartFile filesMF;
  
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */    
  private List<MultipartFile> photoMF;

  /** fsize�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String fsizesLabel;


  public ContentsVO() {
    super();
  }

  public ContentsVO(int contentsno, String name, String content, int views, int replies, String fsize, String photo,
      String thumb, String rdate, int boardno, int memberno, List<MultipartFile> photoMF, String fsizesLabel) {
    super();
    this.contentsno = contentsno;
    this.name = name;
    this.content = content;
    this.views = views;
    this.replies = replies;
    this.fsize = fsize;
    this.photo = photo;
    this.thumb = thumb;
    this.rdate = rdate;
    this.boardno = boardno;
    this.memberno = memberno;
    this.photoMF = photoMF;
    this.fsizesLabel = fsizesLabel;
  }

  public int getContentsno() {
    return contentsno;
  }

  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
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

  public int getViews() {
    return views;
  }

  public void setViews(int views) {
    this.views = views;
  }

  public int getReplies() {
    return replies;
  }

  public void setReplies(int replies) {
    this.replies = replies;
  }

  public String getFsize() {
    return fsize;
  }

  public void setFsize(String fsize) {
    this.fsize = fsize;
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

  public int getBoardno() {
    return boardno;
  }

  public void setBoardno(int boardno) {
    this.boardno = boardno;
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }

  public String getFsizesLabel() {
    return fsizesLabel;
  }

  /**
   * @param fsizesLabel the fsizesLabel to set
   */
  public void setFsizesLabel(String fsizesLabel) {
    this.fsizesLabel = fsizesLabel;
  }

  public List<MultipartFile> getPhotoMF() {
    return photoMF;
  }

  public void setPhotoMF(List<MultipartFile> photoMF) {
    this.photoMF = photoMF;
  }

 
}

  



