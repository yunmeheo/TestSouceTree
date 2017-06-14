package com.my.vo;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class FilePrinter implements Printable{
	
	String fileName = "a.txt";
	
	public FilePrinter(String fileName){
		
		super();
		this.fileName=fileName;
	}
	

	
	

	@Override
	public void print(String msg) {
		
		try {
			FileWriter fr = new FileWriter(fileName);
			BufferedWriter out = new BufferedWriter(fr);
			out.write(msg);
			
			out.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			
		}
	}
	
	
	
	
}
