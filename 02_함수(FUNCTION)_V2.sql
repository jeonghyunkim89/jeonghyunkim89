-- **함수 두번째 파일 **
/*
    선택함수
        * DECODE(비교대상(컬럼/연산식/함수식), 비교값1, 결과값1, 비교값2, 결과값2,.....)
        
        -- 자바에서 SWITCH(비교대상){
            CASE 비교값1 : 결과값1
            CASE 비교값2 : 결과값2
            ....
        }
*/
--사번, 사원명, 주민번호, 성별 조회(1: '남', 3: '남자',2: '여',4: '여자', '알수없음')
SELECT EMP_ID 사원, EMP_NAME 사원명, EMP_NO 주민번호, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여', 3, '남자', 4, '여자', '알수없음') 성별
FROM EMPLOYEE;
-- 사원명, 기존급여, 인상된 급여 조회
/*
    직급이 J7인 사원은 10%인상
          J6        15%인상
          J5        20%인상
        그외에는       5%인상
*/
SELECT EMP_NAME 사원명, SALARY 기존급여, DECODE(JOB_CODE,
                                                'J7', SALARY*1.1,
                                                'J6', SALARY*1.15,
                                                'J5', SALARY*1.2,
                                                SALARY*1.05) "인상된 급여"
FROM EMPLOYEE;

/*
    CASE WHEN THEN : 조건식에 따라 결과값을 반환해주는 함수
    
    [표현법]
            CASE 
                WHEN 조건식1 THEN 결과값1
                WHEN 조건식2 THEN 결과값2
                ...
                ELSE 결과값ㅅ
            END
*/
-- 사원명, 급여, 급여에 따른 등급 조회
/*
    급여가 ...
        500만원 이상 '고급'
        350만원 이상 '중급'
        그 외 '초급'
*/
SELECT EMP_NAME 사원명, SALARY 급여,
        CASE
            WHEN SALARY >= 5000000 THEN '고급'
            WHEN SALARY >= 3500000 THEN '중급'
            ELSE '초급'
        END "급여에 따른 등급"
FROM EMPLOYEE;
--=================단일행 함수 끝=============================================
------------------------------그룹 함수---------------------------------------
/*
    * SUM : 해당 컬럼의 값들의 총 합을 반환해주는 함수
    
    [표현법]
            SUM(숫자타입컬럼)
*/
-- 전체 사원들의 총 급여를 조회
SELECT SUM(SALARY) FROM EMPLOYEE;
-- 'XXX, XXX, XXX' 형식으로 표현한다면..?
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') 총급여 FROM EMPLOYEE;
-- 남자사원들의 총 급여
SELECT SUM(SALARY)"남자사원들의 총 급여"     --3
FROM EMPLOYEE                            --1
WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3'); --2
-- 여자사원들의 총 급여
SELECT SUM(SALARY)"여자사원들의 총 급여"     --3
FROM EMPLOYEE                            --1
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4'); --2

-- 부서코드가 'D5'인 사원들의 총 연봉
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
    AVG : 해당 컬럼의 값들의 평균을 반환해주는 함수
    
    [표현법]
            AVG(숫자타입컬럼)
*/
-- 전체 사원들의 평균 급여 조회 (반올림 적용 : ROUND)
SELECT ROUND(AVG(SALARY)) "전체 사원 평균 급여"
FROM EMPLOYEE;

/*
    MIN : 해당 컬럼의 값들 중 가장 작은 값 반환해주는 함수
    [표현법] MIN(모든타입)
*/
SELECT MIN(EMP_NAME) "문자타입 최솟값", MIN(SALARY) "숫자타입 최솟값", MIN(HIRE_DATE) "날짜타입 최솟값"
FROM EMPLOYEE;

/*
    MAX : 해당 컬럼의 값들 중 가장 큰 값을 반환해주는 함수
    [표현법] MAX(모든타입)
*/
SELECT MAX(EMP_NAME) "문자타입 최솟값", MAX(SALARY) "숫자타입 최솟값", MAX(HIRE_DATE) "날짜타입 최솟값"
FROM EMPLOYEE;

