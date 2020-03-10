package bit.team.eepp.Mapper;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import bit.team.eepp.VO.UserVO;

@Repository
public interface FileMapper {
	
//	@Select("select gdsNum, gdsName,gdsImg, gdsThumbImg from tbl_goods order by gdsNum desc")
//	public List<FileVO> fileView() throws Exception; 
//	
//	@Insert("insert into tbl_goods (gdsNum, gdsName, gdsImg, gdsThumbImg) values(tbl_goods_seq.nextval, #{gdsName}, #{gdsImg}, #{gdsThumbImg})")
//	public void fileInsert(FileVO vo) throws Exception ;
	
	//프로필 넣기
	@Update("UPDATE users SET uprofile = '${uprofile}' WHERE user_id = ${user_id}")
	public void profileUpdate(UserVO userVO) throws Exception ;
	
	//스크랩 가져오기
	@Select("select count(*) from scrap where user_id = ${user_id}")
	public int scrapCount() throws Exception;
	
	//내가 쓴글 가져온기
	@Select("select count(bid) from board where user_id = ${user_id}")
	public int myBoardCount() throws Exception;
}