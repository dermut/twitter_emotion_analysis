package dev.mvc.member_word;

public class Word_MemberWordVO {
  private int wordno; // 검색어 번호
  private int mwno; // 회원 검색어 번호
  private int memberno; // 회원 번호
  private String word; // 검색어
  
  public int getWordno() {
    return wordno;
  }
  public void setWordno(int wordno) {
    this.wordno = wordno;
  }
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
  public String getWord() {
    return word;
  }
  public void setWord(String word) {
    this.word = word;
  }
  
  
}
