package dev.mvc.board;

import java.util.List;

import dev.mvc.categrp.CategrpVO;

public interface BoardDAOInter {
  /**
   * 등록
   * @param categoryVO 등록할 데이터
   * @return 처리된 레코드 갯수
   */
  public abstract int create(BoardVO categoryVO);
  
  /**
   * 목록
   * @return Join 목록
   */
  public List<Categrp_BoardVO> list();
  
  /**
   * 목록
   * @param categrpno 카테고리 그룹 번호
   * @return Join 목록
   */
  public List<Categrp_BoardVO> list_by_categrp(int categrpno);

  /**
   * 한건의 레코드 조회
   * @param categrpno
   * @return
   */
  public Categrp_BoardVO read(int categoryno);
  
  /**
   * 레코드를 수정합니다.
   * @param categoryVO 
   * @return
   */
  public int update(BoardVO categoryVO);
  
  /**
   * 한건의 레코드 삭제
   * @param categoryno
   * @return
   */
  public int delete(int categoryno);
  
  /**
   * 카테고리 그룹에 따른 카운트 산출
   * @param categrpno
   * @return
   */
  public int count_by_categrp(int categrpno);

  /**
   * 카테고리 그룹에 따른 삭제
   * @param categrpno
   * @return
   */
  public int delete_by_categrp(int categrpno);
}









