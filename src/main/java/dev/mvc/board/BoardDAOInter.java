package dev.mvc.board;

import java.util.List;

public interface BoardDAOInter {
  /**
   * 등록
   * @param boardVO 등록할 데이터
   * @return 처리된 레코드 갯수
   */
  public abstract int create(BoardVO boardVO);
  
  /**
   * 목록
   * @return Join 목록
   */
  public List<Categrp_BoardVO> list();
  
  /**
   * 목록
   * @return 메뉴에 표시되는 목록
   */
  public List<BoardVO> list_menu();  
  
  /**
   * 목록
   * @param categrpno 카테고리 그룹 번호
   * @return Join 목록
   */
  public List<Categrp_BoardVO> list_by_categrp(int categrpno);
  
  /**
   * 목록
   * @param categrpno 카테고리 그룹 번호
   * @return Join 목록
   */
  public List<Categrp_BoardVO> list_by_categrp_id(int categrpno);

  /**
   * 한건의 레코드 조회
   * @param categrpno
   * @return
   */
  public BoardVO read(int boardno);
  
  /**
   * 레코드를 수정합니다.
   * @param boardVO 
   * @return
   */
  public int update(BoardVO boardVO);
  
  /**
   * 한건의 레코드 삭제
   * @param boardno
   * @return
   */
  public int delete(int boardno);
  
  public int delete_by_categrp(int categrpno);
  
  public int count_by_board(int boardno);

  public int delete_contents_by_board(int boardno);
  
  public String getId(int memberno);
}









