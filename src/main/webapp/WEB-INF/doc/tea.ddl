DROP TABLE reply;
DROP TABLE board;
DROP TABLE contents;
DROP TABLE categrp;
DROP TABLE member_word;
DROP TABLE crawling_data;
DROP TABLE word;
DROP TABLE log;
DROP TABLE member;
DROP TABLE freshtomato;
DROP TABLE word_crawling;
DROP TABLE word_time_graph;
DROP TABLE word_sentiment;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
memberno INT NOT NULL,
id VARCHAR(15) NOT NULL,
name VARCHAR(15) NOT NULL,
passwd VARCHAR(15) NOT NULL,
phone VARCHAR(15),
email VARCHAR(25) NOT NULL,
birth VARCHAR(20) NOT NULL,
sex CHAR(1) NOT NULL,
grade CHAR(1) NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY(memberno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member),'admin', '김지민', '1234', '01021205548', 'ultimate1994@naver.com', '1994-03-17', 'M', 'A', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root', '박우진', '1234', '01000000000', 'park@naver.com', '1993-00-00', 'M', 'A', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root2', 'girl', '1234', '01000000000', 'girl@gmail.com', '1993-00-00', 'F', 'M', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root3', 'master', '1234', '01000000000', 'girl@gmail.com', '1993-00-00', 'F', 'M', sysdate);


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
WHERE memberno=9;

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


COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원번호';
COMMENT ON COLUMN member.id is '아이디';
COMMENT ON COLUMN member.name is '이름';
COMMENT ON COLUMN member.passwd is '비밀번호';
COMMENT ON COLUMN member.phone is '전화번호';
COMMENT ON COLUMN member.email is '이메일';
COMMENT ON COLUMN member.birth is '생년월일';
COMMENT ON COLUMN member.sex is '성별';
COMMENT ON COLUMN member.grade is '등급';
COMMENT ON COLUMN member.rdate is '가입일';

SHOW FULL COLUMNS FROM member;

/**********************************/
/* Table Name: 로그인 내역 */
/**********************************/
CREATE TABLE log(
logno INT NOT NULL,
ip VARCHAR(20),
rdate DATE NOT NULL,
sf CHAR(1) NOT NULL,
memberno INT NOT NULL, 
PRIMARY KEY(logno),
FOREIGN KEY(memberno) REFERENCES member(memberno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO log(logno, ip, rdate, sf, memberno) 
VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM log), '172.16.12.17', sysdate, 'T', 1);

INSERT INTO log(logno, ip, rdate, sf, memberno)
VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM log), '172.16.12.116', sysdate, 'F', 2);

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


COMMENT ON TABLE log is '로그인 내역';
COMMENT ON COLUMN log.logno is '로그인번호';
COMMENT ON COLUMN log.ip is '아이피';
COMMENT ON COLUMN log.rdate is '로그인시간';
COMMENT ON COLUMN log.sf is '성공여부';
COMMENT ON COLUMN log.memberno is '회원번호';





/**********************************/
/* Table Name: 검색어 */
/**********************************/
CREATE TABLE word(
wordno INT NOT NULL,
word VARCHAR(20) NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY(wordno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '점심', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '저녁', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '식사', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '월급', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '친구', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '술', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '운동', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '키워드', sysdate);


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

COMMENT ON TABLE word is '검색어 내역';
COMMENT ON COLUMN word.wordno is '검색어번호';
COMMENT ON COLUMN word.word is '검색어';
COMMENT ON COLUMN word.rdate is '검색시간';





/**********************************/
/* Table Name: 크롤링데이터 */
/**********************************/
CREATE TABLE crawling_data(
crno INT NOT NULL,
content VARCHAR(500) NOT NULL,
rdate DATE NOT NULL,
wordno INT NOT NULL,
PRIMARY KEY(crno),
FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO crawling_data(crno, content, rdate, wordno)
VALUES((SELECT NVL(MAX(crno), 0)+1 as crno FROM crawling_data), '내용입니다', sysdate, 1);


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

COMMENT ON TABLE crawling_data is '크롤링 데이터';
COMMENT ON COLUMN crawling_data.crno is '크롤링데이터번호';
COMMENT ON COLUMN crawling_data.content is '내용';
COMMENT ON COLUMN crawling_data.rdate is  '크롤링데이터등록시간';
COMMENT ON COLUMN crawling_data.wordno is  '검색어번호';

/**********************************/
/* Table Name: 회원_검색 */
/**********************************/
CREATE TABLE member_word(
mwno INT NOT NULL,
memberno INT NOT NULL,
wordno INT NOT NULL,
PRIMARY KEY(mwno),
    FOREIGN KEY(memberno) REFERENCES member(memberno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO member_word(mwno, memberno, wordno) 
VALUES((SELECT NVL(MAX(mwno), 0)+1 as mwno FROM member_word), 1, 2);

INSERT INTO member_word(mwno, memberno, wordno)
VALUES((SELECT NVL(MAX(mwno), 0)+1 as mwno FROM member_word), 2, 1);

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


COMMENT ON TABLE member_word is '회원 검색';
COMMENT ON COLUMN member_word.mwno is '회원검색번호';
COMMENT ON COLUMN member_word.memberno is '회원번호';
COMMENT ON COLUMN member_word.wordno is '검색어번호';


/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
categrpno INT NOT NULL,
classification INT NOT NULL,
name VARCHAR(50) NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY(categrpno)
);


/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO categrp(categrpno, classification, name, rdate) 
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp), 1, '공지사항', sysdate);

INSERT INTO categrp(categrpno, classification, name, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp), 2, '게시판', sysdate);

