create table bookshelf(
	STATUS_NO int primary key auto_increment, -- 상태 번호(PK)
	STATUS int, -- 읽고싶어요 : 0 / 보는 중 : 1 / 별점, 평가 : 2
	ISBN varchar(50) not null, -- 도서 ISBN
	USER_NO int not null -- 회원 번호(FK)
);
    
-- 독서 상태 등록
INSERT INTO bookshelf(status, isbn, user_no) VALUES(#{status}, #{isbn}, #{userNo})

-- 독서 상태 조회
SELECT status FROM bookshelf WHERE isbn=#{isbn} AND user_no=#{userNo}

-- 독서 상태 삭제
DELETE FROM bookshelf WHERE user_no=#{userNo} AND isbn=#{isbn} AND status=#{status}

-- 해당 도서(ISBN)에 평점을 등록한 해당 회원(uerNo)의 독서 상태 번호 조회
SELECT status_no FROM bookshelf WHERE isbn=#{isbn} AND user_no=#{userNo} AND status=2

-- 해당 도서(ISBN)의 대한 해당 회원(uerNo)의 독서 상태 수정
UPDATE bookshelf SET status=#{status} WHERE isbn=#{isbn} AND user_no=#{userNo} AND status=#{beforeStatus}

-- 해당 도서(ISBN)의 대한 해당 회원(uerNo)의 독서 상태 조회
SELECT status FROM bookshelf WHERE isbn = #{isbn} AND user_no = #{userNo}

-- 해당 회원(userNo)이 코멘트를 작성한 모든 도서(ISBN)
SELECT isbn FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE bookshelf.user_no = #{userNo} AND comment IS NOT NULL

-- 해당 회원의 모든 독서 상태 삭제
DELETE FROM bookshelf WHERE user_no = #{userNo}

-- 인기도서 TOP10
SELECT isbn FROM bookshelf
	INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
GROUP BY bookshelf.isbn ORDER BY AVG(appraisal.star) DESC limit 0,10

-- 추천 도서 TOP10
SELECT isbn FROM bookshelf WHERE bookshelf.status = 0 GROUP BY bookshelf.isbn 
ORDER BY SUM(bookshelf.status = 0) DESC limit 0,10

-- 해당 회원(userNo)의 읽고싶은 도서 TOP10 조회
SELECT isbn FROM bookshelf 
WHERE bookshelf.status = 0 AND bookshelf.user_no = #{userNo} 
ORDER BY bookshelf.status_no DESC limit 0,10

-- 해당 회원(userNo)의 읽는 중 도서 TOP10 조회
SELECT isbn FROM bookshelf 
WHERE bookshelf.status = 1 AND bookshelf.user_no = #{userNo} 
ORDER BY bookshelf.status_no DESC limit 0,10

-- 해당 회원(userNo)의 읽고싶은 도서 리스트 조회
SELECT isbn FROM bookshelf WHERE user_no = #{userNo} AND status = 0

-- 해당 회원(userNo)의 읽는 중 도서 리스트 조회
SELECT isbn FROM bookshelf WHERE user_no = #{userNo} AND status = 1