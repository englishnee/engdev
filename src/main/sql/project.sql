
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE book CASCADE CONSTRAINTS;
DROP TABLE room CASCADE CONSTRAINTS;
DROP TABLE mem CASCADE CONSTRAINTS;
DROP TABLE Notice CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
   -- 게시글 기본 넘버 
   b_num  number NOT NULL,
   -- 커뮤니티 글 제목 
   b_sub varchar2(50) NOT NULL,
   -- 커뮤니티 내용 
   b_content varchar2(1000) NOT NULL,
   --  커뮤니티 게시글 작성 날짜 
   b_date date DEFAULT sysdate,
   b_readcount number,
   -- 회원 아이디 
   m_id varchar2(20) NOT NULL UNIQUE,
   b_re_ref number,
   b_re_lev number,
   b_re_seq number,
   PRIMARY KEY (b_num )
);

SELECT * FROM board;


CREATE TABLE book
(
   -- 예약번호 
   k_num number NOT NULL,
   -- 예약 날짜 
   k_date date NOT NULL,
   -- 금액 
   k_cost number,
   k_content varchar2(500),
   k_dog varchar2(50),
   k_kg number,
   K_cos varchar2(100),
   K_dogname varchar2(50),
   K_age number,
   -- 카페 리스트 식별자 
   r_num number NOT NULL,
   PRIMARY KEY (k_num)
);

SELECT * FROM book;


CREATE TABLE mem
(
   -- 회원 아이디 
   m_id varchar2(20) NOT NULL,
   -- 맴버 비밀번호 
   m_pw varchar2(20) NOT NULL,
   -- 사용자 이름 
   m_name varchar2(30) NOT NULL,
   -- 전화번호 
   m_tel number(20) NOT NULL,
   -- 이메일
   m_email varchar2(50) NOT NULL,
   PRIMARY KEY (m_id)
);

SELECT * FROM mem;


CREATE TABLE Notice
(
   -- 글 넘버 
   n_num number(10) NOT NULL,
   -- 공지사항 제목 
   n_sub varchar2(50) NOT NULL,
   -- 공지사항 내용 
   n_content  varchar2(1000) NOT NULL,
   n_date date DEFAULT sysdate,
   PRIMARY KEY (n_num)
);

SELECT * FROM Notice;


CREATE TABLE room
(
   -- 카페 리스트 식별자 
   r_num number NOT NULL,
   r_name varchar2(50) NOT NULL,
   r_content varchar2(1000) NOT NULL,
   -- 추천수 
   r_cost number DEFAULT 0,
   -- 회원 아이디 
   m_id varchar2(20) NOT NULL UNIQUE,
   PRIMARY KEY (r_num)
);

SELECT * FROM room;

/* Create Foreign Keys */

ALTER TABLE board
   ADD FOREIGN KEY (m_id)
   REFERENCES mem (m_id)
;


ALTER TABLE room
   ADD FOREIGN KEY (m_id)
   REFERENCES mem (m_id)
;


ALTER TABLE book
   ADD FOREIGN KEY (r_num)
   REFERENCES room (r_num)
;



/* Comments */

COMMENT ON COLUMN board.b_num  IS '게시글 기본 넘버 ';
COMMENT ON COLUMN board.b_sub IS '커뮤니티 글 제목 ';
COMMENT ON COLUMN board.b_content IS '커뮤니티 내용 ';
COMMENT ON COLUMN board.b_date IS ' 커뮤니티 게시글 작성 날짜 ';
COMMENT ON COLUMN board.m_id IS '회원 아이디 ';
COMMENT ON COLUMN book.k_num IS '예약번호 ';
COMMENT ON COLUMN book.k_date IS '예약 날짜 ';
COMMENT ON COLUMN book.k_cost IS '금액 ';
COMMENT ON COLUMN book.r_num IS '카페 리스트 식별자 ';
COMMENT ON COLUMN mem.m_id IS '회원 아이디 ';
COMMENT ON COLUMN mem.m_pw IS '맴버 비밀번호 ';
COMMENT ON COLUMN mem.m_name IS '사용자 이름 ';
COMMENT ON COLUMN mem.m_tel IS '전화번호 ';
COMMENT ON COLUMN mem.m_email IS '이메일';
COMMENT ON COLUMN Notice.n_num IS '글 넘버 ';
COMMENT ON COLUMN Notice.n_sub IS '공지사항 제목 ';
COMMENT ON COLUMN Notice.n_content  IS '공지사항 내용 ';
COMMENT ON COLUMN room.r_num IS '카페 리스트 식별자 ';
COMMENT ON COLUMN room.r_cost IS '추천수 ';
COMMENT ON COLUMN room.m_id IS '회원 아이디 ';
