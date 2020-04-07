package bit.team.eepp.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Page.ReviewCriteria;
import bit.team.eepp.Page.ReviewPageMaker;
import bit.team.eepp.Service.ReviewService;
import bit.team.eepp.VO.ReviewVO;

@RequestMapping("/review")
@RestController
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping("/reviewCount")
	public int reviewCount(int eId) {
		System.out.println(eId + "reviewCount");
		
		return reviewService.reviewCount(eId);
	}
	
	@RequestMapping("/reviewList")
	public Map<String, Object> reviewList(Model model,ReviewVO reviewVO, ReviewCriteria rvCriteria) {
		System.out.println("store review list print");
		
		ReviewPageMaker rvPageMaker = new ReviewPageMaker();
		rvPageMaker.setCri(rvCriteria);

		System.out.println("criteria : " + rvCriteria);
		System.out.println("criteria.getPerPageNum() : " + rvCriteria.getPerPageNum());
		System.out.println("criteria.getPage() : " + rvCriteria.getPage_review());

		int rvCount = reviewCount(reviewVO.getEating_id());
		System.out.println("댓글수 : " + rvCount);

		rvPageMaker.setTotalCount(rvCount);
		
		List<ReviewVO> reviewList = reviewService.reviewList(rvCriteria, reviewVO.getEating_id());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rvPageMaker", rvPageMaker);
		map.put("reviewList", reviewList);
		map.put("reviewAVG", reviewService.reviewAVG(reviewVO));
		
//		model.addAttribute("reviewAVG", reviewService.reviewAVG(reviewVO));
//		System.out.println(reviewService.reviewAVG(reviewVO));
		
		return map;
	}
	
	@RequestMapping("/reviewWrite")
	public void replyWrite(ReviewVO reviewVO) {
		System.out.println("review Write call!!");
		
		reviewService.reviewWrite(reviewVO);
	}

	@RequestMapping("/reviewModify")
	public void replyModify(ReviewVO reviewVO) {
		System.out.println("review modify call!!");
		
		reviewService.reviewModify(reviewVO);
	}

	@RequestMapping("/reviewDelete")
	public void replyDelete(ReviewVO reviewVO) {
		System.out.println("review Delete call!!");
		
		reviewService.reviewDelete(reviewVO.getRvId());
	}
}
