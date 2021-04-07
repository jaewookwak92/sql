2021-04-07-01 반복문
    - 개발언어의 반복문과 같은 기능 제공
    - loop, while, for문

1) LOOP 문
    - 반복문의 기본 구조
    - JAVA의 DO 문과 유사한 구조임
    - 기본적으로 무한 루프 구조
    (사용형식)
    LOOP
        반복처리문(들);
        [EXIT WHEN 조건;] -- 조건이 맞으면 빠져나간다. while은 조건이 맞으면 반복되지만 LOOP는 반대.
    END LOOP;
    - 'EXIT WHEN 조건' : '조건'이 참인 경우 반복문의 범위를 벗어남
    
    
    사용예)구구단의 7단출력
    
DECLARE 
    V_CNT NUMBER:=1;
    V_RES NUMBER:=0;
BEGIN
    LOOP
        V_RES:=7*V_CNT;
        DBMS_OUTPUT.PUT_LINE(7||'*'||V_CNT||'='||V_RES);
        V_CNT:=V_CNT+1;
        EXIT WHEN V_CNT>9;
    END LOOP;
    
사용예)1-50사이의 피보나치수를 구하여 출력하시오
        FIBONACCI NUMBER : 첫번째와 두번째 수가 1,1로 주어지고 세번째 수부터 전 두수의 합이 현재수가 되는 수열 -> 검색 알고리즘 사용
DECLARE
    P_NUM NUMBER := 1; --전수
    V_PPNUM NUMBER :=1; --전전수
    V_CURRUM NUMBER :=0; --현재수
BEGIN
    V_RES:=V_PPNUM||','||V_PNUM;
    
    LOOP
        V_CURRUM:=V_PPNUM+V_PNUM
        EXIT WHEN V_CURRNUM >= 50;
        V_RES:=V_RES||', '||V_CURRNUM;
        V_PPNUM:=V_PNUM;
        V_PNUM:=V_CURRUM;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~50사이의 피보나치 수 : '||V_RES);
END;

2)WHILE 문
 - 개발언어의 WHILE문과 같은 기능
 - 조건을 미리 체크하여 조건이 참인 경우에만 반복 처ㅣ\리
 (사용형식)
  WHERE 조건
    LOOP
        반복처리문(들)
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('날수:' ||V_DAYS-1);
    DBMS_OUTPUT.PUT_LINE('저축액수' ||V_SUM);
END;

사용예)회원테이블(NUMBER)에서 마일리지가 3000이상인 회원을 찾아 그들이 2005년 5월을 구매한 횟수와 구매금액합개계를 구하시오(커서사용)
        출력은 회원번호, 회원명, 구매횟수, 구매금액
        
        
(LOOP를 사용한 커서 실행)

DECLARE
    V_MID MEMBER.MEM_ID%TYPE; --회원번호
    V_MNAME MEMBER.MEM_NAME%TYPE; --회원명
    V_CNT NUMBER:=0; --구매횟수
    V_AMT NUMBER:=0; --구매금액 합계
    
    CURSOR CUR_CART_AMT
    IS  
        SELECT MEM_ID,MEM_NAME 
        FROM MEMBER
        WHERE  MEM_MILLEAGE>=3000;
    BEGIN
        OPEN CUR_CART_AMT;
        
    
   WHILE CUR_CART_AMT%FOUND LOOP
        SELECT SUM(CART_QTY*B.PROD_PRICE),
                COUNT(A.CART_PROD) INTO V_AMT, V_CNT
            FROM CART 'A', PROD B
            WHERE A.CART_PROD = B.PROD ID
            AND A.CART_MEMBER=V_MID
            AND SUBSTR(A.CART_NO,1,6)='200505';
            
            DBMS_OUTPUT.PUT_LINE(V_MID||', '||V_MNAME||' => '||V_AMT||'('||V_CNT||')');
            FETCH CUR_CART_AMT INTO V_MID, V_MNAME;
        END LOOP;
        
        
        
        
    3)FOR문
    . 반복횟수를 알고 있거나 회수가 중요한 경우 사용
    (사용형식-1:일반적 FOR)
    FOR 인덱스 IN[REVERSE] 최소값..최대값
    LOOP
        반복처리문(들);
    END LOOP;
    
사용예) 구구단의 7단을 FOR문을 이용하여 구성
DECLARE
    V_CNT NUMBER:=1; --승수(1~9)
    V_RES NUMBER:=0; --결과
BEGIN
  FOR I IN 1..9 LOOP
    V_RES:=7*I;
    DBMS_OUTPUT.PUT_LINE(7||'*'||I||'='||V_RES);
  END LOOP;
END;
    

(사용형식-2:CURSOR에 사용하느 FOR)
FOR 레코드명 IN 커서명|(커서 선언문)
LOOP
    반복처리문(들);
END LOOP;
    . '레코드명'은 시스템에서 자동으로 설정
    . 커서 컬럼 참조형식 : 레코드명.커서컬럼명
    . 커서명 대신 커서 선언문(선언부에 존재했던)이 INLINE형식으로 
      기술할 수 있음
    . FOR문을 사용하는 경우 커서의 OPEN, FETCH, CLOSE문은 생략함
            
DECLARE
  V_CNT NUMBER:=0;--구매횟수
  V_AMT NUMBER:=0;--구매금액 합계
  
  CURSOR CUR_CART_AMT
  IS 
    SELECT MEM_ID,MEM_NAME
      FROM MEMBER
     WHERE MEM_MILEAGE>=3000; 
