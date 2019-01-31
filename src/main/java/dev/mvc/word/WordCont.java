package dev.mvc.word;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member_word.Member_WordProcInter;
import dev.mvc.word_time_graph.WordTimeGraphProcInter;


@Controller
public class WordCont {

  @Autowired
  @Qualifier("dev.mvc.word.WordProc")
  private WordProcInter wordProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.member_word.Member_WordProc")
  private Member_WordProcInter member_wordProc = null;
  
  public WordCont() {
    System.out.println("--> WordCont created.");
  }
  
  /**
   * word 테이블 create 하는 것
   * @param word
   * @return
   */
  @RequestMapping(value="/word/create.do", method=RequestMethod.POST)
  public ModelAndView create(String word, HttpSession session, HttpServletRequest request){
    ModelAndView mav = new ModelAndView();
    
    // 로그인 안했을 때 검색 처리 불가능하게 처리하는 로직
    if(memberProc.isMember(session) == false){
      
      mav.setViewName("redirect:/member/login_need.jsp");

    }else{
    
      // word로 word테이블을 검색해서 존재하지 않으면 create
      if(wordProc.isExist(word) == 0){
        wordProc.create(word);
      }

      int wordno = wordProc.wordno_by_word(word); 
      int memberno = (Integer)session.getAttribute("memberno");

      request.setAttribute("word", word);
      request.setAttribute("wordno", new Integer(wordno));
      request.setAttribute("memberno", new Integer(memberno));
    
      mav.setViewName("forward:/member_word/create.do");
    }
    return mav;
  } 
  
  @RequestMapping(value="/word/word_list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/word/list"); // webapp/member/list.jsp
     
    /*if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {*/
      mav.setViewName("/word/list"); // webapp/member/list.jsp
      
      List<WordVO> list = wordProc.word_list();
      mav.addObject("list", list);
    /*}*/
    
    return mav;
  } 
  
}
