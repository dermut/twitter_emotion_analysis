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
/* Table Name: ȸ�� */
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


/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member),'admin', '������', '1234', '01021205548', 'ultimate1994@naver.com', '1994-03-17', 'M', 'A', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root', '�ڿ���', '1234', '01000000000', 'park@naver.com', '1993-00-00', 'M', 'A', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root2', 'girl', '1234', '01000000000', 'girl@gmail.com', '1993-00-00', 'F', 'M', sysdate);

INSERT INTO member(memberno, id, name, passwd, phone, email, birth, sex, grade, rdate) 
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM member), 'root3', 'master', '1234', '01000000000', 'girl@gmail.com', '1993-00-00', 'F', 'M', sysdate);


/* ��� ���ڵ� �˻� */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

/* �˻� */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE email like "%naver%";

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE name like "��%";

/* ����¡ */
SELECT memberno, id, name
FROM member
ORDER BY memberno ASC
LIMIT 0, 10;

SELECT memberno, id, name
FROM member
ORDER BY memberno ASC
LIMIT 10, 10;

/* �� �� ��ȸ */
SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member
WHERE memberno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM member;

/* ���� */
UPDATE member
SET member.email='GPARK@naver.com'
WHERE memberno=2;

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

/* �� �� ���� */
DELETE FROM member
WHERE memberno=9;

SELECT memberno, id, name, passwd, phone, email, birth, sex, grade
FROM member;

---------������ ���̺� ����-----------
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
---------������ ���̺� ����-----------

DELETE FROM member
WHERE memberno=3;

/********************* DML ���� *********************/


COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN member.id is '���̵�';
COMMENT ON COLUMN member.name is '�̸�';
COMMENT ON COLUMN member.passwd is '��й�ȣ';
COMMENT ON COLUMN member.phone is '��ȭ��ȣ';
COMMENT ON COLUMN member.email is '�̸���';
COMMENT ON COLUMN member.birth is '�������';
COMMENT ON COLUMN member.sex is '����';
COMMENT ON COLUMN member.grade is '���';
COMMENT ON COLUMN member.rdate is '������';

SHOW FULL COLUMNS FROM member;

/**********************************/
/* Table Name: �α��� ���� */
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


/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO log(logno, ip, rdate, sf, memberno) 
VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM log), '172.16.12.17', sysdate, 'T', 1);

INSERT INTO log(logno, ip, rdate, sf, memberno)
VALUES((SELECT NVL(MAX(logno), 0)+1 as logno FROM log), '172.16.12.116', sysdate, 'F', 2);

/* ��� ���ڵ� �˻� */
SELECT logno, ip, rdate, sf, memberno
FROM log;

/* �˻� */ -- ������ �˻� �� ���� ���, ���̳� ��¥�� �˻� �����ϰ� ������ ����
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE YEAR(rdate) = '2017';

-- 2018-12-03 ~ 2018-12-31 ������ �α� �˻�
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-31';

SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE DATE(rdate) BETWEEN '2018-12-01' AND '2018-12-02';

/* ����¡ */

/* �� �� ��ȸ */
SELECT logno, ip, rdate, sf, memberno
FROM log
WHERE logno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM log

/* FK�� ���� ���ڵ� �� */
SELECT COUNT(*) as cnt_fk
FROM log
WHERE memberno=1

/* ���� */ -- �α׿��� ���� ��� ���� X
UPDATE log
SET ip='172.16.12.255'
WHERE memberno=1

/* �� �� ���� */ -- �α׿��� ���� ��� ���� X
DELETE FROM log
WHERE logno=1

/********************* DML ���� *********************/


COMMENT ON TABLE log is '�α��� ����';
COMMENT ON COLUMN log.logno is '�α��ι�ȣ';
COMMENT ON COLUMN log.ip is '������';
COMMENT ON COLUMN log.rdate is '�α��νð�';
COMMENT ON COLUMN log.sf is '��������';
COMMENT ON COLUMN log.memberno is 'ȸ����ȣ';





/**********************************/
/* Table Name: �˻��� */
/**********************************/
CREATE TABLE word(
wordno INT NOT NULL,
word VARCHAR(20) NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY(wordno)
);


