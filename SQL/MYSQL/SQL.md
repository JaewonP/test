#### DBMS = client program(mysql) + server program(mysquld)  => CLI환경
#### client program(Mysql work bench => GUI환경
#### SQL문
* SELECT : 테이블의 데이터를 조회할때  
* '*' : 모든 column까지 포함  
* FROM + DATABASE + DATA : 어느부분의 데이터인지 범위설정  
* WHERE email = 'emma@naver.com'; : 특정조건을 만족하는 row만 추출  
#### 데이터 조회하기  
* int, text타입 모두 부등호로 데이터 조회 가능
ex) age > 20 , sign_up_day > '2020-01-01'  
* ex) address LIKE '서울%' / '%안산시%'  
* ex) age IN (20,30) => 같은 age 컬럼일때 괄호로 묶어서 사용 
 => IN : 집합연산자(~이거나 ~일때 괄호안에넣어 , 로 구분)   
  * %, ', \ 이 포함된 정보를 조회할때 => '20\%'  (앞에 백슬래시 써준다)  
* 데이터 관련함수(WHERE뒤에 사용)  
YEAR, MONTH, DAYOFMONTH, DATEDIFF(sign_up_day, CURDATE), DATE_ADD(sign_up_day) INTERVAL 200DAY : 회원가입으로부터 200일 후의 날짜, DATE_SUB, DATETIME(시간+날짜)  
* 유닉스타입 시간사용   
FROM_UNIXTIME(UNIX_TIMESTAMP(sign_up_time)) => 유닉스타입의 시간을 일반시간타입으로 변환  
#### 정렬
> row를 특정 column기준으로 순서대로 출력  
* ORDER BY + height ASC/DESC , CAST(data AS signed)  
(signed = 음수+양수 / decimal = 소수)   
* LIMIT (개수만 추려보기, N번째부터 몇개 추려보기)  
(LIMIT 10, LIMIT 0, 10) 
#### 데이터특성  
Aggregate Function(집계함수)  
* SELECT + COUNT(*) => All(null까지 포함하여 집계)
* SELECT + 집계함수(MAX, MIN) 
* SELECT + 산술함수(ABS, ROUND, SQRT)
NULL 관리하기 
* WHERE address IS NULL / IS NOT NULL   (address NULL => 유효하지않은 명령)
* NULL을 다른문자로 바꾸기  
=> SELECT COALESCE(height, '####') FROM member;
* Column관리하기
 1. alias : height AS 키  
 2. CONCAT(weight, 'kg', ',', height, 'cm') AS 키와 몸무게 / Column합칠때 사용
 3. CASE END문(컬럼값 변경하여 컬럼추가)
 -단순 CASE age   
           WHEN 값 THEN 값  
      ELSE
 -검색 CASE    
           WHEN 조건 THEN 값  
      ELSE   
* NULL값을 다른값으로 바꾸기
1. COALESCE(height, weight*3, N/A) => height값이 NULL이면 몸무게의3배 출력, 키와몸무게 둘다 NULL이면 N/A출력  
 - Flexable한(파라미터수 자유롭다) 표현법(SQL공식 문법)  
 - Null값을 최대한 인정하지 않으려는 표현  
2. IFNULL(height, 'N/A') => height중에 null값이 있으면 'N/A'  
 - 파라미터는 무조건 2개  
 - NULL값을 인정    
3. IF(height IS NOT NULL, height, 'N/A') => 3항연산자와 비슷  
4. CASE WHEN height IS NOT NULL THEN height  
   ELSE 'N/A'  
   END  
* 고유한 값 추출하기  
1. DISTINCT(gender)  
2. SUBSTRING(address, 1, 2) => 주소란의 1번째 글자부터 2개를 추출한다(0번째 부터 아님주의)  
-> DISTINCT(SUBSTRING(address, 1, 2))  
* 문자열 처리함수  
-> LENGTH, UPPER, LOWER, 채우기 {LPAD, RPAD(age, 10, '0')}, 자르기 {LTRIM, RTRIM, TRIM()}  
* 그루핑(GROUP BY)  
ex) GROUP BY SUBSTRING(address, 1, 2), gender => 2가지 조건을 조합하여 그룹화 함  
 - 일부 row만 출력하기  
  HAVING region = '서울';  
  => GROUP BY에 쓴 인자만 SELECT에 넣을수있다(AVG(gender)처럼 집계함수에 넣어서도 넣어줄수있다)

#### WHERE vs HAVING  
=> WHERE : 초기의 row 조건설정  
=> HAVING : 그루핑 후의 필터링하는 과정  

### ROW와 COLUMN관리 
1. ROW 관리 
```SQL
 INSERT INTO student VALUES ('오구', '황구');
 UPDATE student SET major='멀티미디어' WHERE id=2;
 DELETE FROM student WHERE id=4;
 ```
 => UPDATE & DELETE는 WHERE무조건써준다!

2. COLUMN 관리
* ALTER TABLE : 테이블 구조 변경하기  
```SQL
ALTER TABLE student ADD gender CHAR(1) NULL;  -- 컬럼추가하기
```
```SQL
ALTER TABLE student DROP COLUMN admission_date;  -- 컬럼삭제하기 
```
```SQL
ALTER TABLE student RENAME COLUMN student TO student_number  -- 컬럼이름수정
```
```SQL
ALTER TABLE student MODIFY major INT;  -- 데이터타입 수정 / 유의사항 => 만약 CHAR -> INT형으로 바꿀시 해당하는 글자를 숫자로 바꿔놓은후 해당 명령어를 써야한다
ALTER TABLE student MODIFY major INT NOT NULL DEFAULT 100;  -- 데이터속성 수정 => 보통 디폴트값은 이렇게 수정한다.
```
※ RENAME + MODIFY = CHANGE(이름 및 속성 타입 수정)  
* UNIQUE : 같은값을 가진 추가ROW 방지  
  => PRIMARY KEY vs UNIQUE  
  * PRIMARY KEY : 테이블당 1개! NULL 인정하지않음
  * UNIQUE : 테이블당 여러개가능, NULL 인정!

* CONSTRAINT : 각 컬럼에 제약사항 걸기 
```SQL
ALTER TABLE student ADD CONSTRAINT st_rule CHECK(registration_number < 30000000);  -- 괄호안에 조건은 n가지 가능하다
ALTER TABLE student DROP CONSTRAINT st_rule  -- 제약조건명을 알아야지만 constraint를 삭제할수있다.
```
