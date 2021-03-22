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
        AND customer.CNM IN ('brown', 'sally');

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




