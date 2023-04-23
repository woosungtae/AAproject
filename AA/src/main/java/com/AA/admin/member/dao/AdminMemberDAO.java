package com.AA.admin.member.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.AA.member.vo.MemberVO;

public interface AdminMemberDAO {
	public ArrayList<MemberVO> listMember(HashMap condMap) throws DataAccessException;
	public MemberVO memberDetail(String id) throws DataAccessException;
	public void modifyMemberInfo(HashMap memberMap) throws DataAccessException;
}
