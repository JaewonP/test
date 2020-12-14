package com.korea.data.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.korea.data.domain.GreenVO;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MapperTests {
	@Setter(onMethod_=@Autowired)
	GreenMapper mapper;
	
	//@Test
	public void test1() {
		mapper.getGreen();
	}
	
	//@Test
	public void test2() {
		mapper.getOne(4L);
	}
	
	@Test
	public void test3() {
		GreenVO green = new GreenVO();
		
		green.setGid(3L);
		green.setName("이보람");
		green.setKorea("10");
		green.setMath("0");
		
		mapper.update(green);
	}
		
}
