package com.korea.data.service;

import java.util.List;

import com.korea.data.domain.GreenVO;

public interface GreenService {
	public List<GreenVO> getServiceAll();
	public GreenVO getServiceOne(Long gid);
	public void update(GreenVO green);
	public void insertService(GreenVO green);
	public void deleteService(Long gid);
}
