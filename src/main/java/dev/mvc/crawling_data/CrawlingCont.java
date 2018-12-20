package dev.mvc.crawling_data;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
  
  
}