/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '����', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '����', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '�Ļ�', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '����', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), 'ģ��', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '��', sysdate);

INSERT INTO word(wordno, word, rdate) 
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), '�', sysdate);

INSERT INTO word(wordno, word, rdate)
VALUES((SELECT NVL(MAX(wordno), 0)+1 as wordno FROM word), 'Ű����', sysdate);


/* ��� ���ڵ� �˻� */
SELECT wordno, word, rdate
FROM word;

/* �˻� */ 
SELECT wordno, word, rdate
FROM word
WHERE word like "%����%";

/* ����¡ */
SELECT wordno, word, rdate
FROM word
ORDER BY wordno ASC
LIMIT 0, 10;

SELECT wordno, word, rdate
FROM word
ORDER BY wordno ASC
LIMIT 10, 10;

/* �� �� ��ȸ */
SELECT wordno, word, rdate
FROM word
WHERE wordno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM word

/* ���� */ -- �˻���� ���� ��� ���� X
UPDATE word
SET word='�Ļ�'
WHERE wordno=1

/* �� �� ���� */ -- �˻���� ���� ��� ���� X
DELETE FROM word
WHERE wordno=1

/* FK�� ���� ���� */ -- �˻���� ���� ��� ���� X
 
---------������ ���̺� ����----------- 
DELETE FROM member_word
WHERE wordno=1;

DELETE FROM crawling_data
WHERE wordno=1;
---------������ ���̺� ����-----------

DELETE FROM word
WHERE wordno=1;

/********************* DML ���� *********************/

COMMENT ON TABLE word is '�˻��� ����';
COMMENT ON COLUMN word.wordno is '�˻����ȣ';
COMMENT ON COLUMN word.word is '�˻���';
COMMENT ON COLUMN word.rdate is '�˻��ð�';





/**********************************/
/* Table Name: ũ�Ѹ������� */
/**********************************/
CREATE TABLE crawling_data(
crno INT NOT NULL,
content VARCHAR(500) NOT NULL,
rdate DATE NOT NULL,
wordno INT NOT NULL,
PRIMARY KEY(crno),
FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO crawling_data(crno, content, rdate, wordno)
VALUES((SELECT NVL(MAX(crno), 0)+1 as crno FROM crawling_data), '�����Դϴ�', sysdate, 1);


/* ��� ���ڵ� �˻� */
SELECT crno, content, rdate, wordno
FROM crawling_data;

/* �˻� */ 
SELECT crno, content, rdate, wordno
FROM crawling_data
WHERE content like "%����%";

/* �� �� ��ȸ */
SELECT wordno, word, rdate
FROM word
WHERE wordno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM crawling_data

/* �� �� ���� */ -- �˻���� ���� ��� ���� X
DELETE FROM crawling_data
WHERE crno=1;

/********************* DML ���� *********************/

COMMENT ON TABLE crawling_data is 'ũ�Ѹ� ������';
COMMENT ON COLUMN crawling_data.crno is 'ũ�Ѹ������͹�ȣ';
COMMENT ON COLUMN crawling_data.content is '����';
COMMENT ON COLUMN crawling_data.rdate is  'ũ�Ѹ������͵�Ͻð�';
COMMENT ON COLUMN crawling_data.wordno is  '�˻����ȣ';

/**********************************/
/* Table Name: ȸ��_�˻� */
/**********************************/
CREATE TABLE member_word(
mwno INT NOT NULL,
memberno INT NOT NULL,
wordno INT NOT NULL,
PRIMARY KEY(mwno),
    FOREIGN KEY(memberno) REFERENCES member(memberno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);


/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO member_word(mwno, memberno, wordno) 
VALUES((SELECT NVL(MAX(mwno), 0)+1 as mwno FROM member_word), 1, 2);

INSERT INTO member_word(mwno, memberno, wordno)
VALUES((SELECT NVL(MAX(mwno), 0)+1 as mwno FROM member_word), 2, 1);

/* ��� ���ڵ� �˻� */
SELECT mwno, memberno, wordno
FROM member_word;

/* �˻� */ -- ȸ��_�˻����� �˻� ��� X
SELECT mwno, memberno, wordno
FROM member_word
WHERE mwno=1;

/* �� �� ��ȸ */
SELECT mwno, memberno, wordno
FROM member_word
WHERE mwno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM member_word

/* FK�� ���� ���ڵ� �� */
SELECT COUNT(*) as cnt_fk
FROM member_word
WHERE memberno=1

SELECT COUNT(*) as cnt_fk
FROM member_word
WHERE wordno=1

/* �� �� ���� */ -- ���_�˻����� ���� ��� ���� X
DELETE FROM word
WHERE mwno=1

/********************* DML ���� *********************/


COMMENT ON TABLE member_word is 'ȸ�� �˻�';
COMMENT ON COLUMN member_word.mwno is 'ȸ���˻���ȣ';
COMMENT ON COLUMN member_word.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN member_word.wordno is '�˻����ȣ';


/**********************************/
/* Table Name: ī�װ� �׷� */
/**********************************/
CREATE TABLE categrp(
categrpno INT NOT NULL,
classification INT NOT NULL,
name VARCHAR(50) NOT NULL,
rdate DATE NOT NULL,
PRIMARY KEY(categrpno)
);


/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO categrp(categrpno, classification, name, rdate) 
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp), 1, '��������', sysdate);

