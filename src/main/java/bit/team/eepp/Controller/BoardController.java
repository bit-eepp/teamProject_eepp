package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bit.team.eepp.Page.PageMaker;
import bit.team.eepp.Search.SearchCriteria;
import bit.team.eepp.Service.BoardService;
import bit.team.eepp.VO.BoardVO;

@RequestMapping("/board")
@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;

	@RequestMapping("/boardList")
	public String boardList(Model model, @ModelAttribute("scri") SearchCriteria scri, @RequestParam(value = "sortType", required = false, defaultValue = "bWrittenDate") String sortType, @RequestParam(value = "bCategory", required = false, defaultValue = "") String bCategory) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("scri", scri);
		map.put("sortType", sortType);
		map.put("bCategory", bCategory);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(boardService.listCount(map));

		model.addAttribute("notice", boardService.noticeList());
		model.addAttribute("hotArticle", boardService.hotList());
		model.addAttribute("boardList", boardService.boardList(map));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);
		return "/board/boardList";
	}

	@RequestMapping("/writeView")
	public String writeView(Model model, @ModelAttribute("scri") SearchCriteria scri, @RequestParam(value = "sortType") String sortType, @RequestParam(value = "bCategory") String bCategory) {
		System.out.println("writeView() method");
		model.addAttribute("scri", scri);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);
		return "/board/write_view";
	}

	@RequestMapping("/writeContent")
	public String writeContent(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri,
			@RequestParam(value = "sortType") String sortType, @RequestParam(value = "bCategory") String bCategory) {
		System.out.println("writeContent() method");
		int result = boardService.write(boardVO);
		System.out.println("result : " + result);
		return "redirect:/board/contentView?bId=" + boardVO.getbId() + "&page=" + scri.getPage() + "&perPageNum="
				+ scri.getPerPageNum() + "&sortType=" + sortType + "&bCategory=" + bCategory;
	}

	@RequestMapping("/contentView")
	public String contentView(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri,
			@RequestParam(value = "sortType") String sortType, @RequestParam(value = "bCategory") String bCategory) {
		System.out.println("contentView() method");
		model.addAttribute("content", boardService.selectOne(boardVO));
		model.addAttribute("scri", scri);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);
		return "/board/content_view";
	}

	@RequestMapping("/deleteContent")
	public String deleteContent(BoardVO boardVO) {
		System.out.println("/deleteContent() method");
		boardService.delete(boardVO);
		return "redirect:/board/boardList";
	}

	@RequestMapping("/modifyView")
	public String modifyView(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri,
			@RequestParam(value = "sortType") String sortType, @RequestParam(value = "bCategory") String bCategory) {
		System.out.println("/modifyView() method");
		model.addAttribute("modify", boardService.modifyView(boardVO));
		model.addAttribute("scri", scri);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);
		return "/board/modify_view";
	}

	@RequestMapping("/modifyContent")
	public String modifyContent(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri,
			@RequestParam(value = "sortType") String sortType, @RequestParam(value = "bCategory") String bCategory) {
		System.out.println("/modifyContent() method");
		boardService.modify(boardVO);
		model.addAttribute("scri", scri);
		model.addAttribute("sortType", sortType);
		model.addAttribute("bCategory", bCategory);
		return "redirect:/board/contentView?bId=" + boardVO.getbId() + "&page=" + scri.getPage() + "&perPageNum="
				+ scri.getPerPageNum();
	}

}
