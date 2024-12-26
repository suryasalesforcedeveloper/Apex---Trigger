//Trigger Scenario : Whenever the Account Record is Created check wheather the Account name already existed or not,if so Prevent the duplication

Trigger on - Account
Event - Before Insert

//Handler
public class AccountTriggerHandler 
{
   List<Account> triggernew;
   List<Account> triggerold;
   Map<Id,Account> triggernewmap;
   Map<Id,Account> triggeroldmap;
   
   Public AccountTriggerHandler()
   {
     triggernew = (List<Account>)trigger.new;
     triggerold = (List<Account>)trigger.old;
     triggeroldmap = (Map<id,Account>)trigger.oldmap;
     triggernewmap = (Map<Id,Account>)trigger.newmap;
   }
    
   Public Void doAction()
   {
     Switch On Trigger.Operationtype
     {
       When BEFORE_INSERT
       {
          duplicationpreventionAccountName(); 
       }
     }
   }
  Public Void duplicationpreventionAccountName()
  {
    Set<String> accaddName = New Set<String>();
    for(Account accnewRecord : triggernew)
    {
      If(accnewRecord.Name != Null)
      {
        accaddName.add(accnewRecord.Name);
      }
    }
    Set<String> existingRecord = New Set<String>();
    List<Account> acclist = [SELECT Name FROM Account WHERE Name IN :accaddName];
    for(Account accoldRecord : acclist)
    {
      If(accoldRecord.Name != Null)
      {
        existingRecord.add(accoldRecord.Name);
      }
    }
    for(Account accnewRecord : triggernew)
    {
      If(existingRecord.contains(accnewRecord.Name))
      {
         accnewRecord.Name.AddError('AccountRecod is already existed'); 
      }
    }
  }
    
}
