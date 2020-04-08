package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class ReplyReportCriteria {
	private int page_rpr;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public ReplyReportCriteria() {
		this.page_rpr = 1;
		this.perPageNum = 10;
	}

	public void setPage_rpr(int page_rpr) {
		if (page_rpr <= 0) {
			this.page_rpr = 1;
			return;
		}
		this.page_rpr = page_rpr;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_rpr() {
		return page_rpr;
	}

	public int getPageStart() {
		return (this.page_rpr - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_rpr - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "ReplyReportCriteria [page_rpr=" + page_rpr + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
