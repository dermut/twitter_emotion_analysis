package dev.mvc.crawling_data;

import java.util.List;

public interface CrawlingDAOInter {
  public int create(CrawlingVO crawlingDataVO);
  
  public List<CrawlingVO> list();
  
  public List<CrawlingVO> list_by_content(String word);
  
  public int count();
  
  public CrawlingVO read(int crno);
  
  public int delete(int crno);
  
  public int delete_by_rdate(String rdate);
}
