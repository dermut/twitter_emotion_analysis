package dev.mvc.crawling_data;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.crawling_data.CrawlingDAO")
public class CrawlingDAO implements CrawlingDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CrawlingDAO() {
    System.out.println("--> CrawlingDAO created.");
  }
  
  @Override
  public int create(CrawlingVO crawlingDataVO) {
    return sqlSessionTemplate.insert("crawling.create", crawlingDataVO);
  }

  @Override
  public List<CrawlingVO> list() {
    return sqlSessionTemplate.selectList("crawling.list");
  }

  @Override
  public List<CrawlingVO> list_by_content(String word) {
    return sqlSessionTemplate.selectList("crawling.list_by_content", word);
  }

  @Override
  public int count() {
    return sqlSessionTemplate.selectOne("crawling.count");
  }

  @Override
  public CrawlingVO read(int crno) {
    return sqlSessionTemplate.selectOne("crawling.read", crno);
  }

  @Override
  public int delete(int crno) {
    return sqlSessionTemplate.delete("crawling.delete", crno);
  }

  @Override
  public int delete_by_rdate(String rdate) {
    return sqlSessionTemplate.delete("crawling.delete_by_rdate", rdate);
  }
  
}
