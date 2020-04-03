package bit.team.eepp.Mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.BoardVO;
import bit.team.eepp.VO.ClassVO;
import bit.team.eepp.VO.EatingVO;

@Repository
public interface MainMapper {

	public abstract List<BoardVO> getBoardNotice();

	public abstract List<BoardVO> getBoardHot();

	public abstract List<BoardVO> getBoardListALL();

	public abstract List<BoardVO> getBoardListIT();

	public abstract List<BoardVO> getBoardListService();

	public abstract List<BoardVO> getBoardListFinance();

	public abstract List<BoardVO> getBoardListDesign();

	public abstract List<BoardVO> getBoardListOfficial();

	public abstract List<BoardVO> getBoardListEtc();

	public abstract List<ClassVO> getClassList();

	public abstract List<EatingVO> getEatStoreList();
	
}
