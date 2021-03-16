--2021-03-12 복습
--조건에 맞는 데이터 조회 : WHERE절 - 기술한 조건을 참(TRUE)으로 만족하는 행들만 조회한다(FILTER);



--row : 14개, col : 8개
SELECT *
FROM emp
WHERE deptno = deptno;

--java 
a++ ==> a = a+1;
++a ==> a = a+1;


2021-03-12복습

WHERE절 문제

1) 입사일자가 1982년 1월 1일 이후인 모든 직원을 조회하는 SELECT 쿼리를 작성하세요

SELECT *
FROM emp
WHERE HIREDATE >= TO_DATE('1982/01/01', 'YYYY/MM/DD'); 
-- * 컬럼이 82/01/01여도 1982/01/01이렇게 네자리로 써줘야 인식이 가능한부분이다.


WHERE절에서 사용가능한 연산자
(비교 (=,!=,>,<...)

================================================================== BETWEEN 연산자 =======================================================================================

BETWEEN AND -- 삼항 연산자(항이 3개가 필요하다. = 비교대상 BETWEEN 비교대상의 허용 시작값 AND 비교대상의 허용 종료값)
            -- ex) 부서번호가 10번에서 20번 사이의 속한 직원들만 조회
            SELECT *
            FROM emp
            WHERE DEPTNO BETWEEN 10 AND 20;
            
    문제1) emp 테이블에서 급여(sal)가 1000보다 크거나 같고 2000보다 작거나 같은 직원들만 조회
            sal >= 1000
            sal <= 2000
                SELECT *
                FROM emp
                WHERE sal BETWEEN 1000 AND 2000;
                
                SELECT *
                FROM emp
                WHERE sal >= 1000
                AND   sal <= 2000
                AND deptno = 10; --sal이 1000이상 2000의 조건에다가 (1) depno 가 10인사람(2)
            
* 컴퓨터의 연산            
true AND true ==> true
true AND false ==> false
true OR false ==> true

    문제2) emp테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오. 
          단 연산자는 between을 사용한다.
            
            SELECT *
            FROM emp
            WHERE hiredate BETWEEN TO_DATE('19820101', 'YYYYMMDD') AND TO_DATE('19830101', 'YYYYMMDD');
            
            BETWEEN AND : 포함(이상, 이하)
                            초과, 미만의 개념을 적용하려면 비교연산자를 사용해야한다.
                           
            

============================================================== IN 연산자 =======================================================================================           
            
IN 연산자
        
대상자 IN (대상자와 비교할 값1, 비상자와 비교할 값2, 대상자와 비교할 값3.....)
deptno IN (10,20) ==> deptno값이 10이나 20번이면 TRUE;

SELECT *
FROM emp
WHERE deptno = 10
    OR deptno = 20;
    
SELECT *
FROM emp
WHERE 10 IN (10, 20); --10은 10과 같거나 10은 20과 같다.
                      --TRUE      OR      FALSE ==> TRUE

SELECT * 
FROM emp
WHERE deptno = 10
    OR deptno = 20;
            
                           
문제 3) users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오(IN 연산자 사용)
       
        SELECT *
        FROM users
        WHERE userid IN ('brown', 'cony', 'sally'); 
        
        SELECT userid AS 아이디, usernm AS 이름, alias AS 별명 --- 컬럼의 이름을 변경하여 출력.
        FROM users
        WHERE userid IN ('brown', 'cony', 'sally'); 
        
     
        SELECT *
        FROM users
        WHERE userid = 'brown' 
                OR userid = 'cony'
                    OR userid = 'sally'; --위에꺼의 풀이는 결국 이뜻이다. 논리적으로 
    
        
    --Tip : SELECT 이런건 소문자로 써줘도 상관없어 근데 BROWN 이런 테이블 안에있는 데이터들은 꼭 소대문자 맞춰서 해야대


=====================================================================================LIKE 연산자
LIKE 연산자 : 문자열 매칭 조회
게시글 : 제목 검색, 내용 검색
        제목에 [맥북에어]가 들어가는 게시글만 조회
        
        1. 얼마 안된 맥북에어 팔아요
        2. 맥북에어 팔아요
        3. 팝니다 맥북에어
    테이블 : 게시글
    제목 컬럼 : 제목
    내용 컬럼 : 내용
    
     
    제목      내용
     1         2
     TRUE OR TRUE   TRUE
     TRUE OR FALSE  TRUE
     FALSE OR TRUE  TRUE
     FALSE OR FALSE FALSE
     
     TRUE AND TRUE TRUE
     TRUE AND FALSE  FALSE
     FALSE AND TRUE  FALSE
     FALSE AND FALSE FALSE
    
    SELECT *
    FROM 게시글
    WHERE 제목 LIKE '%맥북에어%'
        OR 내용 LIKE '%맥북에어%'; --첫번째조건을 만족하거나 두번째조건을 만족하거나
    
        
        LIKE ~와 같은, ~와 유사한 느낌으로 사용
        
    % : 0개 이상의 문자
    _ : 1개의 문자
    
    SELECT *
    FROM users
    WHERE userid LIKE 'c%'; 
    -- userid가 c로 시작하는 모든 사용자'; -- 첫글자가 c면 그 뒤에 어떤것이 와도 상관없다. 리눅스에서 .*과 같은느낌
    
    
    SELECT *
    FROM users
    WHERE userid LIKE 'c___'; -- userid가 c로 시작하면서 c이후에 3개의 글자가 오는 사용자
    
    문제4) userid에 1이 들어가는 모든 사용자 조회
    SELECT *
    FROM users
    WHERE userid LIKE '%l%'; -- userid가 앞뒤로 어디든지 l이 나올수있는 구문
    
    문제5) number 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.
    SELECT MEM_ID, MEM_NAME
    FROM member 
    WHERE MEM_NAME LIKE '신%';
    
    문제6) member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오.
    SELECT mem_id, mem_name
    FROM member
    WHERE MEM_NAME LIKE '%이%';
   
