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
      return sqlSessionTemplate.insert("word.create", word);
    }

    @Override
    public int count_by_word(String word) {
      return sqlSessionTemplate.selectOne("word.count_by_word", word);
    }

    @Override
    public int count() {
      return sqlSessionTemplate.selectOne("word.count");
    }

    @Override
    public List<WordVO> word_list() {
      return sqlSessionTemplate.selectList("word.word_list");
    }

    @Override
    public int wordno_by_word(String word) {
      return sqlSessionTemplate.selectOne("word.wordno_by_word", word);
    }

    @Override
    public WordVO word_by_wordno(int wordno) {
      return sqlSessionTemplate.selectOne("word.word_by_wordno", wordno);
    }

    @Override
    public int isExist(String word) {
      int count = sqlSessionTemplate.selectOne("word.isExist", word);
      return count;
    }
}
