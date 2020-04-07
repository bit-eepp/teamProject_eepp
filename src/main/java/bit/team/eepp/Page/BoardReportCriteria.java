package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class BoardReportCriteria {
	private int page_boardRe;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public BoardReportCriteria() {
		this.page_boardRe = 1;
		this.perPageNum = 10;
	}

	public void setPage_boardRe(int page_boardRe) {
		if (page_boardRe <= 0) {
			this.page_boardRe = 1;
			return;
		}
		this.page_boardRe = page_boardRe;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_boardRe() {
		return page_boardRe;
	}

	public int getPageStart() {
		return (this.page_boardRe - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_boardRe - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "BoardReportCriteria [page_boardRe=" + page_boardRe + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