============================================================================IS연산자
    
IS, IS NOT (NULL 비교)
emp 테이블에서 comm 컬럼의 값이 NULL인 사람만 조회
SELECT *
FROM emp
WHERE comm IS NULL; --NULL은 IS라는 연산자를 사용해주어야 한다.
                    --WHERE comm IS NOT NULL; => NULL이 아닌 데이터만 조회하겠다.


emp 테이블에서 매니저가 없는 직원만 조회
SELECT *
FROM emp
WHERE MGR IS NULL;


BETWEEN AND, IN, LIKE, IS

논리연산자 : AND, OR, NOT
AND : 두가지 조건을 동시에 만족시키는지 확인할 때
    조건1 AND 조건2
OR : 두가지 조건중 하나라도 만족 시키는지 확인할 때
    조건1 OR 조건2
NOT : 부정형 논리연산자, 특정 조건을 부정
    mgr IS NULL : MGR컬럼의 값이 NULL인 사람만 조회
    mgr IS NOT NULL : MGR컬럼의 값이 NULL이 아닌 사람만 조회
    
    

문제8)emp 테이블에서 mgr의 사번이 7698이면서 
        sal값이 1000보다 큰 직원만 조회;

SELECT *
FROM emp
WHERE mgr=7698 AND sal>1000;


SELECT *
FROM emp
WHERE sal>1000 AND mgr=7698; --위에 쿼리문과 동일 순서는 상관없다.

AND 조건이 많아지면 : 조회되는 데이터 건수는 줄어든다.
OR 조건이 많아지면 : 조회되는 데이터 건수는 많아진다.

NOT : 부정형 연산자, 다른 연산자와 결합하여 쓰인다.
        IS NOT, NOT IN, NOT LIKE
        
SELECT *
FROM emp
WHERE deptno NOT IN(30); --deptno(부서번호)가 30에 포함되지 않는다. 이런식으로 NOT은 IS NOT 뿐만아니라 다른 연산자와 결합하여 여기저기 쓰일수가 있다.

SELECT *
FROM emp
WHERE ename NOT LIKE 'S%';

NOT IN 연산자 사용시 주의점 : 비교값중에 NULL이 포함되면 데이터가 조회되지 않는다.
SELECT *
FROM emp
WHERE mgr IN (7698, 7839, NULL); -- mgr = 7698 OR mgr = 7839 OR mgr = NULL 이것이 어떤 구문과 동일한건지 이런거 생각하는게 되게 중요하다. 얘가 이 세가지 값중에 하나를 포함한다.


SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL); -- NOT IN은 OR의 NOT이므로  AND가 된다.
-- 결국 이 뜻은 NOT(mgr = 7698 OR mgr = 7839 OR mgr = NULL);
--       이렇게 =!(mgr = 7698, mgr = 7839, mgr = NULL);  = 여기서 ,는 AND 
--              mgr != 7698 AND mgr != 7839 AND mgr != NULL -- mgr != NULL 이 부분이 항상 거짓이기때문에 값이 안나옴.
--              TRUE FALSE 의미가 없음.



문제9) emp테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


문제10) emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
      (IN, NOT IN 연산자 사용 금지)
      
SELECT *
FROM emp 
WHERE DEPTNO != '10' AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
-- NOT IN을 사용하면 DEPTNO NOT IN (10)

문제11) emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
        (부서는 10, 20, 30 만 있다고 가정하고 IN 연산자를 사용)

SELECT *
FROM emp
WHERE DEPTNO IN (20,30) AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
--WHERE DEPTNO NOT IN (10) AND HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');


문제12) emp 테이블에서 job이 SALEMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.

SELECT *
FROM emp
WHERE job = 'SALEMAN' 
    OR HIREDATE >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
    
    
문제13) 풀면 좋고, 못풀어도 괜찮은 문제
       emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
       
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR EMPNO LIKE '78%';



<과제>
문제 14) emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
        (LIKE 연산자 사용 X)
        (데이터 타입에 대한 고민을 하면서 풀어라)
        
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR EMPNO BETWEEN 7800 AND 7899;

 
 SELECT *
 FROM emp 
 WHERE job = 'SALESMAN' OR EMPNO >= 7800; OR EMPNO < 7900; 

 
-- SELECT *
-- FROM emp
-- WHERE job = 'SALESMAN' OR EMPNO LIKE '78%'; --EMPNO는 숫자타입인데 LIKE는 문자타입만 해준다. 근데 오라클은 형변환을 자동으로 해주니까 저렇게 쿼리를 짜도 출력된다. 하지만 좀더 정확하게 데이터타입에 맞춰서 해봐라 이런뜻이다.
