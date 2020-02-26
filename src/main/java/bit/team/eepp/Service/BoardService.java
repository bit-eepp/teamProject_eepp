package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.BoardMapper;
import bit.team.eepp.VO.BoardVO;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;

	// 게시판 내 총 게시물 수
	public int listCount(Map<String, Object> map) {
		return boardMapper.listCount(map);
	}

	// 게시물 리스트 + paging, 정렬
	public List<BoardVO> boardList(Map<String, Object> map) {
		return boardMapper.boardList(map);
	}

	// 선택한 게시글 확인
	public BoardVO selectOne(BoardVO boardVO) {
		boardMapper.hitUp(boardVO.getbId());
		return boardMapper.selectOne(boardVO.getbId());
	}

	// 새로운 게시글 입력
	public int write(BoardVO boardVO) {
		return boardMapper.write(boardVO);
	}

	// 게시글 삭제
	public void delete(BoardVO boardVO) {
		boardMapper.delete(boardVO.getbId());
	}

	// 게시글 수정 페이지
	public BoardVO modifyView(BoardVO boardVO) {
		return boardMapper.modifyView(boardVO.getbId());
	}

	// 게시글 수정
	public void modify(BoardVO boardVO) {
		boardMapper.modify(boardVO);
	}

	public List<BoardVO> noticeList() {
		return boardMapper.noticeList();
	}

	public List<BoardVO> hotList() {
		return boardMapper.hotList();
	}

}
