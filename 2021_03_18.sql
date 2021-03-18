날짜관련 함수
MONTHS_BETWWEN : 
인자- start date, end date, 반환값 : 두 일자 사이의 개월수


ADD_MONTHS(★★★)
인자 : date, number 더할 개월 수: date로 부터 x개월 뒤의 날짜

date + 90
1/15 3개월 뒤의 날짜 --이러면 3개월이 32일일수도 33일일수도 있으므로 개월로 사용

NEXT_DAY(★★★)
인자 : date, number(weekday, 주간일자)
date 이후의 가장 첫번째 주간일자에 해당하는 date를 반환

LAST_DAY(★★★)
인자 : date : date가 속한 월의 마지막 일자를 date로 반환

MONTHS_BETWEEN
SELECT ename, TO_CHAR(hiredate, 'yyyy/mm/dd HH24:mi:ss') hiredate,
       MONTHS_BETWEEN(sysdate, hiredate), -- hiredate부터 현재날짜까지 몇개월이 있는지 -SYSDATE 는 현재날짜
       ADD_MONTHS(SYSDATE, 5), --오늘 날짜로부터 5개월후가 언제인가?
       ADD_MONTHS(TO_DATE('2021-02-15', 'YYYY-MM-DD'), 5), --5개월후 -- ADD_MONTHS(TO_DATE('2021-02-15', 'YYYY-MM-DD'), -5) => (-)5개월전으로 돌아간다
       NEXT_DAY(SYSDATE, 6), --오늘 날짜로부터 처음 등장하는 금요일은 언제인가?
       NEXT_DAY(SYSDATE, 6), --오늘 날짜로부터 처음 등장하는 일요일은 언제인가?
       LAST_DAY(SYSDATE) LAST_DAY --달의 마지막날이 몇일인지? 달의 마지막날은 28~31 까지 다양하지만, 달의 첫시작은 항상 1일이므로 FIRST_DAY는 존재하지 않는다.
       TO_CHAR(TO_CHAR(SYSDATE, 'YYYYMM') || '01' || '01', 'YYYYMMDD') FIRST_DAY
       SYSDATE를 이용하여 SYSDATE가 속한 월의 첫번째 날짜 구하기
       SYSDATE를 이용해서 년월까지 문자로 구하기 + || '01'
                '202103' || '01' ==> '20210301'
                TO_DATE('20210301', 'YYYYMMDD')
             
FROM emp;
★ 자바처럼 주석처리 /* */로 시작 가능하다.★

SELECT TO_DATE(


(date종합실습3)  파라미터로 yyyymm형식의 문자열을 사용 하여 (ex)yyyymm = 201912) 
                해당 년월에 해당하는 일자 수를 구해보세요.
                
                yyyymm=201912 -> 31
                yyyymm=201911 -> 30
                yyyymm=201602 -> 29 (2016년은 윤년)
                
                SELECT:yyyymm 
                FROM dual;
                
                SELECT :YYYYMM, 
                        TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM, 'YYYYMM')), 'DD')DT
                FROM dual;
                
    
형변환
.명시적 형변환
    TO_DATE, TO_CHAR, TO_NUMBER
.묵시적 형변환 -- 개발자가 뭐 해주지않아도 자동적으로 형변환이 되는것이 '묵시적 형변환' 이다.

SELECT *
FROM emp
WHERE empno = '7369';


SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

1. 위에서 아래로
2. ★ 단 들여쓰기 되어있을 경우(자식 노드) 자식노드부터 읽는다 

실행순서 : ㅇ
0
1
2
*3   
4
*5

NUMBER
    형변환
    
    
    

FORMAT
-9 : 숫자
-0 : 강제로 0표시
-, : 1000자리 표시
-. : 소수점
-L : 화폐단위(사용자 지역)
-$ : 달러 화폐 표시

형변환 (NUMBER -> CHARACTER)
SELECT ename, sal, TO_CHAR(sal, 'L0009,999,00') fm_sal FROM emp; -- 문자보단 숫자로 비교하는게 더 편함. 사실 잘 쓰이진 않음

NULL처리 함수 : 4가지
NVL (expr1, expr2) --expr에 어떤 값이 온다. expr1이 NULL이 아니면 expr1을 사용하고, expr1이 NULL값이면 EXPR2로 대체해서 사용한다.
if(expri == null)
    System.out.println(expr2)
else
    System.out.println(expri)



