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
   * ��� �� http://localhost:9090/tea/contents/create.do
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
   * ��� ó��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/contents/storage");
    List<MultipartFile> photoMF = contentsVO.getPhotoMF(); // Spring�� File ��ü��
                                                           // �����ص�.


//     System.out.println("--> photoMF.get(0).getSize(): " +
//     photoMF.get(0).getSize());

    String photo = ""; // �÷��� ������ ���ϸ�
    String photo_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";
    long sizes_item = 0; // �ϳ��� ���� ������
    String thumb = ""; // Thumb ���ϵ�
    String thumb_item = ""; // �ϳ��� Thumb ���ϸ�

    int count = photoMF.size(); // ���ε�� ���� ����

//     Spring�� ���� ������ ���ص� 1���� MultipartFile ��ü�� ������.
     System.out.println("--> ���ε�� ���� ���� count: " + count);

    if (count > 0) { // ���� ������ �����Ѵٸ�
      // for (MultipartFile multipartFile: photoMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = photoMF.get(i); // 0 ~
        System.out.println("multipartFile.getName(): " + multipartFile.getName());

        // if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, photoMF
        if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
          // System.out.println("���� ������ �ֽ��ϴ�.");
          photo_item = Upload.saveFileSpring(multipartFile, upDir);
          sizes_item = multipartFile.getSize();

          if (Tool.isImage(photo_item)) {
            thumb_item = Tool.preview(upDir, photo_item, 120, 80); // Thumb �̹���
                                                                    // ����
          }

          if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
            // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
            photo = photo + "/" + photo_item;
            // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumb = thumb + "/" + thumb_item;
          } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                    // ũ�� üũ
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
    // ���� ���� �ڵ� ����
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
   * ��ü ���
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
   * ī�װ��� ���
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
   * ��ȸ
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

    BoardVO boardVO = boardProc.read(contentsVO.getBoardno()); // ī�װ�
                                                               // ����
                                                               // ����
    mav.addObject("boardVO", boardVO);

    ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);

    mav.addObject("file_list", file_list);

    return mav;
  }

  // ZIP ���� �� ���� �ٿ�ε�
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

    String[] zip_src = new String[photo_array.length]; // ���� ������ŭ �迭 ����

    for (int i = 0; i < photo_array.length; i++) {
      zip_src[i] = upDir + "/" + photo_array[i]; // ���� ��� ����
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
        // 4 KB�� �о buffer �迭�� ������ ���� ����Ʈ���� length�� ����
        while ((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // ����� ����, ���뿡���� ���� ��ġ, �����
                                                    // ����

        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();

      File file = new File(zip_filename);

      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + "�� ����Ǿ� �����Ǿ����ϴ�.");
      }

      // if (file.delete() == true) {
      // System.out.println(zip_filename + " ������ �����߽��ϴ�.");
      // }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }

    // download ���� ����
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);

    return mav;
  }

  /**
   * ���� ���� ���� �� http://localhost:9090/contents/contents/update.do
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

    BoardVO boardVO = boardProc.read(contentsVO.getBoardno()); // ī�װ�
                                                                                   // ����
                                                                                   // ����
    mav.addObject("boardVO", boardVO);

    ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);

    mav.addObject("file_list", file_list);

    return mav;
  }

  
  /**
   * - �۸� �����ϴ� ����� ���� - ���ϸ� �����ϴ� ����� ���� - �۰� ������ ���ÿ� �����ϴ� ����� ����
   * 
   * @param request
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/contents/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, HttpServletRequest request, ContentsVO contentsVO) {
    ModelAndView mav = new ModelAndView();

    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/contents/storage");
    List<MultipartFile> photoMF = contentsVO.getPhotoMF(); // Spring�� File ��ü��
                                                           // �����ص�.

    // System.out.println("--> photoMF.get(0).getSize(): " +
    // photoMF.get(0).getSize());

    String photo = ""; // �÷��� ������ ���ϸ�
    String photo_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";
    long sizes_item = 0; // �ϳ��� ���� ������
    String thumb = ""; // Thumb ���ϵ�
    String thumb_item = ""; // �ϳ��� Thumb ���ϸ�

    int count = photoMF.size(); // ���ε�� ���� ����

    // ������ ��� ���� ��ȸ
    ContentsVO contentsVO_old = contentsProc.read(contentsVO.getContentsno());
    if (photoMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumb ���� ����
      String thumb_old = contentsVO_old.getThumb();
      
      if(thumb_old != null) {
        StringTokenizer thumb_st = new StringTokenizer(thumb_old, "/");
        while (thumb_st.hasMoreTokens()) {
          String fname = upDir + thumb_st.nextToken();
          Tool.deleteFile(fname);
        }
  
        // ���� ���� ����
        String photo_old = contentsVO_old.getPhoto();
        StringTokenizer photo_st = new StringTokenizer(photo_old, "/");
        while (photo_st.hasMoreTokens()) {
          String fname = upDir + photo_st.nextToken();
          Tool.deleteFile(fname);
        }
      }

      // --------------------------------------------
      // ���ο� ������ ��� ����
      // --------------------------------------------
      // for (MultipartFile multipartFile: photoMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = photoMF.get(i); // 0 ~
        System.out.println("multipartFile.getName(): " + multipartFile.getName());

        // if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, photoMF
        if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
          // System.out.println("���� ������ �ֽ��ϴ�.");
          photo_item = Upload.saveFileSpring(multipartFile, upDir);
          sizes_item = multipartFile.getSize();

          if (Tool.isImage(photo_item)) {
            thumb_item = Tool.preview(upDir, photo_item, 120, 80); // Thumb �̹���
                                                                    // ����
          }

          if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
            // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
            photo = photo + "/" + photo_item;
            // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumb = thumb + "/" + thumb_item;
          } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                    // ũ�� üũ
            photo = photo_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumb = thumb_item; // file1_t.jpg
          }

        }
      } // for END
      // --------------------------------------------
      // ���ο� ������ ��� ����
      // --------------------------------------------

    } else { // �۸� �����ϴ� ���, ������ ���� ���� ����
      photo = contentsVO_old.getPhoto();
      sizes = contentsVO_old.getFsize();
      thumb = contentsVO_old.getThumb();
    }
    contentsVO.setPhoto(photo);
    contentsVO.setFsize(sizes);
    contentsVO.setThumb(thumb);

    contentsVO.setMemberno(1); // ȸ�� ������ session���� ����

    count = contentsProc.update(contentsVO);

    redirectAttributes.addAttribute("count", count);

    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("contentsno", contentsVO.getContentsno());
    redirectAttributes.addAttribute("boardno", contentsVO.getBoardno());

    mav.setViewName("redirect:/contents/update_message.jsp");

    return mav;

  }

  /**
   * ���� �� http://localhost:9090/contents/contents/delete.do
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

    String upDir = Tool.getRealPath(request, "/contents/storage"); // ���� ���� ����
                                                                   // ���

    ContentsVO contentsVO = contentsProc.read(contentsno); // ������ ���� ������ �б� ����
                                                           // ����

    String thumb_old = contentsVO.getThumb();
    String photo_old = contentsVO.getPhoto();

    if(thumb_old != null) {
      StringTokenizer thumb_st = new StringTokenizer(thumb_old, "/"); // Thumbs
      while (thumb_st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
        String fname = upDir + thumb_st.nextToken(); // �ܾ� ����
        Tool.deleteFile(fname);
      }
  
      StringTokenizer photo_st = new StringTokenizer(photo_old, "/"); // photo
      while (photo_st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
        String fname = upDir + photo_st.nextToken(); // �ܾ� ����
        Tool.deleteFile(fname);
      }
    }

    int count = contentsProc.delete(contentsno); // ���ڵ� ����

    if (count == 1) {
      // 4���� ���ڵ尡 �ϳ��� �������ΰ�� 5��° ���ڵ尡 �����Ǹ� ����������
      // 2���������� 1 �������� �ٿ����մϴ�. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("boardno", boardno); // #{boardno}
      if (contentsProc.search_count(hashMap) % Contents.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
      
    }

    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("contentsno", contentsVO.getContentsno());
    redirectAttributes.addAttribute("boardno", contentsVO.getBoardno());
    redirectAttributes.addAttribute("nowPage", nowPage);

    mav.setViewName("redirect:/contents/delete_message.jsp");

    return mav;
  }

  /**
   * �˻� ���
   * 
   * @param boardno
   * @param word
   * @return
   */
  @RequestMapping(value = "/contents/list_by_board_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_board_search(int boardno, String word) {
    ModelAndView mav = new ModelAndView();

    // �˻� ��� �߰�, webapp/contents/list_by_board_search.jsp
    mav.setViewName("/contents/list_by_board_search");

    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("boardno", boardno); // #{boardno}
    hashMap.put("word", word); // #{word}

    // System.out.println("boardno: " + boardno);
    // System.out.println("word_find: " + word_find);

    // �˻� ���
    List<ContentsVO> list = contentsProc.list_by_board_search(hashMap);
    mav.addObject("list", list);

    // �˻��� ���ڵ� ����
    int search_count = contentsProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);

    // mav.addObject("word", word);

    return mav;
  }


  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/contents/list_by_board_search_paging.jsp
    mav.setViewName("/contents/list_by_board_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("boardno", boardno); // #{boardno}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);       
    
    // �˻� ���
    List<ContentsVO> list = contentsProc.list_by_board_search_paging(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = contentsProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
  
    BoardVO boardVO = boardProc.read(boardno);
    mav.addObject("boardVO", boardVO);
    
    // mav.addObject("word", word);
  
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param boardno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = contentsProc.paging(boardno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  
  ///// ��� ���� Controller ���� /////
  

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
   * ��� ��� ó��
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
      msgs.put("����� ����߽��ϴ�.");
    } else {
      msgs.put("��� ��Ͽ� �����߽��ϴ�.");
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
      msgs.put("����� �����߽��ϴ�.");
    } else {
      msgs.put("��� ������ �����߽��ϴ�.");
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
      msgs.put("����� �����߽��ϴ�.");
    } else {
      msgs.put("��� ������ �����߽��ϴ�.");
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
  
  
  ///// ��� ���� Controller ���� /////
}


