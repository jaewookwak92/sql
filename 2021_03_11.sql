SELECT *
FROM EMP;

-----데이터 조회 방법
-- FROM : 데이터를 조회할 테이블 명시
-- SELECT : 테이블에 있는 컬럼명, 조회 하고자 하는 컬럼명 
            테이블의 모든 컬럼을 조회할 경우 *을 기술
            
            

SELECT * (모든 컬럼을 조회하라)
FROM EMP; (EMP테이블에 있는)

-- EMPNO : 직원번호, ENAME : 직원이름, JOB : 담당업무
-- MGR : 상위 담당자, HIREDATE : 입사일자, SAL : 급여
-- COMM : TKDDURMA, DEPTNO : 부서번호

SELECT empno, ename
FROM EMP;

SELECT * |{column [alias], ....}
FROM table [alias]
[ORDER BY column];

| -> or

