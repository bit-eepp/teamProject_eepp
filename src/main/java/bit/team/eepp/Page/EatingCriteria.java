package bit.team.eepp.Page;

public class EatingCriteria {
	private int page_eating;
	private int perPageNum;
	private int rowStart;
	private int rowEnd;
	
	public EatingCriteria() {
		//1 페이지 당 n개 
		this.page_eating = 1;
		this.perPageNum = 6;
	}
	
	public void setPage_eating(int page_eating) {
		if(page_eating <= 0) {
			this.page_eating = 1;
			return;
		}
		this.page_eating = page_eating;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		return (this.page_eating -1) * perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page_eating-1) * perPageNum) + 1;
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum -1;
		return rowEnd;
	}
	
	//only return
	public int getPage_eating() {
		return page_eating;
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}
	
	@Override
	public String toString() {
		return "Criteria [page_eating=" + page_eating + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd +"]";
	}
}
