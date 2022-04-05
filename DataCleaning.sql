select *  FROM [Profile].[dbo].[Nashvillehousing]


select SaleDateConverted , CONVERT (date,[SaleDate])
from [Profile].[dbo].[Nashvillehousing]

Update [Profile].[dbo].[Nashvillehousing]
SET [SaleDate] = CONVERT(date,[SaleDate])

ALTER table [Profile].[dbo].[Nashvillehousing]
ADD SaleDateConverted Date;

Update [Profile].[dbo].[Nashvillehousing]
SET SaleDateConverted = CONVERT(date,[SaleDate])

select *
from [Profile].[dbo].[Nashvillehousing]
--where [PropertyAddress] is null
order by [ParcelID]

select a.[ParcelID], a.[PropertyAddress], b.[ParcelID],b.[PropertyAddress], ISNULL(a.[PropertyAddress],b.[PropertyAddress])
from [Profile].[dbo].[Nashvillehousing] a
Join [Profile].[dbo].[Nashvillehousing] b
	on a.[ParcelID] = b.[ParcelID]
	And a.[UniqueID ]<>b.[UniqueID ]
where a.[PropertyAddress] is null

update a
set [PropertyAddress] = ISNULL (a.[PropertyAddress],b.[PropertyAddress])
from [Profile].[dbo].[Nashvillehousing] a
     
Join [Profile].[dbo].[Nashvillehousing] b
	on a.[ParcelID] = b.[ParcelID]
	And a.[UniqueID ]<>b.[UniqueID ]
where a.[PropertyAddress] is null

select  [PropertyAddress]
from [Profile].[dbo].[Nashvillehousing]
--where [PropertyAddress] is null
--order by [ParcelID]

Select 
SUBSTRING([PropertyAddress],1, CHARINDEX(',',[PropertyAddress])-1) as Address
,SUBSTRING([PropertyAddress], CHARINDEX(',',[PropertyAddress])+1, LEN([PropertyAddress])) Address
from [Profile].[dbo].[Nashvillehousing]

ALTER table [Profile].[dbo].[Nashvillehousing]
add PropertySplitAddress varchar(255);

Update [Profile].[dbo].[Nashvillehousing]
SET PropertySplitAddress =SUBSTRING([PropertyAddress],1, CHARINDEX(',',[PropertyAddress])-1) 

ALTER table [Profile].[dbo].[Nashvillehousing]
add PropertySplitCity varchar(255);


Update [Profile].[dbo].[Nashvillehousing]
SET PropertySplitCity = SUBSTRING([PropertyAddress], CHARINDEX(',',[PropertyAddress])+1, LEN([PropertyAddress]))

select * from [Profile].[dbo].[Nashvillehousing]


select [OwnerAddress] from [Profile].[dbo].[Nashvillehousing]


select 
PARSENAME(REPLACE([OwnerAddress],',','.'), 1)
,PARSENAME(REPLACE([OwnerAddress],',','.'), 2)
,PARSENAME(REPLACE([OwnerAddress],',','.'), 3)
from [Profile].[dbo].[Nashvillehousing]

ALTER table [Profile].[dbo].[Nashvillehousing]
add OwnerSplitAddress varchar(255);

Update [Profile].[dbo].[Nashvillehousing]
SET OwnerSplitAddress =PARSENAME(REPLACE([OwnerAddress],',','.'), 3) 

ALTER table [Profile].[dbo].[Nashvillehousing]
add OwnerSplitCity varchar(255);


Update [Profile].[dbo].[Nashvillehousing]
SET OwnerSplitCity = PARSENAME(REPLACE([OwnerAddress],',','.'), 2)

ALTER table [Profile].[dbo].[Nashvillehousing]
add OwnerSplitState varchar(255);

Update [Profile].[dbo].[Nashvillehousing]
SET OwnerSplitState =PARSENAME(REPLACE([OwnerAddress],',','.'), 1) 

select * from [Profile].[dbo].[Nashvillehousing]

select Distinct [SoldAsVacant],COUNT( [SoldAsVacant])
from [Profile].[dbo].[Nashvillehousing]
Group by [SoldAsVacant]
order by 2

Select [SoldAsVacant]
, CASE when [SoldAsVacant] ='Y' Then 'Yes'
		when [SoldAsVacant] = 'N' Then 'No'
		ELSE [SoldAsVacant]
		END
		from [Profile].[dbo].[Nashvillehousing]

update [Profile].[dbo].[Nashvillehousing]
 SET [SoldAsVacant] = CASE when [SoldAsVacant] ='Y' Then 'Yes'
		when [SoldAsVacant] = 'N' Then 'No'
		ELSE [SoldAsVacant]
		END

WITH RowNumCTE As(
Select *,
ROW_NUMBER() OVER (
Partition by [ParcelID],
			[PropertyAddress],
			[SaleDate],
			[SalePrice],
			[LegalReference]
			ORDER BY
			UniqueID
			) row_num
from [Profile].[dbo].[Nashvillehousing] --order by ParcelID
)
Select * from RowNumCTE
where row_num >1
--order by [PropertyAddress]

select * from [Profile].[dbo].[Nashvillehousing]

Alter table [Profile].[dbo].[Nashvillehousing]
Drop column [SaleDate]