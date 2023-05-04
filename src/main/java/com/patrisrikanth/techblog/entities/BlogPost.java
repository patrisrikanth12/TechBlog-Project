package com.patrisrikanth.techblog.entities;

import java.sql.Timestamp;

public class BlogPost {
	private int id;
	private int cid;
	private int uid;
	private String title;
	private String body;
	private Timestamp regDate;
	
	public BlogPost() {
		
	}
	
	public BlogPost(int id, int cid, int uid, String title, String body, Timestamp regDate) {
		super();
		this.id = id;
		this.cid = cid;
		this.uid = uid;
		this.title = title;
		this.body = body;
		this.regDate = regDate;
	}

	public BlogPost(int cid, int uid, String title, String body) {
		super();
		this.cid = cid;
		this.uid = uid;
		this.title = title;
		this.body = body;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
}
