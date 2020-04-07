package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class PointCriteria {
	private int page_po;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public PointCriteria() {
		this.page_po = 1;
		this.perPageNum = 10;
	}

	public void setPage_po(int page_po) {
		if (page_po <= 0) {
			this.page_po = 1;
			return;
		}
		this.page_po = page_po;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_po() {
		return page_po;
	}

	public int getPageStart() {
		return (this.page_po - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_po - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "PointCriteria [page_po=" + page_po + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
