public class AccountTriggerHandler 
{
  List<Account> triggernew;
  List<Account> triggerold;
  Map<Id,Account> triggeroldmap;
  Map<Id,Account> triggernewmap;
    
  Public AccountTriggerHandler()
  {
   triggernew = (List<Account>)trigger.new;
   triggerold = (List<Account>)trigger.old;
   triggeroldmap = (Map<Id,Account>)trigger.oldmap;
   triggernewmap = (Map<Id,Account>)trigger.newmap;
  }
  Public Void doAction()
  {
   Switch On Trigger.Operationtype
   {
     When AFTER_UPDATE
     {
       updatePhonefieldtoContact();  
     }
   }
  }
  Public Void updatePhonefieldtoContact()
  {
    Map<Id,String> addaccid = New Map<Id,String>();
    for(Account accRecord : triggernew)
    {
      If(accRecord.Id != Null && accRecord.Phone != Null && accRecord.Phone != triggeroldmap.get(accRecord.Id).Phone)
      {
       addaccid.put(accRecord.Id,accRecord.Phone);
      }
    }
    List<Contact> updateToContact = New List<Contact>();
    List<Contact> conRecord = [SELECT AccountId,Phone FROM Contact WHERE AccountId IN : addaccid.keyset()];
    for(Contact connewRecord : conRecord)
    {
      connewRecord.Phone = addaccid.get(connewRecord.AccountId);
      updateToContact.add(connewRecord);
    }
    try
    {
      If(!updateToContact.IsEmpty())
      {
      Update UpdateToContact;
      }
    }
    catch(Exception e)
    {
      system.debug(e.getMessage());   
    }
  }
}
