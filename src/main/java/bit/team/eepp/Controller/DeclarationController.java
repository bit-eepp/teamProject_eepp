package bit.team.eepp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Service.DeclarationService;
import bit.team.eepp.VO.DeclarationVO;

@RequestMapping("/declaration")
@RestController
public class DeclarationController {
	@Autowired
	private DeclarationService declarationService;

	@RequestMapping("/doDeclaration")
	public void doDeclaration(DeclarationVO declarationVO) {
		System.out.println("doDeclaration() method");
		declarationService.doDeclaration(declarationVO);
	}
	
	@RequestMapping("/doRpDeclaration")
	public void doRpDeclaration(DeclarationVO declarationVO) {
		System.out.println("doRpDeclaration() method");
		declarationService.doRpDeclaration(declarationVO);
	}

}
