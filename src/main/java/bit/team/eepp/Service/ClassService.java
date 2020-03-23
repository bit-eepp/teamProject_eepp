package bit.team.eepp.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.ClassMapper;
import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;

@Service
public class ClassService {

	@Autowired
	private ClassMapper classMapper;

	public int classListCount(Map<String, Object> map) {
		return classMapper.classListCount(map);
	}

	public List<ClassVO> classList(Map<String, Object> map) {
		return classMapper.classList(map);
	}

	public void classOpen(ClassVO classVO) {
		classMapper.classOpen(classVO);
	}

	public ClassVO classView(ClassVO classVO) {
		return classMapper.classView(classVO.getcId());
	}

	public void deleteClass(ClassVO classVO) {
		classMapper.deleteClass(classVO.getcId());
	}

	public ClassVO classModifyView(ClassVO classVO) {
		return classMapper.classModifyView(classVO.getcId());
	}

	public void modifyClass(ClassVO classVO) {
		classMapper.modifyClass(classVO);
	}

	public void classJoin(ClassJoinVO classJoinVO) {
		classMapper.classJoin(classJoinVO);
	}

	public String getFilePath(int cId) {
		return classMapper.getFilePath(cId);
	}

	public List<ClassJoinVO> getUserIdList(int class_id) {
		return classMapper.getUserIdList(class_id);
	}

	public int getCurrentUserCount(int class_id) {
		return classMapper.getCurrentUserCount(class_id);
	}

}
