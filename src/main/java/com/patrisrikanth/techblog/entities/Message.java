package com.patrisrikanth.techblog.entities;

public class Message {
	private String data;
	private String type;
	private String cssClass;
	
	public Message(String data, String type, String cssClass) {
		super();
		this.data = data;
		this.type = type;
		this.cssClass = cssClass;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCssClass() {
		return cssClass;
	}
	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}
	
	
}
