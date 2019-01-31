package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
 
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
  * @param map
  * @return
  */
public int passwd_update(Map<String, Object> map);
 
 /**
  * 레코드 1건 삭제
  * @param mno 삭제할 회원 번호
  * @return 삭제된 레코드 갯수
  */
 public int delete(int memberno);
 
 /**
  * 로그인
  * @param map
  * @return
  */
 public int login(Map map);
 
 /**
  * 로그인 내역 생성
  * @param logVO
  * @return
  */
 public int create_login_list(Map map);
 
 /**
  * 로그인 내역 조회(호출)
  * @return
  */
 public List<LogVO> login_list();

 public List<LogVO> login_list_paging(HashMap<String, Object> hashmap); 
 
 /**
  * memberno별 레코드 갯수
  * @param memberno
  * @return
  */
 public int search_count(int memberno);
 
 /**
  * 회원 목록 페이징 
  * @param hashmap
  * @return
  */
 public List<MemberVO> member_list_paging(HashMap<String, Object> hashmap);
 
 
 /**
  * 총 회원 수
  * @return
  */
 public int member_count();
 
 /**
  * 아이디 찾기
  * @return
  */
 public String find_id(HashMap<String, Object> hashmap);
 
 /**
  * 비밀번호 찾기
  * @param hashmap
  * @return
  */
 public int find_passwd(HashMap<String, Object> hashmap);
}