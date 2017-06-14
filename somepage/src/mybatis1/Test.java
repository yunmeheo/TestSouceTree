package mybatis1;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.my.vo.Customer;

public class Test {

	public static void main(String[] args) {
		
		String resource = "mybatis-config.xml";
		InputStream inputStream;
		try {
			inputStream = Resources.getResourceAsStream(resource);
			SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			
			//디비에접속하기
			SqlSession session = sqlSessionFactory.openSession();
						
			/*try {
			  Customer c = session.selectOne("CustomerMapper.selectById","id1");
			  System.out.println(c);
			} finally {
			  session.close();
			}*/
			
			
			/*try {
			List<Customer> list = session.selectList("CustomerMapper.selectAll","DESC");
			for(Customer lists : list){
			System.out.println(lists);
			} 
			}finally {
			  session.close();
			}
			
			
			try {
			 int cnt = session.selectOne("CustomerMapper.selectCount","n1");
			 System.out.println(cnt);
			} finally {
			  session.close();
			}*/
			
			
			try {
			HashMap map = session.selectOne("CustomerMapper.selectCount2",8);
			System.out.println(map);  // 키값은 무조건 대문자 {CNT2=1, CNT1=1}
			System.out.println(map.get("CNT1")); 
			} finally {
			  session.close();
			}
			
			
			try {
				//객체를 만들어서  객체로 두번째인자를 준다.
				//해당 객체의 get메서드를 호출하러 간다.
				 
				Customer c = new Customer();
				c.setId("id8");
				c.setPassword("p8");
				c.setName("n8");				
				session.insert("CustomerMapper.insert",c);
				session.commit();
			}catch(Exception e){
				session.rollback();
				e.printStackTrace();
			} finally {
			  session.close();
			}
			
			/*try {
	
				Customer c = new Customer();
				c.setId("id8");
				c.setName("udp1");
				session.update("CustomerMaper.update",c);
				
				//객첵로 넘겨도 되지만 hashmap타입의 객체로도 넘길 수 있다.
				//키를 찾으러간다
				
				HashMap<String,String> map = new HashMap<>();
				map.put("id","id1");
				map.put("name", "upd1");
				
				//처리건수 반환도 해준다.
				int rowcnt = session.update("CustomerMapper.update",map);
				System.out.println("업데이트 처리건수 : "+rowcnt);
				session.commit();
				
			}catch(Exception e){
				session.rollback();
				e.printStackTrace();
			} finally {
			  session.close();
			}*/
			
			
			
			
			

			
		}catch (IOException e) {
			e.printStackTrace();
		}
	
	}
}
