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
   * ī�װ��� ���
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board(int boardno);
  
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
   * �˻� ���
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board_search(HashMap hashMap);

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
  
  /**
   * �ű� �亯�� �ֿ켱���� ����ϱ����� �亯 ���� ����
   * @param contentsVO
   * @return
   */
  public int updateAnsnum(ContentsVO contentsVO);
  
  /**
   * �亯
   * @param contentsVO
   * @return
   */
  public Contents_ReplyVO reply(int contentsno);

   
}











