package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Page.ReplyCriteria;
import bit.team.eepp.Page.ReplyPageMaker;
import bit.team.eepp.Service.QuestionService;
import bit.team.eepp.VO.ReplyVO;

@RequestMapping("/question")
@RestController
public class QuestionController {

	@Autowired
	private QuestionService questionService;

	@RequestMapping("/questionCount")
	public int questionCount(int class_id) {
		System.out.println("questionCount() method");
		System.out.println("class_id : " +class_id);
		return questionService.questionCount(class_id);
	}

	@RequestMapping("/questionList")
	public Map<String, Object> questionList(ReplyVO replyVO, ReplyCriteria rpCriteria) {
		System.out.println("questionList() method");
		ReplyPageMaker rpPageMaker = new ReplyPageMaker();
		rpPageMaker.setCri(rpCriteria);

		int questionCount = questionCount(replyVO.getClass_id());
		System.out.println("댓글수 : " + questionCount);

		rpPageMaker.setTotalCount(questionCount);
		
		List<ReplyVO> questionList = questionService.questionList(rpCriteria, replyVO.getClass_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rpPageMaker", rpPageMaker);
		map.put("questionList", questionList);

		return map;
	}

	@RequestMapping("/questionWrite")
	public void questionWrite(ReplyVO replyVO) {
		System.out.println("questionWrite() method");
		questionService.questionWrite(replyVO);
	}

	@RequestMapping("/questionModify")
	public void questionModify(ReplyVO replyVO) {
		System.out.println("questionModify() method");
		questionService.questionModify(replyVO);
	}

	@RequestMapping("/questionDelete")
	public void questionDelete(ReplyVO replyVO) {
		System.out.println("questionDelete() method");
		questionService.questionDelete(replyVO.getRpId());
	}

	@RequestMapping("/reQuestionWrite")
	public void reQuestionWrite(ReplyVO replyVO) {
		System.out.println("reQuestionWrite() method");
		questionService.reQuestionWrite(replyVO);
	}

}
