package dev.mvc.freshtomato;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.freshtomato.TomatoDAO")
public class TomatoDAO implements TomatoDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  @Override
  public int create(TomatoVO tomatoVO) {
    return sqlSessionTemplate.insert("freshtomato.create", tomatoVO);
  }

  @Override
  public TomatoVO read(int ftno) {
    return sqlSessionTemplate.selectOne("freshtomato.read", ftno);
  }
  
}