/*
    COUNT : 행의 개수를 반환해주는 함수 (단, 조건이 있을 경우 해당 조건에 맞는 행의 개수를 반환)
    
    [표현법]
            COUNT(*):조회된 결과에 모든 행의 갯수를 반환
            COUNT(컬럼) : 해당 컬럼값이 NULL이 아닌 것만 행의 갯수를 세어 반환
            COUNT(DISTINCT 컬럼) : 해당 컬럼값의 중복을 제거한 후의 행의 갯수를 세어 반환
                            => 중복 제거시 NULL은 포함하지 않고 객수가 세어짐 
*/
-- 전체 사원 수 조회
SELECT COUNT(*) "전체 사원 수" FROM EMPLOYEE;
-- 남자 사원 수 조회
SELECT COUNT(*)"남자 사원 수"     --3
FROM EMPLOYEE                            --1
WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3'); --2
-- 여자 사원 수 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('2', '4');
-- 보너스 받는 사원 수 조회
SELECT COUNT(BONUS) FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

-- 부서 배치 받은 사원 수 조회 => 부서코드가 NULL이 아닌 행의 개수
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;

SELECT EMP_NAME, EXTRACT(DAY FROM HIRE_DATE) FROM EMPLOYEE;

-- 1. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT EMP_NAME 사원명, EMP_NO 주민번호, SUBSTR(EMP_NO, 1, 2) 생년
                                    , SUBSTR(EMP_NO, 3, 2) 생월
                                    , SUBSTR(EMP_NO, 5, 2) 생일
FROM EMPLOYEE;
-- 2. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
SELECT EMP_NAME 사원명, EMP_NO 주민번호,
    RPAD(SUBSTR(EMP_NO,1, 7), LENGTH((EMP_NO), '*') "주민번호",
    SUBSTR(EMP_NO, 1, 7) || '*******'
FROM EMPLOYEE;
-- 3. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--     (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT EMP_NAME 사원명
        , FLOOR(ABS(HIRE_DATE - SYSDATE))+1 근무일수1
        , TRUNC(ABS(SYSDATE - HIRE_DATE))+1 근무일수2
FROM EMPLOYEE;

-- 4. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = 1;
-- 5. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
--WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIREDATE) + 1 >=20;
-- WHERE TRUNC(SYSDATE - HIRE_DATE + 1)/ 365 >= 30;
-- WHERE ADD_MONTH(HIRE_DATE, 240) < SYSDATE;

-- 6. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L99,999,999') 급여--L : 언어 설정에 따라 화폐단위 표시
FROM EMPLOYEE;

-- 7. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
--     (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며 
--     나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
SELECT EMP_NAME, DEPT_CODE,
        SUBSTR(EMP_NO, 1, 2) || '년' || SUBSTR(EMP_NO, 3, 2) || '월' || SUBSTR(EMP_NO, 5, 2) || '일' 생년월일
        --TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1,6)), 'YY"년"MM"월"DD"일") 생년월일
        --, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RRRR'))+1 나이
FROM EMPLOYEE;
-- 8. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부, D6면 기획부, D9면 영업부로 처리
--     (단, 부서코드 오름차순으로 정렬)
SELECT EMP_ID, EMP_NAME, DEPT_CODE
    -- DECODE(DEPT_CODE, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부) 부서명
            CASE
                WHEN DEPT_CODE = 'D5' THEN '총무부'
                WHEN DEPT_CODE = 'D6' THEN '기획부'
                WHEN DEPT _CODE = 'D9' THEN '영업부'
                END "부서명"
FROM EMPLOYEE
WHERE DEPT_CODE IN(D5, D6, D9)
ORDER BY 3;

-- 9. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
--     주민번호 앞자리와 뒷자리의 합 조회
SELECT EMP_NAME, SUBSTR(EMP_NO, 1, 6) "주민번호 앞자리", SUBSTR(EMP_NO, 8) "주민번호 뒷자리" -- SUBSTR(DMP_NO, 8, 7)
       -- , TO_NUMBER(SUBSTR(EMP_NO, 1, 6))+TO_NUMBER(SUBSTR(EMP_NO, 8))
        , SUBSTR(EMP_NO, 1, 6)+SUBSTR(EMP_NO, 8)
FROM EMPLOYEE
WHERE EMP_ID = 201;
-- 10. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT SUM((SALARY+(SALARY*NVL(BONUS,0)))*12) "D5부서 연봉 합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 11. 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
-- 전체 직원 수, 1999년, 2000년, 2001년, 2004년
SELECT COUNT(*) "전체 직원 수"
        , COUNT (CASE
                    WHEN SUBSTR(HIRE_DATE, 1, 2)=99 THEN 1
                END) "1999년 입사 인원수"
        ,COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2000, 1)) "2000년 입사 인원수"
        ,COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2001, 1)) "2001년 입사 인원수"
        ,COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2004, 1)) "2004년 입사 인원수"
FROM EMPLOYEE;