package com.my.vo;

public class Admin {

	public String name;
	public String id;
	public String password;
	
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Admin(String name, String id, String password) {
		super();
		this.name = name;
		this.id = id;
		this.password = password;
	}


	@Override
	public String toString() {
		return "Admin [name=" + name + ", id=" + id + ", password=" + password + "]";
	}
	
}
