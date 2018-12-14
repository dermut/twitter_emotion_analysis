package dev.mvc.reply;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyDAO")
  private ReplyDAOInter replyDAO = null;

  @Override
  public int create(ReplyVO replyVO) {
    return replyDAO.create(replyVO);
  }
}