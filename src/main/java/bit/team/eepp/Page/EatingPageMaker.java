package bit.team.eepp.Page;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import bit.team.eepp.Search.EatingSearchCriteria;

public class EatingPageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private EatingCriteria cri;
	
	public void setCri(EatingCriteria cri) {
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

	public EatingCriteria getCri() {
		return cri;
	}

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage_eating() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	public String makeQuery(int page_eating) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page_eating", page_eating).queryParam("perPageNum", cri.getPerPageNum()).build();
		return uriComponents.toUriString();
	}

	public String makeSearch(int page_eating) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page_eating", page_eating)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", ((EatingSearchCriteria) cri).getSearchType())
				.queryParam("keyword", encoding(((EatingSearchCriteria) cri).getKeyword())).build();
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