INSERT INTO categrp(categrpno, classification, name, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp), 2, '�Խ���', sysdate);

/* ��� ���ڵ� �˻� */
SELECT classification, name, rdate
FROM categrp;

SELECT *
FROM categrp;

/* �˻� */
SELECT classification, name, rdate
FROM categrp
WHERE name like "%�Խ���%";

/* �� �� ��ȸ */
SELECT categrpno, classification, name, rdate
FROM categrp
WHERE categrpno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM categrp

/* ���� */
UPDATE categrp
SET categrp.name="�Խ���"
WHERE categrpno=2

/* �� �� ���� */
DELETE FROM categrp
WHERE categrpno=1


/* FK�� ���� ���� */
------------------������ ���̺� ����--------------------
DELETE FROM board
WHERE categrp=1;
------------------������ ���̺� ����--------------------


DELETE FROM categrp
WHERE categrp=1;

/********************* DML ���� *********************/



COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.categrpno is 'ī�װ��׷��ȣ';
COMMENT ON COLUMN categrp.classification is '�з�';
COMMENT ON COLUMN categrp.name is '�̸�';
COMMENT ON COLUMN categrp.rdate is 'ī�װ��׷�����';


/**********************************/
/* Table Name: �Խ��� */
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



/********************* DML ���� *********************/

/* �� �� ��� */
INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '��������', sysdate, 1, 1);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '�Խ���2', sysdate, 1, 2);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '�Խ���3', sysdate, 2, 1);

INSERT INTO board(boardno, name, rdate, categrpno, memberno)
VALUES((SELECT NVL(MAX(boardno), 0)+1 as boardno FROM board), '�Խ���4', sysdate, 2, 2);

/* ��� ���ڵ� �˻� */
SELECT boardno, name, rdate, categrpno, memberno
FROM board; 

/* �� �� ��ȸ */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE boardno=1;

/* �˻� */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE name='�Խ���1';

SELECT boardno, name, rdate, categrpno, memberno
FROM board
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-07'; 

/* ��ü ���ڵ� �� */
SELECT COUNT(boardno) as cnt
FROM board

/* FK�� ���� ���ڵ� �� */
SELECT COUNT(categrpno) as cnt
FROM board
WHERE categrpno=1;

SELECT COUNT(memberno) as cnt
FROM board
WHERE memberno=1;

/* ���� */
UPDATE board
SET name="���"
WHERE boardno=1;
 
/* �� �� ���� */
DELETE FROM board
WHERE boardno=0;

DELETE FROM board
WHERE name="���";

 
/* ��ü ��� ���� ���� */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno ASC;

SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno DESC;



/* ����¡ */
SELECT boardno, name, rdate, categrpno, memberno
FROM board
ORDER BY boardno DESC
LIMIT 0, 10;

