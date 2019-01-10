package dev.mvc.crawling_data;

import java.util.List;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.board.Categrp_BoardVO;

@Controller
public class CrawlingCont {
  @Autowired
  @Qualifier("dev.mvc.crawling_data.CrawlingProc")
  private CrawlingProcInter crawlingProc = null;
  
  public CrawlingCont() {
    System.out.println("--> CrawlingCont created.");
  }
  
  // http://localhost:9090/tea/crawling/create.do
  @RequestMapping(value="/crawling/create.do", method=RequestMethod.POST)
  public ModelAndView create(CrawlingVO crawlingVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = crawlingProc.create(crawlingVO);
    mav.setViewName("redirect:/crawling/create_message.jsp?count=" + count); // /webapp/crawling/create_message.jsp
    
    return mav;
  }
  
  // http://localhost:9090/tea/crawling/list.do
  @RequestMapping(value="/crawling/list.do", method=RequestMethod.GET) 
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<CrawlingVO> crawling_list = crawlingProc.list();
    mav.addObject("crawling_list", crawling_list);
    
    mav.setViewName("/crawling_data/list");
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/crawling/list_json.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
  public ResponseEntity list_json() {
    HttpHeaders responseHeaders = new HttpHeaders();
    JSONArray json = new JSONArray();
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
}
