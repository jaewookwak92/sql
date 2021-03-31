[실습 ana2]
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 본인급여, 부서번호와 
해당 사원이 속한 부서의 급여 평균을 조회하는 쿼리를 작성하세요(급여 평균은 소수 둘째 자리까지 구한다)
SELECT empno, ename, sal, deptno, 
       ROUND(AVG(sal) OVER(PARTITION BY deptno), 2) avg_sal,
       --해당 부서의 가장 낮은 급여
       MIN(sal) OVER(PARTITION BY deptno) min_sal,
       --해당 부서의 가장 높은 급여
       MAX(sal) OVER(PARTITION BY deptno) max_sal,
       SUM(sal) OVER(PARTITION BY deptno) sum_sal,
       COUNT(*) OVER(PARTITION BY deptno) cnt
FROM emp;

■ window함수 (그룹내 행 순서)
LAG(col) 파티션별 윈도우에서 이전 행의 컬럼 값
LEAD(col) 파티션별 윈도우에서 이후 행의 컬럼 값


-- 자신보다 급여 순위가 한단계 낮은 사람의 급여를 5번째 컬럼으로 생성
SELECT empno, ename, hiredate, sal,
       LEAD(sal) OVER (ORDER BY sal DESC, hiredate)
FROM emp;

[실습 ana5]
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여,
전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성
(급여가 같을 경우 입사일이 빠른 사람이 높은순위)
SELECT empno, ename, hiredate, sal, LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

[실습 ana5_1]
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 급여,
전체 사원중 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성
(급여가 같을 경우 입사일이 빠른 사람이 높은순위)
SELECT
FROM (SELECT empno, ename, hiredate, sal, RANK() OVER (ORDER BY sal DESC) rnk FROM emp) a,
     (SELECT sal, count(*) cnt FROM emp GROUP BY sal ORDER BY sal DESC) b
WHERE a.rnk < b.rank

SELECT 
--a.empno, a.ename, a.hiredate, a.sal, b.sal
*
FROM
(SELECT a.*, ROWNUM rnm
 FROM 
  (SELECT empno, ename, hiredate, sal
   FROM emp
   ORDER BY sal DESC) a) a,
(SELECT a.*, ROWNUM rnm
 FROM 
  (SELECT empno, ename, hiredate, sal
   FROM emp
   ORDER BY sal DESC) a) b
WHERE a.rnm-1 = b.rnm(+)
ORDER BY a.sal DESC, a.hiredate;


[실습 ana6]
window function을 이용하여 모든 사원에 대해 사원번호, 사원이름, 입사일자, 직군(job), 급여정보와 담당업무(job)별
급여 순위가 급여 순위가 1단계 높은 사람의 급여를 조회하는 쿼리를 작성
(급여가 같을 경우 입사일이 빠른 사람이 높은순위)
SELECT empno, ename, hiredate, job, sal, 
       LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp

LAG, LEAD 함수의 두번째 인자 : 이저나 이후 몇번째 행을 가져올지 표기 -- 이러한 형태로 쓰는 경우는 많지 않다!
SELECT empno, ename, hiredate, job, sal, 
       LAG(sal, 2) OVER(ORDER BY sal DESC, hiredate)
FROM emp

분석함수 OVER([])

[실습 ana3] rownum, 범위 조인 --누적 합 구하자
모든 사원에 대해 사원번호, 사원이름, 입사일자
1. ROWNUM
2. INLINE VIEW
3. NON-EQUI-JOIN
SELECT a.empno, a.ename, a.sal
--, SUM(a.sal)
FROM
    (SELECT a.*, ROWNUM rn
     FROM (SELECT * FROM emp ORDER BY sal, empno) a) a,
    (SELECT b.*, ROWNUM rn
     FROM (SELECT * FROM emp ORDER BY sal, empno) b) b
WHERE a.rn >= b.rn
GROUP BY  a.empno, a.ename, a.sal
ORDER BY a.sal, a.empno;

SELECT empno, ename, sal, SUM(sal) OVER () c_sum
FROM emp;


























