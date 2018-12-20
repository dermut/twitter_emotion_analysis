package dev.mvc.crawling_data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.crawling_data.CrawlingProc")
public class CrawlingProc implements CrawlingProcInter {
  @Autowired
  @Qualifier("dev.mvc.crawling_data.CrawlingDAO")
  private CrawlingDAOInter crawlingDAO = null;
  
  public CrawlingProc() {
    System.out.println("--> CrawlingProc created.");
  }
  
  @Override
  public int create(CrawlingVO crawlingDataVO) {
    return crawlingDAO.create(crawlingDataVO);
  }

  @Override
  public List<CrawlingVO> list() {
    return crawlingDAO.list();
  }

  @Override
  public List<CrawlingVO> list_by_content(String word) {
    return crawlingDAO.list_by_content(word);
  }

  @Override
  public int count() {
    return crawlingDAO.count();
  }

  @Override
  public CrawlingVO read(int crno) {
    return crawlingDAO.read(crno);
  }

  @Override
  public int delete(int crno) {
    return crawlingDAO.delete(crno);
  }

  @Override
  public int delete_by_rdate(String rdate) {
    return crawlingDAO.delete_by_rdate(rdate);
  }
  
}