/* 모든 레코드 검색 */
SELECT classification, name, rdate
FROM categrp;

SELECT *
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



COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리그룹번호';
COMMENT ON COLUMN categrp.classification is '분류';
COMMENT ON COLUMN categrp.name is '이름';
COMMENT ON COLUMN categrp.rdate is '카테고리그룹등록일';


/**********************************/
/* Table Name: 게시판 */
/**********************************/
CREATE TABLE board(
boardno INT NOT NULL,
name VARCHAR(100) NOT NULL,
rdate DATE NOT NULL,
categrpno INT NOT NULL,
memberno INT NOT NULL,
PRIMARY KEY(boardno),
FOREIGN KEY(categrpno) REFERENCES categrp(categrpno),
FOREIGN KEY(memberno) REFERENCES member(memberno)
);



/********************* DML 시작 *********************/

/* 한 건 등록 */
INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '공지사항', sysdate, 1, 1);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '게시판2', sysdate, 1, 2);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '게시판3', sysdate, 2, 1);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '게시판4', sysdate, 2, 2);

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

COMMENT ON TABLE board is '게시판';
COMMENT ON COLUMN board.boardno is '게시판번호';
COMMENT ON COLUMN board.name is '게시판제목';
COMMENT ON COLUMN board.rdate is '등록일';
COMMENT ON COLUMN board.categrpno is '카테고리그룹번호';
COMMENT ON COLUMN board.memberno is '회원번호';



/**********************************/
/* Table Name: 컨텐츠 */
/**********************************/
CREATE TABLE contents(
contentsno INT NOT NULL,
name VARCHAR(100) NOT NULL,
content VARCHAR(1000) NOT NULL,
views INT NOT NULL,
replies INT NOT NULL,
fsize VARCHAR(1000) NULL,
photo VARCHAR(1000) NULL,
thumb VARCHAR(1000) NULL,
rdate DATE NOT NULL,
boardno INT NOT NULL,
memberno INT NOT NULL,
PRIMARY KEY(contentsno),
FOREIGN KEY(boardno) REFERENCES board(boardno),
FOREIGN KEY(memberno) REFERENCES member(memberno)
);

    

/********************* DML 시작 *********************/

/* 한 건 등록 */
INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '제목', '가나다라마바사', 1, 10, '10.0KB', 'photo01.jpg', 'photo01_t.jpg', sysdate, 1, 1);


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '제목2', '고노도로모보소', 1, 10, '10.0KB', 'photo02.jpg', 'photo02_t.jpg', sysdate, 2, 2); -- 테스트용


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '제목3', '가나다로모보소', 1, 10, '10.0KB', 'photo03.jpg', 'photo03_t.jpg', sysdate, 1, 2); -- 테스트용


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), "제목4", "경기경경기심근경색", 3, 10, "10.0KB", "photo04.jpg", "photo04_t.jpg", sysdate, 10, 10); -- 에러 테스트용


/* 모든 레코드 검색 */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents;

/* 한 건 조회 */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE contentsno=1;

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE contentsno=4 AND boardno=1;

/* 검색 */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE name='제목';

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE content like '%가나다%';

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
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
SET name="고고", content="김수완무", fsize="10.0KB", photo="photo02.jpg", thumb="photo03_t.jpg"
WHERE contentsno=1;
 
/* 한 건 삭제 */

