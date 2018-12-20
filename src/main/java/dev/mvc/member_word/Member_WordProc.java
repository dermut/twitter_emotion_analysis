package dev.mvc.member_word;

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
    /*int count = member_wordDAO.*/
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
