WHERE 조건1 : 10건

WHERE 조건1
AND 조건2 : 10건을 넘을수 없음 -- AND연산자를 사용하면 출력되는 결과값이 줄어들수밖에없음

WHERE deptno = 10;
AND sal > 500

order by 컬럼명 ASC OR DESC;


가상컬럼 ROWNUM

시험 문제 트래잭션, NOT IN 
===========================================================================================================

2021-03-17

--함수

Single row function
- 단일 행을 기준으로 작업하고, 행당 하나의 결과를 반환
= 특정 컬럼의 문자열 길이 : length(ename)

Multi row function
- 여러 행을 기준으로 작업하고, 하나의 결과를 반환
그룹함수
tous aum avg

함수명을 보고
1. 파라미터가 어떤게 들어갈까?
3. 반환되는 값은 무일까

character
CPUNT

================================
Chractor
문자열 조작
INSTR
DPAD|RPAD
TRIM
REPLAE

DUAL table
- sys 계정에 있는 테이블
- 누구나 사용 가능
- DUMMY 컬럼 하나만 존재하며 값은 'X'이며 데이터는 한행만 존재

사용용도
- 데이터와 관련없이 함수실행, 시퀀스 실행
- merge문에서
- 데이터 복제시(connect by level)


SINGLE ROW FUNCTION : WHERE 절에서도 사용 가능
emp 테이블에 등록된 직원들 중에 직원의 이름의 길이가 5글자를 초과하는 직원만 조회

SELECT *
FROM emp
WHERE LENGTH(ename) > 5;

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; -- 소문자로 이름 바꾸기 LOWER같은경우는 14개를 뒤져서 하기때문에 너무 오래걸려


SELECT *
FROM emp
WHERE ename = UPPER('smith'); -- 얘는 


SELECT * 
FROM dual;

SELECT LOWER('TEST') 
FROM emp;

SELECT LENGTH('TEST')
FROM dual;


< ORACLE 문자열 함수 >
SELECT 'HELLO' || ',' || 'WORLD',
        CONCAT('HELLO', CONCAT(', ','WORLD')) CONCAT,
        SUBSTR('HELLO, WORLD', 1, 5) SUBSTR,
        LENGTH('HELLO, WORLD') LENGTH,
        INSTR('HELLO, WORLD', 'O') INSTR, --헬로 월드 라는 문자열에
        INSTR('HELLO, WORLD', 'O', 6) INSTR2,
        LPAD('HELLO, WORLD', 15, '-') LPAD,
        RPAD('HELLO, WORLD', 15, '-') RPAD,
        REPLACE('HELLO, WORLD', 'O', 'X') REPLACE,
        -- 공백을 제거, 문자열의 앞과, 뒷부분에 있는 공백만
        TRIM(' HELLO, WOLRD ') TRIM,
        TRIM('D' FROM 'HELLO, WORLD') TRIM
        FROM dual;

 < ORACLE 숫자열함수 >
○ number
- 숫자 조작
    ROUND
    반올림 

LOWER 소문자로 만들어진다.
UPPER 대문자로 만들어진다

피제수, 제수
SELECT MOD(10, 3)
FROM dual;

SELECT --반올림하는 함수 --자바처럼 ROUND
ROUND(105.54, 1) round1, --반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.5
ROUND(105.55, 1) round2, --반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.6
ROUND(105.55, 0) round3, --반올림 결과가 첫번째 자리(일의 자리)까지 나오도록 : 소수점 첫째 자리에서 반올림 : 106 --제일많이 쓰일거임
ROUND(105.55, -1) round4, --반올림 결과가 두번째 자리(십의 자리)까지 나오도록 : 정수 첫째 자리에서 반올림 : 110
from dual;

SELECT --절삭하는 함수 
TRUNC(105.54, 1) trunc1, --절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 절삭 : 105.5
TRUNC(105.55, 1) trunc2, --절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 절삭 : 105.5
TRUNC(105.55, 0) trunc3, --절삭 결과가 첫번째 자리(일의 자리)까지 나오도록 : 소수점 첫째 자리에서 절삭 : 105
TRUNC(105.55, -1) trunc4 --절삭 결과가 두번째 자리(십의 자리)까지 나오도록 : 정수 첫째 자리에서 절삭 : 100
from dual;



