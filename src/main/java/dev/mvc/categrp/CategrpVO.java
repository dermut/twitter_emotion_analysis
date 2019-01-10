package dev.mvc.categrp;

public class CategrpVO {
  /** 카테고리 번호 */
  private int categrpno;
  /** 카테고리 그룹 분류 */
  private int classification;
  /**  카테고리 이름 */
  private String name;
  /** 등록일 */
  private String rdate;
  
  private int cnt;
  
  public CategrpVO() {
    super();
  }

  public int getCategrpno() {
    return categrpno;
  }

  public CategrpVO(int categrpno, int classification, String name, String rdate, int cnt) {
    super();
    this.categrpno = categrpno;
    this.classification = classification;
    this.name = name;
    this.rdate = rdate;
    this.cnt = cnt;
  }

  public int getClassification() {
    return classification;
  }

  public void setClassification(int classification) {
    this.classification = classification;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
  }

}