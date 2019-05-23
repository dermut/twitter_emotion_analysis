package dev.mvc.categrp;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.simple.JSONObject;
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

import dev.mvc.board.BoardProcInter;
import dev.mvc.board.BoardVO;
import dev.mvc.board.Categrp_BoardVO;


@Controller
public class CategrpCont {
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc")
  private CategrpProcInter categrpProc = null;
 
  @Autowired
  @Qualifier("dev.mvc.board.BoardProc")
  private BoardProcInter boardProc = null;
  
  public CategrpCont() {
    System.out.println("--> CategrpCont created.");
  }

  // http://localhost:9090/tea/categrp/create.do
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/create"); // /webapp/categrp/create.jsp
    
    return mav;
  }

  // http://localhost:9090/tea/categrp/create.do
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.POST)
  public ModelAndView create(CategrpVO categrpVO) {
    ModelAndView mav = new ModelAndView();
    int count = categrpProc.create(categrpVO);
    mav.setViewName("redirect:/categrp/create_message.jsp?count=" + count); // /webapp/categrp/list.jsp
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/categrp/create_json.do", method=RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity create_json(CategrpVO categrpVO) {
    HttpHeaders responseHeaders = new HttpHeaders();
        
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if(categrpProc.create(categrpVO) == 1) {
      msgs.put("ī�װ� �׷� ������ �����Ͽ����ϴ�.");
    } else {
      msgs.put("ī�װ� �׷� ������ �����߽��ϴ�.");
    }
    json.put("msgs", msgs);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  // http://localhost:9090/tea/categrp/list.do
  @RequestMapping(value="/categrp/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<CategrpVO> list = categrpProc.list();
    
    
    mav.addObject("list", list);
    mav.setViewName("/categrp/list"); // /webapp/categrp/list.jsp
    
    return mav;
  }
  
  /**
   * JSON ��� ��ü ���
   * http://localhost:9090/tea/board/list_json.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/categrp/list_json.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ResponseEntity list_json() {
    HttpHeaders responseHeaders = new HttpHeaders();
    List<CategrpVO> list = categrpProc.list();

    JSONArray json = new JSONArray(list);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  // http://localhost:9090/tea/categrp/update.do?categrpno=1
  //  �Ϲ� �ؽ�Ʈ ���
  /*
  {
  "categrpno":1,
  "classification":1,
  "name":"����",
  "rdate":"2018-11-09 16:38:41.0"
  }
  */
  @ResponseBody
  @RequestMapping(value="/categrp/update.do", 
                             method=RequestMethod.GET,
                             produces="text/plain;charset=UTF-8")
  public ResponseEntity update(int categrpno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    CategrpVO categrpVO = categrpProc.read(categrpno);
    
    JSONObject json = new JSONObject();
    json.put("categrpno", categrpVO.getCategrpno());
    json.put("classification", categrpVO.getClassification());
    json.put("name", categrpVO.getName());
    json.put("rdate", categrpVO.getRdate());
        
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  //request.getParameter() �ڵ� ����
  // ����ȯ �ڵ� ����
  // CategrpVO ��ü  �ڵ� ����
  // http://localhost:9090/ojt/categrp/update.do -> ���� �ּ�
  @RequestMapping(value="/categrp/update.do", method=RequestMethod.POST)
  public ModelAndView update(CategrpVO categrpVO) {
    ModelAndView mav = new ModelAndView();
   
    int count = categrpProc.update(categrpVO);
    mav.setViewName("redirect:/categrp/list.do"); // /webapp/categrp/list.jsp
   
    return mav;
  }
  
  // http://localhost:9090/tea/categrp/delete.do?categrpno=1
  // {"categrpno":1,"name":"����2"}
  @ResponseBody
  @RequestMapping(value="/categrp/delete.do", 
                             method=RequestMethod.GET,
                             produces="text/plain;charset=UTF-8")
  public ResponseEntity delete(int categrpno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    CategrpVO categrpVO = categrpProc.read(categrpno);
    
//    int count_by_categrp = boardProc.count_by_categrp(categrpno);
    
    JSONObject json = new JSONObject();
    json.put("categrpno", categrpVO.getCategrpno());
    json.put("name", categrpVO.getName());
    json.put("count_by_categrp", categrpProc.count_by_categrp(categrpno));
        
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  // http://localhost:9090/tea/categrp/delete.do -> ���� �ּ�
  @RequestMapping(value="/categrp/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(int categrpno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int count = categrpProc.delete(categrpno);
    
    session.removeAttribute("board_list");
    List<BoardVO> list = boardProc.list_menu();
    session.setAttribute("board_list", list);
    
    mav.setViewName("/categrp/list"); // /webapp/categrp/create_message.jsp �� ����

    return mav;
  }
  
  // http://localhost:9090/tea/categrp/delete_json.do -> ���� �ּ�
  @RequestMapping(value="/categrp/delete_json.do", method=RequestMethod.POST)
  public ResponseEntity delete_json(int categrpno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    int count = categrpProc.delete(categrpno);
    
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if(count == 1) {
      msgs.put("ī�װ� �׷� ������ �����Ͽ����ϴ�.");
    } else {
      msgs.put("ī�װ� �׷� ������ �����߽��ϴ�.");
    }
    
    return new ResponseEntity(msgs.toString(), responseHeaders, HttpStatus.CREATED);
  }
 
  /**
   * ī�װ� ���̺��� ī�װ� �׷쿡 �Ҽӵ� ���ڵ� ��� ����
   * @param categrpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/categrp/delete_category_by_categrp.do", 
                             method=RequestMethod.POST,
                             produces="text/plain;charset=UTF-8")
  public ResponseEntity delete_category_by_categrp(int categrpno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    CategrpVO categrpVO = categrpProc.read(categrpno);
    
    int delete_by_categrp = boardProc.delete_by_categrp(categrpno);
    
    JSONObject json = new JSONObject();
    json.put("categrpno", categrpVO.getCategrpno());
    json.put("name", categrpVO.getName());
    json.put("delete_by_categrp", delete_by_categrp);
        
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
}



