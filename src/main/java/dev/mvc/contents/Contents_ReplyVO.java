package dev.mvc.contents;

public class Contents_ReplyVO {
  // contents table
  private int contentsno;
  private String contents_name;
  
  // reply table
  private int replyno;
  private String content;
  private int memberno;
  
  
  public Contents_ReplyVO() {
    super();
  }
  public Contents_ReplyVO(int contentsno, String contents_name, int replyno, String content, int memberno) {
    super();
    this.contentsno = contentsno;
    this.contents_name = contents_name;
    this.replyno = replyno;
    this.content = content;
    this.memberno = memberno;
  }
  public int getContentsno() {
    return contentsno;
  }
  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
  }
  public String getContents_name() {
    return contents_name;
  }
  public void setContents_name(String contents_name) {
    this.contents_name = contents_name;
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
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
}
