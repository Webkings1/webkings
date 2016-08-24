/* 회원 */
CREATE TABLE MEMBER (
	M_NO NUMBER NOT NULL, /* 회원번호 */
	M_TYPE CHAR(1) DEFAULT '1' NOT NULL, /* 회원구분값 */
	M_EMAIL VARCHAR2(100) NOT NULL, /* 이메일 */
	M_NICK VARCHAR2(100) NOT NULL, /* 닉네임 */
	M_PWD VARCHAR2(100) NOT NULL, /* 비밀번호 */
	M_REGDATE DATE DEFAULT sysdate NOT NULL, /* 회원등록일 */
	M_CHGDATE DATE /* 회원수정일 */
);

ALTER TABLE MEMBER
	ADD
		CONSTRAINT PK_MEMBER
		PRIMARY KEY (
			M_NO
		);

/* 쇼핑몰 */
CREATE TABLE SHOP (
	S_NO NUMBER NOT NULL, /* 쇼핑몰관리번호 */
	S_DOMAIN VARCHAR2(200) NOT NULL, /* 쇼핑몰도메인 */
	S_MSYN CHAR(1) DEFAULT 'N' NOT NULL, /* 모바일사이트유무 */
	S_NAME VARCHAR2(200) NOT NULL, /* 쇼핑몰명 */
	S_BIMAGE VARCHAR2(200), /* 쇼핑몰큰이미지 */
	S_SIMAGE VARCHAR2(200), /* 쇼핑몰작은이미지 */
	S_BINFO CLOB, /* 쇼핑몰큰설명 */
	S_SINFO CLOB, /* 쇼핑몰작은설명 */
	S_GENDER CHAR(1) NOT NULL, /* 쇼핑몰성별구분값 */
	S_AGE CHAR(1) NOT NULL, /* 쇼핑몰연령대구분값 */
	S_STYLE CHAR(2) DEFAULT '00' NOT NULL, /* 쇼핑몰스타일구분값 */
	S_STAFF VARCHAR2(200) NOT NULL, /* 담당자명 */
	S_DEP VARCHAR2(200), /* 부서명 */
	S_POSITION VARCHAR2(200), /* 직급 */
	S_TEL VARCHAR2(200), /* 담당자전화번호 */
	S_PHONE VARCHAR2(200), /* 담당자휴대폰 */
	S_EMAIL VARCHAR2(200), /* 담당자이메일 */
	S_HIT NUMBER DEFAULT 0 NOT NULL, /* 조회수 */
	S_ACCYN CHAR(1) DEFAULT 'N' NOT NULL, /* 광고신청유무 */
	S_ACCDATE DATE, /* 광고신청일 */
	S_PAYYN CHAR(1) DEFAULT 'N' NOT NULL, /* 결제확인유무 */
	S_REGDATE DATE DEFAULT SYSDATE NOT NULL, /* 쇼핑몰등록일 */
	S_CHGDATE DATE, /* 쇼핑몰수정일 */
	C_NO NUMBER NOT NULL /* 사업자등록번호 */
);

ALTER TABLE SHOP
	ADD
		CONSTRAINT PK_SHOP
		PRIMARY KEY (
			S_NO
		);

/* 문의 */
CREATE TABLE QNA (
	Q_NO NUMBER NOT NULL, /* 문의번호 */
	Q_TITLE VARCHAR2(200) NOT NULL, /* 문의제목 */
	Q_CONTENT CLOB NOT NULL, /* 문의내용 */
	Q_EMAIL VARCHAR2(200) NOT NULL, /* 문의이메일 */
	Q_TEL VARCHAR2(200) NOT NULL, /* 문의연락처 */
	Q_REGDATE DATE DEFAULT SYSDATE NOT NULL, /* 문의등록일 */
	M_NO NUMBER NOT NULL /* 회원번호 */
);

ALTER TABLE QNA
	ADD
		CONSTRAINT PK_QNA
		PRIMARY KEY (
			Q_NO
		);

