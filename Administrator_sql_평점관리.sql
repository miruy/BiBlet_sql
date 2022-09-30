-- 모든 평점 개수 조회
SELECT COUNT(star) FROM appraisal

-- 모든 평점 정보 조회
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE star IS NOT NULL

-- 평점 검색 카테고리에 따른 평점 정보 조회
<if test='option=="선택"'>
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.name LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="userNo"'>
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.user_no LIKE CONCAT('%',#{keyword},'%')     
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="name"'>
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.name LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="id"'>
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.id LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="kakao"'>
SELECT bookshelf.isbn,
       user.user_no,
       user.stored_pic,
       user.name,
       user.id,
       appraisal.appraisal_no,
       appraisal.star
FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND bookshelf.isbn LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>

-- 평점 검색 카테고리에 따른 평점 개수 조회
<if test='option=="선택"'>
SELECT count(*) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.name LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="userNo"'>
SELECT count(*) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.user_no LIKE CONCAT('%',#{keyword},'%')
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="name"'>
SELECT count(*) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.name LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="id"'>
SELECT count(*) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND user.id LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>
<if test='option=="kakao"'>
SELECT count(*) FROM appraisal
	INNER JOIN bookshelf ON bookshelf.status_no = appraisal.status_no
	INNER JOIN user ON user.user_no = bookshelf.user_no
WHERE appraisal.star IS NOT NULL AND bookshelf.isbn 	LIKE CONCAT('%',#{keyword},'%') 
ORDER BY appraisal.appraisal_no DESC
</if>