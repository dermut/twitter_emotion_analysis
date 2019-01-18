package dev.mvc.freshtomato;

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
  public ModelAndView create(TomatoVO tomatoVO) {
    ModelAndView mav = new ModelAndView();
    tomatoProc.create(tomatoVO);
    
    return mav;
  }
}
