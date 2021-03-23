SELECT lprod.lprod_gu, lprod.lprod_nm,
        prod.prod_id, prod.prod_name
FROM lprod, prod --두개 테이블을 연결
WHERE lprod.lprod_gu = prod.prod_lgu;


실습 join2)erd 다이어그램을 참고하여 buyer, prod 테이블을 조인하여
buyer별 담당하는제품 정보를 다음과 같은 결과가 나오도록 쿼리를 
작성해보세요.
SELECT buyer.BUYER_ID, buyer.BUYER_NAME, prod.PROD_ID, prod.PROD_NAME
FROM buyer, prod; --buyer 테이블에있는 buyer_id와 buyer_name
                  --prod 테이블에있는 prod_id와 prod_name을 합쳐서 출력
WHERE prod.buyer_id = buyer.buyer_id;          


실습 join3)erd 다이어그램을 참고하여 member, cart, prod 테이블을 조인하여
회원별 장바구니에 담은 제품 정보를 다음과 같은 결과가 나오는 쿼리를 작성해보세요.

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member
    AND cart.cart_prod = prod.prod_id;
    
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty    
FROM member JOIN cart ON (member.mem_id = cart.cart_member)
JOIN prod ON (cart.cart_prod = prod.prod_id);
                 
    
    
SELECT *
FROM product

SELECT *
FROM cycle;


실습4)

SELECT customer.CID, cycle.CID, customer.CNM, cycle.PID, cycle.DAY, cycle.CNT -- 양쪽에 있는 애들은 앞에 어떤 테이블인지 붙여줘야하고 하나만 있어서 명확한거면 걍 써도됨.
FROM customer, cycle
WHERE   customer.cid = cycle.cid
        AND customer.cnm IN ('brown', 'sally');

실습5)

SELECT customer.CID, customer.CNM, cycle.CID, cycle.PID, cycle.DAY, product.PID, prouct.PNM
FROM customer, cycle, product
WHERE   customer.cid = cycle.cid
        AND customer.cnm IN ('brown', 'sally');

실습 6)

SELECT customer.CID, customer.CNM, cycle.CID, cycle.PID, product.PNM, cycle.CNT, SUM(cycle.cnt) cnt
FROM customer, cycle, product
WHERE cycle.pid = product.pid
GROUP BY customer.CID, customer.CNM, cycle.PID, product.PNM;


실습 7)

SELECT cycle.PID, product.PNM, SUM(cycle.cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm;



IN JOIN
OUT JOIN - 컬럼 연결이 실패해도 [기준]이 되는 테이블 쪽의 컬럼 정보는 나오도록하는 조인
LEFT OUTER JOIN : 기준이 왼쪽에 기술한 테이블이 되는 OUTER JOIN
RIGHT OUTER JOIN : 기준이 오른쪽에 기술한 테이블이 되는 OUTER JOIN
FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복 데이터 제거

테이블 JOIN 테이블2;
테이블1: LEFT OUTER JOIN 테이블2;
테이블 2 : RIGHT OUTER JOIN 테이블1;

직원의 이름, 직원의 상사 이름 두개의 칼럼이 나오도록  join query 작성
13건(King이 안나와도 괜찮음)

SELECT e.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


--ORACLE SQL OUTER JOIN 표기 : (+)
-- OUTER 조인으로 인해 데이터가 안나오는 쪽 컬럼에 (+)를 붙여준다
SELECT e.name, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);


SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.ename, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
    AND     m.deptno = 10;

SELECT e.ename, m.ename, m.deptno
FROM emp e, emp m 
WHERE e.mgr = m.empno(+)
    AND     m.deptno(+) = 10;
    
SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON( e.mgr = m.empno);

SELECT e.ename, m.ename, m.deptno
FROM emp m RIGHT OUTER JOIN emp e ON( e.mgr = m.empno);


--데이터는 몇건이 나올까?? 그려볼것
SELECT e.ename, m.ename, m.deptno
FROM emp e RIGHT OUTER JOIN emp m ON( e.mgr = m.empno);

--FULL OUTER : LEFT OUTER(14) + RIGHT OUTER(21) - 중복 데이터 1개만 남기고 제거(13) = 22개
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

--FULL OUTER 조인은 오라클 SQL문법으로 제공하지 않는다.
SELECT e.ename, m.ename
FROM emp e, emp m 
WHERE e.mgr(+) = m.empno(+);



outer join 문제1

SELECT COUNT(*)
FROM prod;


SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod RIGHT OUTER JOIN prod ON (buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));
WHERE buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

모든 제품을 다 보여주고, 실제 구매가 있을 때는 구매수량을 조회, 없을경우는 null로 표현
제품코드 : 수량


outer join 4
cycle, product 테이블을 이용하여 고객이 애음하는 제품 명칭을 표현하고, 애음하지 않는 제품도 다음과 같이 조회되도록 쿼리를 작성하세요
(고객은 cid=1인 고객만 나오도록 제한, null처리)

SELECT *
FROM product;


SELECT *
FROM cycle;



outerjoin4]
SELECT product.*, cycle.cid, NVL(cycle.day, 0) NVL(cycle.cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON (product.pid = cycle.pid AND cid = 1);

SELECT product.*, :cid, NVL(cycle.day, 0) day, NVL(cycle.cnt, 0) cnt
    FROM product, cycle
WHERE product.pid = cycle.pid(+)
    AND cid(+) = :cid;
    
    
[ outerjoin 5번 => 과제 ]
outerjoin4를 바탕으로 고객 이름 컬럼 추가하기

WHERE, GROUP BY(그룹핑), JOIN

JOIN







SELECT *
FROM buyprod;





<join 과제>
실습 8 erd 다이어그램을 참고하여 countries, regions 테이블을 이용하여 지역별 소속 국가를
      다음과 같은 결과가 나오도록 쿼리를 작성해보세요(지역은 유럽만 한정)
      SELECT c.region_id, region_name, country_name -- r.region_id도 가능.
      FROM COUNTRIES, regions
      WHERE 
       
      
       SELECT c.region_id, region_name, country_name
       FROM
       WHERE
      
      
실습9 erd 다이어그램을 참고하여 countries, regions, locations테이블을 이용하여 지역별 소속 국가,
     국가에 소속된 도시 이름을 다음과 같은 결과가 나오도록 쿼리를 작성해보세요(지역은 유럽만 한정)
     
     
     
     

실습10 erd 다이어그램을 참고하여 countries, regions, locations, departments 테이블을 이용하여 지역별 소속 국가, 
      국가에 소속된 도시 이름 및 도시에 있는 부서를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요(지역은 유럽만 한정)
     
     
      

실습11 erd 다이어그램을 참고하여 countries, regions, locations, departments, employees 테이블을 이용하여 
      지역별 소속 국가, 국가에 소속된 도시 이름 및 도시에 있는 부서, 부서에 소속된 직원 정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
      (지역은 유럽만 한정)
     
     
      
      
실습12 erd 다이어그램을 참고하여 employees, jobs 테이블을 이용하여 직원의 담당업무 명칭을 포함하여
      다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
      
     
     
      
실습13 erd 다이어그램을 참고하여 employees, jobs 테이블을 이용하여 직원의 담당업무 명칭, 직원의 매니저 정보를 포함하여
      다음과 같은결과가 나오도록 쿼리를 작성해보세요.
     
     
     
      