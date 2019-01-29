package dev.mvc.board;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
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

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;

@Controller
public class BoardCont {
  @Autowired
  @Qualifier("dev.mvc.board.BoardProc")
  private BoardProcInter boardProc = null;

  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc")
  private CategrpProcInter categrpProc = null;

  public BoardCont() {
    System.out.println("--> BoardCont created.");
  }

  // http://localhost:9090/tea/board/create.do
  @RequestMapping(value = "/board/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/board/create"); // /webapp/board/create.jsp
    
    return mav;
  }

  // http://localhost:9090/tea/board/create.do
  @RequestMapping(value = "/board/create.do", method = RequestMethod.POST)
  public ModelAndView create(BoardVO boardVO) {
    ModelAndView mav = new ModelAndView();
    int count = boardProc.create(boardVO);
    mav.setViewName("redirect:/board/create_message.jsp?count=" + count); // /webapp/board/create_message.jsp
    
    return mav;
  }

  // http://localhost:9090/tea/board/create_json.do?categrpno=1&name=등산&memberno=1
  // {"msgs":["카테고리를 등록했습니다.","등록된 카테고리 등산"]}
  @ResponseBody
  @RequestMapping(value = "/board/create_json.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity create_json(BoardVO boardVO) {
    HttpHeaders responseHeaders = new HttpHeaders();

    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();

    if (boardProc.create(boardVO) == 1) {
      msgs.put("카테고리를 등록했습니다.");
      msgs.put("등록된 카테고리 " + boardVO.getName());
    } else {
      msgs.put("카테고리 등록에 실패했습니다.");
      msgs.put("다시한번 시도해주세요. ☏ 문의: 000-0000-0000");
    }
    json.put("msgs", msgs);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  /**
   * 전체 목록
   * 
   * @return
   */
  // http://localhost:9090/tea/board/list.do
  @RequestMapping(value = "/board/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    List<CategrpVO> categrp_list = categrpProc.list();
    mav.addObject("categrp_list", categrp_list);
    
    mav.setViewName("/board/list"); // /webapp/board/list.jsp

    return mav;
  }

  /**
   * JSON 기반 전체 목록
   * http://localhost:9090/tea/board/list_json.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/board/list_json.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ResponseEntity list_json() {
    HttpHeaders responseHeaders = new HttpHeaders();
    List<Categrp_BoardVO> list = boardProc.list();

    for(int index=0; index < list.size(); index++) {
      list.get(index).setId(boardProc.getId(list.get(index).getMemberno()));
    }
    
    JSONArray json = new JSONArray(list);
    
    
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  /**
   * 카테고리 그룹별 전체 목록
   * http://localhost:9090/tea/board/list_by_categrp.do
   * @return
   */
  @RequestMapping(value = "/board/list_by_categrp.do", method = RequestMethod.GET)
  public ModelAndView list_by_categrp(int categrpno) {
    ModelAndView mav = new ModelAndView();

    CategrpVO categrpVO = categrpProc.read(categrpno);
    mav.addObject("categrpVO", categrpVO);
    
    mav.setViewName("/board/list_by_categrp"); // /webapp/board/list_by_categrp.jsp

    return mav;
  }

  /**
   * 카테고리 그룹별 JSON 기반 전체 목록
   * http://localhost:9090/tea/board/list_by_categrp_json.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/board/list_by_categrp_json.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ResponseEntity list_by_categrp_json(int categrpno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    List<Categrp_BoardVO> list = boardProc.list_by_categrp(categrpno);

    JSONArray json = new JSONArray(list);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  /*
   * 수정 폼
   * http://localhost:9090/tea/board/update.do?boardno=1
   * @param categrpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/board/update.do", 
                           method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int boardno) {
    // System.out.println("--> update() GET executed");
    BoardVO boardVO = boardProc.read(boardno);
    
    JSONObject obj = new JSONObject(boardVO);
    // 기본 값을 변경하는 경우는 직접 값을 명시
    obj.put("categrpno", boardVO.getCategrpno());
    obj.put("name", boardVO.getName());
    obj.put("memberno", boardVO.getMemberno());
    obj.put("boardno", boardVO.getBoardno());

    return obj.toString();
  }

  // http://localhost:9090/tea/board/update_json.do?categrpno=1&boardno=1&name=네덜란드&memberno=1
  // {"msgs":["카테고리를 등록했습니다.","등록된 카테고리 등산"]}
  @RequestMapping(value = "/board/update.do", method = RequestMethod.POST)
  public ModelAndView update(BoardVO boardVO) {
    ModelAndView mav = new ModelAndView();

    int count = boardProc.update(boardVO);
    mav.setViewName("redirect:/board/list.do");

    return mav;
  }

  /**
   * 삭제 폼
   * http://localhost:9090/tea/board/delete.do?boardno=1
   * @param boardno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/board/delete.do", 
                  method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public ResponseEntity delete(int boardno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    BoardVO boardVO = boardProc.read(boardno);
    JSONObject obj = new JSONObject(boardVO);
    obj.put("boardno", boardVO.getBoardno());
    obj.put("name", boardVO.getName());
    obj.put("count_by_board", boardProc.count_by_board(boardno));
    
    return new ResponseEntity(obj.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  // http://localhost:9090/tea/board/delete.do?boardno=1
  @ResponseBody
  @RequestMapping(value = "/board/delete.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity delete_proc(int boardno) {
//    ModelAndView mav = new ModelAndView();
    HttpHeaders responseHeaders = new HttpHeaders();
    
    String name = boardProc.read(boardno).getName();
    int count = boardProc.delete(boardno);
    
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();
    if (count == 1) {
      msgs.put("카테고리를 삭제했습니다.");
      msgs.put("삭제된 카테고리:" + name);
    } else {
      msgs.put("카테고리 삭제에 실패했습니다.");
      msgs.put("다시한번 시도해주세요. ☏ 문의: 000-0000-0000");
    }
    json.put("msgs", msgs);
//    mav.setViewName("redirect:/board/list.do");

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  /**
   * 카테고리 테이블에서 카테고리 그룹에 소속된 레코드 모두 삭제
   * @param boardno
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/board/delete_contents_by_board.do", 
                             method=RequestMethod.POST,
                             produces="text/plain;charset=UTF-8")
  public ResponseEntity delete_contents_by_board(int boardno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    BoardVO boardVO = boardProc.read(boardno);
    
    int count_by_board = boardProc.count_by_board(boardno);
    int delete_contents_by_board = boardProc.delete_contents_by_board(boardno);
    
    JSONObject json = new JSONObject();
    json.put("boardno", boardVO.getBoardno());
    json.put("name", boardVO.getName());
    json.put("delete_contents_by_board", delete_contents_by_board);
    json.put("count_by_board", count_by_board);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
}