emp 테이블에서 comm 컬럼의 값이 NULL일 경우 0으로 대체 해서 조회하기

SELECT empno, sal, comm, 
       sal + NVL(comm, 0) nvl_sal_comm,
       NVL(sal+comm, 0) nvl_sal_comm2
FROM emp;


NVL2(expr1, expr2, expr3)
if(expr1 != null)
    System.out.println(expr2);
else
    System.out.println(expr3);
    
comm이 null이 아니면 sal_comm을 반환,
comm이 null이면 sal을 반환
SELECT empno, sal, comm, NVL2(comm, sal+comm, sal)
FROM emp;



NULLIF -- 잘 안쓰이는 함수
NULLIF(expr1, expr2) -- 인자가 두개
if(expr1 == expr2)
    System.out.println(null)
else
    System.out.println(expr1)
    

SELECT empno, sal, NULLIF(sal, 1250)
FROM emp;


COALESCE(expr1, expr2, expr3 ....)
인자들 중에 가장먼저 등장하는 null이 아닌 인자를 반환

if(expr1 != null)
    System.out.println(expr1);
else
    COALESCE(expr2, expr3....);
    
if(expr2 != null)
    System.out.println(exprl);
else
    Coalesce(expr3...);
    
    
    
    
NULL처리 함수 : 4가지
NVL (expr1, expr2) --expr에 어떤 값이 온다. expr1이 NULL이 아니면 expr1을 사용하고, expr1이 NULL값이면 EXPR2로 대체해서 사용한다.
if(expri == null)
    System.out.println(expr2)
else
    System.out.println(expri)



4) emp테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
(nvl, nvl2, coalesce)
MGR컬럼에 null, nvl, nvl2, coalesce를 이용하여 나머지 셋 9999로 바꾸기 

SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n_i, COALESCE(mgr, 9999) mgr_n_2 --mgr이면 mgr 그게 아니면 9999
FROM emp;

users 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요.
reg_dt가 null일 경우 sysdate를 적용

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
WHERE users
FROM userid IN ('cony', 'sally', 'james', 'moon');





< 조건분기 >

1. CASE 절
    CASE expri 비교식(참거짓을 판단 할수 있는 수식) THEN 사용할 값--참이면 사용할값     => java로 치면 if
    CASE expri 비교식(참거짓을 판단 할수 있는 수식) THEN 사용할 값--참이면 사용할값2    => java로 치면 else if
    CASE expri 비교식(참거짓을 판단 할수 있는 수식) THEN 사용할 값--참이면 사용할값3    => java로 치면 else if
    ELSE 사용할 값4                                                         --    => else
    END
    
    
2. DECODE 함수 => COALESCE 함수처럼 가변인자 사용
    DECODE( expr1, search1, return1, search2, return2, search3, return3, ....[, default])
    DECODE( expr1, 
                search1, return1, 
                search2, return2, 
                search3, return3, 
                ....[, default])
                
    --java의            
    if(expr1 == search1) --얘는 CASE처럼 <=나 =>처럼 대소비교도 할수있는게아니라 동등비교만 가능.
        System.out.println(retur1)
    else if(expr1 == search2)
        System.out.println(retur2)
    else if(expr1 == search3)
        System.out.println(retur3)
    else
        System.out.println(default)




(문제1)
직원들의 급여를 인상하려고 한다
1.job이 SALESMAN 이면 현재 급여에서 5%를 인상
2.job이 MANAGER 이면 현재 급여에서 10%를 인상
3.job이 PRESIDENT 이면 현재 급여에서 20%를 인상
4.그 이외의 직군은 현재 급여를 유지

SELECT ename, job, sal, --인상된 급여 -- 인상된 급여라는 컬럼을 만들려면
        CASE 
            WHEN job = 'SALESMAN' THEN sal * 1.05  
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal * 1.0 -- 이외의 직군은 현재 급여 유지
        END sal_bonus   -- CASE부터 시작해서 END까지가 하나의 컬럼이라고 생각
FROM emp;

        DECODE(job, 
                'SALESMAN', sal * 1.05,
                'MANAGER', sal * 1.10,
                'PRESIDENT', sal * 1.20,
                sal * 1.0) sal_bonus_decode
FROM emp;


