package dev.mvc.word;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("dev.mvc.word.WordDAO") // DBMS 저장소 접근
public class WordDAO implements WordDAOInter{

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
    
    public WordDAO() {
      System.out.println("--> WordDAO created.");
    }

    @Override
    public int create(String word) {
      int count = sqlSessionTemplate.insert("word.create", word);
      return count;
    }

    @Override
    public int count_by_word(String word) {
      int count = sqlSessionTemplate.selectOne("word.count_by_word", word);
      return count;
    }

    @Override
    public int count() {
      int count = sqlSessionTemplate.selectOne("word.count");
      return count;
    }

    @Override
    public List<WordVO> word_list() {
      List<WordVO> list = sqlSessionTemplate.selectList("word.word_list");
      return list;
    }

    @Override
    public int wordno_by_word(String word) {
      int num = sqlSessionTemplate.selectOne("word.wordno_by_word", word);
      return num;
    }
    
    
  
}
