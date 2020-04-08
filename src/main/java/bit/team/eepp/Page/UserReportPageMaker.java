package bit.team.eepp.Page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class UserReportPageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private UserReportCriteria cri;

	public void setCri(UserReportCriteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public UserReportCriteria getCri() {
		return cri;
	}

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage_urp() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public String makeQuery(int page_urp) {
    	// 페이지 이동을 위한 함수
        UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("page_urp", page_urp)
        		.queryParam("perPageNum", cri.getPerPageNum()) // page=3&perPageNum=10
        		.build(); // ?page=3&perPageNum=10
        
        // ?page=3&perPageNum=10의 값을 리턴
        return uriComponentsBuilder.toUriString();
    }
}
