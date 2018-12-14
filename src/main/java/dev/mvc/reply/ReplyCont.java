package dev.mvc.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.board.Categrp_BoardVO;

@Controller
public class ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc")
  private ReplyProcInter replyProc = null;
  
  public ReplyCont() {
    System.out.println("--> ReplyCont crated.");
  }

  /**
   * µî·Ï Æû http://localhost:9090/tea/reply/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/reply/create.do", method = RequestMethod.GET)
  public ModelAndView create(int contentsno) {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    
    Contents_Reply replyVO = replyProc.read(contentsno);
    mav.addObject("replyVO", replyVO);
    
    mav.setViewName("/reply/create"); // /webapp/contents/create.jsp

    return mav;
  }
}
