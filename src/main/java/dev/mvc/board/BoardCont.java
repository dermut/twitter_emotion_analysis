package dev.mvc.board;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
    System.out.println("--> CategoryCont created.");
  }

  // http://localhost:9090/ojt/board/create.do
  @RequestMapping(value = "/board/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/board/create"); // /webapp/board/create.jsp

    return mav;
  }

  // http://localhost:9090/ojt/board/create.do
  @RequestMapping(value = "/board/create.do", method = RequestMethod.POST)
  public ModelAndView create(BoardVO boardVO) {
    ModelAndView mav = new ModelAndView();

    int count = boardProc.create(boardVO);
    mav.setViewName("redirect:/board/create_message.jsp?count=" + count); // /webapp/board/create_message.jsp
    // mav.setViewName("redirect:/board/list.do"); //
    // /webapp/board/list.jsp

    return mav;
  }

  // http://localhost:9090/ojt/board/create_json.do?categrpno=1&title=등산&seqno=1&visible=Y&ids=admin
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
  // http://localhost:9090/ojt/board/list.do
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
   * http://localhost:9090/ojt/board/list_json.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/board/list_json.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ResponseEntity list_json() {
    HttpHeaders responseHeaders = new HttpHeaders();
    List<Categrp_BoardVO> list = boardProc.list();

    JSONArray json = new JSONArray(list);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  /**
   * 카테고리 그룹별 전체 목록
   * http://localhost:9090/ojt/board/list_by_categrp.do
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
   * http://localhost:9090/ojt/board/list_by_categrp_json.do
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

/*  *//**
   * 카테고리 그룹 및 카테고리 목록 결합 출력 
   * http://localhost:9090/ojt/board/list_index.do
   * @param request
   *          절대 경로용 객체
   * @return
   *//*
  @RequestMapping(value = "/board/list_index.do", method = RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request) {
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/board/list_index"); // webapp/board/list_index.jsp

    List<CategrpVO> categrp_list = categrpProc.list(); // 카테고리 그룹 목록

    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();

    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    // 카테고리 그룹 갯수만큼 순환
    for (int index = 0; index < categrp_list.size(); index++) {
      CategrpVO categrpVO = categrp_list.get(index);

      name_title_list.add("<LI class='categrp_name'>" + categrpVO.getName() + "</LI>");

      // 카테고리 그룹별 카테고리 Join 목록
      List<Categrp_BoardVO> board_list = boardProc.list_by_categrp(categrpVO.getCategrpno());

      // 카테고리 갯수만큼 순환
      for (int j = 0; j < board_list.size(); j++) {
        Categrp_BoardVO categrp_CategoryVO = board_list.get(j);
        String title = categrp_CategoryVO.getTitle(); // 카테고리 이름
        int cnt = categrp_CategoryVO.getCnt();

        url.append("<LI class='board_title'>");
        url.append("  <A href='" + request.getContextPath() + "/contents/list_by_board_search_paging.do?boardno="
            + categrp_CategoryVO.getCategoryno() + "'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>(" + cnt + ")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // 출력 목록에 하나의 board 추가

        url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제

      }
    }

    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", contentsProc.total_count());

    return mav;
  }

  *//**
   * 수정 폼
   * http://localhost:9090/ojt/board/update.do?boardno=1
   * @param categrpno
   * @return
   *//*
  @ResponseBody
  @RequestMapping(value = "/board/update.do", 
                           method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int boardno) {
    // System.out.println("--> update() GET executed");
    
    Categrp_BoardVO boardVO = boardProc.read(boardno);
    JSONObject obj = new JSONObject(boardVO);
   
    // 기본 값을 변경하는 경우는 직접 값을 명시
//    obj.put("boardno", boardno);
//    obj.put("categrpno", boardVO.getCategrpno());
//    obj.put("title", boardVO.getTitle());
//    obj.put("seqno", boardVO.getSeqno());
//    obj.put("visible", boardVO.getVisible());
//    obj.put("ids", boardVO.getIds());
//    obj.put("rdate", boardVO.getRdate());

    return obj.toString();
  }

  // http://localhost:9090/ojt/board/update_json.do?categrpno=1&boardno=1&title=네덜란드&seqno=1&visible=Y&ids=admin
  // {"msgs":["카테고리를 등록했습니다.","등록된 카테고리 등산"]}
  @ResponseBody
  @RequestMapping(value = "/board/update_json.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity update_json(BoardVO boardVO) {
    HttpHeaders responseHeaders = new HttpHeaders();

    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();

    if (boardProc.update(boardVO) == 1) {
      msgs.put("카테고리를 수정했습니다.");
      msgs.put("수정된 카테고리 " + boardVO.getTitle());
    } else {
      msgs.put("카테고리 수정에 실패했습니다.");
      msgs.put("다시한번 시도해주세요. ☏ 문의: 000-0000-0000");
    }
    json.put("msgs", msgs);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  *//**
   * 삭제 폼
   * http://localhost:9090/ojt/board/delete.do?boardno=1
   * @param boardno
   * @return
   *//*
  @ResponseBody
  @RequestMapping(value = "/board/delete.do", 
                           method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete(int boardno) {
    Categrp_BoardVO boardVO = boardProc.read(boardno);
    JSONObject obj = new JSONObject(boardVO);

    return obj.toString();
  }
  
  // http://localhost:9090/ojt/board/delete.do?boardno=1
  @ResponseBody
  @RequestMapping(value = "/board/delete.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity delete_proc(int boardno) {
    HttpHeaders responseHeaders = new HttpHeaders();

    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    String title = boardProc.read(boardno).getTitle();
    
    if (.delete(boardno) == 1) {
      msgs.put("카테고리를 삭제했습니다.");
      msgs.put("삭제된 카테고리 [" + title + "]");
    } else {
      msgs.put("[" + title + "] 카테고리 수정에 실패했습니다.");
      msgs.put("다시한번 시도해주세요. ☏ 문의: 000-0000-0000");
    }
    json.put("msgs", msgs);

    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  *//**
   * 화면 좌측에 카테고리 그룹 및 카테고리 출력
   * @param request
   * @return
   *//*
  @RequestMapping(value="/board/list_index_left.do", method=RequestMethod.GET)
  public ModelAndView list_index_left(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/board/list_index_left"); // webapp/board/list_index_left.jsp
    
    List<CategrpVO> categrp_list = categrpProc.list(); // 카테고리 그룹 목록
    
    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    // 카테고리 그룹 갯수만큼 순환
    for (int index = 0; index < categrp_list.size(); index++) {
      CategrpVO categrpVO = categrp_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ categrpVO.getName() + "</LI>");

      List<Categrp_BoardVO> board_list = .list_by_categrp(categrpVO.getCategrpno()); // 카테고리 Join 목록
      
      // 카테고리 갯수만큼 순환
      for (int j=0; j < board_list.size(); j++) {
        Categrp_BoardVO categrp_CategoryVO = board_list.get(j);
        String title = categrp_CategoryVO.getTitle(); // 카테고리 이름
        int cnt = categrp_CategoryVO.getCnt();
        
        url.append("<LI class='board_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/contents/list_by_board_search_paging.do?boardno="+categrp_CategoryVO.getCategoryno()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // 출력 목록에 하나의 board 추가 
        
        url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", contentsProc.total_count());
    
    return mav;
  } 
   
   
*/  
}