package bit.team.eepp.Page;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import bit.team.eepp.Search.MypageSearchCriteria;

public class myPagePageMaker {

	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private MypageCriteria cri;

	public void setCri(MypageCriteria cri) {
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

	public MypageCriteria getCri() {
		return cri;
	}

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage_my() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public String makeQuery(int page_my) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page_my", page_my).queryParam("perPageNum", cri.getPerPageNum()).build();
		return uriComponents.toUriString();
	}

	public String makeSearch(int page_my) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page_my", page_my)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", ((MypageSearchCriteria) cri).getSearchType())
				.queryParam("keyword", encoding(((MypageSearchCriteria) cri).getKeyword())).build();
		return uriComponents.toUriString();
	}

	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}

		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}

}
