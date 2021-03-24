
WHERE, GROUP BY, JOIN --현재까지 배운것중 중요한것들


SMITH가 속한 부서에 있는 직원들을 조회하기 --20번부서에 속하는 직원들 조회하기

1. SMITH가 속한 부서 이름을 알아 낸다
2. 1번에서 알아낸 부서번호로 해당 부서에 속하는 직원을 emp테이블에서 검색한다.

1.
SELECT deptno
    FROM emp
    WHERE ename = 'SMITH';
    
2. 
SELECT *
FROM emp
WHERE deptno = 20;



< SUBQUERY를 활용 > = 1,2번을 합침.
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp 
                WHERE ename = 'SMITH'); -- where절에서 사용됬기떄문에 서브쿼리이다
                                        -- 단일행 - 단일서브컬럼
                
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM   emp
                 WHEN ename = 'SMITH' OR ename = 'ALLEN');
                

WHERE deptno = (20, 'SMITH')
WHERE deptno IN (20, 30)

SUBQUERY : 쿼리의 일부로 사용되는 쿼리
1. 사용 위치에 따른 분류
    SELECT : 스칼라 서브 쿼리 - 서브쿼리의 실행결과가 하나의 행, 하나의 컬럼을 반환하는 쿼리
    FROM   : 인라인 뷰 
    WHERE  : 서브쿼리
                메인쿼리의 컬럼을 가져다가 사용할 수 있다
                반대로 서브쿼리의 컬럼을 메인쿼리에 가져가서 사용할 수 없다
                
2. 반환값에 따른 분류(행, 컬럼의 개수에 따른 분류)
    행 - 다중행, 단일행, 컬럼 - 단일컬럼, 복수 컬럼
    * 다중행 단일 컬럼
    * 다중행 복수 컬럼
    * 단일행 단일 컬럼
    * 단일행 복수 컬럼

3. main-sub query의 관계에 따른 분류
    * 상호 연관 서브 쿼리 (correlated subquery)- 메인 쿼리의 컬럼을 서브 쿼리에서 가져다 쓴경우
        ==> 메인쿼리가 없으면 서브쿼리만 독자적으로 실행 불가능. 
        
    * 비상호 연관 서브 쿼리 (non-correlated subquery)- 메인 쿼리의 컬럼을 서브 쿼리에서 가져다 쓰지 않은 경우
        ==> 메인쿼리가 없어도 서브쿼리만 실행가능    


서브쿼리 

(실습 sub1)
- 평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요. 직원의 수 -> COUNT(*) -> 행의 갯수

SELECT COUNT(*)
FROM emp;
WHERE sal>= (SELECT AVG(sal)
              FROM emp);

(실습 sub2)
- 평균 급여보다 높은 급여를 받는 직원의 정보를 조회하세요

SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal) 
                FROM emp);
                
(실습 sub3)
- SMITH와 WARD사원이 속한 부서의 모든 사원 정보를 조회하는 쿼리를 다음과 같이 작성하세요.

SELECT *
FROM emp m
WHERE m.deptno IN  (SELECT s.deptno
                    FROM emp s
                    WHERE s.ename IN ('SMITH', 'WARD'));


SELECT *
FROM emp 
WHERE deptno IN  (SELECT deptno
                    FROM emp 
                    WHERE ename IN ('SMITH', 'WARD'));          
       
       
       
                    
MULTI ROW 연산자
IN : =+ OR
비교 연산자 ANY
비교 연산자 ALL

SELECT *
FROM emp e
WHERE e.sal < ANY (SELECT s.sal
                    FROM emp s
                    WHERE s.ename IN ('SMITH', 'WARD'));
직원중에 급여값이 SMITH(800)나 WARD(1250)의 급여보다 작은 직원을 조회
==> 직원중에 급여값이 1250보다 작은 직원 조회

SELECT *
FROM emp e
WHERE e.sal < (SELECT MAX(s.sal)
                    FROM emp s
                    WHERE s.ename IN ('SMITH', 'WARD'));
                    
                    

==> 
SELECT *
FROM emp e
WHERE e.sal < (SELECT MIN(s.sal)
                FROM emp s
                WHERE s.ename IN ('SMITH', 'WARD'));
                
                
subquery 사용시 주의점 NULL 값
IN ()
NOT IN ()

SELECT *
FROM emp
WHERE empno IN( 10, 20, NULL);
==> !(deptno = 10 OR deptno = 20 OR deptno = NULL)
  ==> !(deptno = 10 OR deptno = 20 OR deptno = NULL)
       ==> deptno != 10 AND deptno != 20 AND depnotno != NULL     
       
SELECT *
FROM emp
WHERE NOT IN (SELECT mgr
                FROM emp);
                
