package dev.mvc.categrp;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.categrp.CategrpDAO") // DBMS ����� ���� 
public class CategrpDAO implements CategrpDAOInter {
   @Autowired  // ���� �������� ���� �ڵ� �Ҵ�, �����ڴ� new ��� ����.
   private SqlSessionTemplate sqlSessionTemplate = null;
   
   public CategrpDAO() {
     System.out.println("--> CategrpDAO created.");
   }

  @Override
  public int create(CategrpVO categrpVO) {
    int count = sqlSessionTemplate.insert("categrp.create", categrpVO);
    return count;
  }

  @Override
  public List<CategrpVO> list() {
    List<CategrpVO> list = sqlSessionTemplate.selectList("categrp.list");
    
    return list;
  }

  @Override
  public CategrpVO read(int categrpno) {
    CategrpVO categrpVO = sqlSessionTemplate.selectOne("categrp.read", categrpno);
    return categrpVO;
  }

  @Override
  public int update(CategrpVO categrpVO) {
    int count = sqlSessionTemplate.update("categrp.update", categrpVO);
    return count;
  }

  @Override
  public int delete(int categrpno) {
    return sqlSessionTemplate.delete("categrp.delete", categrpno);
  }

  @Override
  public int count_by_categrp(int categrpno) {
    return sqlSessionTemplate.selectOne("categrp.count_by_categrp", categrpno);
  } 
}






