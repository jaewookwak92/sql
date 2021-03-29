인덱스
컬럼 구성 순서 영향있다

인덱스(Index)란?
-- 인덱스는 데이터베이스 테이블에 있는 데이터를 빨리 찾기 위한 용도의 데이터베이스 객체이며 일종의 색인기술입니다. 테이블에 index를 생성하게 되면 index Table을 생성해 관리합니다. 
-- 인덱스는 테이블에 있는 하나이상의 컬럼으로 만들 수 있습니다. 가장 일반적인 B-tree 인덱스는 인덱스 키(인덱스로 만들 테이블의 컬럼 값)와 이 키에 해당하는 컬럼 값을 가진 테이블의 로우가 저장된 주소 값으로 구성됩니다.

SELECT ename, job, ROWID
FROM emp
ORDER BY ename, job;

job, ename 컬럼으로 구성된 IDX_emp_03 인덱스 삭제

CREATE 객체타입 객체명
DROP 객체타입 객체명;

CREATE INDEX idx_mp_04 ON emp (ename, job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ROWID, dept.*
FROM dept;

CREATE INDEX idx_dept_01 ON dept (deptno);

emp
1. table full access
2. idx_emp_01
3. idx_emp_03
4. idx_emp_04

dept
1. table full access
2. idx_dept_01


EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;


응답성 : OLTP (Online Transaction Processing)
퍼포먼스 : OLAP (Online Analysis Processing)
            - 은행이자 계산

Index Access
- 소수의 데이터를 조회할 때 유리(응답속도가 필요할 때)
  - Index를 사용하는 Input/Output Single Block I/O
- 다량의 데이터를 인덱스로 접근할 경우 속도가 느리다(2~3000건) -- 이정도 분량일경우 테이블을 다 읽는것보다 느리다
Table Access
- 테이블의 모든 데이터를 읽고서 처리를 해야하는 경우 인덱스를 통해 모든 데이터를 테이블로 접근하는 경우보다 빠름.
 - I/O 기준이 multi block

DDL(테이블에 인덱스가 많다면)

1. 테이블의 빈공간을 찾아 데이터를 입력한다.
2. 인덱스의 구성 컬럼을 기준으로 정렬된 위치를 찾아 인덱스 저장
3. 인덱스는 B*트리 구조이고, root node 부터 leaf node 까지의 depth가 항상 같도록 밸런스를 유지한다
4. 즉 데이터 입력으로 밸런스가 무너질경우 밸런스를 맞추는 추가 작업이 필요
5. 2~4까지의 과정을 각 인덱스 별로 반복한다


인덱스가 많아 질 경우 위 과정이 인덱스 개수 만큼 반복 되기 때문에 UPDATE, INSERT, DELETE 시 부하가 커진다.

인덱스는 SELECT 실행시 조회 성능개선에 유리하지만 데이터 변경시 부하가 생긴다

테이블에 과도한 수의 인덱스를 생성하는 것은 바람직 하지 않음

하나의 쿼리를 위한 인덱스 설계는 쉬움

시스템에서 실행되는 모든 쿼리를 분석하여 적절한 개수의 최적의 인덱스를 설계해야함.


* 달력만들기
주어진것 : 년월 6자리 문자열 ex- 202103
만들것 : 해당 년월에 해당하는 달력 (7칸 짜리 테이블)


--(LEVEL은 1부터 시작)
SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

20210331
'202103' ==> 31;

SELECT TO_CHAR(LAST_DAY(TO_DATE('202103', 'YYYYMM')), 'DD') --어떤 DATE타입의 날이있을때 그 타입의 마지막날로 이동, DD는 날짜를 다시 문자로바꾼거다. TO_CHAR를 이용하여, 그래서 원하는 일만 출력
FROM dual;

--(LEVEL은 1부터 시작)

SELECT DECODE(d, 1, iw+1, iw) iw,
    --일요일이면 dt-아니면 null, 월요일이면 dt-아니면 null,
    MIN(d, 1, dt) sun, MIN(d, 2, dt) mon,
    MIN(d, 3, dt) tue, MIN(d, 4, dt) wed,
    MIN(d, 5, dt) thu, MIN(d, 6, dt) fri,
    MIN(d, 7, dt) sat
    
    --화요일이면 dt-아니면 null, 수요일이면 dt-아니면 null,
    --목요일이면 dt-아니면 null, 금요일이면 dt-아니면 null,
    --토요일이면 dt-아니면 null
FROM
    (SELECT TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL-1) DT,
       TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL-1), 'D') d, /*
       TO_CHAR(TO_DATE(:YYYYMM, 'YYYYMM') + (LEVEL-1), 'IW') iw*/
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202103', 'YYYYMM')), 'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
GROUP BY DECODE(d, 1, iw+1, iw);