SELECT &
FROM   emp
WHERE empno NOT IN ((SELECT NVL(mgr, 1999);
                     FROM emp); -- 시험 나중에 보면 이거 나옴.
        
PAIR         

SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, 9999)
                    FROM emp);
     AND deptno IN (SELECT deptno
                    FROM emp
                    WHERE empno IN(7499, 7782));
                    
                    

--ALLEN(30, 7698), CLARK(10, 7839)                    
SELECT ename, mgr, deptno
FROM    emp
WHERE   empno IN(7499, 7782);
                                
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
    AND deptno IN (10, 30);
mgr, deptno
== (7698, 10), (7698, 30), (7839,10), (7839,30)



요구사항 : ALLEN 또는 CLARK의 소속, 부서번호가 같으면서 상사도 같은 직원들을 조회

순서쌍?

SELECT *
FROM emp
WHERE (mgr, deptno) IN
                        (SELECT mgr, deptno
                         FROM emp
                         WHERE ename IN ('ALLEN', 'CLARK'));
                         
                         
DISTINCT(중복된 데이터 제거) - 1. 설계가 잘못된경우 
                             2. 개발자가 sql을 잘 작성하지 못하는 사람인 경우
                             3. 요구사항이 이상한 경우
                             
스칼라 서브쿼리 : SELECT 절에 사용된 쿼리, 하나의 행, 하나의 컬럼을 반환하는 서브쿼리(스칼라 서브쿼리)

SELECT empno, ename, SYSDATE--(현재시간)
FROM emp;
                         
SELECT empno, ename, (SELECT SYSDATE FROM dual)
FROM emp;

emp 테이블에는 해당 직원이 속한 부서번호는 관리하지만 해당 부서명 정보는 dept 테이블에만 있다
해당 직원이 속한 부서 이름을 알고 싶으면 dept 테이블과 조인을 해야한다.

상호연관 서브쿼리는 항상 메인 쿼리가 먼저 실행된다.
SELECT empno, ename, deptno,
        (SELECT dname FROM dept WHERE dept.deptno=emp.deptno) --dept와 emp는 테이블
FROM emp;

FROM emp;
비 상호연관 서브커리는 메인쿼리가 먼저 실행 될 수도 있고
                    서브쿼리가 먼저 실행 될 수도 있다
                    => 성능측면에서 유리한 쪽으로 오라클이 선택
                    
                    
인라인 뷰 : SELECT QUERY 
- inline : 해당위치에 직접 기술 함
  inline view : 해당 위치에 직접 기술한 view
        view : QUERY(O) ==> view table(X)
        -- view는 실제 데이터를 갖고있는게 아니라 데이터를 정의한 쿼리 

SELECT *
FROM
(SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno);

아래 쿼리는 전체 직원의 급여 평균보다 높은 급여를 받는 직원을 조회 하는 쿼리
SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
                FROM emp);
                
직원이 속한 부서의 급여 평균보다 높은 급여를 받는 직원을 조회
SELECT empno, ename, sal, deptno
FROM emp e -- 직원을 말하는 e
WHERE e.sal > (SELECT AVG(sal)
                FROM emp a
                WHERE a.deptno = e.deptno) --메인쿼리가 먼저 실행되고 서브쿼리는 나중에 실행된다. 서브쿼리만 단독적으로 출력은 불가능.

★ 상호 연관 서브쿼리
sub query에서 main query를 참조
- 쿼리 실행 순서가 정해져 있다.
- main -> sub

★ 비상호 연관 서브 쿼리
sub query에서 main query를 참조하지않음


1. 20번 부서의 급여 평균(2175)
SELECT AVG(sal)
FROM emp
WHERE deptno = 20;

2. 10번 부서의 급여 평균(2916.666)
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;


--dept테이블에 행추가 해주고
INSERT INTO dept VALUES(99, 'ddit', 'daejeon');

COMMIT;

SELECT *
FROM dept;

--dept 테이블에는 신규 등록된 99번 부서에 속한 사람은 없음. 
--직원이 속하지 않은 부서를 조회하는 쿼리를 작성해보세요. -- 직원이 속하지 않은 부서는 10,20,30,40,99 중 40번과 99번찾기
SELECT *
FROM dept
WHERE deptno NOT IN (10, 20, 30); --결과적으로는 이렇게 나오는건데 이렇게 하드코딩하라는게 아니라

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);


SELECT e.empno, e.ename, e.sal, e.deptno,
FROM dept
WHERE deptno = (SELECT AVG(sal) avg_sal
                FROM emp a
            WHERE a.deptno = e.deptno);


실습 sub5
cycle, product 테이블을 이용하여 cid=1인 고객이 애음하지 않는 제품을 조회하는 쿼리를 작성하세요.

SELECT *
FROM product;

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid  --이 라인은 같아야함. WHERE pid NOT IN (SELECT pid -- 둘다 pid가 잇지.
                  FROM cycle
                  WHERE cid = 1);


SELECT PID, PNM
FROM cycle
WHERE  = (SELECT pid
          FROM cycle
          WHERE cid = 1;