/* FK�� ���� ���� */
--------------������ ���̺� ����-----------------
DELETE FROM contents
WHERE boardno=1;
--------------������ ���̺� ����-----------------

DELETE FROM board
WHERE boardno=1;

/********************* DML ���� *********************/

COMMENT ON TABLE board is '�Խ���';
COMMENT ON COLUMN board.boardno is '�Խ��ǹ�ȣ';
COMMENT ON COLUMN board.name is '�Խ�������';
COMMENT ON COLUMN board.rdate is '�����';
COMMENT ON COLUMN board.categrpno is 'ī�װ��׷��ȣ';
COMMENT ON COLUMN board.memberno is 'ȸ����ȣ';



/**********************************/
/* Table Name: ������ */
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

    

/********************* DML ���� *********************/

/* �� �� ��� */
INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '����', '�����ٶ󸶹ٻ�', 1, 10, '10.0KB', 'photo01.jpg', 'photo01_t.jpg', sysdate, 1, 1);


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '����2', '��뵵�θ𺸼�', 1, 10, '10.0KB', 'photo02.jpg', 'photo02_t.jpg', sysdate, 2, 2); -- �׽�Ʈ��


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), '����3', '�����ٷθ𺸼�', 1, 10, '10.0KB', 'photo03.jpg', 'photo03_t.jpg', sysdate, 1, 2); -- �׽�Ʈ��


INSERT INTO contents(contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno)
VALUES((SELECT NVL(MAX(contentsno), 0)+1 as contentsno FROM contents), "����4", "������ɱٰ��", 3, 10, "10.0KB", "photo04.jpg", "photo04_t.jpg", sysdate, 10, 10); -- ���� �׽�Ʈ��


/* ��� ���ڵ� �˻� */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents;

/* �� �� ��ȸ */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE contentsno=1;

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE contentsno=4 AND boardno=1;

/* �˻� */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE name='����';

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE content like '%������%';

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, boardno, memberno
FROM contents
WHERE DATE(rdate) BETWEEN '2018-12-03' AND '2018-12-07'; 

/* ��ü ���ڵ� �� */
SELECT COUNT(contentsno) as cnt
FROM contents

/* FK�� ���� ���ڵ� �� */
SELECT COUNT(categrpno) as cnt
FROM contents
WHERE categrpno=1;

SELECT COUNT(memberno) as cnt
FROM contents
WHERE memberno=1;

/* ���� */
UPDATE contents
SET name="���", content="����Ϲ�", fsize="10.0KB", photo="photo02.jpg", thumb="photo03_t.jpg"
WHERE contentsno=1;
 
/* �� �� ���� */

DELETE FROM contents
WHERE contentsno=1;

DELETE FROM contents
WHERE name="���";

 
/* ��ü ��� ���� ���� */
SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno ASC;

SELECT contentsno, name, content, views, replies, fsize, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno DESC;



/* ����¡ */
SELECT contentsno, name, content, fsize, views, replies, photo, thumb, rdate, categrpno, memberno
FROM contents
ORDER BY contentsno DESC
LIMIT 0, 10;



/* FK�� ���� ���� */
--------------������ ���̺� ����-----------------
DELETE FROM reply
WHERE contentsno=1;
--------------������ ���̺� ����-----------------

DELETE FROM contents
WHERE contentsno=1;

/********************* DML ���� *********************/


COMMENT ON TABLE contents is '�Խñ�';
COMMENT ON COLUMN contents.contentsno is '�Խñ۹�ȣ';
COMMENT ON COLUMN contents.name is '����';
COMMENT ON COLUMN contents.content is '����';
COMMENT ON COLUMN contents.views is '��ȸ��';
COMMENT ON COLUMN contents.replies is '��ۼ�';
COMMENT ON COLUMN contents.fsize is '�뷮';
COMMENT ON COLUMN contents.photo is '����';
COMMENT ON COLUMN contents.thumb is '�����';
COMMENT ON COLUMN contents.rdate is '�����';
COMMENT ON COLUMN contents.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN log.boardno is '�Խ��ǹ�ȣ';



