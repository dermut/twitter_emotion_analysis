package dev.mvc.member_word;

import java.util.List;
import java.util.Map;

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
  public int create(Map<String, Object> map) {
    int count = sqlSessionTemplate.insert("member_word.create", map);
    return count; 
  }

  @Override
  public List<Word_MemberWordVO> wordno_by_member(int memberno) {
    List<Word_MemberWordVO> list = sqlSessionTemplate.selectList("member_word.wordno_by_member", memberno);
    return list;
  }

  @Override
  public List<Word_MemberWordVO> member_by_wordno(int wordno) {
    List<Word_MemberWordVO> list = sqlSessionTemplate.selectList("member_word.member_by_wordno", wordno);
    return list; 
  }
}
