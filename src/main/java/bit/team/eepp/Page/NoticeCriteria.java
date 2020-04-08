package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class NoticeCriteria {
	private int page_no;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public NoticeCriteria() {
		this.page_no = 1;
		this.perPageNum = 10;
	}

	public void setPage_no(int page_no) {
		if (page_no <= 0) {
			this.page_no = 1;
			return;
		}
		this.page_no = page_no;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_no() {
		return page_no;
	}

	public int getPageStart() {
		return (this.page_no - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_no - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "NoticeCriteria [page_no=" + page_no + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
