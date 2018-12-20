package dev.mvc.reply;

public interface ReplyDAOInter {
  public int create(ReplyVO replyVO);
  
  public ReplyVO read(int contentsno);
}
