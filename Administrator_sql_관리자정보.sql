-- 모든 관리자수 조회
SELECT COUNT(*) FROM administrator

-- 모든 관리자 정보 조회
SELECT * FROM administrator

-- 관리자 검색 카테고리에 따른 관리자 수 조회
<if test='option=="선택"'>
	SELECT count(*) FROM administrator WHERE adm_name LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admNo"'>
	SELECT count(*) FROM administrator WHERE adm_no LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admName"'>
	SELECT count(*) FROM administrator WHERE adm_name LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admId"'>
	SELECT count(*) FROM administrator WHERE adm_id LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admEmail"'>
	SELECT count(*) FROM administrator WHERE adm_email LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>

-- 관리자 검색 카테고리에 따른 관리자 정보 조회
<if test='option=="선택"'>
  SELECT * FROM administrator WHERE adm_name LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admNo"'>
  SELECT * FROM administrator WHERE adm_no LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admName"'>
  SELECT * FROM administrator WHERE adm_name LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admId"'>
  SELECT * FROM administrator WHERE adm_id LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>
<if test='option=="admEmail"'>
  SELECT * FROM administrator WHERE adm_email LIKE CONCAT('%',#{keyword},'%') ORDER BY adm_regdate DESC
</if>

-- 관리자 번호로 관리자 정보 조회
select * from administrator WHERE adm_no = #{admNo}

-- 해당 회원의 모든 평가 삭제
DELETE appraisal FROM bookshelf
	INNER JOIN appraisal ON bookshelf.status_no = appraisal.status_no
WHERE bookshelf.user_no = #{userNo}

-- 평가 활성상태 수정
UPDATE appraisal SET active = #{active} WHERE appraisal_no = #{appraisalNo}