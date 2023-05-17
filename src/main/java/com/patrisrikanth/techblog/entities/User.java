package com.patrisrikanth.techblog.entities;

import java.sql.Timestamp;

import jakarta.servlet.http.Part;

import jakarta.validation.constraints.*;

public class User {
	private int id;
	
	@NotBlank(message = "Name is required")
	private String name;
	
	@NotBlank(message = "Email is required")
	@Email(message= "Please enter valid email")
	private String email;
	
	@NotBlank(message="Password can't be empty")
	@Size(min=8, max=24, message="Password should atleast contain 8 characters and atmost 24 characters")
	private String password;
	
	@NotBlank(message="Gender is required")
	private String gender;
	
	private String about;
	
	private Part profilePhoto;
	
	private Timestamp regDate;
	
	public User() {
		
	}
	
	public User(int id, String name, String email, String password, String gender, String about, Part profilePhoto,
			Timestamp regDate) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.about = about;
		this.profilePhoto = profilePhoto;
		this.regDate = regDate;
	}

	public User(String name, String email, String password, String gender, String about, Part profilePhoto) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.gender = gender;
		this.about = about;
		this.profilePhoto = profilePhoto;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}
	
	public Part getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(Part profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
}
