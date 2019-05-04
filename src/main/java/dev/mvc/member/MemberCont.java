package dev.mvc.member;
 
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes({"user_memberno", "user_id"})
public class MemberCont {
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  public MemberCont(){
    System.out.println("--> MemberCont created.");
  }
  
  @RequestMapping(value = "/index.do", method = RequestMethod.GET)
  public ModelAndView index() {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/index");
    
    return mav;
  }
  
  //http://localhost:9090/tea/member/create.do
  @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/member/create");
   
    return mav;
  }
 

  /**
   * 중복 ID 검사
   * http://localhost:9090/tea/member/checkId.do?id=user1
   * 결과: {"cnt":1}
   * @param id
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/checkId.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String checkId(String id) {
    JSONObject json = new JSONObject();
    int cnt = memberProc.checkId(id);
  
    json.put("cnt", cnt);
  
    return json.toString();
  }
 
  /**
   * 회원가입처리
   * @param redirectAttributes
   * @param request
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/create.do", method=RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, MemberVO memberVO){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
   
    int count = memberProc.checkId(memberVO.getId());
   
    if (count == 1) { // ID 중복시 메시지 출력
      redirectAttributes.addAttribute("sw", "id");
      redirectAttributes.addAttribute("count", count); // 1 or 0
    } else {
      count = memberProc.create(memberVO); // 등록

      redirectAttributes.addAttribute("sw", "create");
      redirectAttributes.addAttribute("count", count); // 1 or 0
    }
   
    mav.setViewName("redirect:/member/create_message.jsp");
  
    return mav;
  }
 
  @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/list"); // webapp/member/list.jsp
    
    if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {
      mav.setViewName("/member/list"); // webapp/member/list.jsp
     
      List<MemberVO> list = memberProc.list();
      mav.addObject("list", list);
    }
   
    return mav;
 } 
 
  @RequestMapping(value="/member/read.do", method=RequestMethod.GET)
  public ModelAndView read(int memberno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read"); // webapp/member/read.jsp
   
    MemberVO memberVO = memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);
   
    return mav;
  }  
 
  @RequestMapping(value="/member/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, MemberVO memberVO){
    ModelAndView mav = new ModelAndView();
   
    int count = memberProc.update(memberVO); // 수정

    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("memberno", memberVO.getMemberno()); // 회원 번호
   
    mav.setViewName("redirect:/member/update_message.jsp");
  
    return mav;
  }

  /**
   * 패스워드 변경폼
   * @return
   */
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/passwd_update"); // webapp/member/passwd_update.jsp
   
    return mav;
  }  
 
  /**
   * 패스워드를 변경합니다.
   * @param request
   * @param passwd
   * @param new_passwd
   * @return
   */
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.POST)
  public ModelAndView passwd_update(HttpServletRequest request,
                                                    HttpSession session,
                                                    String passwd,
                                                    String new_passwd){
    ModelAndView mav = new ModelAndView();
    
    String id = (String)session.getAttribute("id"); // session
    int memberno = (Integer)session.getAttribute("memberno"); // session
    
    // 로그인 관련 추가 영역
    //int count = memberProc.login(id, passwd); // 현재 패스워드 검사
    int count = 1; // 현재 패스워드 검사
    System.out.println("--> count: " + count);
    if (count == 1) { // 로그인한 회원의 패스워드 검사
      int count_update = memberProc.passwd_update(memberno, new_passwd);
      System.out.println("--> count_update: " + count_update);
      mav.setViewName("redirect:/member/passwd_update_message.jsp?count=" + count_update + "&memberno=" + memberno);
    } else {
      mav.setViewName("redirect:/member/login.do");      
    }
   
    return mav;
  } 
 
  @RequestMapping(value="/member/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int memberno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/delete"); // webapp/member/delete.jsp
    
    MemberVO memberVO = memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  }  
 
  @RequestMapping(value="/member/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request, int memberno){
    ModelAndView mav = new ModelAndView();
   
    int count = memberProc.delete(memberno);

    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("memberno", memberno); // 회원 번호
   
    mav.setViewName("redirect:/member/delete_message.jsp");
  
    return mav;
  }
 
  /**
   * 로그인 폼
   * @return
   */
  // http://localhost:9090/member/member/login.do 
  @RequestMapping(value = "/member/login.do", 
                            method = RequestMethod.GET)
  public ModelAndView login(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/login_ck_form"); // /webapp/member/login_ck_form.jsp
   
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    String ck_id = ""; // id 저장 변수
    String ck_id_save = ""; // id 저장 여부를 체크하는 변수
    String ck_passwd = ""; // passwd 저장 변수
    String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수 

    if (cookies != null) {
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 쿠키 객체 추출
        
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue(); 
        } else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();  // Y, N
        }else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();         // 1234
        }else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();  // Y, N 
        }
      }
    }
   
    mav.addObject("ck_id", ck_id);
    mav.addObject("ck_id_save", ck_id_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);
    
    return mav;
  }
 
 /**
  * 로그인 처리
  * @param request
  * @param response
  * @param session
  * @param id
  * @param id_save
  * @param passwd
  * @param passwd_save
  * @return
  */
 @RequestMapping(value="/member/login.do", method=RequestMethod.POST)
 public ModelAndView login(HttpServletRequest request, 
                                      HttpServletResponse response,
                                      HttpSession session,
                                      String id, 
                                      @RequestParam(value="id_save", defaultValue="") String id_save,
                                      String passwd,
                                      @RequestParam(value="passwd_save", defaultValue="") String passwd_save){
   // System.out.println("--> login() POST called.");
   ModelAndView mav = new ModelAndView();
   
   
   if(memberProc.readById(id) != null ){  // 로그인 시 아이디가 검색되었을 때
    
   
   if (memberProc.login(id, passwd) != 1) { // 로그인 실패시
     // 로그인내역 실패 create
     MemberVO old_memberVO = memberProc.readById(id);
     
     String ip = request.getRemoteAddr();
     String sf = "X";
     int memberno = old_memberVO.getMemberno();
     memberProc.create_login_list(ip, sf, memberno);
     
     mav.setViewName("redirect:/member/login_message.jsp");
     
   } else { // 패스워드 일치하는 경우
     MemberVO old_memberVO = memberProc.readById(id);
  
     session.setAttribute("memberno",  old_memberVO.getMemberno()); // session 내부 객체
     session.setAttribute("id", id);
     session.setAttribute("passwd", passwd);
     session.setAttribute("name", old_memberVO.getName());
     session.setAttribute("grade", old_memberVO.getGrade());  // session에 회원등급 저장(top_second에서 사용하기)

     System.out.println(id);
     // 로그인내역 성공 create
     String ip = request.getRemoteAddr(); 
     String sf = "O";
     int memberno = old_memberVO.getMemberno();
     mav.addObject("user_memberno", memberno); // Session에 memberno 저장
     mav.addObject("user_id", id);
     memberProc.create_login_list(ip, sf, memberno);
     // -------------------------------------------------------------------
     // id 관련 쿠기 저장
     // -------------------------------------------------------------------
     if (id_save.equals("Y")) { // id를 저장할 경우
       Cookie ck_id = new Cookie("ck_id", id);
       ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
       response.addCookie(ck_id);
     } else { // N, id를 저장하지 않는 경우
       Cookie ck_id = new Cookie("ck_id", "");
       ck_id.setMaxAge(0);
       response.addCookie(ck_id);
     }
     // id를 저장할지 선택하는  CheckBox 체크 여부
     Cookie ck_id_save = new Cookie("ck_id_save", id_save);
     ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
     response.addCookie(ck_id_save);
     // -------------------------------------------------------------------

     // -------------------------------------------------------------------
     // Password 관련 쿠기 저장
     // -------------------------------------------------------------------
     if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
       Cookie ck_passwd = new Cookie("ck_passwd", passwd);
       ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
       response.addCookie(ck_passwd);
     } else { // N, 패스워드를 저장하지 않을 경우
       Cookie ck_passwd = new Cookie("ck_passwd", "");
       ck_passwd.setMaxAge(0);
       response.addCookie(ck_passwd);
     }
     // passwd를 저장할지 선택하는  CheckBox 체크 여부
     Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
     ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
     response.addCookie(ck_passwd_save);
     // -------------------------------------------------------------------
     
     mav.setViewName("redirect:/index.do"); // 확장자 명시 
     
     } // else 문 끝
   } else{
     mav.setViewName("redirect:/member/login_message.jsp");
   }
   
   return mav;
 }
 
 
 /**
  * 로그아웃 처리
  * @param request
  * @param session
  * @return
  */
 @RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
 public ModelAndView logout(HttpServletRequest request, 
                                        HttpSession session){
   // System.out.println("--> logout() GET called.");
   ModelAndView mav = new ModelAndView();

   session.invalidate(); // session 내부 객체의 등록된 모든 session 변수 삭제

   // webapp/member/message_logout.jsp
   mav.setViewName("redirect:/"); 
   
   return mav;
 }
 
 @RequestMapping(value="/login/login_list.do", method=RequestMethod.GET)
 public ModelAndView login_list(HttpSession session){
   // System.out.println("--> create() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/login/login_list"); // webapp/member/list.jsp
    
   if (memberProc.isMember(session) == false) {
     mav.setViewName("redirect:/member/login_need.jsp"); 
   } else if(memberProc.isMaster(session) == false){
     mav.setViewName("redirect:/member/auth_need.jsp");
   } else {
     mav.setViewName("/login/login_list"); // webapp/member/list.jsp
     
     List<LogVO> list = memberProc.login_list();
     mav.addObject("list", list);
   }
   
   return mav;
 } 
 
 /**
  * 로그인 내역 페이징
  * @param memberno
  * @param nowPage
  * @return
  */
 @RequestMapping(value = "/login/login_list_paging.do", method = RequestMethod.GET)
 public ModelAndView login_list_paging(
     @RequestParam(value="memberno") int memberno,
     @RequestParam(value="nowPage", defaultValue="1") int nowPage
     ) { 
   System.out.println("--> nowPage: " + nowPage);
   
   ModelAndView mav = new ModelAndView();
   
   mav.setViewName("/login/login_list_paging");   
   
   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   hashMap.put("memberno", memberno); 
   hashMap.put("nowPage", nowPage);       
   
   List<LogVO> list = memberProc.login_list_paging(hashMap);
   mav.addObject("list", list);
   
   int search_count = memberProc.search_count(memberno);
   mav.addObject("search_count", search_count);
 
 
   String paging = memberProc.paging(memberno, search_count, nowPage);
   mav.addObject("paging", paging);
 
   mav.addObject("nowPage", nowPage);
   
   return mav;
 }
 
 
 /**
  * 목록 + 페이징 지원
  * @param nowPage
  * @return
  */
 @RequestMapping(value = "/member/member_list_paging.do", method = RequestMethod.GET)
 public ModelAndView member_list_paging(
     @RequestParam(value="nowPage", defaultValue="1") int nowPage
     ) { 
   System.out.println("--> nowPage: " + nowPage);
   
   ModelAndView mav = new ModelAndView();
   
   mav.setViewName("/member/member_list_paging");   
   
   // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   hashMap.put("nowPage", nowPage);       
   
   // 검색 목록
   List<MemberVO> list = memberProc.member_list_paging(hashMap);
   mav.addObject("list", list);
   
   // 검색된 레코드 갯수
   int member_count = memberProc.member_count();
   mav.addObject("member_count", member_count); 
 
   /*
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
    * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
    *
    * @param search_count 검색(전체) 레코드수 
    * @param nowPage     현재 페이지
    * @return 페이징 생성 문자열
    */  
   String paging2 = memberProc.paging2(member_count, nowPage);
   mav.addObject("paging2", paging2);
 
   mav.addObject("nowPage", nowPage);
   
   return mav;
 }
 
 
 @RequestMapping(value = "/member/find_id.do", method = RequestMethod.GET)
 public ModelAndView find_id(String name, String email){
   
   ModelAndView mav = new ModelAndView();
   
   String id = "";
   id = memberProc.find_id(name, email);
   
   // 이름과 이메일로 찾을수 없는 경우   AND  찾을 수 있는 경우 처리
   if(id.equals("")){
     
     mav.setViewName("/member/find_fail"); // 일치하는 회원정보가 없다는 페이지 비밀번호랑 같은 페이지
   } else{
     mav.addObject("id", id);
     mav.setViewName("/member/find_id_success"); // 아이디 안내 페이지
   }
   
   return mav;
 }
 
 @RequestMapping(value = "/member/find_passwd.do", method = RequestMethod.GET)
 public ModelAndView find_id(String id, String name, String email){
   
   ModelAndView mav = new ModelAndView();
   
   /*return이 1이면 일치하는 게 있으니까 비밀번호를 업데이트 한 후 새로운 비밀번호 부여 
   일치하지 않는다면 일치하지 않는다는 페이지 출력*/
   if(memberProc.find_passwd(id, name, email) != 1){ // 일치하지 않음
     
     mav.setViewName("/member/find_fail"); // 입력한 정보와 일치하는 회원정보가 없다는 페이지
   } else if(memberProc.find_passwd(id, name, email) == 1){ // 일치함
     MemberVO memberVO = memberProc.readById(id);
     int memberno = memberVO.getMemberno();
     String passwd = "1234";
     
     memberProc.passwd_update(memberno, passwd);
     
     mav.setViewName("/member/find_passwd_success"); // 새로운 비밀번호 안내하고 바꾸라고 알려주는 페이지
   }
   
   return mav;
 }
 
 
 @RequestMapping(value = "/member/find_form.do", method = RequestMethod.GET)
 public ModelAndView find_form(){
   
   ModelAndView mav = new ModelAndView();
   
   mav.setViewName("/member/find_form");
   return mav;
 }
 
 /**
  * 로그인이 필요한 페이지 do
  * @return
  */
 @RequestMapping(value = "/member/login_need.do", method = RequestMethod.GET)
 public ModelAndView login_need(){
   
   ModelAndView mav = new ModelAndView();
   
   mav.setViewName("/member/login_need");
   return mav;
 }
 
}