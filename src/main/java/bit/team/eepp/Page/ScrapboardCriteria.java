package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class ScrapboardCriteria {
	private int page_scb;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public ScrapboardCriteria() {
		this.page_scb = 1;
		this.perPageNum = 10;
	}

	public void setPage_scb(int page_scb) {
		if (page_scb <= 0) {
			this.page_scb = 1;
			return;
		}
		this.page_scb = page_scb;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_scb() {
		return page_scb;
	}

	public int getPageStart() {
		return (this.page_scb - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_scb - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "ScrapboardCriteria [page_scb=" + page_scb + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
