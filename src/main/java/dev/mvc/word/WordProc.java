package dev.mvc.word;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Component("dev.mvc.word.WordProc")
public class WordProc implements WordProcInter{

  @Autowired
  @Qualifier("dev.mvc.word.WordDAO")
  private WordDAOInter wordDAO = null;
  
  public WordProc(){
    System.out.println("--> WordProc created.");
  }

  @Override
  public int create(String word) {
    return wordDAO.create(word);
  }

  @Override
  public int count_by_word(String word) {
    return wordDAO.count_by_word(word);
  }

  @Override
  public int count() {
    return wordDAO.count();
  }

  @Override
  public List<WordVO> word_list() {
    return wordDAO.word_list();
  }
  
  @Override
  public int wordno_by_word(String word){
    return wordDAO.wordno_by_word(word);
  }

  @Override
  public int search_word(String word) {
    return wordDAO.search_word(word);
  }
  
  
}
