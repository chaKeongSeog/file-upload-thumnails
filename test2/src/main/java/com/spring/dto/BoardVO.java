package com.spring.dto;

import java.util.List;

public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String id;
	private String regdate;
	private List<AttachVO> attach;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public List<AttachVO> getAttach() {
		return attach;
	}
	public void setAttach(List<AttachVO> attach) {
		this.attach = attach;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", id=" + id + ", regdate="
				+ regdate + ", attach=" + attach + "]";
	}
	
	
	
	
}
