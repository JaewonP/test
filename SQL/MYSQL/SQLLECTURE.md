```sql
-- 서브쿼리 사용하기
SELECT name, height FROM userTbl WHERE height IN (SELECT height FROM userTbl WHERE addr='경남'); 

-- 특정값은 이렇게 사용  
SELECT name, height FROM userTbl WHERE height IN (173,170);  

-- buyTbl로부터 전체를 다시 가져와서 새 테이블 생성  
CREATE TABLE buyTbl2 (SELECT * FROM buyTbl); 
SELECT emp_no, hire_date FROM employees  
	ORDER BY hire_date ASC  
		-- LIMIT 0,5;      --0번째부터 5개를 가져와라  
        LIMIT 19 OFFSET 2;  -- 2번째부터 19까지 가져와라  
	
-- 문제 ) 사용자별 평균 수량을 출력하세요  
SELECT userId, AVG(amount) AS '평균구매개수' FROM buyTbl GROUP BY userId;  

-- WHERE절에 OR조건으로 나누어보기  
SELECT name, height FROM userTbl  
    WHERE height=(SELECT MAX(height) FROM userTbl)  
    OR height = (SELECT MIN(height) FROM userTbl)  
    OR height = (SELECT ROUND(AVG(height)) FROM userTbl);  
    
-- WHERE절에는 집계함수가 들어가면 암됨.(집계함수는 GROUP BY와 함께)  
-- 잘못된예시  

SELECT userId AS '사용자', SUM(price*amount) AS '총구매액'  
	FROM buyTbl  
    WHERE SUM(price*amount) > 1000  
    GROUP BY userId;  
    
-- 맞는 예시  
SELECT userId AS '사용자', SUM(price*amount) AS '총구매액'  
	FROM buyTbl  
    GROUP BY userId  
    HAVING SUM(price*amount) > 1000; -- 집계 함수가 WHERE절에 있으면안되고  
    -- GROUP BY를 먼저 사용하고 이후 HAVING 으로 조건을 적용함  
	-- 집계함수 COUNT, AVG, SUM, ....   
    -- 구매테이블 각 고객의 총 금액의 합계가 1000만원 이상인 사람을 골라냄  
-- CONVERT  

SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매개수' FROM buyTbl; 

-- CAST  
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균구매개수' FROM buyTbl;  

-- 문자열을 날짜형태로 형변환  
SELECT CAST('2010$12$12' AS DATE);  
SELECT CAST('2010/12/12' AS DATE);  
SELECT CAST('2010%12%12' AS DATE);  
SELECT CAST('2010@12@12' AS DATE);  

-- CONCAT  
SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=')  
	AS '단가X수량', price*amount AS '구매액'  
    FROM buyTbl; -- CONCAT 데이터 합치기  


-- CASE END문
SELECT CASE 7 
	WHEN 1 THEN '일'
    WHEN 5 THEN '오'
    WHEN 10 THEN '십'
    ELSE '모름'
    END AS '결과';

-- SELECT문에 쓰는 여러 연산자
SELECT UPPER('abcEFSDF');
SELECT LPAD('이것이', 7, '##'), RPAD('이것이', 50, '##');
SELECT LTRIM('    이것이'), RTRIM('이것이    ');
SELECT TRIM('     이것이    ');
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재미없어 ㅋㅋㅋ');  -- 결과물 : 재미없어 / FROM절의 양쪽ㅋ을 없애주는 기능
SELECT REPEAT('이것이', 3);
SELECT REPLACE('이것이 MYSql이다.', '이것이', 'This is');
SELECT REVERSE('MYSQL');
SELECT CONCAT('이것이', space(30), 'mysql이다');
SELECT SUBSTRING('대한민국만세', 3, 2);                      -- 결과물 : 민국
SELECT ABS(-100);
SELECT 130 > ABS(-230) ;
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7);
SELECT DEGREES(PI()), RADIANS(180);            -- DEGREE각도 / RADIANS
SELECT MOD(157, 10), 157%10, 157 MOD 10; --왼쪽과같이 세종류로 쓸수있다 /  MODULO 연산자 (나눗셈의 나머지를 계산하는 연산자)
SELECT RAND(), FLOOR(1 + (RAND() * (6-1)));  -- 랜덤숫자생성 
-- 랜덤 정렬 > SELECT * FROM tbl_name ORDER BY RAND();
-- 랜덤 숫자(범위) > SELECT FLOOR(5 + (RAND() * 7));
SELECT SIGN(100), SIGN(0), SIGN(-100.123); -- 부호만 알아내기 결과 / 1, 0, -1
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(current_time()), SECOND(current_time()), MICROSECOND(current_time());


--09/25
USE study;
DROP TABLE DEPT;
CREATE TABLE DEPT (
	deptid INT NOT NULL PRIMARY KEY,
    dname VARCHAR(10),
    budget VARCHAR(10)
);
DESC DEPT;
INSERT INTO DEPT VALUES(100, '영업부', '100k');
INSERT INTO DEPT VALUES(200, '관리부', '300k');
INSERT INTO DEPT VALUES(300, '구매부', '220k');
INSERT INTO DEPT VALUES(400, '생산부', '500k');
SELECT * FROM DEPT;

DROP TABLE EMP;
CREATE TABLE EMP(
	empid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ename VARCHAR(10),
    deptid INT ,              -- 부서번호 
    hire_date VARCHAR(10),
    job VARCHAR(10),
    manager INT,
    salary INT,
    FOREIGN KEY(deptid) REFERENCES DEPT(deptid)
);
DESC EMP;
INSERT INTO EMP VALUES(1001, '홍성길', 100, '2001.2.1', '특수영업', 1002, 350);
INSERT INTO EMP VALUES(NULL, '곽희준', 100, '1999.1.1', '영업관리', 1004, 400);
INSERT INTO EMP VALUES(NULL, '김동준', 200, '2000.9.1', '품질관리', 1005, 300);
INSERT INTO EMP VALUES(NULL, '성재규', 300, '1997.2.1', '급여', 1009, 450);
INSERT INTO EMP VALUES(NULL, '박성범', 200, '2000.2.1', '수입자재', 1004, 320);
SELECT * FROM EMP;

-- SELECT문제
SELECT ename, job, salary
FROM EMP
WHERE salary > 300 AND job = '영업관리';

SELECT deptid, SUM(salary) AS '급여액 합계'
FROM EMP
GROUP BY deptid;

SELECT D.dname, E.ename
FROM DEPT AS D RIGHT OUTER JOIN EMP AS E
ON D.deptid = E.deptid;

SELECT budget 
FROM EMP, DEPT
WHERE DEPT.deptid = EMP.deptid AND EMP.ename = '곽희준';  -- JOIN없이 WHERE에 조건걸기

INSERT INTO emp(empid, ename, deptid, hire_date, job, salary) VALUES (106, '강윤호', 200, '2001-01-10', '연말정산', 400);
SELECT * FROM EMP;
INSERT INTO emp(empid, ename, salary) VALUES (107, '남진선', 500);  -- 일부컬럼 생략시 자동으로 null
SELECT * FROM EMP;

SET sql_Safe_updates = 0;        -- 세이프모드 해제하기
UPDATE EMP
	SET deptid = 400, salary = 500
	WHERE ename = '홍성길';
SET sql_Safe_updates = 1; -- 세이프모드 설정하기
SELECT * FROM EMP;

UPDATE EMP
SET salary = salary * 1.2
WHERE deptid = (SELECT deptid FROM DEPT WHERE dname = '영업부');
SELECT * FROM EMP;

-- 09/28

show databases; -- 데이터베이스들을 보여줘 
use employees; -- 데이터베이스 선택 및 이동
show tables;
-- 조회 SELECT 칼럼명 FROM 테이블명 
SELECT * FROM employees; -- 테이블로부터 모든 column(열)를 읽어줘
SELECT emp_no FROM employees; -- 해당 column(열) 만 읽어줘\

DESCRIBE employees; -- 테이블의 구조를 파악함
USE world; -- world로 이동

DESCRIBE employees.employees; -- 데이터베이스명과 함께 사용가능 
SELECT first_name, hire_date FROM employees;
SELECT first_name AS '성' , gender AS '성별', hire_date AS '고용날짜' FROM employees;
-- 테이블생성
DROP DATABASE IF exists sqlDB; -- 만약 sqlDB가 존재하면 우선 삭제한다.
CREATE database sqlDB; -- sqlDB 데이터 베이스를 만들어라
USE sqlDB;
DROP table userTbl;
CREATE table userTbl -- 회원 테이블
(
	userId CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(pk)
    name VARCHAR(10) NOT NULL, -- 이름
    birthYear INT NOT NULL, 
    addr CHAR(2) NOT NULL, -- 지역(경기, 서울, 강남, 식으로 2글자만 입력)
    mobile1 CHAR(3), -- 휴대폰의 국번(010,011 등등)
    mobile2 CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈 제외)
    height SMALLINT, -- 키(적응용량만 차지하게끔)
    mDate DATE -- 회원가입일
);  -- NOT NULL은 무조건 데이터 입력이 되어야 하고 PRIMARY KEY는 중복되면 안됨
-- 칼럼명 데이터 타입 
create table buyTbl
(
	num INT auto_increment NOT NULL PRIMARY KEY,
	userId CHAR(8) NOT NULL,   
    prodName CHAR(6) NOT NULL,  -- 물품명
    groupName CHAR(4), -- 분류
    price INT NOT NULL, -- 단가
    amount smallint NOT NULL, -- 수량 
    foreign key(userId) references userTbl(userId)
);

drop table userTbl;
drop table buyTbl;
DESC userTbl; -- 테이블의 구조를 파악함(구조출력)
DESCRIBE userTbl;

INSERT INTO userTbl VALUES('KBS', '이승기', '1987', '서울', '011', '11111111', 182, '2008-8-8');
SELECT*FROM userTbl;

INSERT INTO buyTbl VALUES (NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buyTbl VALUES (3, 'LSG1', '모니터', '전자', 1000, 1);
SELECT * FROM buyTbl;



INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;
SELECT * FROM userTbl WHERE NAME = '김경호';
SELECT userId, NAME FROM userTbl WHERE birthYear >=1970 and height >=182;
-- 문제) userId, name을 userTbl에서 가져오는데 생년이 1970년이상이거나 키가 182 이상인 것을 가져와라
SELECT userId, name From userTbl WHERE birthYear >= 1970 OR height >= 182;

-- 문제) 이름과 키를 가져오는데 userTbl에서 가져와라, 키가 180이상이고 키가 183이하인것을 
SELECT name, height FROM userTbl WHERE height BETWEEN 180 AND 183;

-- 문제) 이름과 키를 가져오는데 userTbl에서 가져와라, 180과 184사이의 것을 가져와라
SELECT name, height FROM userTbl WHERE height BETWEEN 180 AND 184;

-- 문제) 이름과 주소를 가져와라 userTbl에서 주소가 '경남'이거나 주소가 '전남'이거나 주소가'경북'인것
SELECT name, addr FROM userTbl WHERE addr='경남' OR addr= '전남' OR addr= '경북';

-- 문제) 이름과 주소를 userTbl에서 가져와라, 주소가 '경남', '전남', '경북'에 포함되는 것을 가져와라
SELECT name, addr FROM userTbl WHERE addr IN ('경남', '전남', '경북');        -- 위에처럼 안쓰려면 IN(집합)사용하기

-- 문제 이름과 키를 userTbl에서 가져와라 이름이 김으로 시작하는 것을 가져와라
SELECT name, height FROM userTbl WHERE name LIKE '김%';

-- 문제) 이름이 원으로 끝나는 것을 찾아라 
SELECT name FROM userTbl WHERE name LIKE '%원';
SELECT name FROM userTbl WHERE name LIKE '_종신';
SELECT name, height FROM userTbl WHERE height > 177;
SELECT height FROM userTbl WHERE name = '김경호';
SELECT name, height FROM userTbl WHERE height > (SELECT height FROM userTbl WHERE name ='김경호');
-- 문제) 주소가 경남이 사람의 키 이상인 사람의 이름과 키를 구해라
SELECT height FROM userTbl WHERE addr = '경남';
SELECT name, height FROM userTbl WHERE height >= ANY(SELECT height FROM userTbl WHERE addr = '경남'); -- ANY : 괄호속의 범위중 가장넓은범위를 선정 
SELECT name, height FROM userTbl WHERE height IN (SELECT height FROM userTbl WHERE addr='경남');
SELECT name, height FROM userTbl WHERE height=173 OR height=170;
SELECT name, height FROM userTbl WHERE height IN (173,170);
SELECT name, height FROM userTbl ORDER BY mDate; -- mDate를 정렬해서 보여줘-
SELECT name, height FROM userTbl ORDER BY mDATE DESC;
SELECT name, height FROM userTbl ORDER BY name ASC, height DESC;
SELECT addr FROM userTbl; -- 10개의 데이터
SELECT DISTINCT addr FROM userTbl; -- 5개의 데이터


USE employees; -- db변경
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC;
SELECT emp_no, hire_date FROM employees 
	ORDER BY hire_date ASC 
		-- LIMIT 0,5;      --0번째부터 5개를 가져와라 
        LIMIT 19 OFFSET 2;  -- 2번째부터 19까지 가져와라
        
        
USE world;
CREATE TABLE buyTbl2 (SELECT * FROM buyTbl); -- buyTbl로부터 전체를 다시 가져와서 새 테이블 생성
SELECT * FROM buyTbl2;
CREATE TABLE buyTbl3 (SELECT userId, prodName from buyTbl);
SELECT * FROM buyTbl3;
SELECT userId, SUM(amount) FROM buyTbl GROUP BY userId;
SELECT userId '사용자아이디', SUM(amount) AS '총구매 개수' 
	FROM buyTbl GROUP BY userId;
SELECT AVG(amount) AS '평균구매개수' FROM buyTbl; -- amount칼럼의 데이터 평균

-- 문제 ) 사용자별 평균 수량을 출력하세요
SELECT userId, AVG(amount) AS '평균구매개수' FROM buyTbl GROUP BY userId;
SELECT name, MAX(height), MIN(height) FROM userTbl;
SELECT name, MAX(height), MIN(height) FROM userTbl GROUP BY name;
SELECT ROUND(AVG(height)) FROM userTbl;

SELECT name, height FROM userTbl 
    WHERE height=(SELECT MAX(height) FROM userTbl)
    OR height = (SELECT MIN(height) FROM userTbl)
    OR height = (SELECT ROUND(AVG(height)) FROM userTbl);
SELECT userId AS '사용자', SUM(price*amount) AS '총구매액'
	FROM buyTbl
    WHERE SUM(price*amount) > 1000
    GROUP BY userId; -- WHERE절에는 집계함수가 들어가면 안됩니다.
SELECT userId AS '사용자', SUM(price*amount) AS '총구매액'
	FROM buyTbl
    GROUP BY userId
    HAVING SUM(price*amount) > 1000; -- 집계 함수가 WHERE절에 있으면안되고
    -- GROUP BY를 먼저 사용하고 이후 HAVING 으로 조건을 적용함
	-- 집계함수 COUNT, AVG, SUM, .... 
    -- 구매테이블 각 고객의 총 금액의 합계가 1000만원 이상인 사람을 골라냄

SELECT userId AS '사용자', SUM(price*amount) AS '총구매액'
	FROM buyTbl
    GROUP BY userId
    HAVING SUM(price*amount) > 1000
    ORDER BY SUM(price*amount) DESC; -- 총금액 기준으로 정렬함 

SELECT AVG(amount) AS '평균구매개수' FROM buyTbl;
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균구매개수' FROM buyTbl;
SELECT ROUND(AVG(amount)) AS '평균구매개수' FROM buyTbl;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매개수' FROM buyTbl; -- 위와동일 
SELECT CAST('2010$12$12' AS DATE); -- 문자열을 날짜형태로 형변환 
SELECT CAST('2010/12/12' AS DATE);
SELECT CAST('2010%12%12' AS DATE);
SELECT CAST('2010@12@12' AS DATE);
SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=')
	AS '단가X수량', price*amount AS '구매액'
    FROM buyTbl; -- CONCAT 데이터 합치기
SELECT CONCAT(5, 5, 'ab');
SELECT 5;
SELECT '100' + '200'; -- 문자와 문자를 더하면 정수로 변환되어 연산됨
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수가 문자로 변환되어처리)
SELECT 1 > '2mega'; -- 정수인 2로 변환되어 비교
SELECT 3 > '2MEGA'; -- 정수인 2로 변환되어 비교 true = 1, false = 0
SELECT 0 = 'mega2' AS '정말로'; -- 문자는 0으로 변환됨
SELECT IF (100 > 200, '참이다', '거짓이다') AS '결과';
SELECT IFNULL (NULL, '널이군요'), IFNULL (100, '널이군요');
SELECT NULLIF(100, 100), IFNULL(200, 100); -- 두값의 차이가 NULL인지 보는것
SELECT CASE 7  -- CASE END 문
	WHEN 1 THEN '일'
    WHEN 5 THEN '오'
    WHEN 10 THEN '십'
    ELSE '모름'
    END AS '결과';
SELECT ASCII('A'), ASCII('a'), CHAR(65), CHAR('a');
SELECT true;
SELECT FORMAT(123456.123456,4); -- 소수점 몇째자리 까지
SELECT FORMAT (AVG(100/7),3); 
SELECT bin(31), hex(31), oct(31);
SELECT UPPER('abcEFSDF');
SELECT LPAD('이것이', 7, '##'), RPAD('이것이', 50, '##');
SELECT LTRIM('    이것이'), RTRIM('이것이    ');
SELECT TRIM('     이것이    ');
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재미없어 ㅋㅋㅋ');
SELECT REPEAT('이것이', 3);
SELECT REPLACE('이것이 MYSql이다.', '이것이', 'This is');
SELECT REVERSE('MYSQL');
SELECT CONCAT('이것이', space(30), 'mysql이다');
SELECT SUBSTRING('대한민국만세', 3, 2);
SELECT ABS(-100);
SELECT 130 > ABS(-230) ;
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7);
SELECT DEGREES(PI()), RADIANS(180); -- DEGREE각도 / RADIANS
SELECT MOD(157, 10), 157%10, 157 MOD 10; -- MODULO 연산자
SELECT POW(2,3),SQRT(9);
SELECT RAND(), FLOOR(1 + (RAND() * (6-1)));
SELECT SIGN(100), SIGN(0), SIGN(-100.123); -- 부호만 알아내기
SELECT ADDDATE('2020-01-01', INTERVAL 31 DAY), ADDDATE('2020-01-01' INTERVAL 1 MONTH);
SELECT ADDDATE('2020-01-01', INTERVAL 5 YEAR);
SELECT ADDTIME('2020-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '1:10:10');
SELECT SUBTIME('2020-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUT(CURTIME()), MINUTE(current_time()), SECOND(current_time())
	, MICROSECOND(current_time());

-- SQL 변수명 emp_no => 여러개의 단어 조합으로 변수(칼럼명) Snake_case
-- JAVA empNo => CamelCase

drop table greenstudy;
create table greenstudy
(
num int auto_increment primary key,   -- 사원 번호
team varchar(10) ,      -- 부서이름
name varchar(10),      -- 이름
position varchar(10),   -- 직책
pay int,    -- 급여
hireDate date , --   입사 일   
adr varchar(20) -- 주소
);

insert into greenstudy values(null,'기획','홍길동','주임','3000000',20190903,'경기도');
insert into greenstudy values(null,'기획','김길동','사원','1800000',20200703,'서울시');
insert into greenstudy values(null,'기획','이부장','부장','8000000',20100108,'경기도');
insert into greenstudy values(null,'제작','이대리','대리','3500000',20181111,'경기도');
insert into greenstudy values(null,'제작','계부장','부장','8300000',20000118,'서울시');
insert into greenstudy values(null,'개발','난사원','사원','1300000',20200808,'서울시');
insert into greenstudy values(null,'경영','이사원','사원','870000',20190101,'전라도');
insert into greenstudy values(null,'경영','이재원','과장','570000',20160715,'충청도');
insert into greenstudy values(null,'개발','유시진','인턴','150000',20200911,'경상도');
insert into greenstudy values(null,'경영','김사부','주임','3200000',20110512,'전라도');
insert into greenstudy values(null,'제작','이시진','과장','5600000',20101108,'전라도');
insert into greenstudy values(null,'경영','홍말자','대리','4500000',20101119,'충청도');
insert into greenstudy values(null,'제작','이말년','사원','2500000',20150817,'경기도');

SELECT * FROM greenstudy;
-- 1) 부서가 '경영' 인 부서의 사람 중 지역, 이름, 급여를 출력하라.
SELECT adr, name, pay FROM greenstudy WHERE team ="경영";
-- 2)성이 '김' 이 들어간  사람의 모든 정보를 출력하라.
SELECT * FROM greenstudy WHERE name LIKE '김%';
-- 3)급여가 3,000,000이상이고 5,000,000 이하의 사람의 이름, 급여 출력하라.
SELECT name, pay FROM greenstudy WHERE pay BETWEEN '3000000' AND '5000000';
-- 4)부서가 기획 팀 에 평균 급여를 출력하라
SELECT AVG(pay) FROM greenstudy WHERE team = '기획';
-- 5)각 부서의 평균 급여를 출력하라
SELECT team, AVG(pay) FROM greenstudy GROUP BY team;
-- 6)회사의 총 직원이 몇명인지 출력하라
SELECT COUNT(*) FROM greenstudy;
-- 7)부서 별 최고급여와 최소 급여를 구하라
SELECT team, MAX(pay) AS '최고급여', MIN(pay) AS '최소급여' FROM greenstudy GROUP BY team;
-- 8)지역이 경기도 와 서울 이 아닌 사람을 출력하라
SELECT * FROM greenstudy WHERE adr != '경기도' AND adr != '서울시';
-- 9)이름에 이 가 포함되지 않는 직원을 출력하라
SELECT name FROM greenstudy WHERE NOT name LIKE '%이%';
-- 10)급여가 제작 부서의 최저 급여보다 높은 사원의 직책, 이름, 급여를 내림차순 으로 출력하라.
SELECT position, name, pay FROM greenstudy WHERE pay > (Select MIN(pay) FROM greenstudy WHERE team = '제작') ORDER BY pay DESC;



-- 9/23
CREATE TABLE TEST (SELECT * 
	FROM buytbl	INNER JOIN userTbl
		ON buyTbl.userId = userTbl.userId
	WHERE buyTbl.userId = 'BBK');
-- 모든칼럼 결합(ON필요없음)
SELECT * 
	FROM buytbl	FULL JOIN userTbl
		ON buyTbl.userId = userTbl.userId;
SELECT * FROM userTbl;

-- 문제 
-- 테이블생성
CREATE TABLE members
(
	number_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
	grade CHAR(5)
);
CREATE TABLE committees
(
	committee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    grade CHAR(5)
);
DESC members;
DESC committees;
DROP TABLE members;
DROP TABLE committees;
-- 특정칼럼에 데이터를 세로로 넣기 
INSERT INTO members(NAME,grade) VALUES('john','a'), ('jane','b'), ('mary','c'), ('david','d'), ('amelia','f');
INSERT INTO committees(NAME,grade) VALUES('john','u'), ('mary','f'), ('amelia','z'), ('joe','w');
SELECT * FROM members;
SELECT * FROM committees;

-- JOIN해보기
SELECT m.name, c.committee_id 
	FROM members AS m INNER JOIN committees AS c
		ON m.name = c.name;
SELECT m.name, c.committee_id 
	FROM members AS m LEFT JOIN committees AS c
		ON m.name = c.name;
SELECT m.name, c.committee_id
	FROM members AS m LEFT JOIN committees AS c
		ON m.grade = c.grade;
-- INNERJOIN에는 NULL이없다(NULL이있다면 그값은 원래 NULL임)
SELECT * FROM buyTbl INNER JOIN userTbl
			ON buyTbl.userId = userTbl.userId; 
SELECT buyTbl.userId, name, prodName, addr, mobile1+mobile2 AS '연락처'
FROM buyTbl INNER JOIN userTbl
	ON buyTbl.userId = userTbl.userId;
SELECT B.userId, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처'
FROM buyTbl AS B INNER JOIN userTbl AS U
	ON B.userId = U.userId
-- WHERE B.userId = 'JYP';
ORDER BY U.userId; -- userId로 정렬하여 출력

SELECT DISTINCT U.userId, U.name, U.addr
FROM userTbl AS u INNER JOIN buyTbl AS b
	ON u.userId = b.userId
ORDER BY u.userId; -- 고유한 데이터만 출력(distinct)

SELECT u.userId, u.name, u.addr 
FROM buyTbl AS u
WHERE EXISTS (                   -- IN과 EXISTS는 비슷하지만 적용범위가 다름, IN뒤에는 특정값이나 서브쿼리(특정값이 포함되는지 체크)오지만 EXISTS뒤에는 서브쿼리만(해당컬럼의 값의 존재유무만확인!)
	SELECT * 
    FROM buyTbl AS b 
    WHERE u.userId = b.userId); 
-- 고객의 구매이력이 있는 사람만 추출하여 userId 이름, 주소 추출,
-- WHERE절은 조건을 줘야하고 WHERE절에 exists?(존재하는지?)
-- 고객테이블의 userId와 구매 테이블의 userId를 비교하여, 구매테이블의 정보를 가져오는데 그 정보가 있을경우 구매 이력이 있는것임

-- 문제) 새로 테이블만들어서 진행하기
CREATE TABLE stbTbl
(
	stdName VARCHAR(10) NOT NULL PRIMARY KEY, -- 학생이름
    addr CHAR(4) NOT NULL
);
desc stbTbl;
CREATE TABLE clubTbl
(
	clubName VARCHAR(10) NOT NULL PRIMARY KEY, -- 동아리이름
    roomNo CHAR(4) NOT NULL
);
desc stbTbl;
CREATE TABLE stdclubTbl
(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 동아리학생테이블 고유 숫자
    stdName VARCHAR(10) NOT NULL,
    clubName VARCHAR(10) NOT NULL,
	FOREIGN KEY(stdName) REFERENCES stbTbl(stdName),
    FOREIGN KEY(clubName) REFERENCES clubTbl(clubName) -- 외래키를 사용하는이유는 중복데이터가 없으면서도 문제없이 데이터를 저장,관리가능
);
desc stdclubTbl;
INSERT INTO stbTbl(stdName,addr) VALUES ('김범수', '경남'), ('성시경', '서울'), ('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
INSERT INTO clubTbl(clubName, roomNo) VALUES ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
INSERT INTO stdclubTbl(num, stdName, clubName) VALUES (null, '김범수', '바둑'), (null, '김범수', '축구'), (null, '조용필', '축구'), (null, '은지원', '축구'), (null, '은지원', '봉사'), (null, '바비킴', '봉사');
SELECT * FROM stbTbl;
SELECT * FROM clubTbl;
SELECT * FROM stdclubTbl;
DELETE FROM stdclubTbl WHERE stdName = '바비킴'; -- CRUD DELETE
SELECT * FROM stdclubTbl;

SELECT s.stdName, s.addr, c.clubName, c.roomNo
FROM stbTbl AS s 
	INNER JOIN stdclubTbl AS sc
	ON s.stdName = sc.stdName
    INNER JOIN clubTbl AS c 
	ON sc.clubName = c.clubName
ORDER BY s.stdName;

SELECT s.stdName, s.addr, c.clubName, c.roomNo
FROM stbTbl AS s 
	LEFT OUTER JOIN stdclubTbl AS sc 
    ON s.stdName = sc.stdName
    LEFT OUTER JOIN clubTbl AS c
    ON sc.clubName = c.clubName
ORDER BY s.stdName;

SELECT s.stdName, s.addr, sc.stdName, sc.clubName
FROM stbTbl AS s
	LEFT OUTER JOIN stdclubTbl AS sc -- left outer은 외쪽테이블의 것
    ON s.stdName = sc.stdName; -- 학생 테이블/ 학생 동아리 테이블

DROP TABLE empTbl;
CREATE TABLE empTbl (
	emp char(3),
	manager char(3),
	emptel varchar(8)
);
INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');
SELECT * FROM empTbl;
-- self 조인

SELECT A.emp AS '부하직원', B.emp AS '직속상관', B.empTel AS '직속상관연락처'
FROM empTbl AS A 
	INNER JOIN empTbl AS B 
    ON A.manager = B.emp;

SELECT stdName, addr FROM stbTbl 
UNION ALL
SELECT clubName, roomNo FROM clubTbl; -- 학생테이블과 동아리 테이블의 합집합 
SELECT name, concat(mobile1, mobile2) AS '전화번호' 
FROM userTbl
WHERE name NOT IN (SELECT name FROM userTbl WHERE mobile1 is null);

SELECT * FROM emptbl AS a
	INNER JOIN emptbl AS b
	ON a.manager = b.emp;
    
drop procedure if exists ifProc;
delimiter $$
create procedure ifProc()
begin
	declare var1 int; -- 지역변수 선언
    set var1 =100; -- 지역변수 변수 대입
    
    if var1 =100 then 
		select '100입니다';
    else 
		select '100이 아닙니다';
    end if;
end $$
delimiter ; -- ;를 문장으로 읽어서 띄어쓰기 해야함 
call ifProc();

drop procedure if exists ifProc2;
use employees;
create procedure ifProc2()
begin 
	declare hireDate DATE; -- 입사일
    declare curDate DATE; -- 오늘
    declare days INT; -- 근무한 일수 
    
    select hire_date into hireDate -- hire_date열의 결과를 hirdDate에 대입
		from employees.employees
        where emp_no = 10001;
	set curDate = current_date(); -- 현재 날짜
    set days = datediff(curDate, hireDate); -- 날짜의 차이, 일 단위
    if(days/365) >= 5 then -- 5년이 지났다면 
		select concat('입사한지' ,days, '일이나 지났습니다. 축하합니다');
	else
		select '입사한지 ' + days + '일밖에 안되었네요 열심히 일하세요';
	end if;
end $$
delimiter ;
call ifProc2();

drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
   declare point int;
    declare credit char(1);
    set point =77;
    if point>=90 then
    set credit ='A';
    elseif point >=80 then
    set credit ='B';
    elseif point >= 70 then
    set credit ='C';
        elseif point >= 60 then
    set credit ='D';
    else
      set credit ='F';
        end if;
        select point as '취득점수', credit as '학점';
        end $$
        delimiter ;
call ifProc3();

drop procedure if exists ifProc4;
delimiter $$
create procedure ifProc4()
begin 
	declare point int; -- 입사일
    declare credit char(1); -- 오늘
	set point = 77; -- 근무한 일수 
    
    case point
		when point >= 90 then
			set credit = 'B';
		when point >= 80 then
			set credit = 'B';
		when point >= 70 then
			set credit = 'C';
		when point >= 60 then
			set credit = 'D';
		else
			set credit ='F';
		end case;
    select concat('취득점수 ==>' , point) , concat('학점 ==> ', credit);
end $$
delimiter ;
call ifProc4();

drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
	declare i INT; -- 1에서 100까지 증가할 편수
    declare hap INT; -- 더한값을 누적할 변수
    set i=1;
    set hap=0;
    
    while(i<=100) do
		set hap = hap + i ; -- hap의 원래 값이 i를 더해서 다시 hap에 넣으라는 의미
        set i=i+1; -- i의 원래값에 1을 더해서 다시 i에 넣으라는 의미
	end while;
    
    select hap;
end $$
delimiter ;
call whileProc();

drop procedure if exists apple;

USE world;
SELECT B.userid, U.name, sum(price*amount) AS '총구매액',
    case 
		when (sum(price * amount) >= 1500) then '최우수고객'
        when (sum(price * amount) >= 1000) then '우수고객'
        when (sum(price * amount) >= 1) then '일반고객'
        else '유령고객'
	end '고객 등급'
FROM buyTbl AS B right outer join userTbl AS U
	ON B.userId = U.userId
GROUP BY U.userId
ORDER BY sum(price * amount) desc;

end $$
delimiter ;
call whileProc();


-- 09/28
-- 제약조건
-- 1) primary key 제약조건
-- 2) foreign key 제약조건
-- 3) unique 제약조건 
-- 4) default 제약조건
-- 5) null값 허용 

CREATE DATABASE testdb;
USE testdb;
CREATE TABLE userTbl(
	userId CHAR(8) NOT NULL,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate DATE NULL,
    CONSTRAINT PRIMARY KEY pk_userTbl_userId(userId)  -- pk키 이름 지정 
);
DESC userTbl;
SHOW INDEX FROM usertbl;
SELECT constraint_type FROM information_schema.table_constraints; -- 제약조건 조회 
DROP TABLE IF EXISTS usertbl;
CREATE TABLE userTbl(           -- 제약조건 나중에 추가해보기위해 새로만든 테이블 
	userId CHAR(8) NOT NULL,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate DATE NULL
    -- CONSTRAINT PRIMARY KEY pk_userTbl_userId(userId)  -- pk키 이름 지정 
);
ALTER TABLE usertbl   -- 테이블 구조를 변경해라
	ADD CONSTRAINT pk_usertbl_userid -- 제약조건의 이름은 pk_usertbl_userid
    PRIMARY KEY (userid);  -- userid를 고유키고 해라
    
DROP TABLE IF EXISTS prodtbl;
CREATE TABLE prodtbl(
	prodCode CHAR(3) NOT NULL,
    prodId CHAR(4) NOT NULL,
    prodDate datetime NOT NULL,
    prodCur CHAR(10) NULL
);

-- < 하나의 칼럼으로 고유키를 생성이 어려울때 이렇게 조합하여 기본키생성 가능 함 >
ALTER TABLE prodtbl ADD CONSTRAINT pk_prodtbl_proCode_prodId PRIMARY KEY(prodCode, prodId); -- 두개의 칼럼(필드)를 이용하여 하나의 고유키 생성함

-- < 외래키를 추가하여 테이블생성 >
DROP TABLE IF EXISTS usertbl;
CREATE TABLE userTbl(          
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate DATE NULL
);
DROP TABLE IF EXISTS buytbl; 
CREATE TABLE buyTbl (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    userId CHAR(8) NOT NULL,
    FOREIGN KEY (userId) REFERENCES userTbl(userId), -- 여기서 외래키 바로 가능함
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4) NULL,
    price INT NOT NULL,
    amount SMALLINT NOT NULL
);

-- < 테이블 생성후 외래키 추가(테이블 구조 변경) >
DROP TABLE IF EXISTS buytbl,usertbl;
CREATE TABLE userTbl(          
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL,
    mDate DATE NULL
);
CREATE TABLE buyTbl (
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    userId CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4) NULL,
    price INT NOT NULL,
    amount SMALLINT NOT NULL
); 

ALTER TABLE buyTbl ADD CONSTRAINT fk_userTbl_buyTbl FOREIGN KEY (userId) REFERENCES userTbl(userId); -- 나중에 테이블 구조 변경하면서 외래키 추가
SHOW INDEX FROM prodTbl;

-- 외래키 제거
ALTER TABLE buytbl DROP FOREIGN KEY fk_usertbl_buytbl;
SHOW INDEX FROM buytbl;

-- 부모(기본) 자식간의 직렬로 연결된 칼럼을 동시에 갱신 및 삭제함 
ALTER TABLE buytbl ADD CONSTRAINT fk_userTbl_buyTbl FOREIGN KEY (userId) REFERENCES userTbl(userId) ON UPDATE CASCADE;  -- 갱신되어 연결되어있는 (CASCADE)도 동시에 적용하여 갱신함
-- ON DELETE CASCADE; 삭제 연결되어있는 (CASCADE)도 동시에 삭제됨

-- DEFAULT 
DROP TABLE IF EXISTS usertbl;
CREATE TABLE userTbl(          
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL DEFAULT -1,   -- 입력되지않으면 -1로 저장됨
    addr CHAR(2) NOT NULL DEFAULT '서울', -- 입력되지않으면 '서울'로 DEFAULT값 지정
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL DEFAULT 170,  -- 입력되지않으면 '170'로 DEFAULT값 지정
    mDate DATE NULL
);
DROP TABLE userTbl;
CREATE TABLE userTbl(          
	userId CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,  
    addr CHAR(2) NOT NULL,
    mobile1 CHAR(3) NULL,
    mobile2 CHAR(8) NULL,
    height SMALLINT NULL , 
    mDate DATE NULL
);
 -- 나중에 default값을 추가하기 위해 column을 변경(alter)함
 ALTER TABLE userTbl ALTER COLUMN birthYear SET DEFAULT -1;
 ALTER TABLE userTbl ALTER COLUMN addr SET DEFAULT '서울';
 ALTER TABLE userTbl ALTER COLUMN height SET DEFAULT 170;
 DESC userTbl;
 
 INSERT INTO userTbl VALUES('LHL', '이혜리', default, default, '011', '1234567', default, '2019-12-12');
 INSERT INTO userTbl(userId, name) VALUES ('KAY', '김아영');
 INSERT INTO userTbl VALUES ('WB', '원빈', 1982, '대전', '019', '9876543', 176, '2017.5.5');
 SELECT * FROM userTbl;
 
 -- 칼럼 추가 및 삭제
ALTER TABLE userTbl ADD homepage VARCHAR(30) DEFAULT 'https://naver.com' NULL; -- 디폴트값 정해주고, NULL값 허용 
DESC userTbl;
ALTER TABLE userTbl DROP COLUMN mobile1;
DESC userTbl;
ALTER TABLE userTbl CHANGE COLUMN NAME uName VARCHAR(20) NULL; 
ALTER TABLE userTbl DROP PRIMARY KEY; 
ALTER TABLE buytbl DROP FOREIGN KEY buytbl_ibfk_1; 

-- 학사관리 데이터베이스
CREATE DATABASE studentManage;
-- 문제) 테이블 3개 생성
DROP TABLE IF EXISTS student;
CREATE TABLE student(
	stu_no CHAR(10),
    stu_name VARCHAR(12),
    stu_dept VARCHAR(20), 
    stu_grade INT,
    stu_class CHAR(1),
    stu_gender CHAR(1),
    stu_height DECIMAL(5,2),
    stu_weight DECIMAL(5,2)
);
-- 문제) 제약조건이름 p_stu_no primary key (stu_no) 
ALTER TABLE student ADD CONSTRAINT p_stu_no PRIMARY KEY (stu_no);

-- 문제) 과목(subject)테이블 생성
DROP TABLE IF EXISTS subject;
CREATE TABLE subject(
	sub_no CHAR(3),
    sub_name VARCHAR(30),
    sub_prof VARCHAR(12),
    sub_grade INT,
    sub_dept VARCHAR(20)
);
ALTER TABLE subject ADD CONSTRAINT p_sub_no PRIMARY KEY (sub_no);

-- 문제) enrol테이블 생성
DROP TABLE IF EXISTS enrol;
CREATE TABLE enrol(
	sub_no CHAR(3),
    stu_no CHAR(9),
    enr_grade INT
);
ALTER TABLE enrol ADD CONSTRAINT p_course PRIMARY KEY (sub_no, stu_no);

insert into student values(20153075,'옥한빛','기계',1,'C','M',177,80);
insert into student values(20153088,'이태연','기계',1,'C','F',162,50);
insert into student values(20143054,'유가인','기계',2,'C','M',154,47);
insert into student values(20152088,'조민우','전기전자',1,'C','M',188,90);
insert into student values(20142021,'심수전','전기전자',2,'A','F',168,45); 
insert into student values(20132003,'박희철','전기전자',3,'B','M',null,63);
insert into student values(20151062,'김인중','컴퓨터정보',1,'B','M',166,67);
insert into student values(20141007,'진현무','컴퓨터정보',2,'A','M',174,64);
insert into student values(20131001,'김종헌','컴퓨터정보',3,'C','M',null,72);
insert into student values(20131025,'옥성우','컴퓨터정보',3,'A','F',172,63);

INSERT INTO subject VALUES('111', '데이터베이스', '이재오', 2, '컴퓨터정보');
INSERT INTO subject VALUES('110', '자동제어', '정순정', 2, '전기전자');
INSERT INTO subject VALUES('109', '자동화설계', '박민영', 3, '기계');
INSERT INTO subject VALUES('101', '컴퓨터개론', '강종영', 3, '컴퓨터정보');
INSERT INTO subject VALUES('102', '기계공작법', '김태영', 1, '기계');
INSERT INTO subject VALUES('103', '기초전자실험', '김유석', 1, '전기전자');
INSERT INTO subject VALUES('104', '시스템분석설계', '강석현', 3, '컴퓨터정보');
INSERT INTO subject VALUES('105', '기계요소설계', '김명성', 1, '기계');
INSERT INTO subject VALUES('106', '전자회로실험', '최영민', 3, '전기전자');
INSERT INTO subject VALUES('107', 'CAD응용실습', 'RNQHDRB', 2, '기계');
INSERT INTO subject VALUES('108', '소프트웨어공학', '권민성', 1, '컴퓨터정보');

INSERT INTO enrol VALUES('101', 20131001, 80);
INSERT INTO enrol VALUES('104', 20131001, 56);
INSERT INTO enrol VALUES('106', 20132003, 72);
INSERT INTO enrol VALUES('103', 20152088, 45);
INSERT INTO enrol VALUES('101', 20131025, 65);
INSERT INTO enrol VALUES('104', 20131025, 65);
INSERT INTO enrol VALUES('108', 20151062, 81);
INSERT INTO enrol VALUES('107', 20143054, 41);
INSERT INTO enrol VALUES('102', 20153075, 66);
INSERT INTO enrol VALUES('105', 20153075, 56);
INSERT INTO enrol VALUES('102', 20152088, 61);
INSERT INTO enrol VALUES('105', 20152088, 78);

-- 1) 학생테이블에서 stu_dept결과를 중복없이 출력
SELECT DISTINCT(stu_dept) FROM student;
-- 2) enrol테이블에서 학생번호, 과목번호, 등록학점(등급), 등록 등급 +10을 조회
SELECT sub_no, stu_no, enr_grade, enr_grade+10 FROM enrol;
-- 3) 학생테이블에서 학생번호는 id로 별칭부여, 학생이름은 name으로 별칭부여하여 출력
SELECT stu_no AS id, stu_name AS name FROM student;
-- 4) 학생테이블에서 학과 설명을 출력하기 위하여 별칭 부여하여 문자열 결합 
SELECT CONCAT(stu_dept,',' ,stu_name,'입니다') AS '학과설명' FROM student;
-- 5) 학생테이블에서 컴퓨터정보인 학생들의 이름, stu_dept, std_grade, stu_class출력
SELECT stu_dept, stu_grade, stu_class FROM student WHERE stu_dept = '컴퓨터정보';
-- 6) 학생 테이블에서 컴퓨터정보학과 이면서 stu_grade가 2인 것들의 stu_name, stu_dept, stu_grade, stu_class를 출력
SELECT stu_name, stu_dept, stu_grade, stu_class FROM student WHERE stu_dept = '컴퓨터정보' AND stu_grade = 2;
-- 7) between을 사용하여 학생몸무게가 60-90사이인 학생의 전체정보를 출력
SELECT * FROM student WHERE stu_weight BETWEEN 60 AND 90;
-- 8) 학생이름이 김으로 시작하는 학생의 정보를 선택하여 stu_no, stu_name, stu_dept를 출력 
SELECT stu_no, stu_name, stu_dept FROM student WHERE stu_name LIKE '김%'; 
-- 9) 학생이름의 두번째 문자가 '수'인 학생의 번호,이름,학과를 출력 
SELECT  stu_no, stu_name, stu_dept FROM student WHERE stu_name LIKE '_수_'; 
-- 10) 학생의 학번이 2014로 시작하는 학생의 전체 정보를 출력 
SELECT * FROM student WHERE stu_no LIKE '2014%';
-- 11) 학생이 키가 null인 학생을 출력 
SELECT stu_name FROM student WHERE stu_height IS NULL;
-- 12) 학생의 키가 NULL이 아닌 학생의 번호,이름,키를 출력 
SELECT stu_no, stu_name, stu_height FROM student WHERE stu_height IS NOT NULL;
-- 13) in을 이용하여 학과 정보가 컴퓨터정보이거나 기계인 학생의 번호와 이름을 출력 
SELECT stu_no, stu_name FROM student WHERE stu_dept IN('컴퓨터정보','기계');


CREATE TABLE dept (
	dept INT NOT NULL PRIMARY KEY,
    dname VARCHAR(10),
	loc VARCHAR(13)
);
CREATE TABLE emp (
	empno INT NOT NULL PRIMARY KEY,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr INT,
    hiredate DATE,
    sal DECIMAL(7,2), -- 급여
    comm DECIMAL(7,2),  -- 커미션
    deptno INT   -- 부서번호
);
CREATE TABLE salgrade (
	grade DECIMAL(7,2),      -- 급여등급
    losal decimal(7,2),      -- 최저급여
    hisal DECIMAL(7,2)       -- 최고급여
);
insert into dept values (10, 'accounting' ,'new york');
insert into dept values (20, 'research' ,'DALLAS');
insert into dept values (30, 'SALES' ,'CHICAGO');
insert into dept values (40,'operations','BOSTON');
insert INTO emp values(7839,'KING','PRESIDENT', NULL,'1981-11-17',5000,null,10);
insert INTO emp values(7566,'JONES','MANAGER', 7839,'1981-4-2',2975,null,20);
insert INTO emp values(7698,'BLAKE','MANAGER', 7839,'1981-5-1',2850,null,30);
insert INTO emp values(7782,'CLARK','MANAGER', 7839,'1981-6-9',2450,null,10); 
insert INTO emp values(7788,'SCOTT','ANALYST', 7566,'1987-7-13',3000,null,20);
insert INTO emp values(7902,'FORD','ANALYST', 7566,'1981-12-3',3000,null,20);
insert INTO emp values(7499,'ALLEN','SALESMAN', 7698,'1981-2-20',1600,300,30);
insert INTO emp values(7521,'WARD','SALESMAN', 7698,'1981-2-22',1250,500,30);
insert INTO emp values(7564,'MARTIN','SALESMAN', 7698,'1981-9-28',1250,1400,30);
insert INTO emp values(7844,'TURNER','SALESMAN', 7698,'1981-9-8',1500,0,30);
insert INTO emp values(7900,'JAMES','CLARK', 7698,'1981-12-3',950,null,30);
insert INTO emp values(7522,'WARD','SALESMAN', 7698,'1981-2-22',1250,500,30);
insert INTO emp values(7934,'MILLER','CLARK', 7782,'1982-1-23',1300, null,10);
insert INTO emp values(7369,'SMITH','CLARK', 7902,'1980-12-17',800, null,20);
insert INTO emp values(7876,'ADAMS','CLARK', 7788,'1987-7-13',1100,null,20);
insert into salgrade values(1,700,1200);
insert into salgrade values(2,1201,1400);
insert into salgrade values(3,1401,2000);
insert into salgrade values(4,2001,3000);

-- 1) case when then 구문활용
SELECT ename, empno, sal,                   -- sal뒤에도 ,써야한다! (틀림)
	CASE job
		WHEN 'SALESMAN' THEN sal * 1.1            -- when 뒤엔 ' ____ '써주기 
		WHEN 'clark' THEN sal * 1.5
		WHEN 'MANAGER' THEN sal * 1.2
		ELSE sal 
	END AS '급여인상'
FROM emp;

-- 2) enrol 테이블에서 enr_grade 의  가장 큰값과 가장 작은값을 select하세요
SELECT MAX(enr_grade), MIN(enr_grade) FROM enrol;
-- 3) 기계과 학생의 최저, 최고 몸무게는?
SELECT MAX(stu_weight) AS '최대몸무게', MIN(stu_weight) AS '최소몸무게' FROM student WHERE stu_dept='기계';
-- 4) count(*), count(stu_height) FROM sudent에서 두개의 결과가 차이나는 이유?
SELECT count(*), count(stu_height) FROM student;
-- 5) 컴퓨터정보 학과의 체중의 합과 체중의 평균은?
SELECT SUM(stu_weight) AS '체중의합', AVG(stu_weight) AS '체중의 평균' FROM student WHERE stu_dept = '컴퓨터정보';
-- 6) SELECT COUNT(*) AS 학생, sum(stu_height) AS 신장합 count(std_height) 해당 학생수, avg(stu_height)평균신장 from student -> null값이 제외되어 계산됨
SELECT COUNT(*) AS 학생, sum(stu_height) AS 신장합, count(stu_height) AS 해당학생수, avg(stu_height) AS 평균신장  from student;
-- 7) 학과별 몸무게 평균과 학과를 표시함
SELECT AVG(stu_weight), stu_dept FROM student GROUP BY stu_dept;
-- 8) 학과별 그룹을 하고 몸무게가 50키로 이상인 학생의 학과와 갯수는?
SELECT stu_dept, COUNT(*) FROM student WHERE stu_weight >= 50 GROUP BY stu_dept ;
-- 9) group by stu_dept, stu_grade의 두개로 그룹을 지을 수 있고, 학과별, 같은학과 학년별로 그룹을 짓고
SELECT stu_dept, stu_grade, count(*) FROM student GROUP BY stu_dept, stu_grade;
-- 10) having절 사용 / 기계과 학생들 중 학년별 신장이 160이상인 학년(stu_grade)와 평균 신장을 구하세요
SELECT AVG(stu_height) FROM student WHERE stu_dept='기계' GROUP BY stu_grade HAVING AVG(stu_height) > 160;
 -- 집계함수는 WHERE절에 못들어가고 HAVING절에 사용한다.

-- 11) 최대신장이 175이상인 학과와 학과별최대신장을 구함
SELECT stu_height, stu_dept AS '학과별 최대신장' FROM student GROUP BY stu_dept HAVING MAX(stu_dept) >= 175 ;
-- 12) 학과별 평균신장중 가장 높은 평균신장을 구함
SELECT stu_height FROM student WHERE stu_height IN (SELECT AVG(stu_height) FROM emp) GROUP BY stu_dept;
-- 13) 10번 부서에 근무하는 사원이름검색 
SELECT ename FROM emp WHERE deptno=10;
-- 14) 급여가 2000 이상인  사원들의 사원번호, 사원이름 검색
SELECT empno, ename FROM emp WHERE sal >= 2000;
-- 15) 사원직무가 CLERK인 사원들의 사원번호, 사원이름 검색 
SELECT empno, ename FROM emp WHERE job='CLERK';
-- 16) 1980년 12월 17일에 입사한 사원이름 검색
SELECT ename FROM emp WHERE hiredate='1980-12-17';
-- 17) 10번 부서에 근무하는 manager의 사원이름 검색
SELECT ename FROM emp WHERE deptno =10 AND job='manager';
-- 18) 급여가 2000 이상이며 30번 부서에 근무하는 사원들의 사원번호와 사원이름 검색 
SELECT ename, empno FROM emp WHERE sal >= 2000 AND deptno =30;
-- 19) 사원 직무가 clerk이며 81년 이후에 입사한 사원들의 사원번호와 사원이름 검색
SELECT empno, ename FROM emp WHERE job='CLERK' AND hiredate > '1981-01-01';
-- 20) saleman이며 급여가 1500이상인 사원이름 검색 
SELECT ename FROM emp WHERE sal >= 1500 AND job='salesman';
-- 21) 급여가 1000이상이며, 2500이하인 사원의 사원번호 사원이름, 급여검색
SELECT ename, empno FROM emp WHERE sal BETWEEN 1000 AND 2500;
-- 22) 사원번호가 75xx인 사원의 사원번호, 사원이름, 부서번호 검색 
SELECT empno, ename, deptno FROM emp WHERE empno LIKE '75__';
-- 23) 부서번호가 10 또는 30에 근무하는 사원들의 사원이름과 급여검색
SELECT ename, sal FROM emp WHERE deptno IN (10,30);
-- 24) 1981년 2월에 입사한 서원의 사원번호, 사원이름, 부서번호 검색 
SELECT empno, ename, deptno FROM emp WHERE hiredate LIKE '1981-02%';
-- 25) 사원이름 중간에 'A'가 들어가는 사원의 사원번호와 사원이름 검색
SELECT empno, ename FROM emp WHERE ename LIKE '_%A%_';
-- 26) 20번 부서 사원들중 최고 급여를 받는 사원의 사원번호, 사원이름, 급여를 검색 
SELECT empno, ename, sal FROM emp WHERE deptno=20 ORDER BY sal DESC LIMIT 1;
-- 27) 30번 부서 사원중 최저 급여를 받는 사원의 사원번호, 사원이름, 커미션을 검색 
SELECT empno, ename, comm FROM emp WHERE deptno=30 ORDER BY sal ASC LIMIT 1;
-- 28) 전체 사원들중 최고커미션을 받는 사원의 사원번호, 사원이름, 커미션을 검색 
SELECT empno, ename, comm FROM emp ORDER BY comm DESC LIMIT 1;
-- 29) 부서별 사원들의 급여의 표준편차(stddev)를 검색 
SELECT stddev(sal) FROM emp GROUP BY job;
-- 30) 부서별 사원직무별 사원들의 평균 급여검색 
SELECT AVG(sal) FROM emp LEFT OUTER JOIN dept ON dept.dept = emp.empno GROUP BY job,dept;



```
