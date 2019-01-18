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
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.OAuth2Authorization;
import twitter4j.conf.ConfigurationBuilder;



@Controller
public class WordCont {

  @Autowired
  @Qualifier("dev.mvc.word.WordProc")
  private WordProcInter wordProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.word_time_graph.WordTimeGraphProc")
  private WordTimeGraphProcInter wordTimeGraphProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.member_word.Member_WordProc")
  private Member_WordProcInter member_wordProc = null;
  
  public WordCont() {
    System.out.println("--> WordCont created.");
  }
  
  /**
   * word 테이블 create 하는 것 결국 result.jsp를 표시
   * @param word
   * @return
   */
  @RequestMapping(value="/word/create.do", method=RequestMethod.POST)
  public ModelAndView create(String word, HttpSession session, HttpServletRequest request){
    ModelAndView mav = new ModelAndView();

    if (word == "") {
      mav.setViewName("word/guide");
      return mav;
    }
    
    
    int search_result = wordProc.search_word(word);
    
    wordProc.create(word);
    int wordno = wordProc.wordno_by_word(word);
    int memberno = (Integer)session.getAttribute("memberno");

//    if(search_result == 0) {
//      wordTimeGraphProc.create(wordno);
//    } else {
//      wordTimeGraphProc.increase_freq(word_time_no)
//    }
    
    request.setAttribute("word", word);
    request.setAttribute("wordno", new Integer(wordno));
    request.setAttribute("memberno", new Integer(memberno));
    
    //mav.addObject("wordno", wordno);
    //mav.addObject("memberno", memberno);
    
    mav.setViewName("forward:/member_word/create.do");
    //mav.setViewName("/result");
    
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
  
  
  /**
   * word 테이블 create 하는 것 결국 result.jsp를 표시
   * @param word
   * @return
   */
  @RequestMapping(value="/word/result.do", method=RequestMethod.POST)
  public ModelAndView create(String word, HttpSession session){
    // System.out.println("--> passwd_update() POST called.");
    ModelAndView mav = new ModelAndView();
     
    //String word = wordVO.getWord();
    
    wordProc.create(word);
    int wordno = wordProc.wordno_by_word(word);
    int memberno = (Integer)session.getAttribute("memberno");
    member_wordProc.create(memberno, wordno);
    
    // 크롤링데이터create, 프토create
    // posinega.create, 동향create
    // 감성분석 create
    
    mav.addObject("word", word);
    
    mav.setViewName("/result");      
    
    return mav;
  } 
}
