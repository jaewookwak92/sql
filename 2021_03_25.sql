실습 sub6

cycle 테이블을 이용하는 cid=1인 고객이 애음하는 제품중 cid=2인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리를 작성하세요.


SELECT *
FROM cycle
WHERE cid = 1; --1번고객은 100,400번제품


SELECT *
FROM cycle
WHERE cid = 2; -- 2번고객은 100,200번 제품


SELECT PID
FROM cycle
WHERE cid = 1
AND pid IN (100, 200); -- 이건 하드코딩

SELECT PID 
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2); -- 정답
            
실습 sub7
customer, cycle, product 테이블을 이용하여 cid=1인 고객이 애음하는 제품중 -- 메인쿼리
cid=2인 고객도 애음하는 제품의 
애음정보를 조회하고 고객명과 제품명까지 포함하는 쿼리를 작성하세요.
--서브쿼리


SELECT *
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid --customer, cycle 연결하고
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2); --product 연결
            
-- 헷갈리면 구글 드라이브에 스프리트시트가서 에 테이블 옮겨담고 공통되는부분 색칠하면서 공부


=========================================================================================

연산자 : 몇항
1 + 5//     ?
++, --

EXISTS 서브쿼리 연산자 : 단항
IN : WHERE 컬럼 | EXPRESSION IN (값1, 값2, 값3...)
EXISTS : WHERE EXISTS (서브쿼리)
--앞에 IN처럼 [NOT]EXISTS도 가능(존재하지않는)
     ==> 서브쿼리의 실행결과로 조회되는 행이 있으면 TRUE, 없으면 FALSE (행이 존재하냐 존재하지않냐로만 참,거짓을 판단)
         행이 존재하냐 존재하지않느냐만 판단
         EXISTS 연산자와 사용되는 서브쿼리는 상호 연관, 비상호연관 서브쿼리 둘다 사용 가능하지만
         행을 제한하기 위해서 상호연관 서브쿼리와 사용되는 경우가 일반적이다.
         
         서브쿼리에서 EXISTS 연산자를 만족하는 행을 **하나라도** 발견을 하면은(TRUE) 더이상 진행하지 않고 효율적으로 일을 끊어 버린다
         서브쿼리가 1억건이라 하더라도 10번째 행에서 EXISTS 연산을 만족하는 행을 발견하면 나머지 9999만 건정도의 데이터는 확인 안한다
         
         
         
         
--매니저가 존재하는 직원
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X' --관습적으로 'X'라는 문자열을 많이쓴다 
              FROM emp m
              WHERE e.mgr = m.empno); -- WHERE절이 항상 참으로 인식한다.
             

실습 sub9
cycle, product 테이블을 이용하여 cid=1인 고객이 애음하는 제품을 조회하는 쿼리를 EXISTS 연산자를 이용하여 작성하세요.

SELECT *
FROM product
WHERE EXISTS( SELECT 'X'
         FROM cycle
         WHERE cid = 1 
         AND product.pid = cycle.pid); --존재하는것


SELECT PID, PNM
FROM product
WHERE NOT EXISTS( SELECT 'X'
                  FROM cycle
                  WHERE cid = 1 
                  AND product.pid = cycle.pid);  --존재하지 않는것
                  

==========================================================================================
< 집합연산 >

UNION / UNION ALL - 합집합
INTERSECT - 교집합
MINUS - 차집합(한쪽에서 한쪽을 뺀것)

UNION : {a, b} U {a, c} = {a, a, b, c} ==> {a, b, c}
그냥 UNION은 수학에서 이야기하는 일반적인 합집합

UNION ALL : {a, b} U {a, c} = {a, a, b, c}
UNION ALL은 중복을 허용하는 합집합

●집합 연산
= 데이터를 확장 하는 SQL의 한 방법
- 수학시간에 배운 집합의 개념과 동일
- 집합에는 순서가 없다.

○집합연산
행(row)를 확장 -> 위 아래
위 아래 집합의 col의 개수와 타입이 일치해야 한다

○join
열(col)을 확장 -> 양 옆

union
- 합집합
- 중복을 제거

union all
- 합집합
중복을 제거 하지 않음 -> union 연산자에 비해 속도가 빠르다

intersect
- 교집합 : 두 집합의 공통된 부분

minus
- 차집합 : 한 집합에만 속하는 데이터

UNION : 합집합, 두개의 SELECT 결과를 하나로 합친다. 단 중복되는 데이터는 중복을 제거한다
        ==> 수학적 집합 개념과 동일
        
SELECT empno, ename, NULL 
FROM emp
WHERE empno IN (7369, 7499)

UNION

