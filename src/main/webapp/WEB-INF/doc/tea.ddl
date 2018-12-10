DROP TABLE reply;
DROP TABLE board;
DROP TABLE contents;
DROP TABLE categrp;
DROP TABLE member_word;
DROP TABLE crawling_data;
DROP TABLE word;
DROP TABLE log;
DROP TABLE member;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno INT NOT NULL AUTO_INCREMENT,
		id VARCHAR(15) NOT NULL,
		name VARCHAR(15) NOT NULL,
		passwd VARCHAR(15) NOT NULL,
		phone VARCHAR(15),
		email VARCHAR(25) NOT NULL,
		birth VARCHAR(20) NOT NULL,
		sex CHAR(1) NOT NULL,
		grade CHAR(1) NOT NULL,
		rdate DATETIME NOT NULL,
		PRIMARY KEY(memberno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO member(id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES('admin', '김지민', '1234', '01021205548', 'ultimate1994@naver.com', '1994-03-17', 'M', 'A', now());

INSERT INTO member(id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES('root', '박우진', '1234', '01000000000', 'park@naver.com', '1993-00-00', 'M', 'A', now());

INSERT INTO member(id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES('root2', 'girl', '1234', '01000000000', 'girl@gmail.com', '1993-00-00', 'F', 'A', now());

/* 모든 레코드 검색 */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

/* 검색 */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE email like "%naver%";

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE name like "김%";

/* 페이징 */
SELECT memberno, id, name
FROM member
ORDER BY memberno ASC
LIMIT 0, 10;

SELECT memberno, id, name
FROM member
ORDER BY memberno ASC
LIMIT 10, 10;

/* 한 건 조회 */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE memberno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM member;

/* 수정 */
UPDATE member
SET member.email='GPARK@naver.com'
WHERE memberno=2;

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

/* 한 건 삭제 */
DELETE FROM member
WHERE memberno=3;

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

---------연관된 테이블 삭제-----------
DELETE FROM log
WHERE memberno=3;

DELETE FROM member_word
WHERE memberno=3;

DELETE FROM reply
WHERE memberno=3;

DELETE FROM board
WHERE memberno=3;

DELETE FROM contents
WHERE memberno=3;
---------연관된 테이블 삭제-----------

DELETE FROM member
WHERE memberno=3;

/********************* DML 종료 *********************/


ALTER TABLE member COMMENT = '회원';
ALTER TABLE member MODIFY memberno INT COMMENT '멤버번호';
ALTER TABLE member MODIFY id VARCHAR(15) COMMENT '아이디';
ALTER TABLE member MODIFY name VARCHAR(15) COMMENT '이름';
ALTER TABLE member MODIFY passwd VARCHAR(15) COMMENT '비밀번호';
ALTER TABLE member MODIFY phone VARCHAR(15) COMMENT '전화번호';
ALTER TABLE member MODIFY email VARCHAR(25) COMMENT '이메일';
ALTER TABLE member MODIFY birth VARCHAR(20) COMMENT '생년월일';
ALTER TABLE member MODIFY sex CHAR(1) COMMENT '성별';
ALTER TABLE member MODIFY grade CHAR(1) COMMENT '등급';

SHOW FULL COLUMNS FROM member;

/**********************************/
/* Table Name: 로그인 내역 */
/**********************************/
CREATE TABLE log(
		logno INT NOT NULL AUTO_INCREMENT,
		ip VARCHAR(20),
		rdate DATETIME NOT NULL,
		sf CHAR(1) NOT NULL,
		memberno INT NOT NULL, 
		PRIMARY KEY(logno),
    FOREIGN KEY(memberno) REFERENCES member(memberno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO log(ip, rdate, sf, memberno) 
VALUES('172.16.12.17', now(), 'T', 1);

INSERT INTO log(ip, rdate, sf, memberno)
VALUES('172.16.12.116', now(), 'F', 2);

/* 모든 레코드 검색 */
SELECT logno, ip, rdate, sf, memberno
FROM log;

/* 검색 */ -- 연도로 검색 할 때의 결과, 월이나 날짜도 검색 가능하게 수정할 예정
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE YEAR(rdate) = '2017';

-- 2018-12-03 ~ 2018-12-31 사이의 로그 검색
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-31';

SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE DATE(rdate) BETWEEN '2018-12-01' AND '2018-12-02';

/* 페이징 */

/* 한 건 조회 */
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE logno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM log

/* FK에 따른 레코드 수 */
SELECT COUNT(*) as cnt_fk
FROM log
WHERE memberno=1

/* 수정 */ -- 로그에는 수정 기능 제공 X
UPDATE log
SET ip='172.16.12.255'
WHERE memberno=1

/* 한 건 삭제 */ -- 로그에는 삭제 기능 제공 X
DELETE FROM log
WHERE logno=1

/********************* DML 종료 *********************/


ALTER TABLE log COMMENT = '로그인 내역';
ALTER TABLE log MODIFY logno INT COMMENT '로그인번호';
ALTER TABLE log MODIFY ip VARCHAR(20) COMMENT '아이피';
ALTER TABLE log MODIFY rdate DATETIME COMMENT '로그인시간';
ALTER TABLE log MODIFY sf CHAR(1) COMMENT '성공여부';
ALTER TABLE log MODIFY memberno INT COMMENT '멤버번호';

SHOW FULL COLUMNS FROM log;





/**********************************/
/* Table Name: 검색어 */
/**********************************/
CREATE TABLE word(
		wordno INT NOT NULL AUTO_INCREMENT,
		word VARCHAR(20) NOT NULL,
		rdate DATETIME NOT NULL,
		PRIMARY KEY(wordno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO word(word, rdate) 
VALUES('점심', now());

INSERT INTO word(word, rdate)
VALUES('저녁', now());

INSERT INTO word(word, rdate) 
VALUES('식사', now());

INSERT INTO word(word, rdate)
VALUES('월급', now());

INSERT INTO word(word, rdate) 
VALUES('친구', now());

INSERT INTO word(word, rdate)
VALUES('술', now());

INSERT INTO word(word, rdate) 
VALUES('운동', now());

INSERT INTO word(word, rdate)
VALUES('키워드', now());


/* 모든 레코드 검색 */
SELECT wordno, word, rdate
FROM word;

/* 검색 */ 
SELECT wordno, word, rdate
FROM word
WHERE word like "%저녁%";

/* 페이징 */
SELECT wordno, word, rdate
FROM word
ORDER BY wordno ASC
LIMIT 0, 10;

SELECT wordno, word, rdate
FROM word
ORDER BY wordno ASC
LIMIT 10, 10;

/* 한 건 조회 */
SELECT wordno, word, rdate
FROM word
WHERE wordno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM word

/* 수정 */ -- 검색어에는 수정 기능 제공 X
UPDATE word
SET word='식사'
WHERE wordno=1

/* 한 건 삭제 */ -- 검색어에는 삭제 기능 제공 X
DELETE FROM word
WHERE wordno=1

/* FK에 따른 삭제 */ -- 검색어에는 삭제 기능 제공 X
 
---------연관된 테이블 삭제----------- 
DELETE FROM member_word
WHERE wordno=1;

DELETE FROM crawling_data
WHERE wordno=1;
---------연관된 테이블 삭제-----------

DELETE FROM word
WHERE wordno=1;

/********************* DML 종료 *********************/


ALTER TABLE word COMMENT = '검색어';
ALTER TABLE word MODIFY wordno INT COMMENT '검색어번호';
ALTER TABLE word MODIFY word VARCHAR(20) COMMENT '검색어';
ALTER TABLE word MODIFY rdate DATETIME COMMENT '검색어등록시간';

SHOW FULL COLUMNS FROM word;




/**********************************/
/* Table Name: 크롤링데이터 */
/**********************************/
CREATE TABLE crawling_data(
		crno INT NOT NULL AUTO_INCREMENT,
		content VARCHAR(280) NOT NULL,
		rdate DATETIME NOT NULL,
		wordno INT NOT NULL,
		PRIMARY KEY(crno),
		FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO crawling_data(content, rdate, wordno)
VALUES('내용입니다', now(), 1);


/* 모든 레코드 검색 */
SELECT crno, content, rdate, wordno
FROM crawling_data;

/* 검색 */ 
SELECT crno, content, rdate, wordno
FROM crawling_data
WHERE content like "%내용%";

/* 한 건 조회 */
SELECT wordno, word, rdate
FROM word
WHERE wordno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM crawling_data

/* 한 건 삭제 */ -- 검색어에는 삭제 기능 제공 X
DELETE FROM crawling_data
WHERE crno=1;

/********************* DML 종료 *********************/



ALTER TABLE crawling_data COMMENT = '크롤링데이터';
ALTER TABLE crawling_data MODIFY crno INT COMMENT '크롤링번호';
ALTER TABLE crawling_data MODIFY content VARCHAR(280) COMMENT '내용';
ALTER TABLE crawling_data MODIFY rdate DATETIME COMMENT '시간';
ALTER TABLE crawling_data MODIFY wordno INT COMMENT '검색어번호';

SHOW FULL COLUMNS FROM crawling_data;




/**********************************/
/* Table Name: 회원_검색 */
/**********************************/
CREATE TABLE member_word(
		mwno INT NOT NULL AUTO_INCREMENT,
		memberno INT NOT NULL,
		wordno INT NOT NULL,
		PRIMARY KEY(mwno),
    FOREIGN KEY(memberno) REFERENCES member(memberno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO member_word(memberno, wordno) 
VALUES(1, 2);

INSERT INTO member_word(memberno, wordno)
VALUES(2, 1);

/* 모든 레코드 검색 */
SELECT mwno, memberno, wordno
FROM member_word;

/* 검색 */ -- 회원_검색에는 검색 기능 X
SELECT mwno, memberno, wordno
FROM member_word
WHERE mwno=1;

/* 한 건 조회 */
SELECT mwno, memberno, wordno
FROM member_word
WHERE mwno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM member_word

/* FK에 따른 레코드 수 */
SELECT COUNT(*) as cnt_fk
FROM member_word
WHERE memberno=1

SELECT COUNT(*) as cnt_fk
FROM member_word
WHERE wordno=1

/* 한 건 삭제 */ -- 멤버_검색에는 삭제 기능 제공 X
DELETE FROM word
WHERE mwno=1

/********************* DML 종료 *********************/


ALTER TABLE member_word COMMENT = '회원_검색';
ALTER TABLE member_word MODIFY mwno INT COMMENT '회원검색번호';
ALTER TABLE member_word MODIFY memberno INT COMMENT '회원번호';
ALTER TABLE member_word MODIFY wordno INT COMMENT '검색어번호';

SHOW FULL COLUMNS FROM member_word;





/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
		categrpno INT NOT NULL AUTO_INCREMENT,
		classification INT NOT NULL,
		name VARCHAR(50) NOT NULL,
		rdate DATETIME NOT NULL,
		PRIMARY KEY(categrpno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO categrp(classification, name, rdate) 
VALUES(1, "공지사항", now());

INSERT INTO categrp(classification, name, rdate)
VALUES(2, "게시판", now());

/* 모든 레코드 검색 */
SELECT classification, name, rdate
FROM categrp;

/* 검색 */
SELECT classification, name, rdate
FROM categrp
WHERE name like "%게시판%";

/* 한 건 조회 */
SELECT categrpno, classification, name, rdate
FROM categrp
WHERE categrpno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM categrp

/* 수정 */
UPDATE categrp
SET categrp.name="게시판"
WHERE categrpno=2

/* 한 건 삭제 */
DELETE FROM categrp
WHERE categrpno=1


/* FK에 따른 삭제 */
------------------연관된 테이블 삭제--------------------
DELETE FROM board
WHERE categrp=1;
------------------연관된 테이블 삭제--------------------


DELETE FROM categrp
WHERE categrp=1;

/********************* DML 종료 *********************/



ALTER TABLE categrp COMMENT = '카테고리 그룹';
ALTER TABLE categrp MODIFY categrpno INT COMMENT '카테고리그룹번호';
ALTER TABLE categrp MODIFY classification VARCHAR(50) COMMENT '분류';
ALTER TABLE categrp MODIFY name VARCHAR(50) COMMENT '이름';
ALTER TABLE categrp MODIFY rdate DATETIME COMMENT '카테고리등록일';

SHOW FULL COLUMNS FROM categrp;





/**********************************/
/* Table Name: 게시판 */
/**********************************/
CREATE TABLE board(
		boardno INT NOT NULL AUTO_INCREMENT,
		name VARCHAR(100) NOT NULL,
		rdate DATETIME NOT NULL,
		categrpno INT NOT NULL,
		memberno INT NOT NULL,
		PRIMARY KEY(boardno),
    FOREIGN KEY(categrpno) REFERENCES categrp(categrpno),
    FOREIGN KEY(memberno) REFERENCES member(memberno)
);



/********************* DML 시작 *********************/

/* 한 건 등록 */
INSERT INTO board(name, rdate, categrpno, memberno)
VALUES("게시판1", now(), 1, 1);

INSERT INTO board(name, rdate, categrpno, memberno)
VALUES("게시판2", now(), 1, 2);

INSERT INTO board(name, rdate, categrpno, memberno)
VALUES("게시판3", now(), 2, 1);

INSERT INTO board(name, rdate, categrpno, memberno)
VALUES("게시판4", now(), 2, 2);

/* 모든 레코드 검색 */
SELECT boardno, name, rdate, categrpno, memberno
FROM board; 

/* 한 건 조회 */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE boardno=1;

/* 검색 */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE name='게시판1';

SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-07'; 

/* 전체 레코드 수 */
SELECT COUNT(boardno) as cnt
FROM board

/* FK에 따른 레코드 수 */
SELECT COUNT(categrpno) as cnt
FROM board
WHERE categrpno=1;

SELECT COUNT(memberno) as cnt
FROM board
WHERE memberno=1;

/* 수정 */
UPDATE board
SET name="고고"
WHERE boardno=1;
 
/* 한 건 삭제 */
DELETE FROM board
WHERE boardno=0;

DELETE FROM board
WHERE name="고고";

 
/* 전체 출력 순서 선택 */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno ASC;

SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno DESC;



/* 페이징 */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno DESC
LIMIT 0, 10;

/* FK에 따른 삭제 */
--------------연관된 테이블 삭제-----------------
DELETE FROM contents
WHERE boardno=1;
--------------연관된 테이블 삭제-----------------

DELETE FROM board
WHERE boardno=1;

/********************* DML 종료 *********************/



ALTER TABLE board COMMENT = '게시판';
ALTER TABLE board MODIFY boardno INT COMMENT '게시판번호';
ALTER TABLE board MODIFY name VARCHAR(100) COMMENT '제목';
ALTER TABLE board MODIFY rdate DATETIME COMMENT '등록시간';
ALTER TABLE board MODIFY categrpno INT COMMENT '카테고리그룹번호';
ALTER TABLE board MODIFY memberno INT COMMENT '회원번호';

SHOW FULL COLUMNS FROM board;





/**********************************/
/* Table Name: 컨텐츠 */
/**********************************/
CREATE TABLE contents(
contentsno INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,            
content VARCHAR(1000) NOT NULL,
views INT DEFAULT 0 NOT NULL,
replies INT NOT NULL,
size VARCHAR(1000),
photo VARCHAR(1000),
thumb VARCHAR(1000),
rdate DATETIME NOT NULL,
boardno INT NOT NULL,
memberno INT NOT NULL,
PRIMARY KEY(contentsno),
FOREIGN KEY(boardno) REFERENCES board(boardno),
FOREIGN KEY(memberno) REFERENCES member(memberno)
);



/********************* DML 시작 *********************/

/* 한 건 등록 */
INSERT INTO contents(name, content, views, replies, size, photo, thumb, rdate, boardno, memberno)
VALUES("제목", "가나다라마바사", 1, 10, "10.0KB", "photo01.jpg", "photo01_t.jpg", now(), 1, 1);


INSERT INTO contents(name, content, views, replies, size, photo, thumb, rdate, boardno, memberno)
VALUES("제목2", "고노도로모보소", 1, 10, "10.0KB", "photo02.jpg", "photo02_t.jpg", now(), 2, 2); -- 테스트용


INSERT INTO contents(name, content, views, replies, size, photo, thumb, rdate, boardno, memberno)
VALUES("제목3", "가나다로모보소", 1, 10, "10.0KB", "photo03.jpg", "photo03_t.jpg", now(), 1, 2); -- 테스트용


INSERT INTO contents(name, content, views, replies, size, photo, thumb, rdate, boardno, memberno)
VALUES("제목4", "경기경경기심근경색", 1, 10, "10.0KB", "photo04.jpg", "photo04_t.jpg", now(), 10, 10); -- 에러 테스트용


/* 모든 레코드 검색 */
SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, boardno, memberno
FROM contents;

/* 한 건 조회 */
SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE contentsno=1;

/* 검색 */
SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE name='제목';

SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE content like '%가나다%';

SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-07'; 

/* 전체 레코드 수 */
SELECT COUNT(contentsno) as cnt
FROM contents

/* FK에 따른 레코드 수 */
SELECT COUNT(categrpno) as cnt
FROM contents
WHERE categrpno=1;

SELECT COUNT(memberno) as cnt
FROM contents
WHERE memberno=1;

/* 수정 */
UPDATE contents
SET name="고고", content="김수완무", size="10.0KB", photo="photo02.jpg", thumb="photo03_t.jpg"
WHERE contentsno=1;
 
/* 한 건 삭제 */

DELETE FROM contents
WHERE contentsno=1;

DELETE FROM contents
WHERE name="고고";

 
/* 전체 출력 순서 선택 */
SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno ASC;

SELECT contentsno, name, content, views, replies, size, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno DESC;



/* 페이징 */
SELECT contentsno, name, content, size, views, replies, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno DESC
LIMIT 0, 10;



/* FK에 따른 삭제 */
--------------연관된 테이블 삭제-----------------
DELETE FROM reply
WHERE contentsno=1;
--------------연관된 테이블 삭제-----------------

DELETE FROM contents
WHERE contentsno=1;

/********************* DML 종료 *********************/



ALTER TABLE contents COMMENT = '게시글';
ALTER TABLE contents MODIFY contentsno INT COMMENT '게시글번호';
ALTER TABLE contents MODIFY name VARCHAR(100) COMMENT '제목';
ALTER TABLE contents MODIFY content VARCHAR(1000) COMMENT '내용';
ALTER TABLE contents MODIFY size INT COMMENT '용량';
ALTER TABLE contents MODIFY views INT COMMENT '조회수';
ALTER TABLE contents MODIFY replies INT COMMENT '댓글수';
ALTER TABLE contents MODIFY photo VARCHAR(100) COMMENT '사진';
ALTER TABLE contents MODIFY thumb VARCHAR(100) COMMENT '썸네일';
ALTER TABLE contents MODIFY rdate DATETIME COMMENT '등록시간';
ALTER TABLE contents MODIFY boardno INT COMMENT '게시판번호';
ALTER TABLE contents MODIFY memberno INT COMMENT '회원번호';

SHOW FULL COLUMNS FROM contents;





/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
		replyno INT NOT NULL AUTO_INCREMENT,
		content VARCHAR(500) NOT NULL,
		contentsno INT NOT NULL,
		memberno INT NOT NULL,
		PRIMARY KEY(replyno),
    FOREIGN KEY(memberno) REFERENCES member(memberno),
    FOREIGN KEY(contentsno) REFERENCES member(contentsno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO reply(content, contentsno, memberno)
VALUES('내용입니다', 1, 1);

/* 모든 레코드 검색 */
SELECT replyno, content, contentsno, memberno
FROM reply;
ORDER BY replyno ASC;

/* 검색 */
SELECT replyno, content, contentsno, memberno
FROM reply
WHERE content like '%내용%';

/* 한 건 조회 */
SELECT replyno, content, contentsno, memberno
FROM reply
WHERE replyno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM reply

/* 수정 */
UPDATE reply
SET content='새로운 입력입니다'
WHERE replyno=1;

/* 한 건 삭제 */ -- 멤버_검색에는 삭제 기능 제공 X
DELETE FROM reply
WHERE replyno=1;

/********************* DML 종료 *********************/



ALTER TABLE reply COMMENT = '댓글';
ALTER TABLE reply MODIFY replyno INT COMMENT '댓글번호';
ALTER TABLE reply MODIFY content VARCHAR(500) COMMENT '댓글내용';
ALTER TABLE reply MODIFY contentsno INT COMMENT '게시글번호';
ALTER TABLE reply MODIFY memberno INT COMMENT '회원번호';

SHOW FULL COLUMNS FROM reply;