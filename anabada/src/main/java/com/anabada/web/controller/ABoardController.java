package com.anabada.web.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.anabada.web.service.ABoardService;
import com.anabada.web.service.ALikeService;
import com.anabada.web.service.AReplyService;
import com.anabada.web.vo.ABoardVO;
import com.anabada.web.vo.ALikeVO;
import com.anabada.web.vo.APageMaker;
import com.anabada.web.vo.AReplyVO;
import com.anabada.web.vo.ASearchCriteria;
import com.anabada.web.vo.MemberVO;

@Controller
@RequestMapping("/a_board/*")
public class ABoardController {

	private static final Logger logger = LoggerFactory.getLogger(ABoardController.class);

	@Inject
	ABoardService service;

	@Inject
	AReplyService replyService;

	@Inject
	ALikeService likeService;

	// 게시판글 작성 화면
	// 리턴값이랑 경로랑 같다면 안적어줘도 됨
	@RequestMapping(value = "/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception {

		logger.info("writeView");
	}
	
	//게시글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writeView(ABoardVO boardVO) throws Exception {

		logger.info("write");

		service.write(boardVO);

		return "redirect:/a_board/list";
		// redirect는 컨트롤러 주소를 찾아감
	}
	
	//ckeditor 파일 업로드 
	 @RequestMapping(value="/fileUpload", method = RequestMethod.POST)
	    public void imageUpload(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest multiFile
	    		, @RequestParam MultipartFile upload) throws Exception{
	    	// 랜덤 문자 생성
	    	UUID uid = UUID.randomUUID();
	    	
	    	OutputStream out = null;
	    	PrintWriter printWriter = null;
	    	
	    	//인코딩
	    	response.setCharacterEncoding("utf-8");
	    	response.setContentType("text/html;charset=utf-8");
	    	try{
	    		//파일 이름 가져오기
	    		String fileName = upload.getOriginalFilename();
	    		byte[] bytes = upload.getBytes();
	    		
	    		//이미지 경로 생성
	    		String path = "C:\\Spring\\workspace\\anabada(좋아요 추가까지만).zip_expanded\\anabada\\src\\main\\webapp\\resources\\ckimage"; // 이미지 경로 설정(폴더 자동 생성)
	    		String ckUploadPath = path + uid + "_" + fileName;
	    		File folder = new File(path);
	    		System.out.println("path : " + path);	// 이미지 저장경로 console에 확인
	    		//해당 디렉토리 확인
	    		if(!folder.exists()){
	    			try{
	    				folder.mkdirs(); // 폴더 생성
	    		}catch(Exception e){
	    			e.getStackTrace();
	    		}
	    	}
	    	
	    	out = new FileOutputStream(new File(ckUploadPath));
	    	out.write(bytes);
	    	out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
	    	
	    	String callback = request.getParameter("CKEditorFuncNum");
	    	printWriter = response.getWriter();
	    	String fileUrl = "/a_board/ckImgSubmit?uid=" + uid + "&fileName=" + fileName; // 작성화면
	    	
	    	// 업로드시 메시지 출력
	    	printWriter.println("{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
	    	printWriter.flush();
	    	
	    	}catch(IOException e){
	    		e.printStackTrace();
	    	} finally {
	    		try {
	    		if(out != null) { out.close(); }
	    		if(printWriter != null) { printWriter.close(); }
	    	} catch(IOException e) { e.printStackTrace(); }
	    	}
	    	return;
	    }
	 
	//서버로 전송된 이미지 뿌려주기
	    @RequestMapping(value = "/ckImgSubmit")
	    public void ckSubmit(@RequestParam(value="uid") String uid, @RequestParam(value="fileName") String fileName
	    		, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	    	
	    	//서버에 저장된 이미지 경로
	    	String path = "C:\\Spring\\workspace\\anabada(좋아요 추가까지만).zip_expanded\\anabada\\src\\main\\webapp\\resources\\ckimage";	// 저장된 이미지 경로
	    	System.out.println("path : " + path);
	    	String sDirPath = path + uid + "_" + fileName;
	    	
	    	File imgFile = new File(sDirPath);
	    	
	    	//사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
	    	if(imgFile.isFile()){
	    		byte[] buf = new byte[1024];
	    		int readByte = 0;
	    		int length = 0;
	    		byte[] imgBuf = null;
	    		
	    		FileInputStream fileInputStream = null;
	    		ByteArrayOutputStream outputStream = null;
	    		ServletOutputStream out = null;
	    		
	    		try{
	    			fileInputStream = new FileInputStream(imgFile);
	    			outputStream = new ByteArrayOutputStream();
	    			out = response.getOutputStream();
	    			
	    			while((readByte = fileInputStream.read(buf)) != -1){
	    				outputStream.write(buf, 0, readByte); 
	    			}
	    			
	    			imgBuf = outputStream.toByteArray();
	    			length = imgBuf.length;
	    			out.write(imgBuf, 0, length);
	    			out.flush();
	    			
	    		}catch(IOException e){
	    			e.printStackTrace();
	    		}finally {
	    			outputStream.close();
	    			fileInputStream.close();
	    			out.close();
	    			}
	    		}
	    }
	    
	//게시판 목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") ASearchCriteria scri) throws Exception {

		logger.info("게시판 목록 보기");

		model.addAttribute("list", service.list(scri));

		APageMaker pageMaker = new APageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));

		model.addAttribute("pageMaker", pageMaker);
		return "/a_board/list";
	}

	//게시글 상세보기
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(Model model, ABoardVO boardVO, ALikeVO likeVO, MemberVO memberVO,
			@ModelAttribute("scri") ASearchCriteria scri, HttpServletRequest req) throws Exception {

		logger.info("게시글 상세보기");
		
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		logger.info("id : " + id);
		
		model.addAttribute("read", service.read(boardVO.getA_bno()));
		model.addAttribute("scri", scri);
		
		List<AReplyVO> replyList = replyService.readReply(boardVO.getA_bno());
		model.addAttribute("replyList", replyList);
		
		Map<String, String> likeChk = new HashMap<>();
		
		likeChk.put("id", id);
		likeChk.put("a_bno", Integer.toString(boardVO.getA_bno()));
		
		logger.info("likeChk : " + likeChk);
		
		int Chk = likeService.likeCheck(likeChk);
		
		//좋아요 여부 체크 좋아요 했으면 1, 좋아요 없으면 0
		model.addAttribute("Chk", Chk);
		
		logger.info("Chk : " + Chk);
		
		return "/a_board/readView";
	}
	
	//게시글 수정 화면
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(Model model, ABoardVO boardVO, MemberVO memberVO,
			@ModelAttribute("scri") ASearchCriteria scri) throws Exception {

		logger.info("게시글 수정하기 뷰페이지");

		model.addAttribute("update", service.read(boardVO.getA_bno()));
		model.addAttribute("scri", scri);

		return "a_board/updateView";
	}
	
	//게시글 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ABoardVO boardVO, @ModelAttribute("scri") ASearchCriteria scri, RedirectAttributes rttr)
			throws Exception {

		logger.info("게시글 수정 완료");

		service.update(boardVO);

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		rttr.addAttribute("cateType", scri.getCateType());

		return "redirect:/a_board/list";
	}

	//게시글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(ABoardVO boardVO, @ModelAttribute("scri") ASearchCriteria scri, RedirectAttributes rttr)
			throws Exception {

		logger.info("게시글 삭제 완료");

		service.delete(boardVO.getA_bno());

		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		rttr.addAttribute("cateType", scri.getCateType());

		return "redirect:/a_board/list";
	}
	
	//좋아요 추가
	@RequestMapping(value = "/insertLike", method = RequestMethod.POST)
	public @ResponseBody String insertLike(ABoardVO boardVO, ALikeVO likeVO, @RequestParam(value = "id", required = false) String id, @RequestParam(value = "a_bno", required = false) int a_bno,
			HttpServletRequest request, Model model) throws Exception {
		System.out.println("잘 넘어는지 확인");
		
		Map<String, String> bnoId = new HashMap<>();
		
		bnoId.put("id", id);
		bnoId.put("a_bno", Integer.toString(boardVO.getA_bno()));
		
		likeService.insertLike(bnoId);
		
		int likeCnt = likeService.updateLike(likeVO.getA_bno());
		model.addAttribute("like", likeCnt);
		
		return "redirect:/a_board/readView";
	}
	
	//좋아요 삭제
	@RequestMapping(value = "/deleteLike", method = RequestMethod.POST)
	public @ResponseBody String deleteLike(ABoardVO boardVO, ALikeVO likeVO, @RequestParam(value = "id", required = false) String id, @RequestParam(value = "a_bno", required = false) int a_bno, 
			HttpServletRequest request) throws Exception {
		
		Map<String, String> bnoId = new HashMap<>();
		
		bnoId.put("id", id);
		bnoId.put("a_bno", Integer.toString(boardVO.getA_bno()));
		
		likeService.deleteLike(bnoId);
		likeService.deleteIsLike(likeVO.getA_bno());
		
		return "redirect:/a_board/readView";
	}
	
	//신고 팝업 띄우기
	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public String report() {
		return "a_board/report";
	}

	//신고 사유 선택 유효성 검사 팝업 띄우기
	@RequestMapping(value = "/reportError", method = RequestMethod.GET)
	public String reportError() {
		return "a_board/reportError";
	}
}
