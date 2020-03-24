package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ReviewMapper;
import bit.team.eepp.Page.ReviewCriteria;
import bit.team.eepp.VO.ReviewVO;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;

	public int reviewCount(int eId) {
		return reviewMapper.reviewCount(eId);
	}
	
//	public float reviewAVG(float rvScore) {
//		return reviewMapper.reviewAVG(rvScore);
//	}
	
	public float reviewAVG(ReviewVO reviewVO) {
		return reviewMapper.reviewAVG(reviewVO);
	}

	public List<ReviewVO> reviewList(ReviewCriteria rvCriteria, int eId) {
		return reviewMapper.reviewList(rvCriteria, eId);
	}

	public void reviewWrite(ReviewVO reviewVO) {
		reviewMapper.reviewWrite(reviewVO);
	}

	public void reviewModify(ReviewVO reviewVO) {
		reviewMapper.reviewModify(reviewVO);
	}

	public void reviewDelete(int rvId) {
		reviewMapper.reviewDelete(rvId);
	}
	/*
	public void reReplyWrite(ReviewVO reviewVO) {
		replyMapper.replyShape(replyVO.getRpGroup(), replyVO.getRpStep());
		replyMapper.reReplyWrite(replyVO);
	}
	*/
}
