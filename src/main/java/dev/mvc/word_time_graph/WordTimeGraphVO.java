package dev.mvc.word_time_graph;

public class WordTimeGraphVO {

  private int word_time_no;
  private int wordno;
  private String rdate;
  private int freq;
  
  
  public WordTimeGraphVO() {
    super();
  }
  public WordTimeGraphVO(int word_time_no, int wordno, String rdate, int freq) {
    super();
    this.word_time_no = word_time_no;
    this.wordno = wordno;
    this.rdate = rdate;
    this.freq = freq;
  }
  public int getWord_time_no() {
    return word_time_no;
  }
  public void setWord_time_no(int word_time_no) {
    this.word_time_no = word_time_no;
  }
  public int getWordno() {
    return wordno;
  }
  public void setWordno(int wordno) {
    this.wordno = wordno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getFreq() {
    return freq;
  }
  public void setFreq(int freq) {
    this.freq = freq;
  }
  
  
}
