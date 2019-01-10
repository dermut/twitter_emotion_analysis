package dev.mvc.categrp;

public class CategrpVO {
  /** ī�װ� ��ȣ */
  private int categrpno;
  /** ī�װ� �׷� �з� */
  private int classification;
  /**  ī�װ� �̸� */
  private String name;
  /** ����� */
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