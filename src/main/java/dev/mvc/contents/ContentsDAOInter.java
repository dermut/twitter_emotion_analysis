package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsDAOInter{
  
  /**
   * ������ ���
   * @param contentsVO
   * @return
   */
  public int create(ContentsVO contentsVO);

  /**
   * ��ü ���
   * @return
   */
  public List<ContentsVO> list_all_board();
  
  /**
   * ��ü �ۼ�
   * @return
   */
  public int total_count();

  /**
   * ��ȸ
   * @param contentsno
   * @return
   */
  public ContentsVO read(int contentsno);
  
  /**
   * ����ó��
   * @param vo
   * @return
   */
  public int update(ContentsVO contentsVO);
  
  /**
   * ����
   * @param contentsno
   * @return
   */
  public int delete(int contentsno);

  /**
   * board�� �˻��� ���ڵ� ����
   * @return
   */
  public int search_count(HashMap hashMap);
  
  /**
   * �˻� ��� + ����¡
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
   * �������� ��� ���� ����
   * @param contentsno
   * @return �������� ��� ����
   */
  public int count_reply_by_contents(int contentsno);
  
  public String id_by_reply(int memberno);
}











