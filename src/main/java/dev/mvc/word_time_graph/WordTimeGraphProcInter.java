package dev.mvc.word_time_graph;

import java.util.List;

public interface WordTimeGraphProcInter {

  public int create(WordTimeGraphVO wordTimeGraphVO);
  
  public int increase_freq(int word_time_no);
  
  public List<WordTimeGraphVO> list();
}
