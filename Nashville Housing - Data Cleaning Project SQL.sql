--Doing this project in MySQL

SELECT * 
FROM nashville_housing;

DESCRIBE nashville_housing;

SELECT COUNT(*) 
FROM nashville_housing;

SHOW TABLE STATUS LIKE 'nashville_housing';


# 1 Standarize Sale Date Column

SELECT SaleDate, STR_TO_DATE(SaleDate, '%Y-%m-%d') AS ConvertedDate
FROM nashville_housing;

ALTER TABLE nashville_housing
Add ConvertedDate date;

UPDATE nashville_housing
set ConvertedDate = STR_TO_DATE(SaleDate, '%Y-%m-%d');

SELECT SaleDate, ConvertedDate FROM nashville_housing;

# 2 Populating Propierty Address 

SELECT PropertyAddress
FROM nashville_housing;

SELECT *
FROM nashville_housing
WHERE PropertyAddress = 'nan';

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM nashville_housing a
JOIN nashville_housing b
	ON a.ParcelID = b.ParcelID
    AND a.Unique_ID <> b.Unique_ID
WHERE a.PropertyAddress = 'nan' or null;


UPDATE nashville_housing a
JOIN nashville_housing b
    ON a.ParcelID = b.ParcelID
    AND a.Unique_ID <> b.Unique_ID
SET a.PropertyAddress = b.PropertyAddress
WHERE a.PropertyAddress = 'nan';



# 3. Breaking Out Property Address into Individual Columns

select PropertyAddress
from nashville_housing;

SELECT 
    SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) AS Address,
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1) AS FullAddress
FROM nashville_housing;


ALTER TABLE nashville_housing
ADD PropertySplitAddress nvarchar(255);

ALTER TABLE nashville_housing
ADD PropertySplitCity nvarchar(255);

UPDATE nashville_housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

UPDATE nashville_housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1);

SELECT PropertySplitCity, PropertySplitAddress, PropertyAddress
FROM nashville_housing;


# 4. Breaking Out Owner Address into Individual Columns

SELECT OwnerAddress
from nashville_housing;

SELECT 
    SUBSTRING_INDEX(OwnerAddress, ',', 1) AS 'Street Address',
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1)) AS 'City',
    TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1)) AS 'State'
FROM nashville_housing;

ALTER TABLE nashville_housing
ADD OwnerStreetAddress nvarchar(255);

ALTER TABLE nashville_housing
ADD OwnerCity nvarchar(255);

ALTER TABLE nashville_housing
ADD OwnerState nvarchar(255);

UPDATE nashville_housing
SET OwnerStreetAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

UPDATE nashville_housing
SET OwnerCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1));

UPDATE nashville_housing
SET OwnerState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));

SELECT OwnerStreetAddress, OwnerCity, OwnerState, OwnerAddress
FROM nashville_housing;



# 5. Change Y and N to Yes and Nos in SoldAsVacant

select distinct(SoldAsVacant)
from nashville_housing;

select distinct(SoldAsVacant), count(SoldAsVacant)
from nashville_housing
group by SoldAsVacant
Order by 2;

SELECT SoldAsVacant,
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END AS SoldAsVacantStandard
FROM nashville_housing;

UPDATE nashville_housing
SET SoldAsVacant = CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;




# 6. Remove Duplicates - it is not standard practice to delete data, this is for demonstration purposes.

SELECT *,
	ROW_NUMBER() OVER(
    PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
                SaleDate,
                LegalReference
                ORDER BY 
					Unique_ID
                    ) row_num
FROM nashville_housing
ORDER BY ParcelID;

WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY 
                TRIM(ParcelID), 
                TRIM(PropertyAddress), 
                SalePrice, 
                SaleDate, 
                LegalReference
            ORDER BY 
                Unique_ID
        ) AS row_num
    FROM nashville_housing
)
SELECT * 
FROM RowNumCTE
WHERE row_num > 1; -- This was returning 103 rows, now retunrs 0. Working on Microsoft SQL Server Managment I could have used the DELETE function within the CTE, making this much simpler.

CREATE TEMPORARY TABLE temp_nashville_housing AS
SELECT *
FROM nashville_housing
WHERE Unique_ID IN (
    SELECT MIN(Unique_ID)
    FROM nashville_housing
    GROUP BY 
        TRIM(ParcelID), 
        TRIM(PropertyAddress), 
        SalePrice, 
        SaleDate, 
        LegalReference
);

DELETE FROM nashville_housing
WHERE Unique_ID NOT IN (
    SELECT Unique_ID FROM temp_nashville_housing
);

DROP TABLE temp_nashville_housing;


# 7. Delete Unused Columns - it is not standard practice to delete columns, this is for demonstration purposes.

SELECT * FROM nashville_housing;

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress, 
DROP COLUMN PropertyAddress, 
DROP COLUMN SaleDate;
