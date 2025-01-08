
Salesforce Trigger Scenarios:

## 01.Account to Contact Field Update:
Write a trigger to update the Phone field of all related Contact records whenever the Phone field of an Account is updated.

## 02.Contact to Account Field Update:
Write a trigger to update the Description field of the related Account record whenever the Description field of a Contact is updated.

## 03.Account Duplication Prevention:
Write a trigger to prevent the creation of duplicate Account records by checking if an Account with the same Name already exists. If a duplicate is detected, throw an appropriate error 

## 04. Aggregate (count) - Contact:
Write a reusable and bulk-safe Apex Trigger Handler for the Contact object to update the total number of associated contacts on the related Account whenever a Contact is inserted, updated, deleted, or undeleted. Ensure that the solution adheres to Salesforce governor limits and handles edge cases like account reassignment during updates.

## 05.Aggregate (count) - Opportunity:
Write a reusable and bulk-safe Apex Trigger Handler for the Opportunity object to update the total number of associated opportunities on the related Account whenever an Opportunity is inserted, updated, deleted, or undeleted. Ensure that the solution adheres to Salesforce governor limits and handles edge cases such as opportunities being reassigned to different accounts during updates.

## 06.Aggregate (Count) - Case:
Write a reusable and bulk-safe Apex Trigger Handler for the Case object to update the total number of associated Cases on the related Account. Specifically, the No_of_Cases__c field on the Account should reflect the count of all related Cases.

The trigger should handle the following scenarios:

Insert: When a new Case is created.
Update: When a Case is updated, including changes to the AccountId (e.g., reassignment of Cases to a different Account).
Delete: When a Case is deleted.
Undelete: When a deleted Case is restored.

Ensure the solution adheres to Salesforce governor limits, processes records in bulk, and handles edge cases, such as Cases being reassigned to different Accounts during updates.

## 07.Limit Contact Creation for Accounts:

Write a trigger handler class that ensures no more than two Contact records can be created for a given Account. If a user attempts to insert a Contact for an Account that already has two Contact records, the trigger should throw an error with an appropriate message.

Requirements:
Use a trigger handler approach to keep the logic modular and reusable.
The trigger should operate on the BEFORE_INSERT context.
Leverage SOQL to count existing Contact records associated with the Account.
Provide a clear and user-friendly error message if the limit is exceeded.

## 08 Aggregate (max) - Opportunity:
Write a reusable and bulk-safe Apex Trigger Handler for the Opportunity object to update the Max_Opportunity_Amount__c field on the related Account whenever an Opportunity is inserted, updated, deleted, or undeleted. Ensure that the solution adheres to Salesforce governor limits and handles edge cases such as Opportunities being reassigned to different Accounts during updates.













