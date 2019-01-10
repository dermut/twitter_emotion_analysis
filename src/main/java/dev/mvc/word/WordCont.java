package dev.mvc.word;


import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member_word.Member_WordProcInter;
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
  @Qualifier("dev.mvc.member_word.Member_WordProc")
  private Member_WordProcInter member_wordProc = null;
  
  public WordCont() throws TwitterException{
    System.out.println("--> WordCont created.");
    
//    final String CONSUMER_KEY = "jSfyi2vRJtHsdZ7brddYk1O3X";
//    final String CONSUMER_SECRET = "ou20mWDeEFcGgfXDZndTy9VdzZ0y4NFV9tk4lpR0NTuJPSQ7v8";
//    
//    final String ACCESS_TOKEN = "241886291-HN5Q7vCm2mte6avegHpi9SCOnHx5mOXHCWdQFzDm ";
//    final String ACCESS_TOKEN_SECRET = "0QyYwIPjQTJaUzx6tX4cqN9oQJVgeIuXtBROSDzLX0QRA";
//    
//    ConfigurationBuilder cb = new ConfigurationBuilder();
//    cb.setDebugEnabled(true)
//      .setOAuthConsumerKey(CONSUMER_KEY)
//      .setOAuthConsumerSecret(CONSUMER_SECRET)
//      .setOAuthAccessToken(ACCESS_TOKEN)
//      .setOAuthAccessTokenSecret(ACCESS_TOKEN_SECRET);
//    TwitterFactory tf = new TwitterFactory(cb.build());
//    Twitter twitter = tf.getInstance();
//    
//    Query query = new Query("source:twitter4j yusukey");
//    QueryResult result = twitter.search(query);
//    for(Status status : result.getTweets()) {
//      System.out.println("@" + status.getUser().getScreenName() + ":" + status.getText());
//    }
  }
  
/*  @RequestMapping(value = "/index.do", method = RequestMethod.GET)
  public ModelAndView index() {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/index");
    
    return mav;
  }*/
  
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
  
  @RequestMapping(value="/word/word_list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/word/list"); // webapp/member/list.jsp
     
    if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {
      mav.setViewName("/word/list"); // webapp/member/list.jsp
      
      List<WordVO> list = wordProc.word_list();
      mav.addObject("list", list);
    }
    
    return mav;
  } 
  
  
  
  /*
create.do
  word_create
  crawlingdata_create
  return mav(결과화면)
  */
  
}
