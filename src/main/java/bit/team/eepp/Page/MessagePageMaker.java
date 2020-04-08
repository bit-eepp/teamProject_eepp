package bit.team.eepp.Page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class MessagePageMaker {
	
	private MessageCriteria cri;
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 8;
	private int tempEndPage;

	// 전체 필드 변수들 세팅 : 전체 게시글 수의 setter가 호출될 때 전체 세팅되도록 함
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
 
        calcData();
    }
    
    // 전체 필드 변수 값들을 계산하는 메서드
    // totalCount의 값에 따라 전체 변수들의 값을 setting해주는 메소드
    private void calcData() {
    	
    	// 현재페이지 정보로 부터 끝페이지에 대한 연산
    	// ex) 현재 페이지(pageInfo.getPage()) = 3
    	// 하단 페이징 바에 보여줄 페이징바 개수 = displayPageNum = 10개
    	// 연산 : ceil(3 / 10.0) * 10 => 1 * 10 = 10까지
    	// 1. (3/10.0) = 0.3
    	// 2. ceil(0.3) = 1
    	// 3. 1* 10 = 10
    	// 1 2 3 4 5 6 7 8 9 10

    	// ex2) 현재 페이지 (pageInfo.getPage()) = 13
    	// 하단 페이징 바에 보여줄 페이징바 개수 = diplayPageNum = 10개
    	// 연산 : ceil(13/10.0) * 10 => 2 * 10 = 20까지
    	// 11 12 13 14 15 16 17 18 19 20
        endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
 
        // 끝페이지 정보로 부터 현재 페이지에 대한 연산
     	// ex) 현재페이지 pageInfo.getPage()) = 3
     	// 끝페이지 endPage = 10
     	// 하단 페이징 바에 보여줄 페이징바 개수 = displayPageNum = 10
     	// 시작페이지 = (10 - 10) + 1 = 1

     	// 현재페이지 3으로부터 endPage를 연산한후(10)
     	// 해당 연산결과로 시작페이지의 값을 연산

     	// ex) 현재페이지 pageInfo.getPage()) = 13
     	// 끝페이지 endPage = 20
     	// 하단 페이징 바에 보여줄 페이징바 개수 = displayPageNum = 10
     	// 시작페이지 = (20 - 10) + 1 = 11
        startPage = (endPage - displayPageNum) + 1;
 
        int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
        // 전체 총 페이지수 :
     	// totalCount = select count(*) from tbl_count의 결과값
     	// pageInfo.getPerPageNum = 한 화면에 출력할 행의 개수
     	// ex) totalCount = 512
     	// pageInfo.getPerPageNum = 10
     	// tempEndPage = ceil(512 / 10.0) = 52
     	// 51.2의결과를 올림 => 51페이지 까지는 한 화면당 10개의 게시물이 출력
     	// 마지막 52페이지에는 0.2에 해당하는 2개의 게시물이 출력
        
        this.tempEndPage = tempEndPage;
 
        if (endPage > tempEndPage) {
            endPage = tempEndPage;
        }
        
        // 1페이지면 이전 버튼 '<<' 누를 수 없게 false
        prev = startPage == 1 ? false : true;
        // ====> 총 100페이지, 출력하는 페이지가 90~100일때 우측의 '>>'버튼 생략
        next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
 
    }
 
    // getter setter
    public MessageCriteria getCri() {
        return cri;
    }
    
    public void setCri(MessageCriteria cri) {
        this.cri = cri;
    }
 
    public int getTempEndPage() {
        return tempEndPage;
    }
 
    public int getTotalCount() {
        return totalCount;
    }
 
    public int getStartPage() {
        return startPage;
    }
 
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
 
    public int getEndPage() {
        return endPage;
    }
 
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
 
    public boolean isPrev() {
        return prev;
    }
 
    public void setPrev(boolean prev) {
        this.prev = prev;
    }
 
    public boolean isNext() {
        return next;
    }
 
    public void setNext(boolean next) {
        this.next = next;
    }
 
    public int getDisplayPageNum() {
        return displayPageNum;
    }
 
    public void setDisplayPageNum(int displayPageNum) {
        this.displayPageNum = displayPageNum;
    }
    
    public String makeQuery(int page) {
    	// 페이지 이동을 위한 함수
        UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("page", page)
        		.queryParam("perPageNum", cri.getPerPageNum()) // page=3&perPageNum=10
        		.build(); // ?page=3&perPageNum=10
        
        // ?page=3&perPageNum=10의 값을 리턴
        return uriComponentsBuilder.toUriString();
    }

}
