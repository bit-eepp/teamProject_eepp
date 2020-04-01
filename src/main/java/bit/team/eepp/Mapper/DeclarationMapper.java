package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.DeclarationVO;

@Repository
public interface DeclarationMapper {

	public abstract void doDeclaration(@Param("declarationVO") DeclarationVO declarationVO);

	public abstract void doRpDeclaration(@Param("declarationVO") DeclarationVO declarationVO);
	
	public abstract void doMsgDeclaration(@Param("declarationVO") DeclarationVO declarationVO);
	
	public abstract void doUserDeclaration(@Param("declarationVO") DeclarationVO declarationVO);
	
	@Select("select count(*) from declaration where reported_id = #{reported_id}")
	public int countUserDeclaration(DeclarationVO declarationVO);
	
	@Update("update users set grade_id = 3 where user_id = #{reported_id}")
	public void updateUserGrade(DeclarationVO declarationVO);

}
