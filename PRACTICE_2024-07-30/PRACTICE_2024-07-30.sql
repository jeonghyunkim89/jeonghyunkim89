-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; ����
	User C##TEST��(��) �����Ǿ����ϴ�.
	���� ������ �ϰ� ���� �� ���� (user C##TEST lacks CREATE SESSION privillege; logon denied ����)
*/

CREATE USER C##TEST IDENTIFIED BY 1234;
-- ���� ? ����� ������ ������ �Ŀ� ������ �ο����� �ʾҴ�.
-- �ذ��� ? ������ �������� ������ �Ŀ� �ش� ����ڿ� �ּ����� ����(CONNECT, RESOURCE)�� �ο������ �Ѵ�.
--          ������ �������� ������ �� CREATE SESSION ������ �ο������ �� GRANT CONNECT, RESOURCE TO C##TEST;

-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	���� �� ���̺��� �����Ͽ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�ϰ��� �Ѵ�.
	�̶� ������ SQL���� �Ʒ��� ���ٰ� ���� ��,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- ������ ���� ������ �߻��ߴ�.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ���� ? �����ϰ��� �ϴ� �� ���̺��� ����� ������ �ϴ� �÷����� �ٸ��Ƿ� JOIN~USING ������ ����� �� ����
--        TB_EMP�� JOBNO�� TB_JOB�� JOBCODE �÷� �̸��� �ٸ���.
-- �ذ��� ? JOIN~USING ������ JOIN~ON�������� ���� 
--          FROM TB_EMP
--              JOIN TB_JOB ON (JOBNO = JOBCODE);
