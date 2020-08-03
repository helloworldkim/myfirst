package bbs.bbscomment;

import bbs.Bbs;

public class Comment extends Bbs {
	private int commentId;
	private String commentDate;
	private String commentContent;
	private int countBbsId;
	
	
	public int getCountBbsId() {
		return countBbsId;
	}
	public void setCountBbsId(int countBbsId) {
		this.countBbsId = countBbsId;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	
	

}