SELECT empno, ename, deptno --SELECT 다음에 오는 컬럼수가 위에거와 동일해야한다. 
FROM emp
WHERE empno IN (7369, 7521);

위에 쿼리문두개를 묶는 거 

================================================================================

UNION ALL : 중복을 허용하는 합집합
            중복 제거 로직이 없기 때문에 속도가 빠르다 
            합집합 하려는 집합간 중복이 없다는 것을 알고 있을 경우 UNION 연산자 보다 UNION ALL 연산자가 유리하다.

SELECT empno, ename, NULL 
FROM emp
WHERE empno IN (7369, 7499)

UNION ALL

SELECT empno, ename, deptno --SELECT 다음에 오는 컬럼수가 위에거와 동일해야한다. 
FROM emp
WHERE empno IN (7369, 7521);

================================================================================

INTERSECT : 두개의 집합중 중복되는 부분만 조회


SELECT empno, ename, NULL 
FROM emp
WHERE empno IN (7369, 7499)

INTERSECT

SELECT empno, ename, deptno --SELECT 다음에 오는 컬럼수가 위에거와 동일해야한다. 
FROM emp
WHERE empno IN (7369, 7521);


================================================================================
MINUS : 한쪽 집합에서 다른한쪽 집합을 제외한 나머지 요소들을 반환

SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7499)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7521);



=================================================================================

==================================교 환 법 칙=====================================

=================================================================================

A U B == B U A (UNION, UNION ALL)
A ^ B == B ^ A
A - B != B - A  ==> 집합의 순서에 따라 결과가 달라질 수 있다 (주의)


집합연산 특징

1. 집합연산의 결과로 조회되는 데이터의 컬럼 이름은 첫번째 집합의 컬럼을 따른다

2. 집합 연산의 결과를 정렬하고 싶으면 가장 마지막 집합 뒤에 ORDER BY를 기술한다.
        . 개별 집합에 ORDER BY를 사용한 경우 에러
        단 ORDER BY를 적용한 인라인 뷰를 사용하는 것은 가능
        
SELECT e, enm
FROM 
    (SELECT empno, ename
    FROM emp
    WHERE empno IN (7369, 7499)
    ORDER BY e)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7521);
ORDER BY e;

3. 중복 제거 된다 (예외 UNION ALL)


[4. 9i 이전버전 그룹연산을 하게되면 기본적으로 오름차순으로 정렬되어 나온다
    이후버전 ==> 정렬을 보장하지 않음]
    
========================================== INSERT 문 ================================================


DML
* SELECT
* 데이터 신규 입력 : INSERT
* 기존 데이터 수정 : UPDATE
* 기존 데이터 삭제 : DELETE

INSERT 문법
INSERT INTO 테이블명 [(column,)] VALUES ((value, ))


INSERT INTO 테이블명 (컬럼명1, 컬럼명2, 컬럼명3....)
             VALUES (값1, 값2, 값3....)

만약 테이블에 존재하는 모든 컬럼에 데이터를 입력하는 경우 컬럼명은 생략 가능하고
값을 기술하는 순서를 테이블에 정의된 컬럼 순서와 일치시킨다

INSERT INTO 테이블명 VALUES (값1, 값2, 값3);

DESC emp;

INSERT INTO emp (empno, ename, job, hiredate, sal, comm)
        VALUES (9998, 'sally', 'RANGER', TO_DATE('2021/03/24', 'YYYY/MM/DD'), 1000, NULL);

SELECT *
from emp;


여러건을 한번에 입력하기
INSERT INTO 테이블명
SELECT 쿼리

ex)
INSERT INTO dept
SELECT 90, 'DDIT', '대전' FROM dual 
UNION ALL
SELECT 80, 'DDIT8', '대전' FROM dual;

SELECT *
FROM dept;




INSERT INTO 테이블명 [(column,)] VALUES ((value, ))


========================================== UPDATE ================================================


 UPDATE : 테이블에 존재하는 기존 데이터의 값을 변경
 
 UPDATE 테이블명 SET 컬럼명1=값1, 컬럼명2=값2, 컬럼명3=값3.....
 WHERE ;
 
 SELECT *
 FROM dept;
 
 부서번호 99번 부서정보를 부서명 = 대덕IT로, loc = 영민빌딩으로 변경
 
 UPDATE dept SET dname = '대덕IT', loc = '영민빌딩' -- WHERE절 같이 안써주면 다 바뀐다. 꼭 주의
 WHERE deptno = 99;
 
 
 WHERE 절이 누락 되었는지 확인
 WHERE 절이 누락 된 경우 테이블의 모든 행에 대해 업데이트를 진행
 
 
 SELECT *
 FROM dept;
 
 