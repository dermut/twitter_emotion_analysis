package dev.mvc.contents;

import java.util.HashMap;
import java.util.List;

public interface ContentsDAOInter{
  
  /**
   * 컨텐츠 등록
   * @param contentsVO
   * @return
   */
  public int create(ContentsVO contentsVO);

  /**
   * 전체 목록
   * @return
   */
  public List<ContentsVO> list_all_board();
  
  /**
   * 전체 글수
   * @return
   */
  public int total_count();
  
  /**
   * 카테고리별 목록
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board(int boardno);
  
  /**
   * 조회
   * @param contentsno
   * @return
   */
  public ContentsVO read(int contentsno);
  
  /**
   * 수정처리
   * @param vo
   * @return
   */
  public int update(ContentsVO contentsVO);
  
  /**
   * 삭제
   * @param contentsno
   * @return
   */
  public int delete(int contentsno);
  
  /**
   * 검색 목록
   * @param boardno
   * @return
   */
  public List<ContentsVO> list_by_board_search(HashMap hashMap);

  /**
   * board별 검색된 레코드 갯수
   * @return
   */
  public int search_count(HashMap hashMap);
  
  /**
   * 검색 목록 + 페이징
   * @param hashMap
   * @return
   */
  public List<ContentsVO> list_by_board_search_paging(HashMap<String, Object> hashMap);
  
  /**
   * 신규 답변을 최우선으로 출력하기위한 답변 순서 조절
   * @param contentsVO
   * @return
   */
  public int updateAnsnum(ContentsVO contentsVO);
  
  /**
   * 답변
   * @param contentsVO
   * @return
   */
  public Contents_ReplyVO reply(int contentsno);

   
}











