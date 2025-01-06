
Salesforce Trigger Scenarios:

## 01.Account to Contact Field Update:
Write a trigger to update the Phone field of all related Contact records whenever the Phone field of an Account is updated.

## 02.Contact to Account Field Update:
Write a trigger to update the Description field of the related Account record whenever the Description field of a Contact is updated.

## 03.Account Duplication Prevention:
Write a trigger to prevent the creation of duplicate Account records by checking if an Account with the same Name already exists. If a duplicate is detected, throw an appropriate error 

## 04. Aggregate (count) - Contact:
Write a reusable and bulk-safe Apex Trigger Handler for the Contact object to update the total number of associated contacts on the related Account whenever a Contact is inserted, updated, deleted, or undeleted. Ensure that the solution adheres to Salesforce governor limits and handles edge cases like account reassignment during updates.






