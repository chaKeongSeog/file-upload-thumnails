package com.spring.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.dto.AttachVO;
import com.spring.dto.BoardVO;



public interface BoardDAO {

	int getBoardListCount(String search_option,String keyword);

	List<BoardVO> getBoardList(String search_option, String keyword, int start, int end);

	BoardVO getDetail(int bno);

	List<AttachVO> getAttachList(int bno);

	void write(BoardVO board);

	int maxBno();

	void writeAttach(AttachVO attach);

	AttachVO getAttachVO(int i);

	void attachDelete(int i);

	void modify(BoardVO board);

}
