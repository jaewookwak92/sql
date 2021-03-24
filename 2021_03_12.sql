NUMBER(4,0) 전체자리는 4자리, 소수점은 없음.

숫자, 날짜에서 사용가능한 연산자
일반적인 사칙연산 + - / *, 우선순위 연산자 ()

컬럼 정보를 보는 방법

1. SELECT * ==> 컬럼의 이름을 알 수 있다.
2. SQL DEVELOPER의 테이블 객체를 클릭하여 정보확인
3. DESC 테이블명; //DESCRIBE 설명하다 

DESC emp; 
이름 / 널 / 유형(어떤타입의 유형인지 나온다) 
NUMBER 숫자
VARCHAR2

SELECT empno FROM emp;
SELECT empno + 10 FROM emp; -- empno컬럼 number들에 +10씩해줌
SELECT empno, empno + 10 FROM emp; --empno 컬럼과 +10해준 empno 컬럼을 같이 띄워 비교함.

emp + 10 ==> expression --컬럼정보가 아닌것들은 다 expression 이라고 부른다

SELECT empno, empno +10, 10 FROM emp; -- 3번째 10은 그냥 값을 10으로 출력한다 => --컬럼정보가 아닌것들은 다 expression 이라고 부른다

SELECT empno, empno + 10, 10, hiredate, hiredate + 10 FROM emp; -- 날짜인 hiredate와 숫자를 더해봄. 일수에서 +10일이 됨. 더하기랑 뺄셈만되고 곱하기, 나누기는 안된다.

SELECT empno empno2, empno + 10 emp_plus, 10 hiredate, hiredate + 10 FROM emp; -- empno컬럼 이름을 empno2 로 바꾸어줌.

-------------------------------------------------------------------------------- ALIAS

ALIAS : 컬럼의 이름을 변경
        컬럼 | EXPRESSION [as] [별칭명]
SELECT empno, empno + 10 AS empno_plus FROM emp; -- empno컬럼에 10을 더해주고 별칭을 empno_plus로 바꾸어주어서 같이 출력 (AS는 사용해도, 안해도됨)

NULL : 아직 모르는 값 (값이 할당자체가 안된것)
       0과 공백은 NULL과 다르다.
       **** NULL을 포함한 연산은 결과가 항상 NULL **** 
       ==> 추후 NULL 값을 다른 값으로 치환해주는 함수를 배울 예정.
SELECT ename, sal, comm, comm + 100 FROM emp; -- COMM이 NULL이니 +100을해도 NULL이 나온다. 직접 실행해보고 확인해보자.


-----------------------------------------------------------

column alias 실습 select2 

1. prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오.
   (단 prod_id -> id, prod_name -> name 으로 컬럼 별칭을 지정)
    SELECT prod_id AS id, prod_name AS name FROM prod;
    
2. lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오.
   (단 lrpod_gu -> gu, lprod_nm -> nm으로 컬럼 별칭을 지정)
   SELECT lprod_gu AS gu, lprod_nm AS nm FROM lprod;
 
3. buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리를 작성하시오.  
   (단 buyer_id -> 바이어아이디, buyer_name -> 이름 으로 컬럼별칭을 지정)
    SELECT buyer_id AS 바이어아이디, buyer_name AS 이름 FROM buyer;


literal : 값 자체
literal 표기법 : 값을 표현하는 방법

java 정수 값을 어떻게 표현할까 (10) ?
int a = 10;
float f = 10f; -- 10을 정수가 아닌 실수로 표현하고싶을때 float 이용
long l = 10L;
String s = "Hello World";

SELECT empno, 10, 'Hello World' 
FROM emp; --SQL에서는 문자열을 JAVA와 달리 ''로 써준다.


문자열 연산
java : String msg = "Hello" + "Wolrd";
SELECT empno + 10, ename || ',worlrd, CONCAT(ename,',world;) --결합할 두개의 문자열을 입력받아 결합하고 결정된 문자열을 입력받아 결합하고 결합한 몬자 열을 반환 해준다.
SELECT empno + 10, ename aROM emp;

아이디 : brown
아이디 : apeach

SELECT userid FROM users;

SELECT '아이디 : ' || userid;
        CONCAT('아이디 : ', userid) FROM users;
        
SELECT * FROM user_tables; -- user_tables은 해당사용자가 가지고 있는 테이블이 뜸. 확인해봐.
SELECT table_name FROM user_tables;

SELECT '아이디 : ' || userid, CONCAT('아이디 : ', userid) -- CONCAT은 두개밖에 못붙이므로 먼저 한다음 새로 추가


SELECT table_name FROM user_tables; -- 원본
SELECT 'SELECT * FROM ' || TABLE_NAME || ';' FROM user_tables; -- 앞 뒤로 'SELECT * FROM'과 ';'를 추가해줌.
SELECT CONCAT('SELECT * FROM', TABLE_NAME)||';' FROM user_tables; -- CONCAT은 두개만 가능하지만
SELECT CONCAT(CONCAT('SELECT * FROM', TABLE_NAME), ';') FROM user_tables; -- 이런식으로도 여러개 가능하다. 

CONCAT(문자열1, 문자열2, 문자열3)
==> CONCAT(문자열1과 문자열2가 결합된 문자열, 문자열3)
  ==> CONCAT(CONCAT(문자열1, 문자열2), 문자열3)


   < SQL 조건에 맞는 데이터 조회하기 > 
   
*  WHERE절 조건연산자
---부서번호가 10인 직원들만 조회
---부서번호 : deptno
SELECT *
FROM emp
WHERE deptno=10;

---users 테이블에서 userid 컬럼의 값이 brown인 사용자만 조회
SELECT *
FROM users
WHERE userid='brown'; ---브라운은 문자이므로 ''를 꼭 붙여주어야한다. 오라클은 대소문자를 구별하지않지만, brown은 테이블안에 있는 데이터 이므로 대,소문자를 맞춰적어줘야 출력이 가능하다.

---emp 테이블에서 부서번호가 20번보다 큰부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno>20;

---emp 테이블에서 부서번호가 20번 부서에 속하지 않은 모든 직원 조회
SELECT *
FROM emp
WHERE deptno != 20;

WHERE : 기술한 조건을 참(TRUE)으로 만족하는 행들만 조회한다(FILTER)

SELECT *
FROM emp
WHERE 1=1; --- 1=1은 참이기때문에 모든행 출력, 1=2하면 아무것도 안나옴.

SELECT empno, ename, hiredate
FROM emp
WHERE HIREDATE >= TODATE('81/03/01', 'YYYY/MM/DD');

문자열을 날짜타입으로 변환하는 방법
TO_DATE(날짜 문자열, 날짜 문자열의 포맷팅)
TO_DATE('1981/03/01' -- 한국인 관점으로는 3월1일인데 전세계적으로 표기방법이 다르니 컴퓨터는 어디가 월이고 어디가 일인지 인지하지못하니, 두번째 인자를통해서 알려준다)
TO_DATE('1981/12/11', 'YYYY/MM/DD')

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1981/03/01', 'YYYY/MM/DD'); -- 쿼리가 길어져도 이게 안전하다.