package bit.team.eepp.Search;

import bit.team.eepp.Page.MypageCriteria;

public class MypageSearchCriteria extends MypageCriteria {

	private String searchType = "";
	private String keyword = "";

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "MypageSearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}