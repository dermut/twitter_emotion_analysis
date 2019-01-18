package dev.mvc.word_time_graph;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Component("dev.mvc.word_time_graph.WordTimeGraphProc")
public class WordTimeGraphProc implements WordTimeGraphProcInter{

  @Autowired
  @Qualifier("dev.mvc.word_time_graph.WordTimeGraphDAO")
  private WordTimeGraphDAOInter wordTimeGraphDAO = null;
  
  public WordTimeGraphProc(){
    System.out.println("--> WordTimeGraphProc created.");
  }

  @Override
  public int create(WordTimeGraphVO wordTimeGraphVO) {
    return wordTimeGraphDAO.create(wordTimeGraphVO);
  }

  @Override
  public int increase_freq(int word_time_no) {
    return wordTimeGraphDAO.increase_freq(word_time_no);
  }

  @Override
  public List<WordTimeGraphVO> list() {
    return wordTimeGraphDAO.list();
  }
  
  
}
