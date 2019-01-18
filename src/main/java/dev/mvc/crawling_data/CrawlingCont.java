package dev.mvc.crawling_data;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

@Controller
public class CrawlingCont {
  @Autowired
  @Qualifier("dev.mvc.crawling_data.CrawlingProc")
  private CrawlingProcInter crawlingProc = null;

  private CrawlingVO crawlingVO = new CrawlingVO();
  
  public CrawlingCont() {
    System.out.println("--> CrawlingCont created.");
  }
  
  /*create은 wordCont에 만들기*/
  /*만들어야 할 것*/
  /**
   * 크롤링 데이터 생성
   * @param word
   * @return
   */
  @RequestMapping(value="/crawling_data/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpSession session, HttpServletRequest request){
    
    ModelAndView mav = new ModelAndView();
    
    String word = (String)request.getAttribute("word");
    int wordno = (Integer)request.getAttribute("wordno");
    crawlingVO.setWordno(wordno);
    
    int count = 0;
    Date first = null;
    Date last = null;
    
    Twitter twitter = new TwitterFactory().getInstance();
    
    try {
      Query query = new Query(word);
      QueryResult result;
      do {
        result = twitter.search(query);
        
        List<Status> tweets = result.getTweets();
        
        if (count == 0) {
          last = tweets.get(0).getCreatedAt(); // 가장 최근에 생성된 트윗의 날짜
        }
        if(result.nextQuery() == null && tweets.size() != 0) {
          first = tweets.get(tweets.size()-1).getCreatedAt(); // 가장 먼 시점에 생성된 트윗의 날짜
        }
        
        count += tweets.size();
        
//        last = tweets.get(0).getCreatedAt(); // 가장 먼 시점에 생성된 트윗의 날짜
//        first = tweets.get(count-1).getCreatedAt(); // 가장 최근에 생성된 트윗의 날짜
//        first = tweets.get(0).getCreatedAt(); // 쿼리 결과 제일 첫번째에 있는 값의 날짜
//        last = tweets.get(tweets.size()).getCreatedAt(); // 쿼리 결과 제일 마지막에 있는 값의 날짜
         
        for (Status tweet : tweets) {
          System.out.println(tweet.getText());
                
          //crawlingProc create
          crawlingVO.setContent(tweet.getText()+" /시간/ "+tweet.getCreatedAt());
          crawlingProc.create(crawlingVO);
        }
      } while ((query = result.nextQuery()) != null);

      System.out.println(word + " 쿼리 결과의 갯수는 " + count + " 개 입니다.");
      System.out.println("첫 날짜는 " + first);
      System.out.println("마지막 날짜는 " + last);
      
      if(first != null && last != null) {
        System.out.println("첫 날짜와 마지막 날짜의 차이는 " + (last.getTime()-first.getTime())/1000 + "초 입니다.");
      }
      mav.setViewName("/error");
    } catch (TwitterException e) {
      e.printStackTrace();
      System.out.println("Failed to search tweets: " + e.getMessage());
    }
    
    mav.setViewName("/result");      
    
    return mav;
  } 
  
  
}
