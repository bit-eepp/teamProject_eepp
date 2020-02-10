package bit.team.eepp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.team.eepp.Service.BoardService;
import bit.team.eepp.VO.BoardVO;

@RequestMapping("/board")
@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@RequestMapping("/boardList")
	public String boardList(Model model) {
		System.out.println("boardList() method");
		List<BoardVO> boardList = boardService.list();

		for (int i = 0; i < boardList.size(); i++) {
			System.out.println(boardList.get(i));
			System.out.println(boardList.get(i).getbWrittenDate());
			System.out.println(boardList.get(i).getbModifyDate());
		}

		model.addAttribute("boardList", boardList);
		return "/board/boardList";
	}
}