<문제>
--ex : 7499, ALLEN, 1600, 1, 600
SELECT empno, ename, sal, sal을 1000으로 나눴을때의 몫, sal을 1000으로 나눴을때의 나머지
FROM emp;

<답>
SELECT empno, ename, sal, TRUNC(sal/1000), MOD(SAL, 1000)  --TRUNC는 몫, MOD는 나머지를 구하는 함수
FROM emp;

-------------------------------------- 시간함수 ------------------------------------------------

날짜 <==> 문자 -- 날짜를 문자로 문자를 날짜로 바꿈
서버의 현재 시간 : SYSDATE--오라클에서 서버의 현재 날짜 시간을 조회해주는 함수
SELECT SYSDATE 
FROM dual; -- 서버에 년/월/일만 설정이 되있으므로 21/03/17만 나오는 상황.
           -- 도구 - 환경설정 - 데이터베이스 - NLS - 날짜형식 MM/DD HH24:MI:SS

NLS : YYYY/MM/DD HH24:MI:SS
-- 0:일요일, 1:월요일, 2:화요일  ....6:토요일
SELECT SYSDATE, TO_CHAR(SYSDATE, 'IW'), TO_CHAR(SYSDATE_ 'D')
FROM dual;
●date
    ○FORMAT
        ■ YYYY : 4자리 년도
        ■ MM : 2자리 월
        ■ DD : 2자리 일자
        ■ D : 주간 일자(1~7)
        ■ IW : 주차(1~53)
        ■ HH, HH12 : 2자리 시간(12시간 표현)
        ■ HH24 : 2자리 시간(24시간 표현)
        ■ MI : 2자리 분
        ■ SS : 2자리 초

SELECT SYSDATE + 1 --일수가 하루 +1 된다.
FROM dual;

SELECT SYSDATE - 1 --일수가 하루 -1 된다.
FROM dual;

SELECT SYSDATE + 1/24 -- 시간이 +1시간 된다.
FROM dual;

SELECT SYSDATE + 1/24/60 -- 시간이 +1분이 된다.
FROM dual;

< date실습1번문제 >

1. 2019년 12월 31일을 date형으로 표현
2. 2019년 12월 31일을 date 형으로 표현하고 5일 이전 날짜
3. 현재 날짜
4. 현재 날짜에서 3일 전 값


SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') LASTDAY,
       TO_DATE('2019/12/31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE -3 NOW_BEFORE3
FROM dual

TO_DATE : 인자-문자, 문자의 형식 TO_DATE(문자, 'YYYY/MM/DD')
TO_CHAR : 인자-날짜, 문자의 형식



SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') --내가 보고싶은 포맷대로만 출력가능 (SYSDATE, '')
FROM dual

< date실습2번문제 >
오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오
1. 년-월-일
2. 년-월-일 시간(24) -분-초
3. 일-월-년

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH, --TO_CHAR로 DATE인 날짜타입을 문자로 바꾼것임. -- 1번
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD:MI:SS') DT_DASH_WITH_TIME, -- 2번
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY -- 3번
    FROM dual;

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) --날짜를 문자로 바꿧다가 다시 날짜로 바꿈 ㅋ
FROM dual;

--예를들어 '2021-03-17' ==> '2021-03-17 12:41:00'

TO_CHAR(날짜, 포맷팅 문자열)
SELECT TO_CHAR(TO_DATE('2021-03-17', 'YYYY-MM-DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT SYSDATE, TO_DATE(TO_CHAR(SYSDATE-5, 'YYYYMMDD'), 'YYYYMMDD')
FROM dual; --날짜를 문자로 바꿧다가 다시 날짜로 바꿧다가 이런게 생각보다 빈번하게 일어나니 잘 알아두고 있어라


SELECT ename, LOWER(ename), LOSWER('TEST');
SUBSTR(enaem, 2), 3
SUBSTR*enameE

문자열 조정

================================
Chractor
문자열 조작
INSTR
DPAD|RPAD
TRIM
REPLAE

