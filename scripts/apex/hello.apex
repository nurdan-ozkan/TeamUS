Account acc = new Account(Name = 'Hilton');
insert acc;

//Associated Contacts

Contact con = new Contact(firstName = 'Nur', lastName = 'Blue', accountid = acc.Id);

//Contact con2 = 
//List<Contact> conList = new List<Contact>();
//conList.add(con);
//insert conList;

insert con;

//Associated Opportunities

Date d = Date.today() + 60;
Opportunity opp = new Opportunity(Name = 'Hilton SLA', StageName = 'Prospecting', CloseDate = d , accountid = acc.id);

insert opp; 
