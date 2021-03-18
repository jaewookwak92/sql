--문자열 '', LIKE도 'S%'이렇게 찾는게 문자열이라 ''붙여야한다

연산자 우선순위

1. 산술연산자(*, /, +, -)
2. 문자열결합(||)
3. 



연산자 우선순위 ( AND가 OR 보다 우선순위가 높다 )
==> 헷갈리면 ()를 사용하여 우선순위를 조정하자

SELECT *
FROM emp
WHERE ename = 'SMITH' OR ename = 'ALLEN' AND job = 'SALESMAN';
            
==> 직원의 이름이 ALLEN 이면서 job이 SALESMAN 이거나 
    직원의 이름이 SMITH인 직원 정보를 조회


직원의 이름이 ALLEN 이거나 SMITH 이면서 job이 SALESMAN 인 직원을 조회
SELECT *
FROM emp
WHERE (ename = 'ALLEN' OR ename = 'SMITH') AND job = 'SALESMAN' --괄호 먼저 진행되고, 괄호가 없으면 AND먼저 진행



문제 14. emp 테이블에서 
        1. job이 SALESMAN이거나
        2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
            (1번 조건 또는 2번 조건을 만족 하는 직원)
            
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR EMPNO LIKE '78%' AND HIREDATE >= TO_DATE('1981/06/01','YYYY/MM/DD');





< 데이터 정렬 >

Table 객체에는 데이터를 저장/조회시 순서를 보장하지 않음
- 보편적으로 데이터가 입력된 순서대로 조회됨
- 데이터가 항상 동일한 순서로 조회되는 것을 보장하지 않는다
- 데이터가 삭제되고, 다른 데이터가 들어 올 수도 있음

데이터 정렬(ORDER BY)

ORDER BY
- ASC : 오름차순 (기본)
- DESC : 내림차순

ORDER BY {정렬기준 컬럼 OR alias OR 컬럼번호}[ASC OR DESC]

데이터 졍렬이 필요한이유?

1.table 객체는 순서를 보장하지 않는다
==> 오늘 실행한 쿼리를 내일 실행할 경우 동일한 순서로 조회가 되지 않을 수도 있다.
2. 현실세계에서는 정렬된 데이터가 필요한 경우가 있다
==> 게시판의 게시글은 보편적으로 가장 최신글이 처음에나오고, 가장 오래된 글이 맨 밑에 있다.

SQL에서 정렬 : ORDER BY ==> SELECT -> FROM -> WHERE -> ORDER BY

SELECT *
FROM emp
ORDER BY ename; --이름이 A부터 순차적으로 시작됨