/**********************************/
/* Table Name: ��� */
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



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO reply(replyno, content, contentsno, rdate, memberno)
VALUES((SELECT NVL(MAX(replyno), 0)+1 as replyno FROM reply), '�����Դϴ�', 1, sysdate, 1);

/* ��� ���ڵ� �˻� */
SELECT replyno, content, contentsno, rdate, memberno
FROM reply
ORDER BY replyno ASC;

/* �˻� */
SELECT replyno, content, contentsno, rdate, memberno
FROM reply
WHERE content like '%����%';

/* �� �� ��ȸ */
SELECT replyno, content, contentsno, rdate, memberno
FROM reply
WHERE replyno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM reply

/* ���� */
UPDATE reply
SET content='���ο� �Է��Դϴ�'
WHERE replyno=1;

/* �� �� ���� */ -- ���_�˻����� ���� ��� ���� X
DELETE FROM reply
WHERE replyno=1;

/********************* DML ���� *********************/

COMMENT ON TABLE reply is '�α��� ����';
COMMENT ON COLUMN reply.replyno is '��۹�ȣ';
COMMENT ON COLUMN reply.content is '��۳���';
COMMENT ON COLUMN reply.memberno is 'ȸ����ȣ';
COMMENT ON COLUMN reply.rdate is '��Ͻð�';
COMMENT ON COLUMN reply.contentsno is '�Խñ۹�ȣ';

/**********************************/
/* Table Name: �������丶�� */
/**********************************/
CREATE TABLE freshtomato(
    ftno INT NOT NULL,
    ftrate INT NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(ftno),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO freshtomato(ftno, ftrate, rdate, wordno)
VALUES((SELECT NVL(MAX(ftno), 0)+1 as ftno FROM freshtomato), 80, sysdate, 1);

/* ��� ���ڵ� �˻� */
SELECT ftno, ftrate, rdate, wordno
FROM freshtomato
ORDER BY ftno ASC;

/* �� �� ��ȸ */
SELECT ftno, ftrate, rdate, wordno
FROM freshtomato
WHERE ftno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM freshtomato

/* ���� */
UPDATE freshtomato
SET ftrate=50
WHERE ftno=1;

/* �� �� ���� */
DELETE FROM freshtomato
WHERE ftno=1;

/********************* DML ���� *********************/


COMMENT ON TABLE freshtomato is '������ �丶��';
COMMENT ON COLUMN freshtomato.ftno is '�������丶���ȣ';
COMMENT ON COLUMN freshtomato.ftrate is '�������丶������';
COMMENT ON COLUMN freshtomato.rdate is '�����';
COMMENT ON COLUMN freshtomato.wordno is '�˻����ȣ';


/**********************************/
/* Table Name: �˻�_ũ�Ѹ� ����/���� */
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



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO word_crawling(wcno, posi_nega, crawling_data, rdate, wordno)
VALUES((SELECT NVL(MAX(wcno), 0)+1 as wcno FROM word_crawling), 'P', '������ũ ���־��', sysdate, 1);

INSERT INTO word_crawling(wcno, posi_nega, crawling_data, rdate, wordno)
VALUES((SELECT NVL(MAX(wcno), 0)+1 as wcno FROM word_crawling), 'N', '������ũ �������', sysdate, 1);

/* ��� ���ڵ� �˻� */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
ORDER BY wcno ASC;

/* �˻� */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
WHERE crawling_data like '%������ũ%';

/* �� �� ��ȸ */
SELECT wcno, posi_nega, crawling_data, rdate, wordno
FROM word_crawling
WHERE wcno=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM word_crawling

/* ���� */
UPDATE word_crawling
SET posi_nega='N'
WHERE wcno=1;

/* �� �� ���� */
DELETE FROM word_crawling
WHERE wcno=1;

/********************* DML ���� *********************/

COMMENT ON TABLE word_crawling is '�α��� ����';
COMMENT ON COLUMN word_crawling.wcno is '�α��ι�ȣ';
COMMENT ON COLUMN word_crawling.posi_nega is '����/����';
COMMENT ON COLUMN word_crawling.crawling_data is 'ũ�Ѹ������ͳ���';
COMMENT ON COLUMN word_crawling.rdate is '�����';
COMMENT ON COLUMN word_crawling.wordno is '�˻����ȣ';


/**********************************/
/* Table Name: �˻��� ���� */
/**********************************/
CREATE TABLE word_time_graph (
    word_time_no INT NOT NULL,
    freq INT NOT NULL,
    rdate DATE NOT NULL,
    wordno INT NOT NULL,
    PRIMARY KEY(word_time_no),
    FOREIGN KEY(wordno) REFERENCES word(wordno)
);



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO word_time_graph(word_time_no, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_time_no), 0)+1 as word_time_no FROM word_time_graph), 10, sysdate, 1);

