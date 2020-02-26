package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
public interface RecommendMapper {
	public abstract int blikeCount(@Param("bId") int bId);

	public abstract void blikeUp(@Param("bId") int bId);

	public abstract int bUnlikeCount(@Param("bId") int bId);

	public abstract void bUnlikeUp(@Param("bId") int bId);

	public abstract int rplikeCount(@Param("rpId") int rpId);

	public abstract void rplikeUp(@Param("rpId") int rpId);

	public abstract int rpUnlikeCount(@Param("rpId") int rpId);

	public abstract void rpUnlikeUp(@Param("rpId") int rpId);

}
