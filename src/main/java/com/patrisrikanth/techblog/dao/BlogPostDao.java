package com.patrisrikanth.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.patrisrikanth.techblog.helpers.ConnectionProvider;
import com.patrisrikanth.techblog.entities.BlogPost;
import com.patrisrikanth.techblog.entities.Category;

public class BlogPostDao {
	private Connection conn;
	
	public BlogPostDao(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> categories = new ArrayList<Category>();
		String query = "SELECT * FROM BlogCategories";
		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			ResultSet resultSet = pstmt.executeQuery();
			while(resultSet.next()) {
				Category category = new Category();
				category.setId(resultSet.getInt("id"));
				category.setCategory(resultSet.getString("category"));
				category.setDescription(resultSet.getString("description"));
				categories.add(category);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return categories;
	}
	
	public boolean saveBlogPost(BlogPost post) {
		boolean execStatus = false;
		try {
			String query = "INSERT INTO BlogPosts(title, body, cid, uid) values(?, ?, ?, ?);";
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setString(1, post.getTitle());
			pstmt.setString(2, post.getBody());
			pstmt.setInt(3, post.getCid());
			pstmt.setInt(4, post.getUid());
			pstmt.execute();
			execStatus = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return execStatus;
	}
	
	public ArrayList<BlogPost> getAllPosts() {
		ArrayList<BlogPost> posts = new ArrayList<BlogPost>();
		
		String query = "SELECT * FROM BlogPosts;";
		 try {
			 Statement stmt = this.conn.createStatement();
			 ResultSet resultSet = stmt.executeQuery(query);
			 while(resultSet.next()) {
				 BlogPost post = new BlogPost();
				 post.setId(resultSet.getInt("id"));
				 post.setUid(resultSet.getInt("uid"));
				 post.setTitle(resultSet.getString("title"));
				 post.setBody(resultSet.getString("body"));
				 post.setCid(resultSet.getInt("cid"));
				 post.setRegDate(resultSet.getTimestamp("reg_date"));
				 
				 posts.add(post);
			 }
		 } catch (Exception e) {
			e.printStackTrace();
		}
		
		return posts;
	}
	
	public ArrayList<BlogPost> getPostsByCategory(int cid) {
		ArrayList<BlogPost> posts = new ArrayList<BlogPost>();
		
		String query = "SELECT * FROM BlogPosts where cid=?";
		 try {
			 PreparedStatement pstmt = this.conn.prepareStatement(query);
			 pstmt.setInt(1, cid);
			 ResultSet resultSet = pstmt.executeQuery();
			 while(resultSet.next()) {
				 BlogPost post = new BlogPost();
				 post.setId(resultSet.getInt("id"));
				 post.setUid(resultSet.getInt("uid"));
				 post.setTitle(resultSet.getString("title"));
				 post.setBody(resultSet.getString("body"));
				 post.setCid(resultSet.getInt("cid"));
				 post.setRegDate(resultSet.getTimestamp("reg_date"));
				 
				 posts.add(post);
			 }
		 } catch (Exception e) {
			e.printStackTrace();
		}
		
		return posts;
	}
	
	public BlogPost getPostById(int id) {
		BlogPost post = new BlogPost();
		
		String query = "SELECT * FROM BlogPosts where id=?;";
		
		try {
			PreparedStatement pstmt = this.conn.prepareCall(query);
			pstmt.setInt(1, id);
			ResultSet resultSet = pstmt.executeQuery();
			if(resultSet.next()) {
				post.setId(id);
				post.setCid(resultSet.getInt("cid"));
				post.setUid(resultSet.getInt("uid"));
				post.setTitle(resultSet.getString("title"));
				post.setBody(resultSet.getString("body"));
				post.setRegDate(resultSet.getTimestamp("reg_date"));
			}
		} catch( Exception e) {
			e.printStackTrace();
		}
		
		return post;
	}
}
