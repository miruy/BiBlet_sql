create table user(
	USER_NO int primary key auto_increment, -- 회원번호(PK)
	NAME varchar(50) not null, -- 이름
	ID varchar(100) not null, -- ID
	PASS varchar(200) not null, -- 비밀번호
	REG_DATE datetime not null, -- 가입날짜
	EMAIL varchar(400) not null, -- 이메일
	ORIGIN_PIC varchar(500) not null, -- 프로필 사진의 원본 이름
	STORED_PIC varchar(500), -- 프로필 사진의 저장되는 이름
	AUTH_KEY varchar(200), -- 이메일 인증을 위한 인증 키 
	AUTH_STATUS int default '0' not null -- 이메일 인증을 위한 인증 상태
);

-- 회원 회원가입
INSERT INTO user (name, id, pass, reg_date, email, origin_pic, stored_pic, auth_key, auth_status)
VALUES (#{name}, #{id}, #{pass}, now(), #{email}, #{originPic}, #{storedPic}, #{authKey}, #{authStatus})

-- 회원 이메일 조회
SELECT COUNT(*) FROM user WHERE email=#{email}

-- 회원 ID 조회
SELECT COUNT(*) FROM user WHERE id=#{id}

-- 회원 인증키 조회
SELECT auth_key FROM user WHERE email=#{email}

-- 회원 ID 중복 조회
SELECT * FROM user WHERE id=#{id}

-- 회원번호로 회원정보 조회
SELECT * FROM user WHERE user_no=#{userNo}

-- 이메일, 비밀번호로 회원 ID 조회
SELECT id FROM user WHERE email=#{email} AND pass=#{pass}

-- 회원 인증키 수정
UPDATE user SET auth_key=#{authKey} WHERE email=#{email}

-- 회원 인증상태 수정
UPDATE user SET auth_status=1 WHERE auth_key=#{authKey} and email=#{email}

-- 회원 삭제
DELETE FROM user WHERE user_no = #{userNo}

-- 회원 정보 수정
UPDATE user 
SET origin_pic = #{originPic}, stored_pic = #{storedPic}, id = #{id}, email = #{email}, pass = #{pass} WHERE user_no = #{userNo}

-- 기본 프로필로 수정
UPDATE user SET origin_pic='profile.png', stored_pic=NULL WHERE user_no = #{userNo};