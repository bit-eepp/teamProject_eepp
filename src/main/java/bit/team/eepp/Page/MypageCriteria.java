package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class MypageCriteria {
	private int page_my;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public MypageCriteria() {
		this.page_my = 1;
		this.perPageNum = 10;
	}

	public void setPage_my(int page_my) {
		if (page_my <= 0) {
			this.page_my = 1;
			return;
		}
		this.page_my = page_my;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_my() {
		return page_my;
	}

	public int getPageStart() {
		return (this.page_my - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_my - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "MypageCriteria [page_my=" + page_my + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
