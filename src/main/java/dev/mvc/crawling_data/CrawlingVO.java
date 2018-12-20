package dev.mvc.crawling_data;

public class CrawlingVO {
  private int crno;
  private String content;
  private String rdate;
  private int wordno;
  
  
  public CrawlingVO() {
    super();
  }
  public CrawlingVO(int crno, String content, String rdate, int wordno) {
    super();
    this.crno = crno;
    this.content = content;
    this.rdate = rdate;
    this.wordno = wordno;
  }
  public int getCrno() {
    return crno;
  }
  public void setCrno(int crno) {
    this.crno = crno;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getWordno() {
    return wordno;
  }
  public void setWordno(int wordno) {
    this.wordno = wordno;
  }
}
