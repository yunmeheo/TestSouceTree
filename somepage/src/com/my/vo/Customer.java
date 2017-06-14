package com.my.vo;

import java.sql.Date;

public class Customer extends Person{
		            //필드
				
		private String id;
		private String password;
		private String name;
		private String status;
		private Date sign_date;
		
		public Date getSign_date() {
			return sign_date;
		}


		public void setSign_date(Date sign_date) {
			this.sign_date = sign_date;
		}


		public Customer(){}
		
		
		
		
		public String getStatus() {
			return status;
		}




		public void setStatus(String status) {
			this.status = status;
		}




		public Customer(String id, String password, String name) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
	}
		
		public Customer(String id, String password, String name, String status,Date sign_date) {
			this(id,password,name);
			this.status = status;
			this.sign_date = sign_date;
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
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		@Override
		public String toString() {
			return "id="+id+"&password"+password+"&name"+name+"&status"+status+"&sign_date"+sign_date;
		}
		

}
