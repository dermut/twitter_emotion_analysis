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
grade CHAR(1) NOT NULL,    -- 권한   Master Normal Guest Delete
rdate DATETIME NOT NULL,
PRIMARY KEY(memberno)
  */
 
  /** 회원 번호 */
  private int memberno;
  /** 아이디 */
  private String id = "";
  /** 회원 성명 */
  private String name = "";
  /** 패스워드 */
  private String passwd = "";
  /** 전화 번호 */
  private String phone = "";
  /** 메일 주소 */
  private String email = "";
  /** 생일 */
  private String birth = "";
  /** 성별 */
  private String sex="";
  /** 등급 */
  private String grade="";
  /** 새로운 패스워드 */
/*  private String new_passwd="";*/
  /** 가입일 */
  private String rdate="";
  /** id 저장 여부 */
  private String id_save = "";
  /** passwd 저장 여부 */
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