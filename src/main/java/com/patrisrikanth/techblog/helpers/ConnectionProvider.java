package com.patrisrikanth.techblog.helpers;

import java.sql.*;

public class ConnectionProvider {
	private Connection con;
 
	public Connection getConnection() {
		try {
			con = DriverManager.getConnection(System.getenv("DB_URL") , System.getenv("DB_USER"), System.getenv("DB_PASSWORD"));
			System.out.println("DB Connection created successfully");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
