WITH CTE_Product AS
(
	SELECT Id, Price, ROW_NUMBER() OVER(ORDER BY Id) as Num
	FROM [Filter].[Product]
)
SELECT Id, Price
FROM CTE_Product
WHERE Num between 101 and 201
GO

SELECT Id, Price
FROM [Filter].[Product]
ORDER BY Id
OFFSET 100 ROWS FETCH NEXT 200 ROWS ONLY