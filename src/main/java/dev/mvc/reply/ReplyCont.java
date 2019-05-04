package dev.mvc.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.contents.ContentsProcInter;
import dev.mvc.contents.Contents_ReplyVO;

@Controller
public class ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc")
  private ReplyProcInter replyProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.contents.ContentsProc")
  private ContentsProcInter contentsProc = null;
  
  public ReplyCont() {
    System.out.println("--> ReplyCont crated.");
  }

  /**
   * 등록 폼 http://localhost:9090/tea/reply/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/reply/create.do", method = RequestMethod.GET)
  public ModelAndView create(int contentsno) {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    
    Contents_ReplyVO contentsVO = contentsProc.reply(contentsno);
    //Contents_ReplyVO contentsVO = contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO);
    mav.setViewName("/reply/create"); // /webapp/contents/create.jsp

    return mav;
  }
  
  // request.getParameter() 자동 실행
  // 형변환 자동 실행
  // ReplyVO 객체 자동 생성
  // http://localhost:9090/tea/reply/create.do
  @RequestMapping(value="/reply/create.do", method=RequestMethod.POST)
  public ModelAndView create(ReplyVO replyVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = replyProc.create(replyVO);
    mav.setViewName("redirect:/reply/create_message.jsp?count=" + count); // /webapp/categrp/create_message.jsp
    
    return mav;
  }
}