(문제 2) emp 테이블을 이용하여 deptno에 따라 부서명으로 변경 해서 다음과 같이 조회되는 쿼리를 작성하세요.
        10 -> 'ACCOUNTING'
        20 -> 'RESEARCH'
        30 -> 'SALES'
        40 -> 'OPERATIONS'
        기타 다른값-> DDIT
        
        1) CASE로 한 방법
        SELECT empno, ename, deptno
        CASE 
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
            END dname,
            job
        FROM emp;
        2) ECODE로 한 방법
SELECT empno, ename, deptno,
        DECODE(deptno,
                '10', 'ACCOUNTING'
                '20', 'RESEARCH'
                '30', 'SALES'
                '40', 'OPERATIONS'
                'DDIT') dname_decode
from emp;


< condition 실습 >

emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진대상자인지 조회하는 쿼리를 작성하세요.
(생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다)

SELECT empno, ename, hirdate,
        CASE 
            WHEN
        MOD(TO_CHAR(hiredate, 'yyyy'), 2) = --hiredate가 짝수면 미대상자, 홀수면 대상자
        MOD(TO_CHAR(SYSDATE, 'yyyy'), 2) THEN '건강검진 대상자'
    ELSE '건강검진 비대상자'
END CONTACT_TO_DOCTOR,
DECODE( MOD(TO_CHAR(hiredate, 'yyyy'), 2),
                MOD(TO_CHAR(SYSDATE, 'yyyy'), 2), '건강검진 대상자',
                        
FROM emp;



< 실습 3 >
user 테이블을 이용하여 reg_dt에 따라 올해 건강보험 검진대상자인지 조회하는 쿼리를 작성하세요.
(생년을 기준으로 하나 여기서는 reg_dt를 기준으로 한다)

SELECT userid, usernm, reg_dt,
        CASE 
            WHEN 
                MOD(TO_CHAR(reg_dt, 'yyyy'), 2) =
                MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) THEN '건강검진 대상자'
            ELSE '건강검진 대상자'
        END CONTACT_TO_DOCTOR
from users
WHERE userid IN ('brown', 'cony', 'james', 'moon', 'sally');





GROUP FUNCTION : 여러행을 그룹으로 하여 하나의 행으로 결과값을 반환하는 함수
                 하나의 컬럼으로 하나의 그룹을 묶을수도있고, 여러개의 컬럼으로도 묶을수가있다.
SELECT *
FROM emp;

AVG : 평균
COUNT : 건수
MAX : 최대값
MIN : 최소값
SUM : 합


--GROUP BY 절에 나온 컬럼이 SELECT절에 그룹함수가 적용되지 않은채로 기술되면 에러
SELECT deptno, 'TEST', 100, --TEST 얘는 상수
                MAX(sal), MIN(sal), ROUND(AVG(sal), 2), -- 해당부서에서 가장많이받는사람, 가장적게받는사람
                SUM(sal), 
                COUNT(sal), -- 그룹핑된 행중에 sal 컬럼의 값이 NULL이 아닌 행의 건수
                COUNT(mgr), -- 그룹핑된 행중에 mgr 컬럼의 값이 NULL이 아닌 행의 건수
                COUNT(*) -- 그룹핑된 행 건수
                SUM(NVL(comm, 0)),
                NVL(SUM(comm, 0))
                
FROM emp
WHERE LOWER(ename) = 'smith'
GROUP BY deptno;
HAVING COUNT(*) >= 4;
--GROUP BY를 사용하지 않을 경우 테이블의 모든 행을 하나의 행으로 그룹핑한다
SELECT COUNT(*), MAX(sal), MIN(sal), ROUND(AVG(sal), 2), SUM(sal)
FROM emp;

Group function
- 그룹 함수에서 null컬럼은 계산에서 제외된다.
- group by 절에 작성된 컬럼 이외의 컬럼이 select 절에 올 수 없다
- where절에 그룹 함수를 조건으로 사용할 수 없다
    havin 절 사용
        where sum(sal) > 3000(x)
        
        
emp테이블을 이용하여 다음을 구하시오
- 직원중 가장 높은 급여
- 직원중 가장 낮은 급여
- 직원의 급여 평균(소수점 두자리까지 나오도록 반올림)
- 직원의 급여 합
- 직원 중 급여가 있는 직원의 수 (null제외)
- 직원 중 상급자가 있는 직원의 수 (null제외)
- 전체 직원의 수



SELECT MAX(sal), MIN(sal), ROUND(AVG(sal), 2), SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp;


SELECT empno
from emp;
