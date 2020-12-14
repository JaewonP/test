INDEX
===============
### 개념요약
1) 장.단점  
   * 장점 : 검색속도가 빨라질 수도있다. 쿼리의 부하감소, 시스템능력 향상가능  
   * 단점 : INDEX가 전체 DB에 10%용량을 차지한다.(추가공간이 필요), 인덱스생성에 시간이 소요된다, 변경작업이(특히 INSERT) 있을시 성능이떨어질수있다.   
2) MYSQL INDEX의 종류와 특징  
  * 클러스터형 INDEX : 영어사전과 비슷  
    * PRIMARY KEY생성시 자동생성된다   
    * PRIMARY KEY = UNIQUE + NUT NULL / BUT 둘다 존재한다면 PRIMARY KEY의 우선순위가 더 높다  
    * 특징 : 범위검색에 용이하며, 검색이 빠름(거쳐가는 인덱스숫자가 적다)  
    * 명령어  
    ```SQL
    ALTER TABLE clustertbl ADD CONSTRAINT pk_cluster_userId PRIMARY KEY(userId)  -- 테이블에 primary key설정
    ```
  * 보조형 INDEX : 책뒤의 색인과 비슷   
    * UNIQUE 생성시 자동생성   
    * 특징 : 검색이 비교적 오래걸리지만(별도의 INDEX가 만들어지므로) , 내용추가시 부담 적음  
    * 명령어  
    ```SQL
    ALTER TABLE secondarytbl ADD CONSTRAINT uk_secondarytbl_userId UNIQUE(userId)  -- 테이블에 unique설정
    ```
3) INDEX 명령어
```SQL
SHOW INDEX FROM tbl;               -- 여기서 keyname과 primarykey가 같으면 클러스터형 인덱스임
SHOW TABLE STATUS LIKE 'usertbl';  -- 인덱스의 길이까지 알고싶을때
CREATE INDEX idx_userTbl_addr ON userTbl(addr);  -- index명은 성의있게 만들기
ANALYZE TABLE userTbl;             -- 공부기필요한부분 
```
