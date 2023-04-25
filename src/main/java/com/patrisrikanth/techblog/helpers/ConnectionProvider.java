package com.patrisrikanth.techblog.helpers;

import java.sql.*;
import com.patrisrikanth.techblog.constants.*;

public class ConnectionProvider {
	private Connection con;

	public Connection getConnection() {
		try {
			con = DriverManager.getConnection(Constants.DB_URL, Constants.DB_USER, Constants.DB_PASSWORD);
			System.out.println("DB Connection created successfully");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
