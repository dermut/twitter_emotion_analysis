package dev.mvc.member;
 
public class MemberVO {
  /*
memberno INT NOT NULL AUTO_INCREMENT,
id VARCHAR(15) NOT NULL,
name VARCHAR(15) NOT NULL,
passwd VARCHAR(15) NOT NULL,
phone VARCHAR(15),
email VARCHAR(25) NOT NULL,
birth VARCHAR(20) NOT NULL,
sex CHAR(1) NOT NULL,
grade CHAR(1) NOT NULL,    -- ����   Master Normal Guest Delete
rdate DATETIME NOT NULL,
PRIMARY KEY(memberno)
  */
 
  /** ȸ�� ��ȣ */
  private int memberno;
  /** ���̵� */
  private String id = "";
  /** ȸ�� ���� */
  private String name = "";
  /** �н����� */
  private String passwd = "";
  /** ��ȭ ��ȣ */
  private String phone = "";
  /** ���� �ּ� */
  private String email = "";
  /** ���� */
  private String birth = "";
  /** ���� */
  private String sex="";
  /** ��� */
  private String grade="";
  /** ���ο� �н����� */
/*  private String new_passwd="";*/
  /** ������ */
  private String rdate="";
  /** id ���� ���� */
  private String id_save = "";
  /** passwd ���� ���� */
  private String passwd_save = "";
  
  
  
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getPhone() {
    return phone;
  }
  public void setPhone(String phone) {
    this.phone = phone;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public String getBirth() {
    return birth;
  }
  public void setBirth(String birth) {
    this.birth = birth;
  }
  public String getSex() {
    return sex;
  }
  public void setSex(String sex) {
    this.sex = sex;
  }
  public String getGrade() {
    return grade;
  }
  public void setGrade(String grade) {
    this.grade = grade;
  }
/*  public String getNew_passwd() {
    return new_passwd;
  }
  public void setNew_passwd(String new_passwd) {
    this.new_passwd = new_passwd;
  }*/
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getId_save() {
    return id_save;
  }
  public void setId_save(String id_save) {
    this.id_save = id_save;
  }
  public String getPasswd_save() {
    return passwd_save;
  }
  public void setPasswd_save(String passwd_save) {
    this.passwd_save = passwd_save;
  }
  
  
 
}