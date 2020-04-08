package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class JoinClassCriteria {
	private int page_join;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public JoinClassCriteria() {
		this.page_join = 1;
		this.perPageNum = 10;
	}

	public void setPage_join(int page_join) {
		if (page_join <= 0) {
			this.page_join = 1;
			return;
		}
		this.page_join = page_join;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_join() {
		return page_join;
	}

	public int getPageStart() {
		return (this.page_join - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_join - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "JoinClassCriteria [page_join=" + page_join + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
