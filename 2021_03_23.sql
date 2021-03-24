월별실적

                반도체           핸드폰            냉장고
2021년 1월 :      500             300              400
2021년 2월 :      500             300              400
2021년 3월 :      500             300              400
.
.
.
2021년 12월 :      500             300              400

SELECT buy_date, buy_prod, prod_name, NVL(buy_qty 0)
FROM buyprod, prod
WHERE buyprod.buy_prod(+) = prod.prod._id
AND     buy_date = TO_DATE('2015/01/25', 'YYYY/MM/DD');


JOIN
문법
 : ANSI / ORACLE
논리적 형태
 : SELF JOIN, NON-EQUI-JOIN <==> EQUI-JOIN
연결조건 성공 실패에 따라 조회여부 결정
 : OUTERJOIN <===> INNER JOIN : 연결이 성공적으로 이루어진 행에 대해서만 조회가 되는 조인


SELECT * 
FROM dept INNER emp ON (dept.deptno = emp.deptno);

CROSS JOIN
- 별도의 연결 조건이 없는 조인
- 묻지마 조인 --연결조건없어도 걍 막무가내 조인
- 두 테이블의 행간 연결가능한 모든 경우의 수로 연결
    ==> CROSS JOIN의 결과는 두 테이블의 행의 수를 곱한 값과 같은 행이 변환된다.

[.데이터 복제를 위해 사용]

SELECT *
FROM emp, dept;

cross join 실습1
customer, product 테이블을 이용하여 고객이 애음 가능한 모든 제품의 정보를 결합하여 다음과 같이 조회되도록 쿼리를 작성하세요.

select * 
from customer;

select *
from product;


--대전 중구의 버거지수
도시발전지수 : (kfc + 맥도날드 + 버거킹) / 롯데리아)

대전  중구  2

SELECT *--SIDO, SIGUNGU, 도시발전지수
FROM BURGERSTORE
WHERE SIDO = '대전'
  AND SIGUNGU = '중구';
  
  
  
  
--- 행을 컬럼으로 변경(PIVOT)
SELECT sido, sigungu, 
        (SUM(DECODE(storecategory, 'BURGER KING', 1, 0)) +
        SUM(storecategory, 'KFC', 1, 0) +
        DECODE(storecategory, 'MACDONALD', 1, 0),
        DECODE(storecategory, 'LOTERIA', 1, 0))
FROM burgerstore --가 BURGER KING 이면 1, 아니면 0
GROUP BY sido, sigungu
ORDER BY sido, sigungu;
    
    
        storecategory가 BURGER KING 이면 1, 0,
        storecategory가 KFC 이면 1, 0,
        storecategory가 MACDONALD 이면 1, 0,
        storecategory가 LOTTERIA 면 1, 0
FROM burgerstore;
