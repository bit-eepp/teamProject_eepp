package bit.team.eepp.boardService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.boardMapper.BoardMapper;
import bit.team.eepp.boardVO.BoardVO;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;

	public List<BoardVO> list() {
		return boardMapper.list();
	}

}
