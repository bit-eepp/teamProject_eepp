package bit.team.eepp.Search;

import bit.team.eepp.Page.ClassCriteria;

public class ClassSearchCriteria extends ClassCriteria {

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
		return "ClassSearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}