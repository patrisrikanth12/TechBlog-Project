package com.patrisrikanth.techblog.helpers;

import java.sql.*;
import com.patrisrikanth.techblog.constants.*;

public class ConnectionProvider {
	private static Connection con;
	
	public static Connection getConnection() {
		try {
			if(con == null) {
				con = DriverManager.getConnection(Constants.DB_URL, Constants.DB_USER, Constants.DB_PASSWORD);
				System.out.println("DB Connection created successfully");
			} else {
				System.out.println("DB connection exists");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}
