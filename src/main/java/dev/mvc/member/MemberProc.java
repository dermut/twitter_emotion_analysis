package dev.mvc.member;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
 
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

  

  
}