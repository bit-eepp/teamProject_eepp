package bit.team.eepp.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.Search.SearchCriteria;
import bit.team.eepp.VO.BoardVO;

@Repository
public interface BoardMapper {
	// 게시물 총 갯수
	public abstract int listCount(Map<String, Object> map);

	// 게시물 리스트 + paging, 정렬 : 시간순
	public abstract List<BoardVO> boardList(Map<String, Object> map);

	// 게시글 조회수 up
	public abstract void hitUp(@Param("bId") int bId);

	// 선택한 게시글 확인
	public abstract BoardVO selectOne(@Param("bId") int bId);

	// 새로운 게시글 입력
	public abstract int write(@Param("boardVO") BoardVO boardVO);

	// 게시글 삭제
	public abstract void delete(@Param("bId") int bId);

	// 게시글 수정 페이지
	public abstract BoardVO modifyView(@Param("bId") int bId);

	// 게시글 수정
	public abstract void modify(@Param("boardVO") BoardVO boardVO);
	
	// 공지사항 2개 노출
	public abstract List<BoardVO> noticeList();
	
	// 인기글 노출 : 24시간동안 등록된 글중 조회수가 가장 높은 글 3개
	public abstract List<BoardVO> hotList();

}
