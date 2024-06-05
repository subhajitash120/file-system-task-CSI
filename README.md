# file-system-task-CSI


Create a temporary table to store cumulative sizes.
Initialize the table with the sizes of individual files.
Iteratively update the sizes of folders by summing the sizes of their child nodes.

Explanation:

Base Case: Select the files with their sizes.
Recursive Case: Join the parent folders with their child nodes, accumulating the total size.
Final Selection: Group by NodeID and NodeName to get the total sizes for each folder.

This approach ensures that all folders will have the correct cumulative sizes, including the sizes of their subfolders and files.
