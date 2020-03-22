package bit.team.eepp.Mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.ClassJoinVO;
import bit.team.eepp.VO.ClassVO;

@Repository
public interface ClassMapper {

	public abstract int classListCount(Map<String, Object> map);

	public abstract List<ClassVO> classList(Map<String, Object> map);

	public abstract void classOpen(@Param("classVO") ClassVO classVO);

	public abstract ClassVO classView(@Param("cId") int cId);

	public abstract void deleteClass(@Param("cId") int cId);

	public abstract ClassVO classModifyView(@Param("cId") int cId);

	public abstract void modifyClass(@Param("classVO") ClassVO classVO);

	public abstract String getFilePath(@Param("cId") int cId);

	public abstract List<ClassJoinVO> getUserIdList(@Param("class_id") int class_id);
	
	public abstract int getCurrentUserCount(@Param("class_id") int class_id);
	
	public abstract void classJoin(@Param("classJoinVO") ClassJoinVO classJoinVO);


}
