Trigger Object = Case
DML Event = After insert,after update,after delete,after undelete

trigger CaseTrigger on Case (after insert,after update,after delete,after undelete) 
{
   CaseHandlerTrigger obj = New CaseHandlerTrigger();
   obj.doAction();
}
------------------------------------------------------------------------------------------------------------------------------------------------------------
public class CaseHandlerTrigger 
{
  List<Case> triggernew;
  List<Case> triggerold;
  Map<Id,Case> triggernewmap;
  Map<Id,Case> triggeroldmap;
  
    Public CaseHandlerTrigger()
    {
      triggernew =(List<Case>)trigger.new;
      triggerold =(List<Case>)trigger.old;
      triggeroldmap=(Map<Id,Case>)trigger.oldmap;
      triggernewmap=(Map<Id,Case>)trigger.newmap;
    }
  Public Void doAction()
  {
     Switch On trigger.Operationtype
     {
       When AFTER_INSERT
       {
        countCaseUpdatetoAccount(triggernew);   
       }
       When AFTER_UPDATE
       {
        countCaseUpdatetoAccount(triggernew);   
       }
       When AFTER_UNDELETE
       {
       countCaseUpdatetoAccount(triggernew);    
       }
       When AFTER_DELETE
       {
        countCaseUpdatetoAccount(triggerold);   
       }
     }
  }
  Public Void countCaseUpdatetoAccount(List<Case> csrecordlist)
  {
   Set<Id> accIds = New Set<Id>();
   for(Case csRecord : csrecordlist)
   {
     If(Trigger.IsUpdate && csRecord.AccountId != triggeroldmap.get(csRecord.Id).AccountId)
     {
       accIds.add(csRecord.AccountId);
       accIds.add(triggeroldmap.get(csRecord.Id).AccountId);
     }
     else If(csRecord.AccountId != Null)
     {
       accIds.add(csRecord.AccountId);   
     }
   }
   List<Account> updateToAccount = New List<Account>();
   List<AggregateResult> csnewRecord = [SELECT AccountId,Count(Id) totalcase FROM Case WHERE AccountId IN :accIds GROUP BY AccountId];
   for(AggregateResult aggrlist : csnewRecord)
   {
     Account accRecord = New Account();
     accRecord.Id =(Id)aggrlist.get('AccountId');
     accRecord.No_of_Contact__c =(Decimal)aggrlist.get('totalcase');
     updateToAccount.add(accRecord);
   }
   If(! updateToAccount.IsEmpty())
   {
     Update updateToAccount;
   }
  }
}
