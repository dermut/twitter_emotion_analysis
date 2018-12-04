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
  
  public CategrpVO() {
    super();
  }
  public CategrpVO(int categrpno, int classification, String name, String rdate) {
    super();
    this.categrpno = categrpno;
    this.classification = classification;
    this.name = name;
    this.rdate = rdate;
  }
  public int getCategrpno() {
    return categrpno;
  }
  public void setCategrpno(int categrpno) {
    this.categrpno = categrpno;
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
}