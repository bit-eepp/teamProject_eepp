package bit.team.eepp.Page;

// 한페이지에 담아내야할 것들을 모음
public class UserReportCriteria {
	private int page_urp;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;

	public UserReportCriteria() {
		this.page_urp = 1;
		this.perPageNum = 10;
	}

	public void setPage_urp(int page_urp) {
		if (page_urp <= 0) {
			this.page_urp = 1;
			return;
		}
		this.page_urp = page_urp;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	public int getPage_urp() {
		return page_urp;
	}

	public int getPageStart() {
		return (this.page_urp - 1) * perPageNum;
	}

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public int getRowStart() {
		rowStart = ((page_urp - 1) * perPageNum) + 1;
		return rowStart;
	}

	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "UserReportCriteria [page_urp=" + page_urp + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
