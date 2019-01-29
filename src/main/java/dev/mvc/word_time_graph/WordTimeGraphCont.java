package dev.mvc.word_time_graph;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@Controller
public class WordTimeGraphCont {
  
  @Autowired
  @Qualifier("dev.mvc.word_time_graph.WordTimeGraphProc")
  private WordTimeGraphProcInter wordTimeGraphProc = null;
  
  private WordTimeGraphVO wordTimeGraphVO = new WordTimeGraphVO();
  
  public WordTimeGraphCont(){
    System.out.println("--> WordTimeGraphCont created.");
  }
  
  /**
   * 검색어 동향 생성
   * @param session
   * @param request
   * @return
   */
  @RequestMapping(value="/wordTimeGraph/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpSession session, HttpServletRequest request){
    ModelAndView mav = new ModelAndView();

    int wordno = (Integer)request.getAttribute("wordno");
    wordTimeGraphVO.setWordno(wordno);
    String word = (String) request.getAttribute("word");
    
    wordTimeGraphProc.create(wordTimeGraphVO);
    
    int arr[] = new int[8];
    SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy", new Locale("en", "US"));
    String ar[] = new String[8];
    Date str;
    int a[] = new int[8];
    
    // 배열 저장 
    for(int day=0; day<=7; day++){
      arr[day] = wordTimeGraphProc.freq_by_day(day, wordno);
      a[day] = wordTimeGraphProc.all_freq_by_day(day);
      
      Calendar cal = Calendar.getInstance();
      cal.add(Calendar.DATE, -day);
      str = cal.getTime();
      ar[day] = sdf.format(str);
      // ar은 x축의 날짜    arr은 매일단위의 검색어 빈도  a는 매일단위의 총 빈도
      mav.addObject("a"+day, a[day]);
      mav.addObject("ar"+day, ar[day]);
      mav.addObject("arr"+day, arr[day]);
      // 코드 합칠 시 위의 addObject삭제후 주석해제 사용
      //request.setAttribute("a"+day, a[day]);
      //request.setAttribute("ar"+day, ar[day]);
      //request.setAttribute("arr"+day, arr[day]);
    }
    int allfreq = wordTimeGraphProc.allFreq();
    int maxfreq = wordTimeGraphProc.maxFreq(wordno);
    
    int rest = allfreq - maxfreq;
    // 합치면 request.setAttribute() 사용
    mav.addObject("allfreq", allfreq);
    mav.addObject("maxfreq", maxfreq);
    mav.addObject("rest", rest);
    mav.addObject("word", word);
    
    mav.setViewName("/result");
    //mav.setViewName("/wtgChart");
    //mav.setViewName("/result");      
     
    return mav;
  } 
  
  @RequestMapping(value="/wordTimeGraph/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/wordTimeGraph/list"); // webapp/wordTimeGraph/list.jsp
     
    /*if (memberProc.isMember(session) == false) {
      mav.setViewName("redirect:/member/login_need.jsp"); 
    } else if(memberProc.isMaster(session) == false){
      mav.setViewName("redirect:/member/auth_need.jsp");
    } else {*/
      mav.setViewName("/wordTimeGraph/list"); // webapp/member/list.jsp
      
      List<WordTimeGraphVO> list = wordTimeGraphProc.list(); 
      mav.addObject("list", list);
   /* }*/
     
    return mav;
  } 
  
  /*하루하루의 빈도를 리턴하는 컨트롤러*/
  
  
}
