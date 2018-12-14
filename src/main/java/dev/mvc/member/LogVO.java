package dev.mvc.member;

public class LogVO {
  /*
  logno INT NOT NULL AUTO_INCREMENT,
  ip VARCHAR(20),
  rdate DATETIME NOT NULL,
  sf CHAR(1) NOT NULL,
  memberno INT NOT NULL, 
  PRIMARY KEY(logno),
  FOREIGN KEY(memberno) REFERENCES member(memberno)
  */
  /** �α��� ��ȣ*/
  private int logno;
  /** ������ �ּ�*/
  private String ip="";
  /** �����*/
  private String rdate="";
  /** ��������*/
  private String sf="";
  /** ȸ����ȣ*/
  private int memberno;
  
  
  public int getLogno() {
    return logno;
  }
  public void setLogno(int logno) {
    this.logno = logno;
  }
  public String getIp() {
    return ip;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getSf() {
    return sf;
  }
  public void setSf(String sf) {
    this.sf = sf;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  
  
  
}
