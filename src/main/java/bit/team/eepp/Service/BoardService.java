package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.BoardMapper;
import bit.team.eepp.VO.BoardVO;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;

	public List<BoardVO> list() {
		return boardMapper.list();
	}

}
