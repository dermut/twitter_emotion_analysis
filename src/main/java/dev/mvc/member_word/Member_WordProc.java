package dev.mvc.member_word;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member_word.Member_WordProc")
public class Member_WordProc implements Member_WordProcInter{

  @Autowired
  @Qualifier("dev.mvc.member_word.Member_WordDAO")
  private Member_WordDAOInter member_wordDAO = null;
  
  public Member_WordProc(){
    System.out.println("--> Member_WordProc created");
  }
  
  @Override
  public int create(int memberno, int wordno) {
    /*여기서 맵 이용*/
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("wordno", wordno);
    
    int count = member_wordDAO.create(map);
    
    return count;
  }

  @Override 
  public List<Word_MemberWordVO> wordno_by_member(int memberno) {
    List<Word_MemberWordVO> list = member_wordDAO.wordno_by_member(memberno);
    return list;
  }

  @Override
  public List<Word_MemberWordVO> member_by_wordno(int wordno) {
    List<Word_MemberWordVO> list = member_wordDAO.member_by_wordno(wordno);
    return list; 
  }

}
