trigger OpportunityTrigger on Opportunity (After insert,After Update,After delete,After undelete)
{
 OpportunityTriggerHandler obj = New OpportunityTriggerHandler();
 obj.doAction();
}
-------------------------------------------------------------------------------------------------------------------
public class OpportunityTriggerHandler 
{
   List<Opportunity> triggernew;
   List<Opportunity> triggerold;
   Map<id,Opportunity> triggeroldmap;
   Map<Id,Opportunity> triggernewmap;
    
  Public OpportunityTriggerHandler()
  {
     triggernew = (List<Opportunity>)trigger.new;
     triggerold = (List<Opportunity>)trigger.old;
     triggernewmap = (Map<Id,Opportunity>)trigger.newmap;
     triggeroldmap = (Map<Id,Opportunity>)trigger.oldmap;
  }
  Public Void doAction()
  {
    Switch On trigger.Operationtype
    {
      When AFTER_INSERT
      {
       countopportunityupdateToAccount(triggernew);   
      }      
      When AFTER_UPDATE
      {
       countopportunityupdateToAccount(triggernew);   
      }      
      When AFTER_UNDELETE
      {
       countopportunityupdateToAccount(triggernew);   
      }     
      When AFTER_DELETE
      {
      countopportunityupdateToAccount(triggerold);  
      }
    }
  }
    Public Void countopportunityupdateToAccount(List<Opportunity> opprecordlist)
    {
      Set<Id> accIds = New Set<Id>();
      for(Opportunity oppnewRecord : opprecordlist)
      {
       if(trigger.isUpdate && oppnewRecord.AccountId != triggeroldmap.get(oppnewRecord.Id).AccountId)
       {
        accIds.add(oppnewRecord.AccountId);
        accIds.add(triggeroldmap.get(oppnewRecord.Id).AccountId);
       }
       else if(oppnewRecord.AccountId != Null)
       {
        accIds.add(oppnewRecord.AccountId);
       }
      }
      List<Account> accRecordUpdate = New List<Account>();
      List<AggregateResult> oppnewRecord = [SELECT AccountId,Count(Id) totalcount FROM Opportunity WHERE AccountId IN :accIds GROUP BY AccountId];
      for(AggregateResult aggr : oppnewrecord)
      {
       Account accRecord = New Account();
       {
        accRecord.Id =(Id)aggr.get('AccountId');
        accRecord.Max_Opportunity_Amount__c =(Decimal)aggr.get('totalcount');
        accRecordUpdate.add(accRecord);
       }
      }
      If(!accRecordUpdate.isEmpty())
      {
        Update accRecordUpdate;
      }
    }
}
