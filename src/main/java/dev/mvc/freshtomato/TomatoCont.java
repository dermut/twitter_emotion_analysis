package dev.mvc.freshtomato;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TomatoCont {
  @Autowired
  @Qualifier("dev.mvc.freshtomato.TomatoProc")
  private TomatoProcInter tomatoProc = null;
  
  private TomatoVO tomatoVO = new TomatoVO();
  
  public TomatoCont() {
    System.out.println("--> TomatoCont created.");
  }
  
  /**
   * 프레시토마토 생성
   * @param session
   * @param request
   * @return
   */
  @RequestMapping(value="/freshtomato/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    
    int ftrate = (Integer) request.getAttribute("freshtomato");
    int wordno = (Integer) request.getAttribute("wordno");
    
    tomatoVO.setFtrate(ftrate);
    tomatoVO.setWordno(wordno);
    
    tomatoProc.create(tomatoVO);
    
    request.setAttribute("ftrate", ftrate);
    mav.setViewName("forward:/wordTimeGraph/create.do");
    
    return mav;
  }
}
