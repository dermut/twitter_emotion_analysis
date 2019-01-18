package dev.mvc.freshtomato;

public class TomatoVO {
  private int ftno;
  private int ftrate;
  private String rdate;
  private int wordno;
  
  
  public TomatoVO() {
    super();
  }
  public TomatoVO(int ftno, int ftrate, String rdate, int wordno) {
    super();
    this.ftno = ftno;
    this.ftrate = ftrate;
    this.rdate = rdate;
    this.wordno = wordno;
  }
  public int getFtno() {
    return ftno;
  }
  public void setFtno(int ftno) {
    this.ftno = ftno;
  }
  public int getFtrate() {
    return ftrate;
  }
  public void setFtrate(int ftrate) {
    this.ftrate = ftrate;
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
