package com.spring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.dto.AttachVO;
import com.spring.dto.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO{
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public int getBoardListCount(String search_option,String keyword) {
		Map<String,Object> map = new HashMap();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		int count = sqlSession.selectOne("Board-Mapper.getBoardListCount",map);
		
		return count;
	}
	@Override
	public List<BoardVO> getBoardList(String search_option, String keyword, int start, int end) {
		Map<String,Object> map = new HashMap();
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("start",start);
		map.put("end",end);
		
		List<BoardVO> list = sqlSession.selectList("Board-Mapper.getBoardList",map);
		return list;
	}
	@Override
	public BoardVO getDetail(int bno) {
		BoardVO vo = sqlSession.selectOne("Board-Mapper.getDetail",bno);
		
		
		return vo;
	}
	@Override
	public List<AttachVO> getAttachList(int bno) {
		List<AttachVO> attach = sqlSession.selectList("Board-Mapper.getBoardAttach",bno);
		return attach;
	}
	@Override
	public void write(BoardVO board) {
		sqlSession.insert("Board-Mapper.write",board);
		
	}
	@Override
	public int maxBno() {
		int bno = sqlSession.selectOne("Board-Mapper.maxBno");
		return bno;
	}
	@Override
	public void writeAttach(AttachVO attach) {
		sqlSession.insert("Board-Mapper.writeAttach",attach);
		
	}
	@Override
	public AttachVO getAttachVO(int i) {
		int ano = i;
		AttachVO vo = sqlSession.selectOne("Board-Mapper.getAttachVO",ano);
		return vo;
	}
	@Override
	public void attachDelete(int i) {
		int ano = i;
		
		sqlSession.delete("Board-Mapper.attachDelete",ano);
	}
	@Override
	public void modify(BoardVO board) {
		sqlSession.update("Board-Mapper.modify",board);
		
	}
	
}
