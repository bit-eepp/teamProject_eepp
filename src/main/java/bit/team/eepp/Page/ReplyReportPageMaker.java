package bit.team.eepp.Page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class ReplyReportPageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private ReplyReportCriteria cri;

	public void setCri(ReplyReportCriteria cri) {
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

	public ReplyReportCriteria getCri() {
		return cri;
	}

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage_rpr() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public String makeQuery(int page_rpr) {
    	// 페이지 이동을 위한 함수
        UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("page_rpr", page_rpr)
        		.queryParam("perPageNum", cri.getPerPageNum()) // page=3&perPageNum=10
        		.build(); // ?page=3&perPageNum=10
        
        // ?page=3&perPageNum=10의 값을 리턴
        return uriComponentsBuilder.toUriString();
    }
}
