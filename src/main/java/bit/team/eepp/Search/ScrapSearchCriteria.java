package bit.team.eepp.Search;

import bit.team.eepp.Page.ScrapCriteria;

public class ScrapSearchCriteria extends ScrapCriteria {

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
		return "ScrapSearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}