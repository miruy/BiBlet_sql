create table notice(
	NOTICE_NO int primary key auto_increment, -- 공지 번호(PK)
	WRITER varchar(300) not null, -- 작성자
	TITLE varchar(300) not null, -- 제목
	CONTENT varchar(4000) not null, -- 내용
	WRITE_DATE datetime not null, -- 등록날짜
	COUNT int default 0 not null, -- 조회수
	ORIGIN_FILE varchar(500), -- 첨부파일 원본 이름
	STORED_FILE varchar(500) -- 첨부파일 저장되는 이름
);
    
-- 모든 공지 개수
select COUNT(*) FROM notice

-- 모든 공지 조회
select * from notice ORDER BY notice_no DESC

-- 공지페이지 번호의 따른 모든 공지사항 조회
<if test='page==1'>
	select * from notice LIMIT 0, 10
</if>
<if test='page==2'>
	select * from notice LIMIT 10, 10
</if>
<if test='page==1'>
	select * from notice LIMIT 20, 10
</if>

-- 조회수 수정
UPDATE notice SET COUNT = COUNT+1 WHERE notice_no = #{noticeNo}

-- 공지사항 상세내용 조회
select * from notice WHERE notice_no = #{noticeNo}

-- 공지 검색 카테고리의 따른 공지사항 리스트 조회
<if test='option=="선택"'>
	SELECT * FROM notice WHERE title 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>
<if test='option=="제목"'>
	SELECT * FROM notice WHERE title 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>
<if test='option=="번호"'>
	SELECT * FROM notice WHERE notice_no 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>

--공지 검색 카테고리의 따른 공지사항 개수 조회
<if test='option=="선택"'>
	SELECT count(*) FROM notice WHERE title 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>
<if test='option=="제목"'>
	SELECT count(*) FROM notice WHERE title 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>
<if test='option=="번호"'>
	SELECT count(*) FROM notice WHERE notice_no 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY write_date DESC
</if>

-- 첨부파일 포함 공지사항 등록
insert into notice (WRITER, WRITE_DATE, TITLE, CONTENT, origin_file, stored_file) 
value (#{writer}, now(), #{title}, #{content}, #{originFile}, #{storedFile})

-- 첨부파일 미포함 공지사항 등록
insert into notice (WRITER, WRITE_DATE, TITLE, CONTENT) value (#{writer}, now(), #{title}, #{content})

-- 첨부파일 포함 공지사항 수정
UPDATE notice SET title = #{title}, content = #{content},
	origin_file = #{originFile}, stored_file = #{storedFile} WHERE notice_no = #{noticeNo}

-- 첨부파일만 삭제
UPDATE notice SET origin_file = NULL, stored_file = NULL WHERE notice_no = #{noticeNo}

-- 공지사항 삭제
DELETE notice FROM notice WHERE notice_no = #{noticeNo}