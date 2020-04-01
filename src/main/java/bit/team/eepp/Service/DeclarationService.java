package bit.team.eepp.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.DeclarationMapper;
import bit.team.eepp.VO.DeclarationVO;

@Service
public class DeclarationService {
	@Autowired
	private DeclarationMapper declarationMapper;
	
	public void doDeclaration(DeclarationVO declarationVO) {
		declarationMapper.doDeclaration(declarationVO);
	}

	public void doRpDeclaration(DeclarationVO declarationVO) {
		declarationMapper.doRpDeclaration(declarationVO);
	}
	
	public void doMsgDeclaration(DeclarationVO declarationVO) {
		declarationMapper.doMsgDeclaration(declarationVO);
	}
	
	public void doUserDeclaration(DeclarationVO declarationVO) {
		declarationMapper.doUserDeclaration(declarationVO);
	}
	
	public int countUserDeclaration(DeclarationVO declarationVO) {
		return declarationMapper.countUserDeclaration(declarationVO);
	}
	
	public void updateUserGrade(DeclarationVO declarationVO) {
		declarationMapper.updateUserGrade(declarationVO);
	}

}
