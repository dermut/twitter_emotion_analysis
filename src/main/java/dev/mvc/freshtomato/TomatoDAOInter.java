package dev.mvc.freshtomato;

public interface TomatoDAOInter {
  /**
   * 생성
   * @param tomatoVO
   * @return
   */
  public int create(TomatoVO tomatoVO);
  
  /**
   * 읽어오기
   * @param ftno
   * @return
   */
  public TomatoVO read(int ftno);
}
