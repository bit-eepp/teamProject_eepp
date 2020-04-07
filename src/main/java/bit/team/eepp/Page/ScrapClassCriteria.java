package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class ScrapClassCriteria {
	private int page_scc;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public ScrapClassCriteria() {
		this.page_scc = 1;
		this.perPageNum = 10;
	}

	public void setPage_scc(int page_scc) {
		if (page_scc <= 0) {
			this.page_scc = 1;
			return;
		}
		this.page_scc = page_scc;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_scc() {
		return page_scc;
	}

	public int getPageStart() {
		return (this.page_scc - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_scc - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "ScrapClassCriteria [page_scc=" + page_scc + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
