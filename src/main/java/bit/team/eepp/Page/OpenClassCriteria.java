package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class OpenClassCriteria {
	private int page_oc;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public OpenClassCriteria() {
		this.page_oc = 1;
		this.perPageNum = 10;
	}

	public void setPage_oc(int page_oc) {
		if (page_oc <= 0) {
			this.page_oc = 1;
			return;
		}
		this.page_oc = page_oc;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_oc() {
		return page_oc;
	}

	public int getPageStart() {
		return (this.page_oc - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_oc - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "OpenClassCriteria [page_oc=" + page_oc + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
