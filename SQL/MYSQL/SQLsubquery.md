## 위치에 따른 서브쿼리
### SELECT절의 서브쿼리  
```MYSQL
SELECT id, name, price,(SELECT MAX(price) FROM item) AS max_price
FROM copang_main.item;
```

### FROM절의 서브쿼리
#### * Derived Table : 서브쿼리로 탄생한 테이블 (alias필수) </span>
```MYSQL
select AVG(review_count)
FROM
(select
    SUBSTRING(address, 1, 2) AS region,
    COUNT(*) AS review_count
FROM review AS r LEFT OUTER JOIN member AS m
ON r.mem_id = m.mem_id
GROUP BY SUBSTRING(address, 1, 2)
HAVING region IS NOT NULL AND region != '안드' AS review_count_summary);
```

### WHERE절의 서브쿼리
* 계산하는 서브쿼리
```MYSQL
SELECT id, name, price
FROM item
WHERE price = (SELECT MIN(price) FROM item);  
```
* 원하는 조건을 필터링 (IN뒤의 조건중 맞는게 있다면 TRUE를 리턴 / ANY,SOME,ALL(서브쿼리) 가능!)
```MYSQL
SELECT * FROM item
WHERE id IN
(
SELECT item_id
FROM review
GROUP BY item_id HAVING COUNT(*) >= 3
)
```
* 서브쿼리의 결과값이 여러개일때는 ALL,ANY를 


### 상관서브쿼리 
* 서브쿼리만으로 동작이 안됨
* 외부쿼리와 상호작용하여 실행
* EXISTS : 내부쿼리안의 조건에 충족하는 row를 조회후, 충족하는 row만 외부쿼리에 쌓인다!
```sql
SELECT * FROM item
WHERE EXISTS (SELECT item_id FROM review GROUP BY item_id HAVING COUNT(*) >= 3);
```
※ 상관서브쿼리 and JOIN은 원하는값을 모아준다는 공통점이있다.  아래의 결과는 동일하므로 뭔하는걸 쓴다
* 상관서브쿼리 사용
```sql
SELECT id, name, (SELECT inventory_count FROM stock WHERE stock.item_id = item.id) FROM item;
```
* JOIN사용
```sql
SELECT i.id, i.name, s.inventory_count
FROM item AS i LEFT OUTER JOIN stock AS s
ON s.item_id = i.id;
```

### 서브쿼리로 코드를 줄이기!
- alias처리해도 변수처럼 다시 사용 불가능하다  
** derived table에 alias를 붙이면 재사용가능(원래 존재하던 테이블인것처럼 취급하기 때문)  
** FROM 뒤에 서브쿼리 + alias를 써서 코드를 재활용하자!   

### 뷰(View, 가상테이블)
* Join등의 작업으로 만들어진 결과테이블이 '가상'으로 저장된 형태(테이블을 간결하게 할수있다)
* 컴퓨터에 저장이되지않고, 뷰를 쓰면 DBMS가 그 뷰를 생성하는 SQL문을 재실행하는 방식(FUNCTION과 비슷)
* 만드는 방법
```sql
-- ctrl + t
CREATE VIEW three_tables_joined AS ___   -- CREATE VIEW 뷰의이름 AS 뷰로 지정할 코드
```

## 실무에서 첫번째로 해야할 일
1. 데이터베이스 확인
```sql
SHOW DATABASES;
```
2. 테이블확인
* 아마 BASE TABLE + VIEW로 나뉘어져 있을것
```sql
SHOW FULL TABLES IN copang_main;
```
3. 한 테이블의 컬럼확인(구조확인)
```sql
DESCRIBE item;
```
4. FOREIGN KEY확인 
![capture](https://github.com/lee-bomi/git-practice-with-CIT/blob/master/foreignkey.JPG)

```