주간 요일 : D


계층쿼리 - 조직도, BOM(Bill OF Material), 게시판(답변형 게시판)
        - 데이터의 상하 관계를 나타내는 쿼리

SELECT empno, ename, mgr
FROM emp
START WIRH empno = 7839;
CONNECT BY 내가 읽은 행의 사번 = 앞으로 읽을 행의 MGR 컬럼
CONNECT BY PRIOR empino = mgr;


KING의 사번 = mgr 컬럼의 값이 KING의 사번인 녀석
empno = mgr


사용방법 : 1. 시작위치를 설정
          2. 행과 행의 연결 조건을 기술
          
        
SELECT empno, ename mgr, LOEVE
FOMR emp
START WITH empno = 7566
CONNECT BY PRON EMPNO = 'mgr'

SELECT LPAD( ),1*4

PRIOR - 이전의, 사전의, 이미 읽은 데이터
CONNECT BY - 내가 읽은 행의 사번 = 앞으로 읽을 행의 MGR 컬럼

계층쿼리 방향에 따른 분류
상향식 : 최하위 노드(leaf node)에서 자신의 부모를 방문하는 형태
하향식 : 최상위 노드(root node)에서 모든 자식 노드를 방문하는 형태. 

상향식 쿼리
SMITH(7369)부터 시작하여 노드의 부모를 따라가는 계층형 쿼리 작성

SELECT empno, LPAD(' ', (LEVEL-1)*4) || ename, mgr, LEVEL
FROM emp
START WITH empno = 7369
CONNECT BY PRIOR mgr = empno;

CONNECT BY SMITH의 mgr 컬럼값 = 내앞으로 읽을 행의 empno
;

SMITH - FORD

SELECT *
FROM dept_h;

최상위 노드부터 리프 노드까지 탐색하는 계층 쿼리 작성
(LPAD를 이용한 시각적 표현까지 포함)

SELECT LPAD(' ', (LEVEL-1) * 3) || deptnm
FROM dept_h
START WITH p_deptcd IS NULL
CONNECT BY deptcd = p_deptcd;


계층쿼리 (실습 h_2)
정보시스템부 하위의 부서계층 구조를 조회하는 쿼리를 작성하세요.

SELECT LEVEL, deptcd, 
       LPAD(' ', (LEVEL-1) *3) ||deptnm deptnm, p_deptcd --LPAD(' ', (LEVEL-1) *3) ||deptnm를 deptnm로 별칭
FROM dept_h
START WITH p_deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;


계층쿼리 (상향식 실습 h_2)
디자인팀에서 시작하는 상향식 계층 쿼리를 작성하세요


SELECT LEVEL, deptcd,
       LPAD(' ', (LEVEL-1) *3) ||deptnm deptnm, p_deptcd 
FROM dept_h
START WITH p_deptcd = 'dept0_00_0' --현재행의부모 = 앞으로 읽을 행의 부서코드
CONNECT BY PRIOR deptcd = p_deptcd;


계층쿼리 (실습 h_4)

계층형쿼리 복습.sql을 이용하여 테이블을 생성하고 다음과 같은 결과가 나오도록 쿼리를 작성 하시오.
s_id : 노드 아이디
ps_id : 부모 노드 아이디
value : 노드 값

SELECT *
FROM h_sum;

SELECT s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

