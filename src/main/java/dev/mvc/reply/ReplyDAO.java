package dev.mvc.reply;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.reply.ReplyDAO") // DBMS 저장소 접근 
public class ReplyDAO implements ReplyDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ReplyDAO() {
    System.out.println("--> ReplyDAO created.");
  }
  
  @Override
  public int create(ReplyVO replyVO) {
    return sqlSessionTemplate.insert("reply.create", replyVO);
  }

  @Override
  public ReplyVO read(int contentsno) {
    return null;
  }
}
