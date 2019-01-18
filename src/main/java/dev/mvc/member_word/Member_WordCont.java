package dev.mvc.member_word;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Member_WordCont {

  @Autowired
  @Qualifier("dev.mvc.member_word.Member_WordProc")
  private Member_WordProcInter member_wordProc = null;
  
  public Member_WordCont(){
    System.out.println("--> Member_WordCont created.");
  }
  
  /**
   * 회원 검색어 생성
   * @param memberno, wordno
   * @return
   */
  @RequestMapping(value="/member_word/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpSession session, HttpServletRequest request){
    // System.out.println("--> passwd_update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    int wordno = (Integer)request.getAttribute("wordno");
    int memberno = (Integer)request.getAttribute("memberno");

    member_wordProc.create(memberno, wordno); 
    request.setAttribute("wordno", wordno);
    mav.setViewName("forward:/crawling_data/create.do");      
    
    return mav;
  } 
  
  // 회원 별 검색어번호 목록 
  /**
   * 
   * @param session
   * @return
   */
  @RequestMapping(value="/member_word/wordno_by_member.do", method=RequestMethod.GET)
  public ModelAndView wordno_by_member(int memberno, HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member_word/wordno_by_member"); // webapp/member_word/wordno_by_member.jsp
     
   /* if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {*/
      mav.setViewName("/member_word/wordno_by_member"); // webapp/member/list.jsp
       
      List<Word_MemberWordVO> list = member_wordProc.wordno_by_member(memberno);
      mav.addObject("list", list);
    /*}*/ 
    
    return mav;
  } 
  
  // 특정 검색어를 어떤 회원이 검색했는지
  /**
   * 
   * @param session
   * @return
   */
  @RequestMapping(value="/member_word/member_by_wordno.do", method=RequestMethod.GET)
  public ModelAndView member_by_wordno(int wordno, HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member_word/member_by_wordno"); // webapp/member_word/wordno_by_member.jsp
     
    /*if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {*/
      mav.setViewName("/member_word/member_by_wordno"); // webapp/member/list.jsp
       
      List<Word_MemberWordVO> list = member_wordProc.member_by_wordno(wordno);
      
      mav.addObject("list", list);
    /*}*/  
    
    return mav;
  } 
  
  
}