BEGIN
  FOR REC_CART IN CUR_CART_AMT LOOP 
    SELECT SUM(A.CART_QTY*B.PROD_PRICE),
           COUNT(A.CART_PROD) INTO V_AMT,V_CNT
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND A.CART_MEMBER=REC_CART.MEM_ID
       AND SUBSTR(A.CART_NO,1,6)='200505';   
    DBMS_OUTPUT.PUT_LINE(REC_CART.MEM_ID||', '||REC_CART.MEM_NAME||
                         ' => '||V_AMT||'('||V_CNT||')'); 
  END LOOP;
END; 
  


(FOR문에서 INLINE 커서 사용)  
DECLARE
  V_CNT NUMBER:=0;--구매횟수
  V_AMT NUMBER:=0;--구매금액 합계
BEGIN
  FOR REC_CART IN (SELECT MEM_ID,MEM_NAME
                     FROM MEMBER
                    WHERE MEM_MILEAGE>=3000)
  LOOP 
    SELECT SUM(A.CART_QTY*B.PROD_PRICE),
           COUNT(A.CART_PROD) INTO V_AMT,V_CNT
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND A.CART_MEMBER=REC_CART.MEM_ID
       AND SUBSTR(A.CART_NO,1,6)='200505';   
    DBMS_OUTPUT.PUT_LINE(REC_CART.MEM_ID||', '||REC_CART.MEM_NAME||
                         ' => '||V_AMT||'('||V_CNT||')'); 
  END LOOP;
END; 
  


=========================================================================================================
2021-0407-02)저장프로시져(Stored Procedure: Procedure)
 - 특정 결과를 산출하기 위한 코드의 집합(모듈)
 - 반환값이 없음 --JAVA VOID처럼
 - 컴파일되어 서버에 보관(실행속도를 증가, 은닉성, 보안성)
 (사용형식)
 CREATE [OR REPLACE] PROCEDURE 프로시져명[(
    매개변수명 [IN | OUT | INOUT] 데이터타입 [[:= | DEFAULT] expr],
    매개변수명 [IN | OUT | INOUT] 데이터타입 [[:= | DEFAULT] expr],
                                :
    매개변수명 [IN | OUT | INOUT] 데이터타입 [[:= | DEFAULT] expr])]
    
AS | IS
    선언영역;
BEGIN
    실행영역;
END;

** 다음 조건에 맞는 재고수불 테이블을 생성하시오
1. 테이블명 : REMAIN
2. 컬럼 
---------------------------------------------------------------------------------
    컬럼명         데이터타입                   제약사항
---------------------------------------------------------------------------------
REMAIN_YEAR       CHAR(4)                        PK
PROD_ID           VARCHAR2(10)                   PK & FK
REMAIN_J_00       NUMBER(5)                      DEFAULT 0 --기초재고
REMAIN_I          NUMBER(5)                      DEFAULT 0 --입고
REMAIN_O          NUMBER(5)                      DEFAULT 0 --출고
REMAIN_J_99       NUMBER(5)                      DEFAULT 0 --기말재고
REMAIN_DATE       DATE                           DEFAULT SYSDATE --처리일자
---------------------------------------------------------------------------------


**테이블 생성명령
CREATE TABLE 테이블명(
  컬럼명1 데이터타입[(크기)] [NOT NULL][DEFAULT 값|수식] [,]
  컬럼명2 데이터타입[(크기)] [NOT NULL][DEFAULT 값|수식] [,]
                              :
  컬럼명n 데이터타입[(크기)] [NOT NULL][DEFAULT 값|수식] [,]
  
  CONSTRAINT 기본키설정명 PREMARY KEY (컬럼명1[, 컬럼명2,...]) [,]
  CONSTRAINT 외래키설정명1 FOREIGN KEY (컬럼명1[, 컬럼명2,...]) 
    REFERENCES 테이블명1(컬럼명1[, 컬럼명2,...])[,]
                      :
  CONSTRAINT 외래키설정명n FOREIGN KEY (컬럼명1[, 컬럼명2,...]) 
     REFERENCES 테이블명n(컬럼명1[, 컬럼명2,...])[,];
     
     
CREATE TABLE REMAIN(
        REMAIN_YEAR       CHAR(4),                        
        PROD_ID           VARCHAR2(10),                   
        REMAIN_J_00       NUMBER(5) DEFAULT 0,
        REMAIN_I          NUMBER(5) DEFAULT 0,
        REMAIN_O          NUMBER(5) DEFAULT 0,
        REMAIN_J_99       NUMBER(5) DEFAULT 0,
        REMAIN_DATE       DATE     DEFAULT SYSDATE,
        
        CONSTRAINT PK_REMAIN PRIMARY KEY (REMAIN_YEAR, PROD_ID),
        CONSTRAINT PK_REMAIN_PROD FOREIGN KEY (PROD_ID)
        REFERENCES PROD(PROD_ID));
 

** REMAIN 테이블에 기초자료 삽입
    년도 : 2005
    상품코드 : 상품테이블의 상품코드
    기초재고 : 상품테이블의 적정재고(PROD_PROPERSTOCK)
    입고수량/출고수량 : 없음
    처리일자 : 2004/12/31
    
INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
     SELECT '2005',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20041231')
       FROM PROD;
    
    
    
SELECT *
FROM REMAIN;
    