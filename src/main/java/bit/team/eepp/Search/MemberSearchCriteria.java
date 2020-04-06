package bit.team.eepp.Search;

import bit.team.eepp.Page.MemeberCriteria;

public class MemberSearchCriteria extends MemeberCriteria {

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
		return "MemberSearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}