package dev.mvc.crawling_data;


import java.util.ArrayList;
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

    List<CrawlingVO> crawling_list = new ArrayList<CrawlingVO>();   

    int count = 0;
    Date first = null;
    Date last = null;
    double word_weight = 0;
    int freshtomato = 0; 

    Twitter twitter = new TwitterFactory().getInstance();

    try {
      Query query = new Query(word);
      QueryResult result;

      query.count(5);

      do {
        result = twitter.search(query);

        List<Status> tweets = result.getTweets();

        if (count == 0) {         
          if(tweets.isEmpty()){
            mav.setViewName("redirect:../error.jsp");
            return mav;
          }
          else{
            last = tweets.get(0).getCreatedAt(); // 가장 최근에 생성된 트윗의 날짜
           System.out.println(last);
           
          }
        }

        if(result.nextQuery() == null && tweets.size() == 0) {
          System.out.println(first);
        } else {
          first = tweets.get(tweets.size()-1).getCreatedAt();
        }

        count += tweets.size();

        for (Status tweet : tweets) {
          System.out.println(tweet.getText());
          System.out.println(tweet.getCreatedAt());
          //crawlingProc create
          crawlingVO.setContent(tweet.getText());
          crawlingProc.create(crawlingVO);
        }
      } while ((query = result.nextQuery()) != null);

      if(first != null && last != null) {
        long seconds = (last.getTime()-first.getTime())/1000;

        if(seconds == 0) {  // 만약 나온 초가 0이면 1을 강제로 부여한다.
          seconds = 1;
        }

        word_weight = (double)count/seconds;  // 계산할 가중치를 (나온 갯수 / 트윗을 올린 시간)의 차이로 구한다.
        freshtomato = (int) ((word_weight / 1.03218391) * 100);

        if(freshtomato >= 100) {
          freshtomato = 100;
        }
        System.out.println("걸린 시간은 " + seconds + " 입니다.");
      }

      System.out.println("가장 예전에 만들어진 트윗 : " + first);
      System.out.println("가장 최근에 만들어진 트윗 : " + last);
      System.out.println("word_weight는 " + String.format("%.10f", word_weight ) + " 입니다.");
      System.out.println("freshtomato 수치는 " + freshtomato + " 입니다.");

      mav.setViewName("/error");

    } catch (TwitterException e) {
      e.printStackTrace();
      System.out.println("Failed to search tweets: " + e.getMessage());
    }

    crawling_list = crawlingProc.list_by_content(word);
    request.setAttribute("crawling_list", crawling_list);
    request.setAttribute("freshtomato", freshtomato);

    mav.setViewName("forward:/freshtomato/create.do");
    
    return mav;

  } 

}

