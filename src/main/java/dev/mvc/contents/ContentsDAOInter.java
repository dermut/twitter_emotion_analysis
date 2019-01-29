package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsDAOInter{
  
  /**
   * ÄÁÅÙÃ÷ µî·Ï
   * @param contentsVO
   * @return
   */
  public int create(ContentsVO contentsVO);

  /**
   * ÀüÃ¼ ¸ñ·Ï
   * @return
   */
  public List<ContentsVO> list_all_board();
  
  /**
   * ÀüÃ¼ ±Û¼ö
   * @return
   */
  public int total_count();

  /**
   * Á¶È¸
   * @param contentsno
   * @return
   */
  public ContentsVO read(int contentsno);
  
  /**
   * ¼öÁ¤Ã³¸®
   * @param vo
   * @return
   */
  public int update(ContentsVO contentsVO);
  
  /**
   * »èÁ¦
   * @param contentsno
   * @return
   */
  public int delete(int contentsno);

  /**
   * boardº° °Ë»öµÈ ·¹ÄÚµå °¹¼ö
   * @return
   */
  public int search_count(HashMap hashMap);
  
  /**
   * °Ë»ö ¸ñ·Ï + ÆäÀÌÂ¡
   * @param hashMap
   * @return
   */
  public List<ContentsVO> list_by_board_search_paging(HashMap<String, Object> hashMap);
  
  public int reply_create(ReplyVO replyVO);
  
  public List<ReplyVO> reply_list();
  
  public List<ReplyIDVO> reply_by_contents(int contentsno);
  
  public ReplyVO reply_read(int replyno);
  
  public int reply_update(ReplyVO replyVO);
  
  public int reply_delete(int replyno);
  
  /**
   * ÄÜÅÙÃ÷º° ´ñ±Û °¹¼ö ¼¼±â
   * @param contentsno
   * @return ÄÜÅÙÃ÷º° ´ñ±Û °¹¼ö
   */
  public int count_reply_by_contents(int contentsno);
  
  public String id_by_reply(int memberno);
}











