package dev.mvc.word_time_graph;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("dev.mvc.word_time_graph.WordTimeGraphDAO") // DBMS 저장소 접근
public class WordTimeGraphDAO implements WordTimeGraphDAOInter{

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate = null;
    
    public WordTimeGraphDAO() {
      System.out.println("--> WordTimeGraphDAO created.");
    }

    @Override
    public int create(WordTimeGraphVO wordTimeGraphVO) {
      return sqlSessionTemplate.insert("word_time_graph.create", wordTimeGraphVO);
    }

    @Override
    public int increase_freq(int word_time_no) {
      return sqlSessionTemplate.update("word_time_graph.increase_freq", word_time_no);
    }

    @Override
    public List<WordTimeGraphVO> list() {
      return sqlSessionTemplate.selectList("word_time_graph.list");
    }
    
    
}
