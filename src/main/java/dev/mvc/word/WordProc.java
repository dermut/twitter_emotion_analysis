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
    int count = wordDAO.create(word);
    return count;
  }

  @Override
  public int count_by_word(String word) {
    int count = wordDAO.count_by_word(word);
    return count;
  }

  @Override
  public int count() {
    int count = wordDAO.count();
    return count;
  }

  @Override
  public List<WordVO> word_list() {
    List<WordVO> list = wordDAO.word_list();
    return list;
  }
  
  @Override
  public int wordno_by_word(String word){
    int num = wordDAO.wordno_by_word(word);
    return num;
  }
  
  
}
