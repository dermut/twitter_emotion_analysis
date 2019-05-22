package dev.mvc.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class MemberTool {
  /**
   * ������ �������� �˻��մϴ�.
   * @param request
   * @return true or false
   */
  public static synchronized boolean isAdmin(HttpServletRequest request){
  //  public static synchronized boolean isMember(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession(); // java class���� session ��ü ����
    String grade = (String)session.getAttribute("grade"); // ���� ����
    
    if (grade != null){
      if (grade.equals("A")){ // �α��� ����
        sw = true;
      }
    }
    return sw;
  }

}
