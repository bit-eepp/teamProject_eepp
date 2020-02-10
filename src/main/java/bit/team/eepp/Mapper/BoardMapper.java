package bit.team.eepp.Mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import bit.team.eepp.VO.BoardVO;

public interface BoardMapper {
	
	@Select("SELECT * FROM BOARD")
	public abstract List<BoardVO> list();
	
}
