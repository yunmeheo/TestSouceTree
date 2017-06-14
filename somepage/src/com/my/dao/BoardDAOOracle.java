package com.my.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.my.vo.Repboard;

@Repository
public class BoardDAOOracle {
	
	@Autowired
	private SqlSession session;

	public boolean chkPassword(int no, String password){
		
		Map<String, Object> list = new HashMap<String, Object>(); 
		list.put("no", no);
		list.put("password", password);
		
		return session.selectOne("RepboardMapper.chkPassword",list);
		
		
	}
	
	public void delete(int on) {
		session.delete("RepboardMapper.delete",on);
	
	}

	
	public void insert(Repboard board){
			
		session.insert("RepboardMapper.insert",board);
		
	}

	public  List<Repboard> selectAll() {
		
		return session.selectList("RepboardMapper.selectAll");
		
	}

	public List<Repboard> selectByNo(int no){
		
		return session.selectList("RepboardMapper.selectByNo", no);
		
	}
	
    //이름으로 검색
    public List<Repboard> selectByName(String inputSubject){
    
	return session.selectList("RepboardMapper.selectByName", inputSubject);
	
	}

    public int selectMaxNo(){
    	
    	return session.selectOne("RepboardMapper.selectMaxNo");
    /*<select id="selectMaxNo"  resultType="Repboard">
    select max(no) from repboard
    </select>*/
    }
    
	
	public void update(int no, 
						String subject, 
						String content, 
						String password){
		//Connection con = null;
		//PreparedStatement pstmt = null;
		
		
		StringBuffer set=new StringBuffer();
		int updateColumnCnt = 0;
		if(!"".equals(subject)){
			set.append("subject='");
			set.append(subject);
			set.append("'");
			updateColumnCnt++;
		}
		if(!"".equals(content)){
			if(updateColumnCnt > 0){
				set.append(",");
			}
			set.append("content='");
			set.append(content);
			set.append("'");
			updateColumnCnt++;
		}
		if(!"".equals(password)){
			if(updateColumnCnt > 0){
				set.append(",");
			}
			set.append("password='");
			set.append(password);	
			set.append("'");
			updateColumnCnt++;
		}
		if(updateColumnCnt == 0){
			return;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("set", set);
		map.put("no", no);
		session.update("RepboardMapper.update", map);	
		
		//String updateSQL = "UPDATE Repboard SET " + set +" WHERE no='"+ no + "'";
		
		/*try {
			con = DriverManager.getConnection(updateSQL);
			pstmt = con.prepareStatement(updateSQL);
			pstmt.executeUpdate();
		} catch (SQLException e) {			
			e.printStackTrace();
		}finally{
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
	}

}



