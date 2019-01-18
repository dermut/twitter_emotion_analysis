package dev.mvc.freshtomato;

public interface TomatoDAOInter {
  public int create(TomatoVO tomatoVO);
  
  public TomatoVO read(int ftno);
}
