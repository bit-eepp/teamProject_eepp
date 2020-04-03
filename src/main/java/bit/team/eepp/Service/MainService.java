package bit.team.eepp.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.MainMapper;
import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassVO;

@Service
public class MainService {

	@Autowired
	private MainMapper mainMapper;

	public List<BoardVO> getBoardNotice() {
		return mainMapper.getBoardNotice();
	}

	public List<BoardVO> getBoardHot() {
		return mainMapper.getBoardHot();
	}

	public List<BoardVO> getBoardListALL() {
		return mainMapper.getBoardListALL();
	}

	public List<BoardVO> getBoardListIT() {
		return mainMapper.getBoardListIT();
	}

	public List<BoardVO> getBoardListService() {
		return mainMapper.getBoardListService();
	}

	public List<BoardVO> getBoardListFinance() {
		return mainMapper.getBoardListFinance();
	}

	public List<BoardVO> getBoardListDesign() {
		return mainMapper.getBoardListDesign();
	}

	public List<BoardVO> getBoardListOfficial() {
		return mainMapper.getBoardListOfficial();
	}

	public List<BoardVO> getBoardListEtc() {
		return mainMapper.getBoardListEtc();
	}

	public List<ClassVO> getClassList() {
		return mainMapper.getClassList();
	}

}
