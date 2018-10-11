
SELECT TOP (1) WITH TIES S.Id, S.Price
FROM [Filter].[Product] S
ORDER BY S.Price DESC

;WITH SalesOrder AS
(
	SELECT * ,
	case Max(Price) OVER() when Price then 1 else 0 end AS IsMax
	FROM [Filter].[Product]
)
SELECT S.Id , S.Price
FROM SalesOrder AS S
WHERE S.IsMax = 1


;WITH SalesOrder AS
(
	SELECT max(Price) AS MaxPrice
	FROM [Filter].[Product]
)
SELECT S.Id, S.Price
FROM [Filter].[Product] S inner join SalesOrder on S.Price = SalesOrder.MaxPrice


SELECT S.Id, S.Price
FROM [Filter].[Product] S
WHERE S.Price = (SELECT max(Price) AS MaxPrice
	FROM [Filter].[Product])

