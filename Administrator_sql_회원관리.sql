-- 모든 회원 정보 조회
select * from user

-- 모든 회원수 조회
SELECT COUNT(*) FROM user

-- 회원 검색 카테고리에 따른 회원 정보 조회
<if test='option=="선택"'>
	SELECT * FROM user WHERE name 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY reg_date DESC
</if>
<if test='option=="userNo"'>
	SELECT * FROM user WHERE user_no 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY reg_date DESC
</if>
<if test='option=="name"'>
	SELECT * FROM user WHERE name 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY reg_date DESC
</if>
<if test='option=="id"'>
	SELECT * FROM user WHERE id 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY reg_date DESC
</if>
<if test='option=="email"'>
	SELECT * FROM user WHERE email 
	LIKE CONCAT('%',#{keyword},'%') ORDER BY reg_date DESC
</if>

-- 회원 번호로 회원 정보 조회
SELECT * FROM user WHERE user_no=#{userNo}

-- 회원 검색 카테고리에 따른 회원수 조회
<if test='option=="선택"'>
	SELECT count(*) FROM user 
		WHERE name LIKE CONCAT('%',#{keyword},'%') 
	ORDER BY reg_date DESC
</if>
<if test='option=="userNo"'>
	SELECT count(*) FROM user 
		WHERE user_no LIKE CONCAT('%',#{keyword},'%') 
	ORDER BY reg_date DESC
</if>
<if test='option=="name"'>
	SELECT count(*) FROM user 
		WHERE name LIKE CONCAT('%',#{keyword},'%') 
	ORDER BY reg_date DESC
</if>
<if test='option=="id"'>
	SELECT count(*) FROM user 
		WHERE id LIKE CONCAT('%',#{keyword},'%') 
	ORDER BY reg_date DESC
</if>
<if test='option=="email"'>
	SELECT count(*) FROM user 
		WHERE email LIKE CONCAT('%',#{keyword},'%') 
	ORDER BY reg_date DESC
</if>