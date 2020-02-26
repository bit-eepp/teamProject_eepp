package bit.team.eepp.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.RecommendMapper;

@Service
public class RecommendService {

	@Autowired
	private RecommendMapper recommendMapper;

	public int blikeCount(int bId) {
		return recommendMapper.blikeCount(bId);
	}

	public void blikeUp(int bId) {
		recommendMapper.blikeUp(bId);
	}

	public int bUnlikeCount(int bId) {
		return recommendMapper.bUnlikeCount(bId);
	}

	public void bUnlikeUp(int bId) {
		recommendMapper.bUnlikeUp(bId);
	}

	public int rplikeCount(int rpId) {
		return recommendMapper.rplikeCount(rpId);
	}

	public void rplikeUp(int rpId) {
		recommendMapper.rplikeUp(rpId);
	}

	public int rpUnlikeCount(int rpId) {
		return recommendMapper.rpUnlikeCount(rpId);
	}

	public void rpUnlikeUp(int rpId) {
		recommendMapper.rpUnlikeUp(rpId);
	}

}
