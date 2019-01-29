package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import dev.mvc.contents.Contents;

public interface MemberProcInter {
 
  /**
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkId(String id);
  
  /**
  회원 등록
  @param memberVO
  @return 등록된 회원수 1 or 0
  */
  public int create(MemberVO memberVO);
  
  /**
   * 회원 전체 목록
   * @return
   */
  public List<MemberVO> list();
  
  /**
   * 로그인된 회원 계정인지 검사합니다.
   * @param request
   * @return true: 관리자
   */
  public boolean isMember(HttpSession session);
  
  /**
   * 로그인된 회원 계정인지 검사합니다.
   * @param request
   * @return true: 관리자
   */
  public boolean isMaster(HttpSession session);
  
  /**
   * 조회
   * @param mno
   * @return
   */
 public MemberVO read(int memberno);
  
  /**
   * 조회
   * @param id
   * @return
   */
 public MemberVO readById(String id);
 
 /**
  * 변경
  * @param memberVO
  * @return
  */
 public int update(MemberVO memberVO);
  
 /**
  * 패스워드 변경
  * 
  * @param mno 회원 번호
  * @param passwd 변경할 패스워드 값
  * @return
  */
 public int passwd_update(int memberno, String passwd);
 
 /**
  * 레코드 1건 삭제
  * @param mno 삭제할 회원 번호
  * @return 삭제된 레코드 갯수
  */
 public int delete(int memberno);
 
 /**
  * 로그인
  * @param id
  * @param passwd
  * @return
  */
 public int login(String id, String passwd);
 
 /**
  * 로그인 내역 생성
  * @param logVO
  * @return
  */
 public int create_login_list(String ip, String sf, int memberno);
 
 /**
  * 로그인 내역 조회(호출)
  * @return
  */
 public List<LogVO> login_list();
 
 /**
  * �α��� ���� ����¡
  * @param hashmap
  * @return
  */
 public List<LogVO> login_list_paging(HashMap<String, Object> hashmap); 
 
 public int search_count(int memberno);
 
 public String paging(int memberno, int search_count, int nowPage);
 
 
}