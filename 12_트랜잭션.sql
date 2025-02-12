--트랜잭션 (작업의 논리적 단위)
-- DML구문에 대해서만 트랜잭션 적용가능

-- 오토커밋 상태 확인
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

--세이브 포인트 (별로 안쓰임)

COMMIT;
select * from depts;
delete from Depts WHERE DEPARTMENT_ID = 10;
SAVEPOINT DEL10;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;
SAVEPOINT DEL20;

ROLLBACK to DEL10; --> 에코궁임 걍 ㅇㅇ; 단, 커밋 이후에는 세이브포인트 사용못함