/* 자유게시판 */
CREATE TABLE FREEBOARD (
	B_NO NUMBER NOT NULL, /* 글번호 */
	B_TITLE VARCHAR2(200) NOT NULL, /* 글제목 */
	B_CONTENT CLOB NOT NULL, /* 글내용 */
	B_FILENAME VARCHAR2(200), /* 업로드파일명 */
	B_FILESIZE NUMBER, /* 파일크기 */
	B_ORIGINALFILENAME VARCHAR2(200), /* 파일명 */
	B_REGDATE DATE DEFAULT SYSDATE NOT NULL, /* 글등록일 */
	B_CHGDATE DATE, /* 글수정일 */
	M_NO NUMBER NOT NULL /* 회원번호 */
);

ALTER TABLE FREEBOARD
	ADD
		CONSTRAINT PK_FREEBOARD
		PRIMARY KEY (
			B_NO
		);

/* 결제 */
CREATE TABLE PAYMENT (
	P_NO NUMBER NOT NULL, /* 광고등록번호 */
	P_YEAR VARCHAR2(4) NOT NULL, /* 결제년도 */
	P_MONTH VARCHAR2(2) NOT NULL, /* 결제월 */
	P_DAY VARCHAR2(8) NOT NULL, /* 결제년월일 */
	P_REGDATE DATE NOT NULL, /* 광고등록일 */
	P_EXTDATE DATE NOT NULL, /* 광고만료일 */
	S_NO NUMBER NOT NULL /* 쇼핑몰관리번호 */
);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT PK_PAYMENT
		PRIMARY KEY (
			P_NO,
			P_YEAR,
			P_MONTH
		);

/* 댓글 */
CREATE TABLE REPLY (
	R_NO NUMBER NOT NULL, /* 댓글번호 */
	R_NO_GROUP NUMBER NOT NULL, /* 댓글번호구분값 */
	R_GBN NUMBER NOT NULL, /* 댓글구분값 */
	R_CONTENT CLOB NOT NULL, /* 댓글내용 */
	R_REGDATE DATE DEFAULT SYSDATE NOT NULL, /* 댓글등록일 */
	R_CHGDATE DATE, /* 댓글수정일 */
	B_NO NUMBER NOT NULL /* 글번호 */
);

ALTER TABLE REPLY
	ADD
		CONSTRAINT PK_REPLY
		PRIMARY KEY (
			R_NO
		);

/* 사업자 */
CREATE TABLE CHIEF (
	C_NO NUMBER NOT NULL, /* 사업자등록번호 */
	C_NUMBER VARCHAR2(100) NOT NULL, /* 사업자번호 */
	C_EMAIL VARCHAR2(100), /* 사업자이메일 */
	C_PWD VARCHAR2(100), /* 사업자비밀번호 */
	C_NAME VARCHAR2(100), /* 사업자명 */
	C_CNAME VARCHAR2(200), /* 사업장명 */
	C_ADD VARCHAR2(200), /* 사업장주소 */
	C_REGDATE DATE DEFAULT SYSDATE NOT NULL, /* 사업자등록일 */
	C_CHGDATE DATE /* 사업자수정일 */
);

ALTER TABLE CHIEF
	ADD
		CONSTRAINT PK_CHIEF
		PRIMARY KEY (
			C_NO
		);

ALTER TABLE SHOP
	ADD
		CONSTRAINT FK_CHIEF_TO_SHOP
		FOREIGN KEY (
			C_NO
		)
		REFERENCES CHIEF (
			C_NO
		);

ALTER TABLE QNA
	ADD
		CONSTRAINT FK_MEMBER_TO_QNA
		FOREIGN KEY (
			M_NO
		)
		REFERENCES MEMBER (
			M_NO
		);

ALTER TABLE FREEBOARD
	ADD
		CONSTRAINT FK_MEMBER_TO_FREEBOARD
		FOREIGN KEY (
			M_NO
		)
		REFERENCES MEMBER (
			M_NO
		);

ALTER TABLE PAYMENT
	ADD
		CONSTRAINT FK_SHOP_TO_PAYMENT
		FOREIGN KEY (
			S_NO
		)
		REFERENCES SHOP (
			S_NO
		);

ALTER TABLE REPLY
	ADD
		CONSTRAINT FK_FREEBOARD_TO_REPLY
		FOREIGN KEY (
			B_NO
		)
		REFERENCES FREEBOARD (
			B_NO
		);