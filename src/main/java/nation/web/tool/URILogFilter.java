package nation.web.tool;
 
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
 
public class URILogFilter implements Filter {
  private String charSet = null;
 
  @Override
  public void init(FilterConfig config) throws ServletException {
    // /WEB-INF/web.xml파일의 <init-param>태그의 값
    charSet = config.getInitParameter("charSet");
 
    System.out.println("────────────");
    System.out.println(" URI Logger start...");
    System.out.println("────────────");
  }
 
  // 요청이 오면 자동 실행
  public void doFilter(ServletRequest servletRequest, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    DBOpen dbopen = null;
    DBClose dbclose = null;
    HttpServletRequest request = (HttpServletRequest) servletRequest;
    Connection con = null;
    PreparedStatement pstmt = null;
    request.setCharacterEncoding(charSet); // 한글 문자셋 변경
    String uri = request.getRequestURI(); // 요청 uri 추출 부분
    boolean login = false;
 
    // ------------------------------------------------------------------------------
    // URL DBMS 기록
    // ------------------------------------------------------------------------------
    String ip = request.getRemoteAddr();
    System.out.println("ip: " + ip);
 
    try {
      dbopen = new DBOpen();
      dbclose = new DBClose();
      con = dbopen.getConnection();
 
      StringBuffer sql = new StringBuffer();
      sql.append(" INSERT INTO uriLog(urilogno, id, ip, uri, uridate)");
      sql.append(" VALUES((SELECT NVL(MAX(urilogno), 0)+1 as no FROM uriLog),");
      sql.append(" ?, ?, ?, TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS'))");
 
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, "guest"); // session에서 추출하세요.
      pstmt.setString(2, ip);
      pstmt.setString(3, uri);
 
      pstmt.executeUpdate();
    } catch (Exception e) {
      System.out.println(e.toString());
    } finally {
      dbclose.close(con, pstmt);
    }
 
    // ------------------------------------------------------------------------------
    // 접근 가능 URL 체크
    // ------------------------------------------------------------------------------
    ArrayList<String> guest_list = UriList.getGuest_list();
    for (int index = 0; index < guest_list.size(); index++) {
      if (guest_list.equals(uri)) {
        login = true;
      }
    }
    // ------------------------------------------------------------------------------
 
    // ------------------------------------------------------------------------------
    // session의 사용 ★
    // ------------------------------------------------------------------------------
    // 새로운 세션을 생성하지않고 기존의 세션 객체를 반환
    /*
     * HttpSession session = request.getSession(false);
     * 
     * if (session != null) { if (session.getAttribute("s_id") != null &&
     * session.getAttribute("s_memlevel").equals("AA")) { login = true; } }
     * 
     * if (login) { chain.doFilter(request, response); // 다른 필터 실행, 요청 JSP 실행 }
     * else { // 손님이면 로그인 페이지로 이동 RequestDispatcher dispatcher =
     * request.getRequestDispatcher("/admin_login_form.jsp");
     * dispatcher.forward(request, response); }
     */
    // ------------------------------------------------------------------------------
 
    // 다른 필터 실행, 요청 JSP 실행
    // chain.doFilter(request, response);
  }
 
  public void destroy() {
 
  }
}