package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class MyReviewCriteria {
	private int page_rv;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public MyReviewCriteria() {
		this.page_rv = 1;
		this.perPageNum = 10;
	}

	public void setPage_rv(int page_rv) {
		if (page_rv <= 0) {
			this.page_rv = 1;
			return;
		}
		this.page_rv = page_rv;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_rv() {
		return page_rv;
	}

	public int getPageStart() {
		return (this.page_rv - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_rv - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "MyReviewCriteria [page_rv=" + page_rv + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
