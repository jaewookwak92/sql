FROM -> [START WITH] -> WHERE -> GROUP BY -> SELECT  -> ORDER BY 적용순서.

CONNECT BY는 3가지로 기술

 WHERE
    데이터를 가져온 뒤 마지막으로 조건절에 맞게 정리

 START WITH
    어떤 데이터로 계층구조를 지정하는지 지정

 CONNECT BY	 
    각 행들의 연결 관계를 설정

SELECT
FROM WHERE
START WITH
CONNECT BY
GROUP BY
ORDER BY


START WITH
가지치기 : Pruning branch

SELECT empno, LPAD(' ', (LEVEL-1)*4) || ename ename, mgr, deptno, job
FROM emp
WHERE job != 'ANALYST'
START WITH mgr IS null
CONNECT BY PRIOR empno = mgr AND job != 'ANALYST';

계층 쿼리와 관련된 특수 함수
1. CONNECT_BY_ROOT(컬럼) : 최상위 노드의 해당 컬럼 값
2. SYS_CONNECT_BY_PATH(컬럼, '구분자문자열') : 최상위 행부터 현재 행까지의 해당 컬럼의 값을 구분자로 연결한 문자열
3. CONNECT_BY_ISLEAF : CHILD가 없는 leaf node 여부 0 - false (no leaf node)/ 1 - true(leaf node)


SELECT LPAD(' ', (LEVEL-1)*4) || ename ename, 
       CONNECT_BY_ROOT(ename) root_ename,
       LTRIM(SYS_CONNECT_BY_PATH(ename, '-'), '-') path_ename,
       INSTR('TEST', 'T'),
       CONNECT_BY_ISLEAF isleaf
FROM emp
START WITH mgr IS null
CONNECT BY PRIOR empno = mgr;


SELECT *
FROM board_test;
최상위 글은 최신글 순(desc)로 정렬, 답글은 순차(asc)적으로 정렬
SELECT seq, parent_seq, LPAD(" ", (LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER STBLINGS BY () desc, seq ASC;

SELECT ename, job, sal
FROM emp
ORDER BY job, sal;

시작글부터 관련 답글까지 그룹번호를 부여하기 위해 새로운 컬럼 추가

ALTER TABLE board_test ADD(gn NUMBER);
DESC board_test;

UPDATE board_test SET gn = 1
WHERE seq IN (1, 9);


UPDATE board_test SET gn = 2
WHERE seq IN (2, 9);
 
UPDATE board_test SET gn = 4
WHERE seq IN (, 9;
 
 
SELECT *
FROM 
    (SELECT CONNECT_BY_ROOT(seq) root_seq,
        seq, parent_seq, LPAD(' ', (LEVEL-1)*4) || title title
    FROM board_test
    START WITH parent_seq IS NULL
    CONNECT BY PRIOR seq = parent_seq)
        
        
        
SELECT = gn, SYS_CONNET(seq) root_seq,
seq, parent_seq, LPAD(" ", (LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY () desc, seq ASC;




SELECT *
FROM emp;
WHERE deptno =  10;
  AND sal = 
        (SELECT MAX(sal)
        FROM emp
        WHERE deptno = 10);
        
분석함수(window 함수)
    SQL에서 행간 연산을 지원하는 함수
    
    해당 행의 범위를 넘어서 다른 행과 연산이 가능
    . SQL의 약점 보완
    . 이전행의 특정 컬럼을 참조
    . 특정 범위의 행들의 컬럼의 합
    . 특정 범위의 행중 특정 컬럼을 기준으로 순위, 행번호 부여
    
    . SUM, COUNT, AVG, MAX, MIN --집계관련
    . RANK, LEAD, LAG....  --순위관련
    
SELECT *
FROM emp;

SELECT DEPTNO
FROM emp
ORDER BY DEPTNO ASC;

SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal DESC)
FROM emp;
ORDER BY deptno, sal DESC;


분석함수 / window 함수



RANK()over*(PARTITION BY deptno ORDER BY sal DESC)sal_rank
PARTITION BY deptno : 같은 부서코드를 갖는 row를 그룹으로 묶는다
ORDER BY sal : 그룹내에서 sal로 row의 순서를 정한다
RANK() : 파티션 단위안에서 정렬 순서대로 순위를 부여한다

SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno;


SELECT ROWNUM rn, rank
FROM
(SELECT a.rn rank
FROM
    (SELECT ROWNUM rn
     FROM emp) a,
     (SELECT deptno, COUNT(*) cnt
      FROM emp
      GROUP BY deptno
      ORDER BY deptno) b
  WHERE a.rn <= b.cnt
  ORDER BY b.deptno, a.rn);



순위 관련된 함수 (중복값을 어떻게 처리하는가)
RANK : 동일 값에 대해 동일 순위 부여하고, 후순위는 동일값만 건너뛴다
        1등 2명이면 그 다음순위는 3위

DENSE_RANK : 동일 값에 대해 동일 순위 부여하고, 후순위는 이어서 부여한다
             1등이 2명이면 그 다음 순위는 2위
ROW_NUMBER : 중복 없이 행에 순차적인 번호를 부여(ROWBUM)

SELECT ename, sal, deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) sal_row_number
FROM emp;

SELECT WINDOW_FUNCTION([인자]) OVER ( [PARTITION BY 컬럼] [ORDER BY 컬럼])
FROM ....

PARTITION BY : 영역 설정
ORDER BY (ASC/DESC) : 영역 안에서의 순서 정하기


분석함수 / window 함수 (실습 ana2)
- 기존의 배운 내용을 활용하여, 모든 사원에 대해 사원번호, 사원이름, 해당 사원이 속한 부서의 사원 수를 조회하는 쿼리를 작성하세요.
    --조인을 활용하자
    SELECT emp.empno, emp.ename, emp.deptno, b.cnt   
    FROM emp,
        (SELECT deptno, COUNT(*) cnt
         FROM emp
         GROUP BY deptno) b
    WHERE emp.deptno = b.deptno
    ORDER BY emp.deptno;
    
    SELECT empno, ename, deptno,
           COUNT(*) OVER (PARTITION BY deptno) cnt
    FROM emp;