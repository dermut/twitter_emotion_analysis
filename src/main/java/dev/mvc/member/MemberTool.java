package dev.mvc.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MemberTool {
  /**
   * 관리자 계정인지 검사합니다.
   * @param request
   * @return true or false
   */
  public static synchronized boolean isAdmin(HttpServletRequest request){
  //  public static synchronized boolean isMember(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession(); // java class에서 session 객체 추출
    String grade = (String)session.getAttribute("grade"); // 권한 산출
    
    if (grade != null){
      if (grade.equals("A")){ // 로그인 가능
        sw = true;
      }
    }
    return sw;
  }

}
