package com.korea.data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.data.domain.GreenVO;
import com.korea.data.mapper.GreenMapper;

import lombok.Setter;

@Service
public class GreenServiceImpl implements GreenService {
	
	
	@Setter(onMethod_=@Autowired)
	GreenMapper mapper;        //스프링에게 객체를 만들어서 주입시켜줘<DI>
	
	@Override
	public List<GreenVO> getServiceAll(){
		return mapper.getGreen();
	}
	@Override
	public GreenVO getServiceOne(Long gid){
		return mapper.getOne(gid);
	}
	
	@Override
	public void update(GreenVO green){
		mapper.update(green);
	}
	
	@Override
	public void insertService(GreenVO green){
		int korea = green.getKorea();
		int math = green.getMath();
		int total = korea + math;
		
		green.setTotal(total);
		
		if(green.getTotal() < 40) {
			green.setMorestudy(green.getName() + "님은 나머지 공부 하셔야겠네요");
		} else {
			green.setMorestudy("오케이! 퇴근하세요!");
		}
		System.out.println("시험결과는? : " + green.getMorestudy());
		mapper.insert(green);
	}
	
	@Override
	public void deleteService(Long gid){
		mapper.delete(gid);
	}
}
