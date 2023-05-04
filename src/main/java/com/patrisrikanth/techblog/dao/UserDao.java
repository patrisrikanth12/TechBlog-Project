package com.patrisrikanth.techblog.dao;

import java.io.InputStream;
import java.sql.*;

import org.xml.sax.InputSource;

import com.patrisrikanth.techblog.entities.User;

public class UserDao {
	private Connection con;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public boolean saveUser(User user) {
		
		boolean execStatus = false;
		
		try {
			String query = "INSERT INTO BlogUsers(name, email, password, gender, about, profile_photo) VALUES(? , ? , ? , ? , ?, ?);";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			InputStream file = null;
			
			if(user.getProfilePhoto() != null) {
				file = user.getProfilePhoto().getInputStream();
				pstmt.setBlob(6, file);
			}
			
			pstmt.executeUpdate();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return execStatus;
	}
	
	public User getUserByEmailAndPassword(String email, String password) {
		User user = null;
		try {
			String query = "select * from BlogUsers where email=? and password=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				user = new User();
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setRegDate(set.getTimestamp("reg_date"));
				user.setId(set.getInt("id"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public boolean updateUser(User user) {
		boolean execStatus =  false;
		String query = "Update BlogUsers set name=?, email=?, password=?, gender=?, about=? where id=?";
		try {
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.setInt(6, user.getId());
			pstmt.executeUpdate();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}

		return execStatus;
	}
	
	public Blob getProfilePhoto(int id) {
		Blob profilePhoto = null;
		String query = "select * from BlogUsers where id=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				profilePhoto = rs.getBlob("profile_photo");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return profilePhoto;
	}
	
	public User getUserById(int id) {
		User user = null;
		try {
			String query = "select * from BlogUsers where id=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, id);
			ResultSet set = pstmt.executeQuery();
			
			if(set.next()) {
				user = new User();
				user.setName(set.getString("name"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setRegDate(set.getTimestamp("reg_date"));
				user.setId(set.getInt("id"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
}
