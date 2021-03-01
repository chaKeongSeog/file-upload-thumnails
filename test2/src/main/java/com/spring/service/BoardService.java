package com.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.dto.AttachVO;
import com.spring.dto.BoardVO;


@Service
public interface BoardService {

	int getBoardListCount(String search_option,String keyword);

	List<BoardVO> getBoardList(String search_option, String keyword, int start, int end);

	BoardVO getDetail(int bno);

	void write(BoardVO board, List<AttachVO> list);

	void boardWrite(BoardVO board);

	List<AttachVO> getAttachList(int bno);

	AttachVO getAttachVO(int i);

	void attachDelete(int i);

	void modify(BoardVO board);

	void modify(BoardVO board, List<AttachVO> list);

}
