package dev.mvc.contents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;

@Component("dev.mvc.contents.ContentsProc")
public class ContentsProc implements ContentsProcInter {
  @Autowired
  @Qualifier("dev.mvc.contents.ContentsDAO")
  private ContentsDAOInter contentsDAO = null;
  
  public ContentsProc() {
    System.out.println("--> ContentsProc created.");
  }

  @Override
  public int create(ContentsVO contentsVO) {
    return contentsDAO.create(contentsVO);
  }

  @Override
  public List<ContentsVO>  list_all_board() {
    return contentsDAO.list_all_board();
  }

  @Override
  public int total_count() {
    return contentsDAO.total_count();
  }

  @Override
  public List<ContentsVO> list_by_board(int boardno) {
    List<ContentsVO> list = contentsDAO.list_by_board(boardno);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ContentsVO contentsVO = list.get(i);
      contentsVO.setThumb(getThumb(contentsVO));
    }
    
    return list;
  }
  
  /**
   * �̹��� ����߿� ù��° �̹��� ���ϸ��� �����Ͽ� ����
   * @param contentsVO
   * @return
   */
  public String getThumb(ContentsVO contentsVO) {
    String thumbs = contentsVO.getThumb();
    String thumb = "";
    
    if (thumbs != null) {
      String[] thumbs_array = thumbs.split("/");
      int count = thumbs_array.length;
      
      if (count > 0) {
        thumb = thumbs_array[0];    
      }
    }
    // System.out.println("thumb: " + thumb);
    return thumb;
  }

  @Override
  public ContentsVO read(int contentsno) {
    return contentsDAO.read(contentsno);
  }

  @Override
  public ArrayList<FileVO> getThumbs(ContentsVO contentsVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String thumbs = contentsVO.getThumb(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = contentsVO.getPhoto();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = contentsVO.getSize();        // 272558/404087... 
    
    String[] thumbs_array = thumbs.split("/");  // Thumbs
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������
 
    int count = sizes_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);
 
    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }

  @Override
  public int update(ContentsVO contentsVO) {
    return contentsDAO.update(contentsVO);
  }

  @Override
  public int delete(int contentsno) {
    return contentsDAO.delete(contentsno);
  }

  @Override
  public List<ContentsVO> list_by_board_search(HashMap hashMap) {
    List<ContentsVO> list = contentsDAO.list_by_board_search(hashMap);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ContentsVO contentsVO = list.get(i);
      contentsVO.setThumb(getThumb(contentsVO));
    }
    
    return list;
  }

  @Override
  public int search_count(HashMap hashMap) {
    return contentsDAO.search_count(hashMap);
  }

  @Override
  public List<ContentsVO> list_by_board_search_paging(HashMap<String, Object> hashMap) {
    /* 
     ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
     1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
     2 ������: nowPage = 2, (2 - 1) * 10 --> 10
     3 ������: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Contents.RECORD_PER_PAGE;
    
     // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
    int endNum = beginOfPage + Contents.RECORD_PER_PAGE;   
    /*
     1 ������: WHERE r >= 1 AND r <= 10
     2 ������: WHERE r >= 11 AND r <= 20
     3 ������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("s3tartNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<ContentsVO> list = contentsDAO.list_by_board_search_paging(hashMap); 
    Iterator<ContentsVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      ContentsVO contentsVO = iter.next();
      String title = Tool.textLength(contentsVO.getName(), 90);
      title = Tool.convertChar(title); // �±� ó��
      contentsVO.setName(title);
      
      String thumbs = contentsVO.getThumb();
      if (thumbs.length() > 0) { // preview �̹����� �ִ��� �˻�
        String thumb = (thumbs.split("/"))[0]; // ù��° ���ϸ� ����
        contentsVO.setThumb(thumb);
      }
    }
    
    return list;
  }

  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param boardno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String paging(int boardno, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Contents.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Contents.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Contents.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Contents.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Contents.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Contents.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_board_search_paging.do?&word="+word+"&nowPage="+_nowPage+"&boardno="+boardno+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./list_by_board_search_paging.do?word="+word+"&nowPage="+i+"&boardno="+boardno+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Contents.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_board_search_paging.do?&word="+word+"&nowPage="+_nowPage+"&boardno="+boardno+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public int updateAnsnum(ContentsVO contentsVO) {
    int count = 0;
    count = contentsDAO.updateAnsnum(contentsVO);
    
    return count;
  }

  @Override
  public Contents_ReplyVO reply(int contentsno) {
    return contentsDAO.reply(contentsno);
  }
}










