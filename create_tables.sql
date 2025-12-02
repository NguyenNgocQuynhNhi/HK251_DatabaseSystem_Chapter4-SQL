-- -- Xóa bảng cũ nếu tồn tại (để chạy lại không lỗi)
-- IF OBJECT_ID('EMP', 'U') IS NOT NULL DROP TABLE EMP;
-- IF OBJECT_ID('SALGRADE', 'U') IS NOT NULL DROP TABLE SALGRADE;
-- IF OBJECT_ID('DEPT', 'U') IS NOT NULL DROP TABLE DEPT;

-- 1. Tạo bảng Phòng ban (DEPT)
CREATE TABLE DEPT (
    DEPTNO INT NOT NULL,          -- Mã phòng ban
    DNAME  NVARCHAR(50),          -- Tên phòng ban
    LOC    NVARCHAR(50),          -- Địa điểm
    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
);

-- 2. Tạo bảng Mức lương (SALGRADE)
CREATE TABLE SALGRADE (
    GRADE INT NOT NULL,           -- Mức lương
    LOSAL INT,                    -- Lương thấp nhất
    HISAL INT,                    -- Lương cao nhất
    CONSTRAINT PK_SALGRADE PRIMARY KEY (GRADE)
);

-- 3. Tạo bảng Nhân viên (EMP)
CREATE TABLE EMP (
    EMPNO    INT NOT NULL,        -- Mã nhân viên
    ENAME    NVARCHAR(50),        -- Tên nhân viên
    JOB      NVARCHAR(50),        -- Nghề nghiệp
    MGR      INT,                 -- Mã người quản lý
    HIREDATE DATE,                -- Ngày vào làm
    SAL      DECIMAL(10, 2),      -- Lương
    DEPTNO   INT NOT NULL,        -- Mã phòng ban
    
    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
    CONSTRAINT FK_EMP_DEPT FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO),
    CONSTRAINT FK_EMP_MGR FOREIGN KEY (MGR) REFERENCES EMP(EMPNO)
);