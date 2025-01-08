trigger OpportunityTrigger on Opportunity (after insert,after update,after delete,after undelete) 
{
   OpportunityTriggerHandler obj = New OpportunityTriggerHandler();
   obj.doAction();
}
---------------------------------------------------------------------------------------------------------------------------------------------------
public class OpportunityTriggerHandler 
{
  List<Opportunity> triggernew;
  List<Opportunity> triggerold;
  Map<Id,Opportunity> triggeroldmap;
  Map<Id,Opportunity> triggernewmap;
  Public OpportunityTriggerHandler()
  {
     triggernew =(List<Opportunity>)trigger.new;
     triggerold =(List<Opportunity>)trigger.old;
     triggeroldmap =(Map<id,Opportunity>)trigger.oldmap;
     triggernewmap =(Map<id,Opportunity>)trigger.newmap;
  }
  Public Void doAction()
  {
    Switch On Trigger.Operationtype
    {
      When AFTER_INSERT
      {
       maxonopportunityamounttoUpdateonAccount(triggernew);  
      }
       When AFTER_UPDATE
      {
      maxonopportunityamounttoUpdateonAccount(triggernew);   
      }
       When AFTER_UNDELETE
      {
      maxonopportunityamounttoUpdateonAccount(triggernew);    
      }
       When AFTER_DELETE
      {
       maxonopportunityamounttoUpdateonAccount(triggerold);
      }
    }
  }
  Public Void maxonopportunityamounttoUpdateonAccount(List<Opportunity> opprecordlist)
  {
    Set<id> accids = New Set<Id>();
    for(Opportunity oppnewRecord :opprecordlist)
    {
      If(Trigger.isUpdate && oppnewRecord.AccountId != triggeroldmap.get(oppnewRecord.Id).AccountId)
      {
        accids.add(oppnewRecord.AccountId);
        accids.add(triggeroldmap.get(oppnewRecord.Id).AccountId);
      }
      If(oppnewRecord.AccountId != Null)
      {
        accids.add(oppnewRecord.AccountId);   
      }
    }
   List<Account> opprecordToUpdate = New List<Account>();
   List<AggregateResult> aggrlist = [SELECT AccountId,Max(Amount) maxamount FROM Opportunity WHERE AccountId IN :accids Group By AccountId];
   for(AggregateResult aggr : aggrlist)
   {
       Account accRecord = New Account();
       accRecord.Id =(Id)aggr.get('AccountId');
       accRecord.Max_Opportunity_Amount__c =(Decimal)aggr.get('maxamount');
       opprecordToUpdate.add(accRecord);
   }
   If(! opprecordToUpdate.IsEmpty())
   {
     Update opprecordToUpdate;
   }
  }
}
