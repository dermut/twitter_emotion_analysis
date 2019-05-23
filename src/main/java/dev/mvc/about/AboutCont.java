package dev.mvc.about;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AboutCont {
  
  @RequestMapping(value = "/about/about.do", method = RequestMethod.GET)
  public ModelAndView about() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/about/about"); 
    
    return mav;
  }
  
  @RequestMapping(value = "/about/privacy.do", method = RequestMethod.GET)
  public ModelAndView privacy() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/about/privacy"); 
    
    return mav;
  }
  
  @RequestMapping(value = "/about/help.do", method = RequestMethod.GET)
  public ModelAndView help() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/about/help"); 
    
    return mav;
  }
}
