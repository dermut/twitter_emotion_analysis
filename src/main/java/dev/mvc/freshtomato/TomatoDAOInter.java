package dev.mvc.freshtomato;

public interface TomatoDAOInter {
  /**
   * ����
   * @param tomatoVO
   * @return
   */
  public int create(TomatoVO tomatoVO);
  
  /**
   * �о����
   * @param ftno
   * @return
   */
  public TomatoVO read(int ftno);
}
