package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.DeclarationVO;

@Repository
public interface DeclarationMapper {

	public abstract void doDeclaration(@Param("declarationVO") DeclarationVO declarationVO);

	public abstract void doRpDeclaration(@Param("declarationVO") DeclarationVO declarationVO);

}