/* ��� ���ڵ� �˻� */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
ORDER BY word_time_no ASC;

/* �˻� */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
WHERE freq=0;

/* �� �� ��ȸ */
SELECT word_time_no, freq, rdate, wordno
FROM word_time_graph
WHERE word_time_no=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM word_time_graph

/* ���� */
UPDATE word_time_graph
SET freq=20
WHERE word_time_no=1;

/* �� �� ���� */
DELETE FROM word_time_graph
WHERE word_time_no=1;

    COUNT(*) as cnt
    FROM word_time_graph
    WHERE word=#{word} and rdate=#{rdate}

/********************* DML ���� *********************/

COMMENT ON TABLE word_time_graph is '�˻��� ����';
COMMENT ON COLUMN word_time_graph.word_time_no is '�˻�����ȣ';
COMMENT ON COLUMN word_time_graph.freq is '��';
COMMENT ON COLUMN word_time_graph.rdate is '�����';
COMMENT ON COLUMN word_time_graph.wordno is '�˻����ȣ';



/**********************************/
/* Table Name: �˻��� �����м� */
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



/********************* DML ���� *********************/

/* �� ���� ���ڵ� ��� */
INSERT INTO word_sentiment(word_sentiment_no, posi_nega, percentage, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_sentiment_no), 0)+1 as word_sentiment_no FROM word_sentiment), 'P', 100, 5, sysdate, 1);

INSERT INTO word_sentiment(word_sentiment_no, posi_nega, percentage, freq, rdate, wordno)
VALUES((SELECT NVL(MAX(word_sentiment_no), 0)+1 as word_sentiment_no FROM word_sentiment), 'N', 100, 5, sysdate, 1);

/* ��� ���ڵ� �˻� */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
ORDER BY word_sentiment_no ASC;

/* �˻� */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
WHERE percentage=100;

/* �� �� ��ȸ */
SELECT word_sentiment_no, posi_nega, percentage, freq, rdate, wordno
FROM word_sentiment
WHERE word_sentiment_no=1;

/* ��ü ���ڵ� �� */
SELECT COUNT(*) as cnt
FROM word_sentiment

/* ���� */
UPDATE word_sentiment
SET posi_nega='N'
WHERE word_sentiment_no=1;

/* �� �� ���� */
DELETE FROM word_sentiment
WHERE word_sentiment_no=1;

/********************* DML ���� *********************/


COMMENT ON TABLE word_sentiment is '�˻��� �����м�';
COMMENT ON COLUMN word_sentiment.word_sentiment_no is '�˻�����м���ȣ';
COMMENT ON COLUMN word_sentiment.posi_nega is '����/����';
COMMENT ON COLUMN word_sentiment.percentage is '�ۼ�Ʈ';
COMMENT ON COLUMN word_sentiment.freq is '��';
COMMENT ON COLUMN word_sentiment.rdate is '�����';
COMMENT ON COLUMN word_sentiment.wordno is '�˻����ȣ';


SELECT min(wordno)
FROM word
WHERE word='�ٴ�' and TO_CHAR(rdate, 'YYYY/MM/DD')=TO_CHAR(sysdate, 'YYYY/MM/DD'); /***** if) �̰� 0�̸�, ���� word_time_graph�� create *****/


select * from word;
select * from member_word;
select * from member;
select * from crawling_data;
select * from word_crawling;
select * from word_sentiment;
select * from word_time_graph;
select * from categrp;