DELETE FROM contents
WHERE contentsno=1;

DELETE FROM contents
WHERE name="고고";

 
/* 전체 출력 순서 선택 */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno ASC;

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno DESC;



/* 페이징 */
SELECT contentsno, name, content, fsize, views, replies, photo, thumb, rdate, categrpno, memberno
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


COMMENT ON TABLE contents is '게시글';
COMMENT ON COLUMN contents.contentsno is '게시글번호';
COMMENT ON COLUMN contents.name is '제목';
COMMENT ON COLUMN contents.content is '내용';
COMMENT ON COLUMN contents.views is '조회수';
COMMENT ON COLUMN contents.replies is '댓글수';
COMMENT ON COLUMN contents.fsize is '용량';
COMMENT ON COLUMN contents.photo is '사진';
COMMENT ON COLUMN contents.thumb is '썸네일';
COMMENT ON COLUMN contents.rdate is '등록일';
COMMENT ON COLUMN contents.memberno is '회원번호';
COMMENT ON COLUMN log.boardno is '게시판번호';



/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
replyno INT NOT NULL,
content VARCHAR(500) NOT NULL,
contentsno INT NOT NULL,
rdate DATE NOT NULL,
memberno INT NOT NULL,
PRIMARY KEY(replyno),
FOREIGN KEY(memberno) REFERENCES member(memberno),
FOREIGN KEY(contentsno) REFERENCES contents(contentsno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO reply(replyno, content, contentsno, rdate, memberno)
VALUES((SELECT NVL(MAX(replyno), 0)+1 as replyno FROM reply), '내용입니다', 1, sysdate, 1);

/* 모든 레코드 검색 */
SELECT replyno, content, contentsno, rdate, memberno
FROM reply
ORDER BY replyno ASC;

/* 검색 */
SELECT replyno, content, contentsno, rdate, memberno
FROM reply
WHERE content like '%내용%';

/* 한 건 조회 */
SELECT replyno, content, contentsno, rdate, memberno
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

COMMENT ON TABLE reply is '로그인 내역';
COMMENT ON COLUMN reply.replyno is '댓글번호';
COMMENT ON COLUMN reply.content is '댓글내용';
COMMENT ON COLUMN reply.memberno is '회원번호';
COMMENT ON COLUMN reply.rdate is '등록시간';
COMMENT ON COLUMN reply.contentsno is '게시글번호';

/**********************************/
/* Table Name: 프레시토마토 */
/**********************************/
CREATE TABLE freshtomato(
    ftno INT NOT NULL,
    ftrate INT NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(ftno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO freshtomato(ftno, ftrate, rdate, wordno)
VALUES((SELECT NVL(MAX(ftno), 0)+1 as ftno FROM freshtomato), 80, sysdate, 1);

/* 모든 레코드 검색 */
SELECT ftno, ftrate, rdate, wordno
FROM freshtomato
ORDER BY ftno ASC;

/* 한 건 조회 */
SELECT ftno, ftrate, rdate, wordno
FROM freshtomato
WHERE ftno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM freshtomato

/* 수정 */
UPDATE freshtomato
SET ftrate=50
WHERE ftno=1;

/* 한 건 삭제 */
DELETE FROM freshtomato
WHERE ftno=1;

/********************* DML 종료 *********************/


COMMENT ON TABLE freshtomato is '프레시 토마토';
COMMENT ON COLUMN freshtomato.ftno is '프레시토마토번호';
COMMENT ON COLUMN freshtomato.ftrate is '프레시토마토지수';
COMMENT ON COLUMN freshtomato.rdate is '등록일';
COMMENT ON COLUMN freshtomato.wordno is '검색어번호';


/**********************************/
/* Table Name: 검색_크롤링 긍정/부정 */
/**********************************/
CREATE TABLE word_crawling (
    wcno INT NOT NULL,
    posi_nega CHAR(1) NOT NULL,
    crawling_data VARCHAR(1000) NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(wcno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO word_crawling(wcno, posi_nega, crawling_data, rdate, wordno)
VALUES((SELECT NVL(MAX(wcno), 0)+1 as wcno FROM word_crawling), 'P', '스테이크 맛있어요', sysdate, 1);

INSERT INTO word_crawling(wcno, posi_nega, crawling_data, rdate, wordno)
VALUES((SELECT NVL(MAX(wcno), 0)+1 as wcno FROM word_crawling), 'N', '스테이크 맛없어요', sysdate, 1);

/* 모든 레코드 검색 */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
ORDER BY wcno ASC;

/* 검색 */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
WHERE crawling_data like '%스테이크%';

/* 한 건 조회 */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
WHERE wcno=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM word_crawling

/* 수정 */
UPDATE word_crawling
SET posi_nega='N'
WHERE wcno=1;

/* 한 건 삭제 */
DELETE FROM word_crawling
WHERE wcno=1;

/********************* DML 종료 *********************/

COMMENT ON TABLE word_crawling is '로그인 내역';
COMMENT ON COLUMN word_crawling.wcno is '로그인번호';
COMMENT ON COLUMN word_crawling.posi_nega is '긍정/부정';
COMMENT ON COLUMN word_crawling.crawling_data is '크롤링데이터내용';
COMMENT ON COLUMN word_crawling.rdate is '등록일';
COMMENT ON COLUMN word_crawling.wordno is '검색어번호';


/**********************************/
/* Table Name: 검색어 동향 */
/**********************************/
CREATE TABLE word_time_graph (
    word_time_no INT NOT NULL,
    freq INT NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(word_time_no),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO word_time_graph(word_time_no, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_time_no), 0)+1 as word_time_no FROM word_time_graph), 10, sysdate, 1);

/* 모든 레코드 검색 */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
ORDER BY word_time_no ASC;

/* 검색 */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
WHERE freq=0;

/* 한 건 조회 */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
WHERE word_time_no=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM word_time_graph

/* 수정 */
UPDATE word_time_graph
SET freq=20
WHERE word_time_no=1;

/* 한 건 삭제 */
DELETE FROM word_time_graph
WHERE word_time_no=1;

    COUNT(*) as cnt
    FROM word_time_graph
    WHERE word=#{word} and rdate=#{rdate}

/********************* DML 종료 *********************/

COMMENT ON TABLE word_time_graph is '검색어 동향';
COMMENT ON COLUMN word_time_graph.word_time_no is '검색어동향번호';
COMMENT ON COLUMN word_time_graph.freq is '빈도';
COMMENT ON COLUMN word_time_graph.rdate is '등록일';
COMMENT ON COLUMN word_time_graph.wordno is '검색어번호';



/**********************************/
/* Table Name: 검색어 감성분석 */
/**********************************/
CREATE TABLE word_sentiment (
    word_sentiment_no INT NOT NULL,
    posi_nega CHAR(1) NOT NULL,
    percentage INT NOT NULL,
    freq INT NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(word_sentiment_no),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML 시작 *********************/

/* 한 개의 레코드 등록 */
INSERT INTO word_sentiment(word_sentiment_no, posi_nega, percentage, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_sentiment_no), 0)+1 as word_sentiment_no FROM word_sentiment), 'P', 100, 5, sysdate, 1);

INSERT INTO word_sentiment(word_sentiment_no, posi_nega, percentage, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_sentiment_no), 0)+1 as word_sentiment_no FROM word_sentiment), 'N', 100, 5, sysdate, 1);

