trigger ContactTrigger on Contact (before insert)
{
  ContactTriggerHandler obj = New ContactTriggerHandler();
  obj.doAction();
}
--------------------------------------------------------------------------------------------------------------------

public class ContactTriggerHandler 
{
    List<Contact> triggernew;
    List<Contact> triggerold;
    Map<Id,Contact> triggeroldmap;
    Map<Id,Contact> triggernewmap;
   
  Public ContactTriggerHandler()
  {
    triggernew =(List<Contact>)trigger.new;
    triggerold =(List<Contact>)trigger.old;
    triggernewmap = (Map<Id,Contact>)trigger.oldmap;
    triggeroldmap = (Map<Id,Contact>)trigger.newmap;
  }
  Public Void doAction()
  {
    Switch On trigger.Operationtype
    {
      When BEFORE_INSERT
      {
       countContactaddError();   
      }
    }
  }
  Public Void countContactaddError()
  {
   Set<Id> accIds = New Set<Id>();
   for(Contact conRecord : triggernew)
   {
     If(conRecord.AccountId != Null)
     {
      accIds.add(conRecord.AccountId);   
     }
   }
  Map<Id,Integer> countContact = New Map<Id,Integer>();
  List<AggregateResult> connewRecord = [SELECT AccountId,Count(Id) totalcontact FROM Contact Where AccountId IN :accIds GROUP BY AccountId];
  for(AggregateResult aggrlist : connewRecord)
  {
    countContact.put((Id)aggrlist.get('AccountId'),(Integer)aggrlist.get('totalcontact'));
  }
  for(Contact conRecord : triggernew)
  {
    If(conRecord.AccountId != Null && countContact.get(ConRecord.AccountId)>= 2 )
    {
      conRecord.AddError('You cant Insert Contactalready two contact present');   
    }
  }
  }
}
