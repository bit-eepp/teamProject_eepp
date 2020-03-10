package bit.team.eepp.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.team.eepp.Mapper.FileMapper;
import bit.team.eepp.VO.UserVO;

@Service
public class FileService {
	@Autowired
	FileMapper fm;

//	public List<FileVO> fileView() throws Exception {
//		return fm.fileView();
//	}
//
//	public void fileInsert(FileVO vo) throws Exception {
//		fm.fileInsert(vo);
//	}
	
	public void profileUpdate(UserVO userVO) throws Exception {
		fm.profileUpdate(userVO);
	}
	
	public int scrapCount() throws Exception {
		return fm.scrapCount();
	}
	
	public int myBoardCount() throws Exception{
		return fm.myBoardCount();
	}
	
//	public UserVO profileView(UserVO userVO) throws Exception {
//		return fm.profileView(userVO);
//	}
}