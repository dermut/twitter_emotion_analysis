package dev.mvc.word_time_graph;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class WordTimeGraphCont {

  @Autowired
  @Qualifier("dev.mvc.word_time_graph.WordTimeGraphProc")
  private WordTimeGraphProcInter wordTimeGraphProc = null;
  
  public WordTimeGraphCont() {
    System.out.println("--> WordTimeGraphCont created.");
  }
  
  
}
