package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class MemeberCriteria {
	private int page_member;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public MemeberCriteria() {
		this.page_member = 1;
		this.perPageNum = 10;
	}

	public void setPage_member(int page_member) {
		if (page_member <= 0) {
			this.page_member = 1;
			return;
		}
		this.page_member = page_member;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_member() {
		return page_member;
	}

	public int getPageStart() {
		return (this.page_member - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_member - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "MemeberCriteria [page_member=" + page_member + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
