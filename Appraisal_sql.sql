create table appraisal(
	APPRAISAL_NO int primary key auto_increment, -- 평가번호(PK)
	STAR int, -- 평점(별점)
	COMMENT varchar(4000), -- 평가(코멘트)
	START_DATE varchar(50), -- 독서 시작날짜
	END_DATE varchar(50), -- 독서 완료날짜
	CO_PRV varchar(200), -- 평가 공개 여부
	active int default '1' not null, -- 활성상태
	STATUS_NO int not null, -- 상태번호(FK)
);
    
-- 평가 작성
INSERT INTO appraisal(comment, start_date, end_date, co_prv, status_no, active)
VALUES (#{comment}, #{startDate}, #{endDate}, #{coPrv}, #{statusNo}, 1)

-- 해당 도서(ISBN)의 대한 해당 회원(userNo)의 평가 조회
SELECT appraisal.comment,
       appraisal.start_date,
       appraisal.end_date,
       appraisal.active,
       user.id,
       user.name,
       user.stored_pic,
       user.origin_pic
FROM bookshelf
    INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON bookshelf.user_no = user.user_no
WHERE bookshelf.isbn=#{isbn} AND user.user_no=#{userNo} AND bookshelf.status=2 AND appraisal.comment IS NOT NULL

-- 해당 도서(ISBN)의 대한 해당 회원(userNo)의 평가 수정
UPDATE appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON user.user_no = bookshelf.user_no
SET comment=#{comment}, start_date=#{startDate},end_date=#{endDate}, co_prv=#{coPrv}
WHERE bookshelf.isbn=#{isbn} AND user.user_no=#{userNo} AND bookshelf.status=2

-- 해당 도서(ISBN)의 대한 해당 회원(userNo)의 평가 삭제
DELETE appraisal, bookshelf FROM appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE user.user_no=#{userNo} AND bookshelf.isbn=#{isbn} AND bookshelf.status=2

-- 해당 도서(ISBN)의 대한 평균 평점 조회
SELECT AVG(star) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE isbn = #{isbn}

-- 해당 도서(ISBN)의 대한 평점 개수 조회
SELECT COUNT(star) FROM appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE isbn = #{isbn}

-- 평점 등록
INSERT INTO appraisal(star, status_no, co_prv) 
VALUES (#{star}, #{statusNo}, '공개')

-- 평점 수정
UPDATE appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON user.user_no = bookshelf.user_no
SET star=#{star} 
	WHERE bookshelf.isbn=#{isbn} AND user.user_no=#{userNo}

-- 평점 삭제
DELETE appraisal, bookshelf FROM appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE user.user_no=#{userNo} AND bookshelf.isbn=#{isbn} AND star=#{star}

-- 해당 도서(ISBN)의 대한 해당 회원(userNo)의 평점 조회
SELECT star FROM appraisal
    INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE isbn = #{isbn} AND user_no = #{userNo} AND star IS NOT NULL

-- 모든 평가 조회
SELECT appraisal.appraisal_no,
			 appraisal.comment,
			 appraisal.active,
			 appraisal.start_date,
			 appraisal.end_date,
			 appraisal.status_no,
			 user.id,
			 user.name,
			 user.stored_pic,
			 user.origin_pic,
			 user.pass
FROM bookshelf
		INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
		INNER JOIN user ON bookshelf.user_no = user.user_no
WHERE bookshelf.isbn = #{isbn} AND appraisal.co_prv = '공개' AND appraisal.comment IS NOT NULL

-- 모든 평점 조회
SELECT appraisal.star,
       user.id
FROM bookshelf
    INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
    INNER JOIN user ON bookshelf.user_no = user.user_no
WHERE bookshelf.isbn = #{isbn} AND star IS NOT NULL

-- 모든 평가 개수 조회
SELECT COUNT(comment) FROM bookshelf
    INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
WHERE bookshelf.isbn = #{isbn} AND appraisal.co_prv = '공개'

-- Kakao 로그인 회원의 이름 조회
SELECT name FROM user WHERE id = #{id}

-- 최근 평가 5개
SELECT bookshelf.isbn,
       appraisal.appraisal_no,
       appraisal.star,
       appraisal.comment,
       appraisal.active,
       user.id,
       user.name,
       user.user_no,
       user.stored_pic,
       user.origin_pic
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON bookshelf.user_no = user.user_no
WHERE appraisal.co_prv = '공개' AND appraisal.comment IS NOT NULL 
ORDER BY appraisal.appraisal_no DESC limit 5

-- 최근 평점 5개
SELECT star FROM appraisal
INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE isbn = #{isbn} AND user_no = #{userNo}

-- 해당 회원(userNo)의 모든 평가 개수 조회
SELECT COUNT(comment) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE user.user_no = #{userNo}

-- 해당 회원(userNo)의 모든 평점 개수 조회
SELECT COUNT(star) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE user.user_no = #{userNo}

-- 해당 회원(userNo)의 모든 평가 정보 조회
SELECT bookshelf.isbn,
	     appraisal.comment,
	     appraisal.active,
	     appraisal.start_date,
	     appraisal.end_date,
	     appraisal.appraisal_no,
	     appraisal.co_prv
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE bookshelf.user_no = #{userNo} AND appraisal.comment IS NOT NULL

-- 해당 회원(userNo)의 모든 평점 정보 조회
SELECT appraisal.star,
	     bookshelf.isbn
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
WHERE bookshelf.user_no = #{userNo} 
ORDER BY appraisal.appraisal_no DESC limit 5