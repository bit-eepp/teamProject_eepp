package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class ScrapCriteria {
	private int page_scrap;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public ScrapCriteria() {
		this.page_scrap = 1;
		this.perPageNum = 10;
	}

	public void setPage_scrap(int page_scb) {
		if (page_scb <= 0) {
			this.page_scrap = 1;
			return;
		}
		this.page_scrap = page_scb;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_scrap() {
		return page_scrap;
	}

	public int getPageStart() {
		return (this.page_scrap - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_scrap - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "ScrapCriteria [page_scrap=" + page_scrap + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
