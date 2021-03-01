package com.spring.service;

import java.util.List;

import com.spring.dao.BoardDAO;
import com.spring.dto.AttachVO;
import com.spring.dto.BoardVO;


public class BoardServiceImpl implements BoardService{
	private BoardDAO boardDAO;
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	@Override
	public int getBoardListCount(String search_option, String keyword) {
		
		int count = boardDAO.getBoardListCount(search_option,keyword);
		
		
		
		return count;
	}
	@Override
	public List<BoardVO> getBoardList(String search_option, String keyword, int start, int end) {
		List<BoardVO> list = boardDAO.getBoardList(search_option,keyword,start,end);
		return list;
	}
	@Override
	public BoardVO getDetail(int bno) {
		BoardVO vo = boardDAO.getDetail(bno);
		List<AttachVO> attach = boardDAO.getAttachList(bno);
		vo.setAttach(attach);
		
		
		return vo;
	}
	@Override
	public void write(BoardVO board, List<AttachVO> list) {
		boardDAO.write(board);
		int bno = boardDAO.maxBno();
		for(AttachVO attach:list) {
			attach.setBno(bno);
			boardDAO.writeAttach(attach);
		}
				
	}
	@Override
	public void boardWrite(BoardVO board) {
		boardDAO.write(board);
		
	}
	@Override
	public List<AttachVO> getAttachList(int bno) {
		List<AttachVO> list = boardDAO.getAttachList(bno);
		return list;
	}
	@Override
	public AttachVO getAttachVO(int i) {
		AttachVO vo = boardDAO.getAttachVO(i);
		return vo;
	}
	@Override
	public void attachDelete(int i) {
		boardDAO.attachDelete(i);
		
	}
	@Override
	public void modify(BoardVO board) {
		boardDAO.modify(board);
		
	}
	@Override
	public void modify(BoardVO board, List<AttachVO> list) {
		int bno = board.getBno();
		boardDAO.modify(board);
		for(AttachVO attach:list) {
			attach.setBno(bno);
			boardDAO.writeAttach(attach);
		}
		
	}
	
	
}
