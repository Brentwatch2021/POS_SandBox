/* =========================================
   INSERT STORES
========================================= */

INSERT INTO pos_Store
(
    StoreName,
    StoreLocation,
    IsStoreActive,
    StoreCreatedAt
)
VALUES
('NovaMart Cape Town', '12 Long Street, Cape Town CBD, Western Cape', 1, GETUTCDATE()),
('BluePeak Retail', 'Century Boulevard, Century City, Western Cape', 1, GETUTCDATE()),
('Urban Basket Claremont', '25 Main Road, Claremont, Western Cape', 1, GETUTCDATE()),
('Coastal Trade Hub', '88 Blaauwberg Road, Table View, Western Cape', 1, GETUTCDATE()),
('Oakline Market', '7 Church Street, Stellenbosch, Western Cape', 1, GETUTCDATE()),
('MetroSquare Sandton', '158 Rivonia Road, Sandton, Gauteng', 1, GETUTCDATE()),
('Velocity Retail Rosebank', '14 Oxford Road, Rosebank, Gauteng', 1, GETUTCDATE()),
('Capital Grocers Pretoria', '210 Church Street, Pretoria, Gauteng', 1, GETUTCDATE()),
('PrimeStack Distribution', '5 Richards Drive, Midrand, Gauteng', 1, GETUTCDATE()),
('HarbourView Retail', '45 Umhlanga Rocks Drive, Durban North, KZN', 1, GETUTCDATE()),
('Sunline Market Umhlanga', '1 Palm Boulevard, Umhlanga, KZN', 1, GETUTCDATE()),
('BaySide Traders', '90 Main Road, Gqeberha, Eastern Cape', 1, GETUTCDATE()),
('GoldFields Retail', '55 Nelson Mandela Drive, Bloemfontein, Free State', 1, GETUTCDATE()),
('NorthPoint Supplies', '18 Market Street, Polokwane, Limpopo', 1, GETUTCDATE()),
('Platinum Retail Group', '34 Nelson Mandela Street, Rustenburg, North West', 1, GETUTCDATE()),
('Lowveld Market Hub', '22 Brown Street, Mbombela, Mpumalanga', 1, GETUTCDATE()),
('Diamond Edge Retail', '11 Du Toitspan Road, Kimberley, Northern Cape', 1, GETUTCDATE()),
('Training Environment Store', 'Internal Training Environment', 0, GETUTCDATE()),
('QA Simulation Branch', 'Quality Assurance Sandbox', 0, GETUTCDATE()),
('Legacy Warehouse Archive', 'Deprecated Warehouse Location', 0, GETUTCDATE()),
('QuickCart Express', 'Sea Point Promenade, Cape Town', 1, GETUTCDATE()),
('Skyline Convenience', 'Voortrekker Road, Bellville', 1, GETUTCDATE()),
('Terminal One Retail', 'Cape Town International Airport', 1, GETUTCDATE()),
('Nomad Mobile Store', 'Temporary Event Location', 1, GETUTCDATE()),
('SummerWave Pop-Up', 'Camps Bay Beachfront', 0, GETUTCDATE());

GO


/* =========================================
   INSERT ROLES
========================================= */

DECLARE @ManagerRoleId INT;
DECLARE @CashierRoleId INT;

INSERT INTO pos_Role
(
    RoleName,
    IsRoleActive,
    RoleCreatedAt
)
VALUES
(
    'Manager',
    1,
    GETUTCDATE()
);

SET @ManagerRoleId = SCOPE_IDENTITY();

INSERT INTO pos_Role
(
    RoleName,
    IsRoleActive,
    RoleCreatedAt
)
VALUES
(
    'Cashier',
    1,
    GETUTCDATE()
);

SET @CashierRoleId = SCOPE_IDENTITY();


/* =========================================
   SAMPLE FIRST NAMES
========================================= */

DECLARE @FirstNames TABLE
(
    Id INT IDENTITY(1,1),
    FirstName NVARCHAR(50)
);

INSERT INTO @FirstNames (FirstName)
VALUES
('Liam'),
('Noah'),
('Ethan'),
('Mason'),
('Lucas'),
('James'),
('Logan'),
('Daniel'),
('Matthew'),
('Benjamin'),
('Michael'),
('David'),
('Elijah'),
('Alexander'),
('Jacob'),
('Ryan'),
('Nathan'),
('Samuel'),
('Gabriel'),
('Luke'),
('Emma'),
('Olivia'),
('Sophia'),
('Ava'),
('Mia'),
('Charlotte'),
('Amelia'),
('Harper'),
('Ella'),
('Grace'),
('Chloe'),
('Lily'),
('Zoe'),
('Hannah'),
('Layla'),
('Scarlett'),
('Aria'),
('Nora'),
('Leah'),
('Samantha');


/* =========================================
   SAMPLE LAST NAMES
========================================= */

DECLARE @LastNames TABLE
(
    Id INT IDENTITY(1,1),
    LastName NVARCHAR(50)
);

