[실습 grp4]

직원의 입사 년월별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요.
select TO_CHAR(hiredate, 'YYYYMM'), hire_yyyymm, COUNT(*)cnt
from emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

[실습 grp5]

직원의 입사 년별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요.
select TO_CHAR(hiredate, 'YYYYMM'), hire_yyyy, COUNT(*)cnt
from emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

[실습 grp6]
SELECT COUNT(*)
FROM dept;

SELECT *
FROM emp
WHERE deptno IN(10,20,30);

SELECT deptno
FROM emp
GROUP BY deptno;


SELECT COUNT(*)
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);






< 데이터 결합 >

JOIN
- RDBMS는 중복을 최소화 하는 형태의 데이터 베이스
- 다른 테이블과 결합하여 데이터를 조회
--JOIN 데이터를 결합할수있는 방법중에 하나
- EMP 테이블에는 부서코드만 존재,
  부서정보를 담은 dept테이블 별도로 생성
- emp테이블과 dept테이블의 연결고리로 조인하여 실제 부서명을 조회한다.

JOIN
1. 표준 SQL => ANSI SQL
2. 비표준 SQL - DBMS를 만드는 회사에서 만든 고유의 SQL 문법

ANSI : SQL
ORACLE : SQL

ARSI - NATURAL JOIN
 - 조인하고자 하는 테이블의 연결컬럼 명(타입도 동일)이 동일한경우(emp,deptno, dept.deptno)
 - 연결 컬럼의 값이 동일할때(=) 컬럼이 확장된다.
 
 SELECT * 
 FROM emp NATURAL JOIN dept;
 
 SELECT ename, dname
 FROM emp NATURAL JOIN dept;

ORACLE join : 
1. FROM절에 조인할 테이블을 (,)콤마로 구분하여 나열
2. WHERE : 조인할 테이블의 연결조건을 기술


7369 SMITH, 7902 FORD
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno; -- oracle에서는 join을 이런식으로 한다.

SELECT * 
FROM emp, emp
WHERE emp.mgr = emp.empno; -- 동일한거므로 하나는 별칭을 사용해주자 => 아래 참조

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno; -- 

ANSI SQL : JOIN WITH USING
조인 하려고 하는 테이블의 컬럼명과 타입이 같은 컬럼이 두개 이상인 상황에서 
두 컬럼을 모두 조인 조건으로 참여시키지 않고, 개발자가 원하는 특정 컬럼으로만 연결을 시키고 싶을 때 사용

SELECT emp.deptno
FROM emp JOIN dept USING(deptno);

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

JOIN WITH ON : NATURAL JOIN, JOIN WITH USING을 대체할 수 있는 보편적인 문법
조인 컬럼을 개발자가 임의로 지정

SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


사원 번호, 사원 이름, 해당사원의 상시 사번, 해당사원의 상사 이름 : JOIN WITH ON을 이용하여 쿼리 작성
(단 사원의 번호가 7369에서 7698인 사원들만 조회)

SELECT e.empno, e.name, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;


SELECT e.empno, e.name, m.empno, m.ename
FROM emp e, emp m
WHERE e.empno BETWEEM 8369 AND 7698
AND e.mgr = m.empno;


논리적인 조인 형태
1. SELF JOIN : 조인 테이블이 같은 경우
    - 계층구조
2. NONEQUI-JOIN : 조인 조건이 =(equals)가 아닌 조인

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;

SELECT * 
FROM salgrade;

--salgrade를 이용하여 직원의 급여 등급 구하기
-- empno, ename, sal, 급여등급
-- ansi, oracle
SELECT * 
FROM emp;

SELECT empno, ename, sal, 


SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT *
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.local AND s.hisal;



데이터를 확장(결합)
1. 컬럼에 대한 확장 : JOIN
2. 행에 대한 확장 : 집합연산자(UNION ALL, UNION(합집합), MINUS(차집합), INTERSECT(교집합))


emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요

SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10,30);

emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
(급여가 2500 초과)

sal >= 2500

SELECT empno, ename, emp.deptno, dname
FROM emp, dept;
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (10,30);

급여 2500초과, 사번이 7600보다 크고 RESEARCH부서에 속하는 직원

SELECT empno, ename, emp.deptno, dname
FROM emp, dept;
WHERE emp.deptno = dept.deptno
AND sal>2500
AND empno>7600
AND dname = 'RESEARCH';
