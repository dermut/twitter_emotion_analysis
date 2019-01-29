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

}