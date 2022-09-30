create table administrator(
	ADM_NO int primary key auto_increment, -- 관리자 번호(PK)
	ADM_NAME varchar(50) not null, -- 이름
	ADM_ID varchar(100) not null, -- ID
	ADM_PASS varchar(200) not null, -- 비밀번호
	ADM_REGDATE datetime not null, -- 가입날짜
	ADM_EMAIL varchar(400) not null, -- 이메일
	ADM_AUTHKEY varchar(200), -- 이메일 인증을 위한 인증 키 
	ADM_AUTHSTATUS int default '0' not null, -- 이메일 인증을 위한 인증 상태
	SECURITYCODE varchar(20) -- 회원가입 보안코드
);
    
-- 관리자 회원가입
INSERT INTO administrator (adm_name, adm_id, adm_pass, adm_regdate, adm_email, adm_authkey, adm_authstatus, securitycode)
VALUES (#{admName}, #{admId}, #{admPass}, now(), #{admEmail}, #{admAuthkey}, #{admAuthstatus}, #{securitycode})

-- 관리자 이메일 조회
SELECT COUNT(*) FROM administrator WHERE adm_email=#{admEmail}

-- 관리자 ID 조회
SELECT COUNT(*) FROM administrator WHERE adm_id=#{admId}

-- 인증키 수정
UPDATE administrator SET adm_authkey=#{admAuthkey} WHERE adm_email=#{admEmail}

-- 인증상태 수정
UPDATE administrator SET adm_authstatus='1' WHERE adm_email=#{adm_email}

-- ID로 관리자 정보 조회
SELECT * FROM administrator WHERE adm_id=#{admId}