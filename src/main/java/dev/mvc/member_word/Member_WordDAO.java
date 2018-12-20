package dev.mvc.member_word;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.member_word.Member_WordDAO")
public class Member_WordDAO implements Member_WordDAOInter{

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public Member_WordDAO() {
    System.out.println("--> Member_WordDAO created.");
  }

  @Override
  public int create(int memberno, int wordno) {
    /*int count = sqlSessionTemplate.insert("member_word.create", memberno, )*/
    return 0;
  }

  @Override
  public Member_WordVO wordno_by_member(int memberno) {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public Member_WordVO member_by_wordno(int wordno) {
    // TODO Auto-generated method stub
    return null;
  }
}
