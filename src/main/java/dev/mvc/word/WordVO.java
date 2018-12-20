package dev.mvc.word;

public class WordVO {
  /*
  wordno INT NOT NULL AUTO_INCREMENT,
  word VARCHAR(20) NOT NULL,
  rdate DATETIME NOT NULL,
  PRIMARY KEY(wordno)
  */
  /** 검색어 번호*/
  private int wordno;
  /** 검색어*/
  private String word="";
  /** 등록일*/
  private String rdate="";
  
  
  public int getWordno() {
    return wordno;
  }
  public void setWordno(int wordno) {
    this.wordno = wordno;
  }
  public String getWord() {
    return word;
  }
  public void setWord(String word) {
    this.word = word;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  
  
}
