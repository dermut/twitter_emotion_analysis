package dev.mvc.contents;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.board.BoardProcInter;
import dev.mvc.board.BoardVO;
import dev.mvc.board.Categrp_BoardVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class ContentsCont {
  @Autowired
  @Qualifier("dev.mvc.board.BoardProc")
  private BoardProcInter boardProc = null;

  @Autowired
  @Qualifier("dev.mvc.contents.ContentsProc")
  private ContentsProcInter contentsProc = null;

  public ContentsCont() {
    System.out.println("--> ContentsCont crated.");
  }
  
  /**
   * 등록 폼 http://localhost:9090/tea/contents/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/contents/create.do", method = RequestMethod.GET)
  public ModelAndView create(int boardno) {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    
    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);
    
    mav.setViewName("/contents/create"); // /webapp/contents/create.jsp

    return mav;
  }

  /**
   * 등록 처리
   * 
   * @param request
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/contents/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ContentsVO contentsVO) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();

    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/contents/storage");
    List<MultipartFile> photoMF = contentsVO.getPhotoMF(); // Spring이 File 객체를
                                                           // 저장해둠.


//     System.out.println("--> photoMF.get(0).getSize(): " +
//     photoMF.get(0).getSize());

    String photo = ""; // 컬럼에 저장할 파일명
    String photo_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0; // 하나의 파일 사이즈
    String thumb = ""; // Thumb 파일들
    String thumb_item = ""; // 하나의 Thumb 파일명

    int count = photoMF.size(); // 업로드된 파일 갯수

//     Spring은 파일 선택을 안해도 1개의 MultipartFile 객체가 생성됨.
     System.out.println("--> 업로드된 파일 갯수 count: " + count);

    if (count > 0) { // 전송 파일이 존재한다면
      // for (MultipartFile multipartFile: photoMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = photoMF.get(i); // 0 ~
        System.out.println("multipartFile.getName(): " + multipartFile.getName());

        // if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, photoMF
        if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
          // System.out.println("전송 파일이 있습니다.");
          photo_item = Upload.saveFileSpring(multipartFile, upDir);
          sizes_item = multipartFile.getSize();

          if (Tool.isImage(photo_item)) {
            thumb_item = Tool.preview(upDir, photo_item, 120, 80); // Thumb 이미지
                                                                    // 생성
          }

          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            photo = photo + "/" + photo_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumb = thumb + "/" + thumb_item;
          } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                    // 크기 체크
            photo = photo_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumb = thumb_item; // file1_t.jpg
          }

        } // if (multipartFile.getSize() > 0) {  END
        
      }
    }
    contentsVO.setPhoto(photo);
    contentsVO.setFsize(sizes);
    contentsVO.setThumb(thumb);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------


    count = contentsProc.create(contentsVO);
    mav.setViewName(
        "redirect:/contents/create_message.jsp?count=" + count + "&boardno=" + contentsVO.getBoardno()); // /webapp/contents/create_message.jsp

    // mav.setViewName("redirect:/contents/list_by_board_search_paging.do?boardno="
    // + contentsVO.getBoardno());
    // mav.setViewName("redirect:/contents/list_all_board.do");

    return mav;
  }

  /**
   * 전체 목록
   * 
   * @return
   */
  // http://localhost:9090/ojt/contents/list_all_board.do
  @RequestMapping(value = "/contents/list_all_board.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    List<ContentsVO> list = contentsProc.list_all_board();
    mav.addObject("list", list);

    mav.setViewName("/contents/list_all_board"); // /webapp/contents/list_all_board.jsp

    return mav;
  }

  /**
   * 카테고리별 목록
   * 
   * @return
   */
  // http://localhost:9090/ojt/contents/list_by_board.do?boardno=1
  @RequestMapping(value = "/contents/list_by_board.do", method = RequestMethod.GET)
  public ModelAndView list_by_board(int boardno) {
    ModelAndView mav = new ModelAndView();

    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);

    List<ContentsVO> list = contentsProc.list_by_board(boardno);
    mav.addObject("list", list);

    mav.setViewName("/contents/list_by_board"); // /webapp/contents/list_by_board.jsp

    return mav;
  }

  /**
   * 조회
   * 
   * @param contentsno
   * @return
   */
  @RequestMapping(value = "/contents/read.do", method = RequestMethod.GET)
  public ModelAndView read(int contentsno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/contents/read"); // /webapp/contents/read.jsp

    ContentsVO contentsVO = contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO);

    BoardVO boardVO = boardProc.read(contentsVO.getBoardno()); // 카테고리
                                                               // 정보
                                                               // 추출
    mav.addObject("boardVO", boardVO);

    ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);

    mav.addObject("file_list", file_list);

    return mav;
  }

  // ZIP 압축 후 파일 다운로드
  @RequestMapping(value = "/contents/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int contentsno) {
    ModelAndView mav = new ModelAndView();

    ContentsVO contentsVO = contentsProc.read(contentsno);

    String photo = contentsVO.getPhoto();
    String[] photo_array = photo.split("/");

    String dir = "/contents/storage";
    String upDir = Tool.getRealPath(request, dir);

    String zip = "download_photo.zip";
    String zip_filename = upDir + zip;

    String[] zip_src = new String[photo_array.length]; // 파일 갯수만큼 배열 선언

    for (int i = 0; i < photo_array.length; i++) {
      zip_src[i] = upDir + "/" + photo_array[i]; // 절대 경로 조합
    }

    byte[] buffer = new byte[4096]; // 4 KB

    try {
      ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zip_filename));

      for (int index = 0; index < zip_src.length; index++) {
        FileInputStream in = new FileInputStream(zip_src[index]);

        Path path = Paths.get(zip_src[index]);
        String zip_src_file = path.getFileName().toString();
        // System.out.println("zip_src_file: " + zip_src_file);

        ZipEntry zipEntry = new ZipEntry(zip_src_file);
        zipOutputStream.putNextEntry(zipEntry);

        int length = 0;
        // 4 KB씩 읽어서 buffer 배열에 저장후 읽은 바이트수를 length에 저장
        while ((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // 기록할 내용, 내용에서의 시작 위치, 기록할
                                                    // 길이

        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();

      File file = new File(zip_filename);

      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + "이 압축되어 생성되었습니다.");
      }

      // if (file.delete() == true) {
      // System.out.println(zip_filename + " 파일을 삭제했습니다.");
      // }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    // download 서블릿 연결
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);

    return mav;
  }

  /**
   * 다중 파일 수정 폼 http://localhost:9090/contents/contents/update.do
   * 
   * @param contentsno
   * @return
   */
  @RequestMapping(value = "/contents/update.do", method = RequestMethod.GET)
  public ModelAndView update(int contentsno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/contents/update"); // /webapp/contents/update.jsp

    ContentsVO contentsVO = contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO);

    BoardVO boardVO = boardProc.read(contentsVO.getBoardno()); // 카테고리
                                                                                   // 정보
                                                                                   // 추출
    mav.addObject("boardVO", boardVO);

    ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);

    mav.addObject("file_list", file_list);

    return mav;
  }

  
  /**
   * - 글만 수정하는 경우의 구현 - 파일만 수정하는 경우의 구현 - 글과 파일을 동시에 수정하는 경우의 구현
   * 
   * @param request
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/contents/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, HttpServletRequest request, ContentsVO contentsVO) {
    ModelAndView mav = new ModelAndView();

    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/contents/storage");
    List<MultipartFile> photoMF = contentsVO.getPhotoMF(); // Spring이 File 객체를
                                                           // 저장해둠.

    // System.out.println("--> photoMF.get(0).getSize(): " +
    // photoMF.get(0).getSize());

    String photo = ""; // 컬럼에 저장할 파일명
    String photo_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0; // 하나의 파일 사이즈
    String thumb = ""; // Thumb 파일들
    String thumb_item = ""; // 하나의 Thumb 파일명

    int count = photoMF.size(); // 업로드된 파일 갯수

    // 기존의 등록 정보 조회
    ContentsVO contentsVO_old = contentsProc.read(contentsVO.getContentsno());
    if (photoMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumb 파일 삭제
      String thumb_old = contentsVO_old.getThumb();
      
      if(thumb_old != null) {
        StringTokenizer thumb_st = new StringTokenizer(thumb_old, "/");
        while (thumb_st.hasMoreTokens()) {
          String fname = upDir + thumb_st.nextToken();
          Tool.deleteFile(fname);
        }
  
        // 원본 파일 삭제
        String photo_old = contentsVO_old.getPhoto();
        StringTokenizer photo_st = new StringTokenizer(photo_old, "/");
        while (photo_st.hasMoreTokens()) {
          String fname = upDir + photo_st.nextToken();
          Tool.deleteFile(fname);
        }
      }

      // --------------------------------------------
      // 새로운 파일의 등록 시작
      // --------------------------------------------
      // for (MultipartFile multipartFile: photoMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = photoMF.get(i); // 0 ~
        System.out.println("multipartFile.getName(): " + multipartFile.getName());

        // if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, photoMF
        if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
          // System.out.println("전송 파일이 있습니다.");
          photo_item = Upload.saveFileSpring(multipartFile, upDir);
          sizes_item = multipartFile.getSize();

          if (Tool.isImage(photo_item)) {
            thumb_item = Tool.preview(upDir, photo_item, 120, 80); // Thumb 이미지
                                                                    // 생성
          }

          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            photo = photo + "/" + photo_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumb = thumb + "/" + thumb_item;
          } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                    // 크기 체크
            photo = photo_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumb = thumb_item; // file1_t.jpg
          }

        }
      } // for END
      // --------------------------------------------
      // 새로운 파일의 등록 종료
      // --------------------------------------------

    } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
      photo = contentsVO_old.getPhoto();
      sizes = contentsVO_old.getFsize();
      thumb = contentsVO_old.getThumb();
    }
    contentsVO.setPhoto(photo);
    contentsVO.setFsize(sizes);
    contentsVO.setThumb(thumb);

    contentsVO.setMemberno(1); // 회원 개발후 session으로 변경

    count = contentsProc.update(contentsVO);

    redirectAttributes.addAttribute("count", count);

    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("contentsno", contentsVO.getContentsno());
    redirectAttributes.addAttribute("boardno", contentsVO.getBoardno());

    mav.setViewName("redirect:/contents/update_message.jsp");

    return mav;

  }

  /**
   * 삭제 폼 http://localhost:9090/contents/contents/delete.do
   * 
   * @param contentsno
   * @param boardno
   * @return
   */
  @RequestMapping(value = "/contents/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int contentsno, int boardno) {
    // System.out.println("--> delete() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/contents/delete"); // /webapp/contents/delete.jsp

    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);

    ContentsVO contentsVO = contentsProc.read(contentsno);
    mav.addObject("contentsVO", contentsVO);

    return mav;
  }

  @RequestMapping(value = "/contents/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                        HttpServletRequest request, 
                                        int boardno,
                                        int contentsno, 
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage 
      ) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/contents/delete_message"); // /webapp/contents/delete_message.jsp

    String upDir = Tool.getRealPath(request, "/contents/storage"); // 저장 폴더 절대
                                                                   // 경로

    ContentsVO contentsVO = contentsProc.read(contentsno); // 삭제할 파일 정보를 읽기 위한
                                                           // 목적

    String thumb_old = contentsVO.getThumb();
    String photo_old = contentsVO.getPhoto();

    if(thumb_old != null) {
      StringTokenizer thumb_st = new StringTokenizer(thumb_old, "/"); // Thumbs
      while (thumb_st.hasMoreTokens()) { // 단어가 있는지 검사
        String fname = upDir + thumb_st.nextToken(); // 단어 추출
        Tool.deleteFile(fname);
      }
  
      StringTokenizer photo_st = new StringTokenizer(photo_old, "/"); // photo
      while (photo_st.hasMoreTokens()) { // 단어가 있는지 검사
        String fname = upDir + photo_st.nextToken(); // 단어 추출
        Tool.deleteFile(fname);
      }
    }

    int count = contentsProc.delete(contentsno); // 레코드 삭제

    if (count == 1) {
      // 4개의 레코드가 하나의 페이지인경우 5번째 레코드가 삭제되면 페이지수도
      // 2페이지에서 1 페이지로 줄여야합니다. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("boardno", boardno); // #{boardno}
      if (contentsProc.search_count(hashMap) % Contents.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
      
    }

    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("contentsno", contentsVO.getContentsno());
    redirectAttributes.addAttribute("boardno", contentsVO.getBoardno());
    redirectAttributes.addAttribute("nowPage", nowPage);

    mav.setViewName("redirect:/contents/delete_message.jsp");

    return mav;
  }

  /**
   * 검색 목록
   * 
   * @param boardno
   * @param word
   * @return
   */
  @RequestMapping(value = "/contents/list_by_board_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_board_search(int boardno, String word) {
    ModelAndView mav = new ModelAndView();

    // 검색 기능 추가, webapp/contents/list_by_board_search.jsp
    mav.setViewName("/contents/list_by_board_search");

    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("boardno", boardno); // #{boardno}
    hashMap.put("word", word); // #{word}

    // System.out.println("boardno: " + boardno);
    // System.out.println("word_find: " + word_find);

    // 검색 목록
    List<ContentsVO> list = contentsProc.list_by_board_search(hashMap);
    mav.addObject("list", list);

    // 검색된 레코드 갯수
    int search_count = contentsProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);

    // mav.addObject("word", word);

    return mav;
  }


  /**
   * 목록 + 검색 + 페이징 지원
   * @param boardno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/contents/list_by_board_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_board_search_paging(
      @RequestParam(value="boardno") int boardno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    // System.out.println("--> list_by_board() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/contents/list_by_board_search_paging.jsp
    mav.setViewName("/contents/list_by_board_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("boardno", boardno); // #{boardno}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    List<ContentsVO> list = contentsProc.list_by_board_search_paging(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = contentsProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
  
    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);
    
    // mav.addObject("word", word);
  
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param boardno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = contentsProc.paging(boardno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  
  ///// 댓글 관련 Controller 시작 /////
  

  @RequestMapping(value = "/contents/reply_create.do", method = RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttribute, ReplyVO replyVO,
                             @RequestParam(value="word", defaultValue="") String word,
                             @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    ContentsVO contentsVO = contentsProc.read(replyVO.getContentsno());
    int count = contentsProc.reply_create(replyVO);
    
    redirectAttribute.addAttribute("contentsno", contentsVO.getContentsno());
    redirectAttribute.addAttribute("boardno", contentsVO.getBoardno());
    redirectAttribute.addAttribute("word", word);
    redirectAttribute.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/contents/read.do");
    
    return mav;
  }
  
  /**
   * 댓글 등록 처리
   * 
   * @param request
   * @param replyVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/contents/reply_create_json.do",
                  method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity reply_create(HttpServletRequest request, ReplyVO replyVO) {
    HttpHeaders responseHeaders = new HttpHeaders();
    
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();

    int count = contentsProc.reply_create(replyVO);
    if(count == 1) {
      msgs.put("댓글을 등록했습니다.");
    } else {
      msgs.put("댓글 등록에 실패했습니다.");
    }
    json.put("msgs", msgs);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  
  @ResponseBody
  @RequestMapping(value = "/contents/reply_update.do", 
                           method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String reply_update(int replyno) {
    ReplyVO replyVO = contentsProc.reply_read(replyno);
    
    JSONObject obj = new JSONObject(replyVO);
    
    return obj.toString();
  }
  
  
  @ResponseBody
  @RequestMapping(value = "/contents/reply_update_json.do",
                  method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public ResponseEntity reply_update(ReplyVO replyVO) {
    HttpHeaders responseHeaders = new HttpHeaders();
    
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();

    int count = contentsProc.reply_update(replyVO);
    
    if(count == 1) {
      msgs.put("댓글을 수정했습니다.");
    } else {
      msgs.put("댓글 수정에 실패했습니다.");
    }
    json.put("msgs", msgs);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }

  
  @ResponseBody
  @RequestMapping(value="/contents/reply_delete.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public ResponseEntity reply_delete(int replyno) {
    HttpHeaders responseHeaders = new HttpHeaders();
    ReplyVO replyVO = contentsProc.reply_read(replyno);
    JSONObject obj = new JSONObject(replyVO);
    
    return new ResponseEntity(obj.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  
  @ResponseBody
  @RequestMapping(value = "/contents/reply_delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public ResponseEntity delete_proc(int replyno) {
    HttpHeaders responseHeaders = new HttpHeaders();
   
    int count = contentsProc.reply_delete(replyno);
   
    JSONObject json = new JSONObject();
    JSONArray msgs = new JSONArray();
    if (count == 1) {
      msgs.put("댓글을 삭제했습니다.");
    } else {
      msgs.put("댓글 삭제에 실패했습니다.");
    }
    json.put("msgs", msgs);

   return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
 }
  
  @ResponseBody
  @RequestMapping(value = "/contents/reply_by_contents.do",
                  method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public ResponseEntity reply_by_contents(int contentsno){
    HttpHeaders responseHeaders = new HttpHeaders();
    
    List<ReplyVO> list = contentsProc.reply_by_contents(contentsno);
    JSONArray json = new JSONArray(list);
    
    return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
  }
  
  
  ///// 댓글 관련 Controller 종료 /////
}


