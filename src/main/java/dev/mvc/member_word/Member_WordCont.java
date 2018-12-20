package dev.mvc.member_word;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class Member_WordCont {

  @Autowired
  @Qualifier("dev.mvc.member_word.Member_WordProc")
  private Member_WordProcInter member_wordProc = null;
  
  public Member_WordCont(){
    System.out.println("--> Member_WordCont created.");
  }
  
  // 필요한 것 : create, 
  
}