/* 모든 레코드 검색 */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
ORDER BY word_sentiment_no ASC;

/* 검색 */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
WHERE percentage=100;

/* 한 건 조회 */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
WHERE word_sentiment_no=1;

/* 전체 레코드 수 */
SELECT COUNT(*) as cnt
FROM word_sentiment

/* 수정 */
UPDATE word_sentiment
SET posi_nega='N'
WHERE word_sentiment_no=1;

/* 한 건 삭제 */
DELETE FROM word_sentiment
WHERE word_sentiment_no=1;

/********************* DML 종료 *********************/


COMMENT ON TABLE word_sentiment is '검색어 감성분석';
COMMENT ON COLUMN word_sentiment.word_sentiment_no is '검색어감성분석번호';
COMMENT ON COLUMN word_sentiment.posi_nega is '긍정/부정';
COMMENT ON COLUMN word_sentiment.percentage is '퍼센트';
COMMENT ON COLUMN word_sentiment.freq is '빈도';
COMMENT ON COLUMN word_sentiment.rdate is '등록일';
COMMENT ON COLUMN word_sentiment.wordno is '검색어번호';


SELECT min(wordno)
FROM word
WHERE word='바다' and TO_CHAR(rdate, 'YYYY/MM/DD')=TO_CHAR(sysdate, 'YYYY/MM/DD'); /***** if) 이게 0이면, 새로 word_time_graph를 create *****/


select * from word;
select * from member_word;
select * from member;
select * from crawling_data;
select * from word_crawling;
select * from word_sentiment;
select * from word_time_graph;
select * from categrp;