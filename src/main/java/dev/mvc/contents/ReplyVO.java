package dev.mvc.contents;

public class ReplyVO {
  private int replyno;
  private String content;
  private int contentsno;
  private int memberno;
  private String rdate;
  
  
  public ReplyVO() {
    super();
  }
  public ReplyVO(int replyno, String content, int contentsno, int memberno, String rdate) {
    super();
    this.replyno = replyno;
    this.content = content;
    this.contentsno = contentsno;
    this.memberno = memberno;
    this.rdate = rdate;
  }
  public int getReplyno() {
    return replyno;
  }
  public void setReplyno(int replyno) {
    this.replyno = replyno;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public int getContentsno() {
    return contentsno;
  }
  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
}
