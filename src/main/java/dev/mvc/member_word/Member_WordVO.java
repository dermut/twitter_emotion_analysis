package dev.mvc.member_word;

public class Member_WordVO {
/*
  mwno INT NOT NULL AUTO_INCREMENT,
  memberno INT NOT NULL,
  wordno INT NOT NULL,
  PRIMARY KEY(mwno),
      FOREIGN KEY(memberno) REFERENCES member(memberno),
      FOREIGN KEY(wordno) REFERENCES word(wordno)*/
  
  /** 회원검색어 번호*/
  private int mwno;
  /** 회원번호*/
  private int memberno;
  /** 검색어 번호*/
  private int wordno;
  
  
  public int getMwno() {
    return mwno;
  }
  public void setMwno(int mwno) {
    this.mwno = mwno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public int getWordno() {
    return wordno;
  }
  public void setWordno(int wordno) {
    this.wordno = wordno;
  }
  
  
}
