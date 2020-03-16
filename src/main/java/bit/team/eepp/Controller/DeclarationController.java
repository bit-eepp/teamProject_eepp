package bit.team.eepp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import bit.team.eepp.Service.DeclarationService;
import bit.team.eepp.Service.UserService;
import bit.team.eepp.VO.DeclarationVO;
import bit.team.eepp.VO.MessageVO;

@RequestMapping("/declaration")
@RestController
public class DeclarationController {
	@Autowired
	private DeclarationService declarationService;
	@Autowired
	private UserService us;

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
	
	@RequestMapping("/doMsgDeclaration")
	public void doMsgDeclaration(DeclarationVO declarationVO) {
		System.out.println("doMsgDeclaration() method");
		
		declarationService.doMsgDeclaration(declarationVO);
		MessageVO message = new MessageVO();
		message.setMid(declarationVO.getMid());
		us.reportMessage(message);
	}
	
	@RequestMapping("/doUserDeclaration")
	public void doUserDeclaration(DeclarationVO declarationVO) {
		System.out.println("doUserDeclaration() method");
		
		declarationService.doUserDeclaration(declarationVO);
	}

}
