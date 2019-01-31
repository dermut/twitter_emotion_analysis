package dev.mvc.member;
 
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.contents.Contents;
import dev.mvc.contents.ContentsVO;
import nation.web.tool.Tool;
 
@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {

  @Autowired
  @Qualifier("dev.mvc.member.MemberDAO")
  private MemberDAOInter memberDAO = null;
  
  public MemberProc(){
    System.out.println("--> MemberProc created.");
  }

  @Override
  public int checkId(String id) {
    int cnt = memberDAO.checkId(id);
    return cnt;
  }

  @Override
  public int create(MemberVO memberVO) {
    int cnt = memberDAO.create(memberVO);
    return cnt;
  }

  @Override
  public List<MemberVO> list() {
    List<MemberVO> list = memberDAO.list();
      
    return list;
  }
  
  @Override
  public boolean isMember(HttpSession session){
    boolean sw = false;
    
    String id = (String)session.getAttribute("id");
    
    if (id != null){
      sw = true;
    }
    return sw;
  }
  
  @Override
  public boolean isMaster(HttpSession session){
    boolean sw = false;
    
    String grade = (String)session.getAttribute("grade");
    
    if (grade.equals("M")){
      sw = true;
    }
    return sw;
  }
  
  @Override
  public boolean isDelete(HttpSession session){
    boolean sw = false;
    
    String grade = (String)session.getAttribute("grade");
    
    if (grade.equals("D")){
      sw = true;
    }
    return sw;
  }

  @Override
  public MemberVO read(int memberno) {
    MemberVO memberVO = memberDAO.read(memberno);
    return memberVO;
  }

  @Override
  public MemberVO readById(String id) {
    MemberVO memberVO = memberDAO.readById(id);
    return memberVO;
  }

  @Override
  public int update(MemberVO memberVO) {
    int count = memberDAO.update(memberVO);
    return count;
  }

  @Override
  public int passwd_update(int memberno, String passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("passwd", passwd);
    
    int count = memberDAO.passwd_update(map);
    
    return count;
  }

  @Override
  public int delete(int memberno) {
    int count = memberDAO.delete(memberno);
    return count;
  }

  @Override
  public int login(String id, String passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
    int count = memberDAO.login(map);
    return count;
  }

  @Override
  public int create_login_list(String ip, String sf, int memberno) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("ip", ip);
    map.put("sf", sf);
    map.put("memberno", memberno);
    int count = memberDAO.create_login_list(map);
    return count;
  }

  @Override
  public List<LogVO> login_list() {
    List<LogVO> list = memberDAO.login_list();
    return list;
  }

  @Override
  public List<LogVO> login_list_paging(HashMap<String, Object> hashmap) {
   int beginOfPage = ((Integer)hashmap.get("nowPage") - 1) * Log.RECORD_PER_PAGE;
   
   int startNum = beginOfPage + 1; 
   int endNum = beginOfPage + Log.RECORD_PER_PAGE;   
   hashmap.put("startNum", startNum);
   hashmap.put("endNum", endNum);
     
    List<LogVO> list = memberDAO.login_list_paging(hashmap);
    return list;
  }

  @Override
  public int search_count(int memberno) {
    int num = memberDAO.search_count(memberno);
    return num;
  }

  @Override
  public String paging(int memberno, int search_count, int nowPage){ 
    int totalPage = (int)(Math.ceil((double)search_count/Log.RECORD_PER_PAGE)); 
    int totalGrp = (int)(Math.ceil((double)totalPage/Log.PAGE_PER_BLOCK));
    int nowGrp = (int)(Math.ceil((double)nowPage/Log.PAGE_PER_BLOCK)); 
    int startPage = ((nowGrp - 1) * Log.PAGE_PER_BLOCK) + 1;
    int endPage = (nowGrp * Log.PAGE_PER_BLOCK); 
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px;"); 
    str.append("    margin:1px 2px 1px 2px;"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px;"); 
    str.append("    margin:1px 2px 1px 2px;"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
    int _nowPage = (nowGrp-1) * Log.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./login_list_paging.do?&nowPage="+_nowPage+"&memberno="+memberno+">이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); 
      }else{
        str.append("<span class='span_box_1'><A href='./login_list_paging.do?&nowPage="+i+"&memberno="+memberno+"'>"+i+"</A></span>");   
      } 
    } 
    _nowPage = (nowGrp * Log.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./login_list_paging.do?&nowPage="+_nowPage+"&memberno="+memberno+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  
  @Override
  public int member_count() {
    int num = memberDAO.member_count();
    return num;
  }

  @Override
  public List<MemberVO> member_list_paging(HashMap<String, Object> hashmap) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)hashmap.get("nowPage") - 1) * Member.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   hashmap.put("startNum", startNum);
   hashmap.put("endNum", endNum);
     
    List<MemberVO> list = memberDAO.member_list_paging(hashmap);
    return list;
  }

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param member_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @return 페이징 생성 문자열
   */ 
  @Override 
  public String paging2(int search_count, int nowPage){ 
    int totalPage = (int)(Math.ceil((double)search_count/Member.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Member.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Member.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Member.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Member.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Member.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./member_list_paging.do?&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./member_list_paging.do?&nowPage="+i+"'>"+i+"</A></span>");   
      }  
    } 

    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./member_list_paging.do?&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public String find_id(String name, String email) {
    HashMap<String, Object> hashmap = new HashMap<String, Object>();
    hashmap.put("name", name);
    hashmap.put("email", email);

    String id = memberDAO.find_id(hashmap);
    
    return id;
  }

  @Override
  public int find_passwd(String id, String name, String email) {
    HashMap<String, Object> hashmap = new HashMap<String, Object>();
    
    hashmap.put("id", id);
    hashmap.put("name", name);
    hashmap.put("email", email);
    
    int num = memberDAO.find_passwd(hashmap);
    
    return num;
  }

}