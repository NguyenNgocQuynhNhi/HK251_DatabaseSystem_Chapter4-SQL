-- 1. Tạo bảng Phòng ban (DEPT) trước vì bảng EMP sẽ tham chiếu đến nó
CREATE TABLE DEPT (
    DEPTNO INT NOT NULL,        -- Đổi NUMBER(2) -> INT
    DNAME  NVARCHAR(50),        -- Đổi CHAR -> NVARCHAR để hỗ trợ tiếng Việt nếu cần
    LOC    NVARCHAR(50),        -- Đổi CHAR -> NVARCHAR
    CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
);

-- 2. Tạo bảng Mức lương (SALGRADE)
CREATE TABLE SALGRADE (
    GRADE INT NOT NULL,         -- Đổi NUMBER -> INT
    LOSAL INT,                  -- Lương thấp nhất
    HISAL INT,                  -- Lương cao nhất
    CONSTRAINT PK_SALGRADE PRIMARY KEY (GRADE)
);

-- 3. Tạo bảng Nhân viên (EMP)
CREATE TABLE EMP (
    EMPNO    INT NOT NULL,          -- Đổi NUMBER(4) -> INT
    ENAME    NVARCHAR(50),          -- Tên nhân viên
    JOB      NVARCHAR(50),          -- Nghề nghiệp
    MGR      INT,                   -- Mã người quản lý (tham chiếu chính bảng này)
    HIREDATE DATE,                  -- Ngày vào làm
    SAL      DECIMAL(10, 2),        -- Đổi NUMBER(7,2) -> DECIMAL (Lương có số lẻ)
    DEPTNO   INT NOT NULL,          -- Mã phòng ban
    
    -- Tạo khóa chính
    CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
    
    -- Tạo khóa ngoại liên kết với bảng DEPT
    CONSTRAINT FK_EMP_DEPT FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO),
    
    -- Tạo khóa ngoại tự tham chiếu (Người quản lý cũng là nhân viên)
    CONSTRAINT FK_EMP_MGR FOREIGN KEY (MGR) REFERENCES EMP(EMPNO)
);

