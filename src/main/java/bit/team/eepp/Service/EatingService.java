package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.EatingMapper;
import bit.team.eepp.VO.EatingVO;

@Service
public class EatingService {
	@Autowired
	private EatingMapper eatingMapper;
	
		// 게시판 내 총 게시물 수
		public int eatingListCount(Map<String, Object> map) {
			return eatingMapper.eatingListCount(map);
		}

		// 게시물 리스트 + paging, 정렬
		public List<EatingVO> eatingList(Map<String, Object> map) {
			return eatingMapper.eatingList(map);
		}
		//테마 리스트 정렬
		public List<EatingVO> themaList(Map<String, Object> map) {
			return eatingMapper.themaList(map);
		}

		// 선택한 게시글 확인
		public EatingVO selectOne(EatingVO eatingVO) {
			//조회수 eatingMapper.hitUp(boardVO.getbId());
			return eatingMapper.selectOne(eatingVO.geteId());
		}

		// 새로운 게시글 입력
		public int write(EatingVO eatingVO) {
			return eatingMapper.write(eatingVO);
		}

		// 게시글 삭제
		public void delete(EatingVO eatingVO) {
			eatingMapper.delete(eatingVO.geteId());
		}

		// 게시글 수정 페이지
		public EatingVO modifyView(EatingVO eatingVO) {
			return eatingMapper.modifyView(eatingVO.geteId());
		}

		// 게시글 수정
		public void modify(EatingVO eatingVO) {
			eatingMapper.modify(eatingVO);
		}
		
		/*
		public List<EatingVO> noticeList() {
			return eatingMapper.noticeList();
		}

		public List<BoardVO> hotList() {
			return boardMapper.hotList();
		}
		*/
}