INSERT INTO @LastNames (LastName)
VALUES
('Smith'),
('Johnson'),
('Williams'),
('Brown'),
('Jones'),
('Garcia'),
('Miller'),
('Davis'),
('Wilson'),
('Moore'),
('Taylor'),
('Anderson'),
('Thomas'),
('Jackson'),
('White'),
('Harris'),
('Martin'),
('Thompson'),
('Young'),
('Walker'),
('Hall'),
('Allen'),
('King'),
('Wright'),
('Scott'),
('Green'),
('Baker'),
('Adams'),
('Nelson'),
('Hill'),
('Campbell'),
('Mitchell'),
('Roberts'),
('Carter'),
('Phillips'),
('Evans'),
('Turner'),
('Parker'),
('Collins'),
('Edwards');


/* =========================================
   CONFIGURATION
========================================= */

DECLARE @ManagersPerStore INT = 100;
DECLARE @CashiersPerStore INT = 1000;


/* =========================================
   STORE TEMP TABLE
========================================= */

DECLARE @Stores TABLE
(
    RowNum INT IDENTITY(1,1),
    StoreId INT
);

INSERT INTO @Stores (StoreId)
SELECT StoreId
FROM pos_Store;


/* =========================================
   VARIABLES
========================================= */

DECLARE @CurrentStoreId INT;
DECLARE @CurrentUserId INT;

DECLARE @Counter INT;

DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);

DECLARE @FullName NVARCHAR(150);
DECLARE @Username NVARCHAR(150);


/* =========================================
   GENERATE MANAGERS
========================================= */

DECLARE @StoreLoop INT = 1;
DECLARE @StoreCount INT;

SELECT @StoreCount = COUNT(*)
FROM @Stores;

WHILE @StoreLoop <= @StoreCount
BEGIN

    SELECT
        @CurrentStoreId = StoreId
    FROM @Stores
    WHERE RowNum = @StoreLoop;

    SET @Counter = 1;

    WHILE @Counter <= @ManagersPerStore
    BEGIN

        SELECT TOP 1
            @FirstName = FirstName
        FROM @FirstNames
        ORDER BY NEWID();

        SELECT TOP 1
            @LastName = LastName
        FROM @LastNames
        ORDER BY NEWID();

        SET @FullName =
            CONCAT(@FirstName, ' ', @LastName, ' (Manager)');

        SET @Username =
            LOWER(
                CONCAT(
                    @FirstName,
                    '.',
                    @LastName,
                    @CurrentStoreId,
                    @Counter
                )
            );

        INSERT INTO pos_User
        (
            StoreId,
            Username,
            FullName,
            PasswordHash,
            IsUserActive,
            UserCreatedAt
        )
        VALUES
        (
            @CurrentStoreId,
            @Username,
            @FullName,
            HASHBYTES('SHA2_256', 'password'),
            1,
            GETUTCDATE()
        );

        SET @CurrentUserId = SCOPE_IDENTITY();

        INSERT INTO pos_UserRole
        (
            UserID,
            RoleID,
            AssignedAt
        )
        VALUES
        (
            @CurrentUserId,
            @ManagerRoleId,
            GETUTCDATE()
        );

        SET @Counter = @Counter + 1;

    END;

    SET @StoreLoop = @StoreLoop + 1;

END;


/* =========================================
   GENERATE CASHIERS
========================================= */

SET @StoreLoop = 1;

WHILE @StoreLoop <= @StoreCount
BEGIN

    SELECT
        @CurrentStoreId = StoreId
    FROM @Stores
    WHERE RowNum = @StoreLoop;

    SET @Counter = 1;

    WHILE @Counter <= @CashiersPerStore
    BEGIN

        SELECT TOP 1
            @FirstName = FirstName
        FROM @FirstNames
        ORDER BY NEWID();

        SELECT TOP 1
            @LastName = LastName
        FROM @LastNames
        ORDER BY NEWID();

        SET @FullName =
            CONCAT(@FirstName, ' ', @LastName, ' (Cashier)');

        SET @Username =
            LOWER(
                CONCAT(
                    @FirstName,
                    '.',
                    @LastName,
                    @CurrentStoreId,
                    @Counter
                )
            );

        INSERT INTO pos_User
        (
            StoreId,
            Username,
            FullName,
            PasswordHash,
            IsUserActive,
            UserCreatedAt
        )
        VALUES
        (
            @CurrentStoreId,
            @Username,
            @FullName,
            HASHBYTES('SHA2_256', 'password'),
            1,
            GETUTCDATE()
        );

        SET @CurrentUserId = SCOPE_IDENTITY();

        INSERT INTO pos_UserRole
        (
            UserID,
            RoleID,
            AssignedAt
        )
        VALUES
        (
            @CurrentUserId,
            @CashierRoleId,
            GETUTCDATE()
        );

        SET @Counter = @Counter + 1;

    END;

    SET @StoreLoop = @StoreLoop + 1;

END;

GO