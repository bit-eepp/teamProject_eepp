package bit.team.eepp.boardMapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import bit.team.eepp.boardVO.BoardVO;

public interface BoardMapper {
	
	@Select("SELECT * FROM BOARD")
	public abstract List<BoardVO> list();
	
}
