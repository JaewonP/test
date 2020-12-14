SQL join part
====================
### 1. Foreign key(외래키)
### 2. alias  
  * column에 alias 사용 : 실제로 내가 보는 column값을 재정의하는것  
  * table에 alias 사용 : SQL문 전체의 길이를 줄여 가독성을 높이기 위함 ex) m.gender(m이라고 붙인테이블의 gender column값을 가르킨다)  
### 3. JOIN 1_ 다른종류의 테이블 조인하기(LEFT/RIGHT OUTER JOIN)  
```sql
SELECT
  item.id,
  item.name,
  stock.item_id,
  stock.inventory_count
FROM item LEFT OUTER JOIN stock
ON item.id = stock.item_id
```
### 4. JOIN 2_다른종류의 테이블 조인하기(INNER JOIN)  
```sql
SELECT
  i.id,  -- alias로 바꿔준것을 적용할것
  i.name,
  s.item_id,
  s.inventory_count
FROM item AS i INNER JOIN stock AS s
ON i.id = s.item_id; -- JOIN의 조건을 사용할때는 ON!
```
### 5. 결합연산(JOIN) vs 집합연산 
    => 집합연산(집합 : 같은종류의 테이블일때만 가능)
    ```sql
    SELECT*FROM member_A
    INTERSECT -- MINUS(차집합), UNION(합집합)
    SELECT*FROM member_B
    ```
    
    => 컬럼수가 다른 데이터2개를 집합연산 가능!(각 컬럼에서 공통된부분만 추린다)  
    ```sql
    SELECT id, nation, count FROM member_A
    INTERSECT -- MINUS(차집합), UNION(합집합, UNION ALL => 겹치는것까지 중복하여 보여준다)
    SELECT id, nation, count FROM member_B
    ```
