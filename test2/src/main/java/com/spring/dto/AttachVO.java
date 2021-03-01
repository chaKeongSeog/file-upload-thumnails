package com.spring.dto;

public class AttachVO {
	private int ano;
	private int bno;
	private String fileName;
	private String originFileName;
	private String fileType;
	private String path;
	private String id;
	private String regdate;
	
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
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
	@Override
	public String toString() {
		return "AttachVO [ano=" + ano + ", bno=" + bno + ", fileName=" + fileName + ", originFileName=" + originFileName
				+ ", fileType=" + fileType + ", path=" + path + ", id=" + id + ", regdate=" + regdate + "]";
	}
	
	
}
