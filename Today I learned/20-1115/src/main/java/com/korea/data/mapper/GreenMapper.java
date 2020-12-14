package com.korea.data.mapper;

import java.util.List;

import com.korea.data.domain.GreenVO;

public interface GreenMapper {
	public List<GreenVO> getGreen();
	public GreenVO getOne(Long gid);    // 데이터 한개만
	public void update(GreenVO green);
	public void insert(GreenVO green);
	public void delete(Long gid);
}
