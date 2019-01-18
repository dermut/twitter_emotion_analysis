package dev.mvc.word_time_graph;

public class WordTimeGraphVO {
  /** �˻��� ��ȣ*/
  private int word_time_no;
  /** �˻���*/
  private int freq;
  /** �����*/
  private String rdate="";
  private int wordno;
  
  public WordTimeGraphVO() {
    super();
  }
  public WordTimeGraphVO(int word_time_no, int freq, String rdate, int wordno) {
    super();
    this.word_time_no = word_time_no;
    this.freq = freq;
    this.rdate = rdate;
    this.wordno = wordno;
  }
  public int getWord_time_no() {
    return word_time_no;
  }
  public void setWord_time_no(int word_time_no) {
    this.word_time_no = word_time_no;
  }
  public int getFreq() {
    return freq;
  }
  public void setFreq(int freq) {
    this.freq = freq;
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