A -> B -> C -> D ..:오름차순(ASC => DEFAULT -- 뒤에 ASC나 DESC를 붙이지 않고 ORDER BY를 사용하면 디폴트로 쟤가 설정됨)
100 ->99 ...->1    :내림차순(DESC => 써줘야 설정됨

SELECT *
FROM emp
ORDER BY job, sal; --job이 A부터 시작하고 그 안에 SAL도 오름차순으로 설정됨.

SELECT *
FROM emp
ORDER BY job DESC, sal ASC, ENAME DESC;

정렬 : 컬럼명이 아니라 select 절의 컬럼 순서(index)
정렬 방법 : ORDER BY 컬럼명 | 컬럼인덱스(순서) | 별칭 [정렬순서]
정렬 순서 : 기본 ASC(오름차순), DESC(내림차순)
SELECT ename, empno, job, mgr AS m
FROM emp
ORDER BY m;

문제 15. 데이터 졍렬 ORDER BY
dept 테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요

dept 테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요.

*컬럼명을 명시하지 않았습니다. 지난 수업에 배운 내용으로 올바른 컬럼을 찾아보세요.

SELECT *
FROM dept
ORDER BY DNAME;

SELECT *
FROM dept 
ORDER BY LOC DESC;


문제 16. 
emp테이블에서 상여(comm)정보가 있는 사람들만 조회하고, 
상여(comm)를 많이 받는 사람이 먼저 조회되도록 정렬하고, 
상여가 같을 경우 사번으로 내림차순 정렬하세요 (상여가 0인 사람은 상여가 없는 것으로 간주)
--comm이 NULL이 아니여야하고 0이 아니여야한다.
SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm != 0
ORDER BY comm DESC, empno DESC;


문제 17.
emp테이블에서 관리자가 있는 사람들만 조회하고, 직군(job)순으로 오름차순 정렬하고, 
직군이 같을 경우 사번이 큰 사원이 먼저 조회되로록 커리를 작성하세요

SELECT *
FROM emp
WHERE MGR IS NOT NULL
ORDER BY JOB, EMPNO DESC;

문제 18.
emp 테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람중 급여(sal)가 1500이 넘는 사람들만 조회하고 
이름으로 내림차순 정렬되도록 쿼리를 작성하세요.

SELECT *
FROM emp
WHERE DEPTNO = '10' OR DEPTNO = '30' AND SAL > 1500
ORDER BY ENAME DESC;

SELECT * 
FROM emp
WHERE DEPTNO IN (10, 30) AND SAL > 1500
ORDER BY ENAME DESC;


페이징 처리 : 전체 데이터를 조회하는게 아니라 페이지 사이즈가 정해졌을 때 원하는 페이지의 데이터만 가져오는 방법
(1. 400건을 다 조회하고 필요한 20것만 사용하는 방법 --> 전체조회(400)
 2. 400건의 데이터중 원하는 페이지의 20건만 조회 --> 페이징 처리(20)) - 우리가 배우려는 방법
페이징 처리(게시글) ==> 정렬의 기준이 뭔데???(일반적으로는 게시글의 작성일시 역순) --게시글 올라오면 화면에 나오는 정렬의기준이 뭐냐
페이징 처리기 고려할 변수 : 페이지 번호, 페이지 사이즈


ROWNUM : 행번호를 부여하는 특수 키워드(오라클에서만 제공)
 * 제약사항 
    ROWNUM은 WHERE절 에서도 사용 가능하다.
     단 ROWNUM의 사용을 1부터 사용하는 경우에만 사용 가능
     WHERE ROWNUM BETWEEN 1 AND 5 ==> O
     WHERE ROWNUM BETWEEN 6 AND 10 ==> X ---1번부터 읽지않았기때문(순차적으로 읽음)
     WHERE ROWNUM = 1; ==> O
     WHERE ROWNUM = 2; ==> X(1번부터 하지 않았기때문에)
     WHERE ROWNUM < 10; ==> O
     WHERE ROWNUM > 10; ==> X
전체 데이터 : 14건
페이지사이즈 : 5건
1번째 페이지 : 1~5
2번째 페이지 : 6~10
3번째 페이지 : 11~15(14)
    
인라인 뷰
ALIAS

SELECT empno, ename
FROM emp; --행 번호를 부여할순없을까? 앞에 숫자 1~14번까지 있는거



SELECT ROWNUM, EMPNO, ENAME
FROM emp
WHERE ROWNUM <= 15;

SELECT ROWNUM, empno, ename -- **********SQL의 실행순서 from => select => order by******** 
FROM emp
ORDER BY ename;

FROM => WHERE => SELECT  => ORDER BY
ORDER BY와 ROWNUM을 동시에 사용하면 정렬된 기준으로 ROWNUM이 부여되지 않는다
(SELECT절이 먼저 실행되므로 ROWNUM이 부여된 상태에서 ORDER BY 절에 의해 정렬이 된다)



인라인 뷰

SELECT *
FROM (SELECT empno, ename 
        FROM emp
        ORDER BY ename);

SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename 
      FROM emp
      ORDER BY name);
WHERE ROWNUM BETWEEN 2 AND 10;

SELECT * 
FROM (SELECT ROWNUM rn, empno, ename
                FROM (SELECT empno, ename 
                    FROM emp
                    ORDER BY ename)) --ORDER BY로 먼저 정렬해둔뒤(묶고) 그다음 ROWNUM을 사용
            WHERE rn BETWEEN 1 AND 5;
            
pageSize : 5건 
1page : rn BETWEEN 1 AND 5;
2page : rn BETWEEN 6 AND 10;
3page : rn BETWEEN 11 AND 15;

공식 : npage : rn BETWEEN n*5-4 AND n*5;
      n page : rn BETWEEN n*pageSize-4 AND n*pageSize;
                            (n-1)*pageSize + 1
최종공식 : rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize;    -- *를 이용하여 변수로 만들어줌.




문제 19. 데이터 정렬(가상컬럼 ROWNUM)
emp테이블에서 ROWNUM값이 1~10인 값만 조회하는 쿼리를 작성해보세요 (정렬없이 진행하세요. 결과는 화면과 다를수 있습니다)

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


SELECT *
FROM
(SELECT ROWNUM rn, EMPNO, ENAME
FROM emp)
WHERE rn BETWEEN 11 AND 14;


emp테이블의 사원정보를 이름컬럼으로 오름차순 적용 했을 때의 11~14번째 행을 다음과 같이 조회하는 쿼리를 작성해보세요

SELECT *
FROM
(SELECT ROWNUM rn, empno, ename 
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename))
WHERE rn BETWEEN 11 AND 14;

SELECT ROWNUM, emp.*
FROM emp;

--예를 들어 3학년 고득점자 10명을 뽑는 쿼리문을 원한다면
--SELECT * FROM student WHERE grade=3 AND rownum<=10 ORDER BY score DESC 의 경우에는 원하는 결과를 얻을 수 없고
--SELECT * FROM (SELECT * FROM student WHERE grade=3 ORDER BY score DESC) WHERE rownum<=10 의 쿼리를 실행해야 합니다. 필요한거 다 정리한다음 그다음 rownum을 정리

