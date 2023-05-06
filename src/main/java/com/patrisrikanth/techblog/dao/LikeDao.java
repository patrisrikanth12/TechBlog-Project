package com.patrisrikanth.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
	private Connection conn;
	
	public LikeDao(Connection conn) {
		this.conn = conn;
	}
	
	public boolean insertLike(int pid, int uid) {
		
		String query = "insert into BlogLikes(pid, uid) values(?, ?);";
		
		boolean execStatus = false;
		
		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			pstmt.execute();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return execStatus;
	}
	
	public int countLikes(int pid) {
		int count = 0;
		
		String query = "select count(*) from BlogLikes where pid=?;";
		
		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setInt(1, pid);
			ResultSet resultSet = pstmt.executeQuery();
			if(resultSet.next()) {
				count = resultSet.getInt("count(*)");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public boolean isLikedByUser(int pid, int uid) {
		boolean isLiked = false;
		
		String query = "select * from BlogLikes where pid=? and uid=?";

		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			ResultSet resultSet = pstmt.executeQuery();
			if(resultSet.next()) {
				isLiked = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return isLiked;
	}
	
	public boolean deleteLike(int pid, int uid) {
String query = "delete from BlogLikes where pid=? and uid=?";
		
		boolean execStatus = false;
		
		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setInt(1, pid);
			pstmt.setInt(2, uid);
			pstmt.execute();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return execStatus;
	}
}
 