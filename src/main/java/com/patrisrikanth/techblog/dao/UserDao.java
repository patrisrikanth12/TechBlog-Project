package com.patrisrikanth.techblog.dao;

import java.sql.*;

import com.patrisrikanth.techblog.entities.User;

public class UserDao {
	private Connection con;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public boolean saveUser(User user) {
		
		boolean execStatus = false;
		
		try {
			String query = "INSERT INTO BlogUsers(name, email, password, gender, about) VALUES(? , ? , ? , ? , ?);";
			PreparedStatement pstmt = this.con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return execStatus;
	}
}
