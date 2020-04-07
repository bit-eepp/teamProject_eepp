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
	
	//가게 리뷰 개수 
	public int reviewCount(int eating_id) {
		return reviewMapper.reviewCount(eating_id);
	}
	
	//가게 리뷰 평점
	public float reviewAVG(ReviewVO reviewVO) {
		return reviewMapper.reviewAVG(reviewVO);
	}
	
	//리뷰 리스트
	public List<ReviewVO> reviewList(ReviewCriteria rvCriteria, int eating_id) {
		return reviewMapper.reviewList(rvCriteria, eating_id);
	}
	
	//리뷰 작성
	public void reviewWrite(ReviewVO reviewVO) {
		reviewMapper.reviewWrite(reviewVO);
	}
	
	//리뷰 수정
	public void reviewModify(ReviewVO reviewVO) {
		reviewMapper.reviewModify(reviewVO);
	}
	
	//리뷰 삭제
	public void reviewDelete(int rvId) {
		reviewMapper.reviewDelete(rvId);
	}
	
}
