CREATE DATABASE CSI
USE CSI
-- Step 1: Create the table
CREATE TABLE FileSystem (
    NodeID INT PRIMARY KEY,
    NodeName VARCHAR(255),
    ParentID INT,
    SizeBytes INT
);

-- Step 2: Insert the data
INSERT INTO FileSystem (NodeID, NodeName, ParentID, SizeBytes) VALUES
(1, 'Documents', NULL, NULL),
(2, 'Pictures', NULL, NULL),
(3, 'File1.txt', 1, 500),
(4, 'Folder1', 1, NULL),
(5, 'Image.jpg', 2, 1200),
(6, 'Subfolder1', 4, NULL),
(7, 'File2.txt', 4, 750),
(8, 'File3.txt', 6, 300),
(9, 'Folder2', 2, NULL),
(10, 'File4.txt', 9, 250);

-- Step 3: Use Recursive CTE to calculate the total sizes
WITH RECURSIVE FolderSizes AS (
    SELECT 
        NodeID,
        NodeName,
        COALESCE(SizeBytes, 0) AS TotalSize,
        ParentID
    FROM FileSystem
    UNION ALL

    SELECT 
        f.NodeID,
        f.NodeName,
        COALESCE(fs.TotalSize, 0) + COALESCE(f.SizeBytes, 0) AS TotalSize,
        f.ParentID
    FROM FileSystem f
    JOIN FolderSizes fs ON f.ParentID = fs.NodeID
)
-- Step 4: Aggregate the results
SELECT 
    NodeID,
    NodeName,
    SUM(TotalSize) AS sizeBytes
FROM FolderSizes
GROUP BY NodeID, NodeName
ORDER BY NodeID;
