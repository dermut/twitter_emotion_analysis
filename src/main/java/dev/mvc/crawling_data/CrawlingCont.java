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
  
  /*create�� wordCont�� �����*/
  /*������ �� ��*/
  /**
   * ũ�Ѹ� ������ ����
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
          last = tweets.get(0).getCreatedAt(); // ���� �ֱٿ� ������ Ʈ���� ��¥
        }
        if(result.nextQuery() == null && tweets.size() != 0) {
          first = tweets.get(tweets.size()-1).getCreatedAt(); // ���� �� ������ ������ Ʈ���� ��¥
        }
        
        count += tweets.size();
        
//        last = tweets.get(0).getCreatedAt(); // ���� �� ������ ������ Ʈ���� ��¥
//        first = tweets.get(count-1).getCreatedAt(); // ���� �ֱٿ� ������ Ʈ���� ��¥
//        first = tweets.get(0).getCreatedAt(); // ���� ��� ���� ù��°�� �ִ� ���� ��¥
//        last = tweets.get(tweets.size()).getCreatedAt(); // ���� ��� ���� �������� �ִ� ���� ��¥
         
        for (Status tweet : tweets) {
          System.out.println(tweet.getText());
                
          //crawlingProc create
          crawlingVO.setContent(tweet.getText()+" /�ð�/ "+tweet.getCreatedAt());
          crawlingProc.create(crawlingVO);
        }
      } while ((query = result.nextQuery()) != null);

      System.out.println(word + " ���� ����� ������ " + count + " �� �Դϴ�.");
      System.out.println("ù ��¥�� " + first);
      System.out.println("������ ��¥�� " + last);
      
      if(first != null && last != null) {
        System.out.println("ù ��¥�� ������ ��¥�� ���̴� " + (last.getTime()-first.getTime())/1000 + "�� �Դϴ�.");
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
