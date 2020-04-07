USE AdventureWorks
GO

CREATE TABLE Sales.MediaOutlet
(
MediaOutletID INT NOT NULL,
MediaOutletName NVARCHAR(40) NOT NULL,
Contact NVARCHAR(50) NOT NULL,
City NVARCHAR(50) NOT NULL
);


CREATE TABLE Sales.PrintMediaPlacement
(
PrintMediaPlacementID INT NOT NULL,
MediaOutletID INT NOT NULL,
ProductID INT NOT NULL,
PublicationDate DATETIME NOT NULL,
PlacementDate DATETIME NOT NULL,
PlacementCost DECIMAL(18,2) NOT NULL
);



ALTER TABLE Sales.MediaOutlet ADD CONSTRAINT IX_MediaOutlet UNIQUE CLUSTERED (MediaOutletID);
ALTER TABLE Sales.PrintMediaPlacement ADD CONSTRAINT IX_PrintMediaPlacement UNIQUE CLUSTERED (PrintMediaPlacementID);


DECLARE @start int=1, @end int=32767;With MediaIDS( Number ) as
(
    SELECT @start as Number
    union all
    SELECT Number + 1
    from MediaIDS
    where Number < @end
)

INSERT INTO Sales.MediaOutlet
(MediaOutletID,MediaOutletName,Contact,City)

    SELECT Number, 
    NEWID() Name, 
    NEWID() Contact,
    NEWID() City
    from MediaIDS Option (MaxRecursion 32767);

;With MediaIDS( Number ) as
(
    SELECT @start as Number
    union all
    SELECT Number + 1
    from MediaIDS
    where Number < @end
)

INSERT INTO Sales.PrintMediaPlacement
           (PrintMediaPlacementID,MediaOutletID,PlacementDate,PublicationDate,ProductID,PlacementCost)

SELECT Number,
ABS(CHECKSUM(NewId())) % 32767 MediaID,
GETDATE() - ABS(CHECKSUM(NewId())) % 365,
GETDATE() - ABS(CHECKSUM(NewId())) % 365,
ABS(CHECKSUM(NewId())) % 32767 ProductID,
RAND(ABS(CHECKSUM(NewId())) % 32767)*1000
from MediaIDS Option (MaxRecursion 32767);

SELECT PMP.*, MO.City 
FROM Sales.PrintMediaPlacement PMP
JOIN Sales.MediaOutlet MO ON PMP.MediaOutletID=MO.MediaOutletID
WHERE PublicationDate BETWEEN '2015-09-1' AND '2015-09-30'
AND PlacementCost BETWEEN 1 AND 2000
ORDER BY PlacementCost DESC;


CREATE NONCLUSTERED INDEX NCI_PrintMediaPlacement
ON [Sales].[PrintMediaPlacement] ([PublicationDate],[PlacementCost])
INCLUDE ([MediaOutletID],[PlacementDate],[ProductID])



GO

