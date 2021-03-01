package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.Pager;
import com.spring.dto.AttachVO;
import com.spring.dto.BoardVO;
import com.spring.service.BoardService;


@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/test",method = RequestMethod.GET)
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView();
		String url = "/test";
		mav.setViewName(url);
		
		
		return mav;
	}
	
	@RequestMapping(value="/board/list",method = RequestMethod.GET)
	public ModelAndView list(@RequestParam(defaultValue="1") int curPage,
							 @RequestParam(defaultValue="all") String search_option,
							 @RequestParam(defaultValue="") String keyword) {
		ModelAndView mav = new  ModelAndView();
		String url = "board/list";
		mav.setViewName(url);
		
		int count = boardService.getBoardListCount(search_option,keyword);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BoardVO> list = boardService.getBoardList(search_option,keyword,start,end);
		Map<String,Object> map = new HashMap<>();
		map.put("pager",pager);
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		map.put("board",list);
		mav.addObject("map",map);
		return mav;
	}
	@RequestMapping(value="/board/detail",method = RequestMethod.GET)
	public ModelAndView detail(int bno,int curPage,String search_option,String keyword) {
		ModelAndView mav = new ModelAndView();
		String url = "/board/detail";
		BoardVO vo = boardService.getDetail(bno);
		mav.addObject("board",vo);
		mav.addObject("curPage",curPage);
		mav.addObject("search_option",search_option);
		mav.addObject("keyword",keyword);
		mav.setViewName(url);
		
		return mav;
	}
	
	@RequestMapping(value="/board/writeForm",method = RequestMethod.POST)
	public ModelAndView writeForm(String id) {
		ModelAndView mav = new ModelAndView();
		String url = "/board/write";
		mav.setViewName(url);
		mav.addObject("id","asd");
		
		return mav;
	}
	@RequestMapping(value="/board/write",method = RequestMethod.POST,produces="text/plain;charset=utf-8")
	public ModelAndView write(String id,String title,String content,@RequestParam(value = "file") List<MultipartFile> file,HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		String url = "redirect:list";
		mav.setViewName(url);
		BoardVO board = new BoardVO();
		board.setId(id);
		board.setTitle(title);
		board.setContent(content);
		
		if(file.isEmpty()) {
			boardService.boardWrite(board);
		}else {
			List<AttachVO> list = saveFile(id,file,request);
			
			boardService.write(board,list);
		}
		
		return mav;
	}
	
	@RequestMapping(value="board/modifyForm",method = RequestMethod.POST)
	public ModelAndView modifyForm(int bno,int curPage,String search_option,String keyword) {
		ModelAndView mav =new ModelAndView();
		String url="/board/modify";
		BoardVO board = boardService.getDetail(bno);
		List<AttachVO> attach = boardService.getAttachList(bno);
		board.setAttach(attach);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("board",board);
		map.put("curPage",curPage);
		map.put("search_option",search_option);
		map.put("keyword",keyword);
		mav.addObject("map",map);
		mav.setViewName(url);
		return mav;
	}
	
	@RequestMapping(value="/board/modify",method = RequestMethod.POST)
	public ModelAndView modify(int curPage,String search_option,String keyword,int[] ano,int bno,String title,String content,List<MultipartFile> file,String id,HttpServletRequest request) throws IOException {
		ModelAndView mav =new ModelAndView();
		String url="redirect:list?curPage="+curPage+"&search_option="+search_option+"&keyword="+keyword;
		String path = request.getSession().getServletContext().getRealPath("resources/upload/");
		
		if(ano != null) {
			for(int i = 0; i <ano.length;i++) {
				AttachVO attach = boardService.getAttachVO(ano[i]);
				String fileName = attach.getFileName();
				File f = new File(path,fileName);
				f.delete();
				
				boardService.attachDelete(ano[i]);
			}
		}
		if(file.isEmpty()) {
			BoardVO board = new BoardVO();
			board.setBno(bno);
			board.setTitle(title);
			board.setContent(content);
			board.setId(id);
			
			boardService.modify(board);
			
		}else {
			BoardVO board = new BoardVO();
			board.setBno(bno);
			board.setTitle(title);
			board.setContent(content);
			board.setId(id);
			
			List<AttachVO> list = saveFile(id,file,request);
			boardService.modify(board,list);
			
		}
		mav.setViewName(url);
		
		return mav;
	}
	
	public List<AttachVO> saveFile(String id,List<MultipartFile> file,HttpServletRequest request) throws  IOException{
		List<AttachVO> list = new ArrayList<AttachVO>();
		String path = request.getSession().getServletContext().getRealPath("resources/upload/");
		
		for(MultipartFile f:file) {
			if(!f.isEmpty()) {
				String origin = f.getOriginalFilename();
				String fileName = UUID.randomUUID().toString().replace("-","")+"_"+origin;
				String type= fileName.substring(fileName.lastIndexOf(".")+1);
				
				File f2 = new File(path,fileName);
				if(!f2.exists()) {
					f2.mkdirs();
				}
				f.transferTo(f2);
				
				AttachVO attach = new AttachVO();
				attach.setFileName(fileName);
				attach.setFileType(type);
				attach.setId(id);
				attach.setOriginFileName(origin);
				attach.setPath(path);
				list.add(attach);
			}
		}
		
		return list;
	}
}
