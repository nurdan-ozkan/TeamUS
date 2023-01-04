//list<Account> accList= [select id name from Account];
//map <id,Account> idToAccountMap= new map<id, Account>(accList);
// find the key items and iterate in the map, for(integer keyItem:mapA.keyset()){system.debug(keyitem);}
//find the values, for(string valueItem:mapA.values()){system.debug(valueItem);}

//map< account, list<Contact>> accToConMap= new map < account, list<Contact>>();
//Methods= put(key,value), putAll(fromMap), putAll(sobjectArray), remove(key), size(),values()
//clear(), clone(), containsKey(), isEmpty(), get(key), keyset()


/*1.Query 5 Account records into a list. Now iterate on a list and create a set of account Ids
and display values of the set.*/

//Query
// Query the Account records and store them in a list
List<Account> accountRecords = [SELECT Id FROM Account LIMIT 5];

// Create a set of Account IDs
Set<Id> accountIds = new Set<Id>();

// Iterate over the list of Account records and add the Ids to the set
for (Account record : accountRecords) {
    accountIds.add(record.Id);
}

// Display the values of the set
for (Id accountId : accountIds) {
    System.debug(accountId);
}


/*2.Query 5 Account records into a list. Now iterate on a list and create a map where key will
be account Id and value will Account sObject (using loop) and display values of map.*/

List <Account> acclist1 = New List <Account>();
acclist1 = [ select Id, Name from Account Limit 5 ];
Map <Id, Account> mapAcc= new map <Id,Account>(acclist1);
for ( id key: mapAcc.keyset()){
    Account acc= mapAcc.get(key);
    system.debug(acc);}

    
  List <Account> acclist1 = New List <Account>();
acclist1 = [ select Name from Account Limit 5 ];
Map <Id, Account> mapAcc= new map <Id,Account>(acclist1);
  system.debug(mapAcc.values());
list <Account> mapvalues= new list <Account>();
mapvalues= mapAcc.values();
for ( account a:mapvalues ){
    system.debug(a);
    
}
//query
// Query the Account records and store them in a list
List<Account> accountRecords = [SELECT  Name FROM Account LIMIT 5];

// Create a map of Account IDs to Account records
Map<Id, Account> accountMap = new Map<Id, Account>();

// Iterate over the list of Account records and add them to the map
for (Account record : accountRecords) {
    accountMap.put(record.Id, record);
    system.debug(record);
}
 //Display the values of the map
for (Account record : accountMap.values()) {
    System.debug(record);
}



//Map<Id, myObjectType> mapName = new Map <Id, myObjectType>();
//for (Id key: mapName.keyset()){
    //myObjectType theObject = mapname.get(key);
    //do something with theObject}//next key


/*3. Query 5 Account records into a list. Now iterate on a list and create a map where key will
be account Id and value will Account sObject (without using loop) and display values of
map.*/

   List <Account> acclist1 = New List <Account>();
acclist1 = [ select Name from Account Limit 5 ];
Map <Id, Account> mapAcc= new map <Id,Account>(acclist1);
    system.debug(mapAcc.values());


/*4. Query 5 Account records into a list. Now create a set of Account ID and Map <Id,
Account> using a list. Now iterate on set and check whether set values match with map
key, if yes then display map value.*/

List <Account> acclist1 = New List <Account>();
set <Id> set1Acc= new set <Id>();
acclist1 = [ select Id, Name from Account Limit 5 ];
Map <Id, Account> mapAcc= new map <Id,Account>(acclist1);
if (set1Acc=mapAcc.keyset()){   
      for(id i:set1Acc){
         
                 system.debug(i);
          
      }}
 
for ( id key: mapAcc.keyset()){
    Account acc= mapAcc.get(key);
    system.debug(acc);}

///////////////////////////////////////////////////////////////////////
///MELTEM HOCA
List<Account> accList = [SELECT Id,Name FROM Account LIMIT 5];
system.debug('accList: '+accList);
set<Id> accIds = new Set<Id>();
for(Account acc:accList){
accIds.add(acc.Id);
}
system.debug('Account Ids: '+accIds);

Map<Id,Account> accMap = new Map<Id,Account>(accList);

for(Id i : accIds){
if(accMap.containsKey(i)){
system.debug('Map Value: '+accMap.get(i));
}
}
  
/*5. Query This/Last Week created Accounts with related contacts.
[Hint: Parent-Child SOQL]*/
 
    list <account> accConLast= new list<Account>();
    accConLast=[ select id,Name, (select id,Name from contacts) from account where createdDate=LAST_N_DAYS:7 ];
    system.debug(accConLast);
    

/*6. Query This/Last Week created contacts with related account Name and Phone.
[Hint: Child-Parent SOQL]*/
    
    list <Contact> conAcc= new list <Contact>();
  conAcc =[select id, name, Phone,Account.Id, Account.Name from Contact where createdDate=LAST_N_DAYS:7];
       system.debug(conAcc);
    
   
/*7. Query Account (Id, Name, Phone) with Related Opportunities (Name, CloseDate, Stage)
where Account Phone != null. Sort the records in both Asc or Desc Order based on
CreatedDate.*/

list<Account> accOpp= new list <Account>([select id, name,phone,(select id,name, closeDate, StageName from Opportunities) 
                                          from Account where Phone!=null order by CreatedDate Asc]);
system.debug(accOpp);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
list<Account> accOppD= new list <Account>([select id, name,phone,(select id,name, closeDate, StageName from Opportunities) 
                                          from Account where Phone!=null order by CreatedDate Desc]);
system.debug(accOppD);
for (Account a:accOppD){/////this is extra, I want to see iterate version
    system.debug(a);
}
//////////////////////////////////////////////////////////////////////////////////////

/*8. Query Account along with related contacts where Account phone!=null. Now display
results through system.debug( ) in following ways:
Account Name has #ofcontacts related.*/

list <account> accConN= new list <Account>();
accConN=[select id, name, phone, (select id, name from contacts) from account where phone!=null];

for (Account a : accConN) {
    System.debug('Account Name: ' + a.Name + ' has ' + a.Contacts.size() + ' related contacts');
}


/*9. Query Account along with related opportunities where Account phone!=null. Now display
results through system.debug( ) in following ways:
Account Name has TotalAmountOnRelatedOpp worth Opportunities.*/

 list< account>  accOppA= new list< account>();
accOppA=[ select id, name, phone, (select id, name, Amount from opportunities)from account where phone!=null];

for(Account a:accOppA){
    Decimal totalAmount=0;
    for(Opportunity o:a.Opportunities ){
        totalAmount += o.Amount;
    }
    
   system.debug('Account Name:'+a.Name+' has'+totalAmount+' worth Opportunities');
}

/*10 Create 2 Account records with two separate insert statements. Then create 2 Account
records with a single insert DML statement using List.*/

Account acc1=new account();
acc1.Name='apex1';
insert acc1;
Account acc2=new account();
acc2.Name='apex2';
insert acc2;
List<Account> multiAcc=new List<account>();
for(integer i=3; i<5; i++){
    Account acc=new Account(name='Apex'+i);
    multiAcc.add(acc);
}
insert multiAcc;

------------------11--------------
List <Account> MultiAccList= New List <Account>();
for (integer AccNum=3; AccNum<=4; AccNum ++){
    Account NewAcc=New Account();
        NewAcc.Name='DENEME' + AccNum;
        NewAcc.Phone= '1234' ;
        NewAcc.Type='Customer - Direct';
        NewAcc.AnnualRevenue=10000;
        NewAcc.Industry='Agriculture';
    MultiAccList.add(NewAcc);
}
for (Account listAcc:MultiAccList){
    system.debug(listAcc);
}
insert   MultiAccList;

-------------12------------------
list<opportunity> opplist= new list<opportunity>();
for( integer i=6;i<10;i++){
    opportunity o= new opportunity(name='Test Opportunity'+i, CloseDate= date.today() , StageName='Prospecting' );
        system.debug(o);  
    opplist.add(o);
}
insert opplist;

    --------------------13------------

Account a=new Account();
 	a.name='kizlar';
	insert a;
	system.debug(a);
    Contact c=new Contact();
    c.LastName='lets';
	c.AccountId=a.Id;
   	insert a;
	system.debug(c);

    ----------------14----------------
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


-------------------15------------------
 List<Account> accList = new List<Account>();
List<Opportunity> oppList = new List<Opportunity>();
for(Integer i=1;i<=5;i++){
Account acc = new Account();
acc.Name= 'Insert Account '+i;
accList.add(acc);
}
insert accList;
for(Account acc: accList){
for(Integer i=1;i<=3;i++){
Opportunity opp = new Opportunity();
opp.Name = acc.Name+ i;
opp.CloseDate = date.today()+15;
opp.StageName = 'Qualification';
opp.AccountId = acc.Id;
oppList.add(opp);
}
}
insert oppList;

--------------------16------------------
List<Account> accList=new List<account>();
for(integer i=5; i<10; i++){
    Account acc=new Account ();
	acc.Name='8 Account Each Related Con&Opp '+i ;
    accList.add(acc); 
}
insert accList;
List<Opportunity> oppList=new List<Opportunity>();
List<Contact> conList=new List<Contact>();
for(integer i=0; i<5; i++){
    Opportunity opp=new Opportunity();
	opp.AccountId=accList[i].Id;
	opp.Name='8 Opportunity Each Related Con&Opp';
	opp.CloseDate=Date.TODAY();
	opp.StageName='Prospecting';
    oppList.add(opp);
    Contact con=new contact();
	con.AccountId=accList[i].Id;
	con.lastName='8 Contact Each Related Con&Opp';
	conList.add(con);
}
insert conList;
insert oppList;

/* 11. Insert 5 Accounts by populating Name, Phone, Type, Annual Revenue and Industry Field
Values. [Hint: Use Loop]

12. Insert 5 Opportunities with different Opportunity Names, CloseDate = Today’s Date and
Stage = ‘Prospecting’. [Hint: Use Loop]

13. Insert an Account along with 1 related Contact.

14. Insert an Account along with 1 related Contact and 1 related Opportunity.

15. Insert 5 Accounts with at least 1 related Opportunity. [Hint: Use Loop and List]

16. Insert 5 Accounts and a Contact & a Opportunity related to each account.
[Hint: Use Loop and List]

---------------------------

17. Query Accounts where Phone =’123456’ and update Phone to ’654321’.

18. Query Contacts where Email is null and update their email with
‘welcome@studysalesforce.com.

19. Query Accounts where Phone =654321 and update Phone to 123456. Also create 5 new
account records. [Hint : Use Upsert Statement]

20. Query Opportunities where created date is last month and updated their stage to closed
won. Also create 5 new opportunities. [Hint: Use Upsert Statement]

21. Delete account records where Phone =’123456’. Verify whether records are deleted
through Recycle Bin.

22. Undelete account records deleted in previous step. Check recycle bin is not having those
records and they will be under the accounts tab in the app.
*/

/*23.23. Insert 200 Account records and your code should not hit the governor limit. Once records
are successfully created then just delete those 200 records only.*/


17. Query Accounts where Phone ='123456' and update Phone to '654321'.
List<Account> accList =new List <Account> ([select id, phone from account where phone='123456']);
for(Account acc:accList){
    acc.Phone='654321';
}
update accList;

18. Query Contacts where Email is null and update their email with
'welcome@studysalesforce.com.
List<contact> conList =new List <Contact> ([select id, email from contact where email=null]);
for(Contact con:conList){
   con.Email='welcome@studysalesforce.com';
}
update conList;

    
19. Query Accounts where Phone =654321 and update Phone to 123456. Also create 5 new
account records. [Hint : Use Upsert Statement]
List<Account> accList =new List <Account> ([select id, phone from account where phone='654321']); 
for(Account acc:accList){
    acc.Phone='123456';
}
for(integer i=1; i<6; i++){
    Account acc=new Account(name='Q19 '+i);
    accList.add(acc);
}
upsert accList;

/*20. Query Opportunities where created date is last month and updated their stage to closed
won. Also create 5 new opportunities. [Hint: Use Upsert Statement]*/
List<Opportunity> oppList =new List<Opportunity>
([select id, Name, CreatedDate, StageName, CloseDate from Opportunity where CreatedDate = Last_N_Months:2 or CreatedDate = THIS_MONTH]); 
for(Opportunity opp:oppList){
    opp.StageName='Closed Won';
}
for(integer i=1; i<6; i++){
    Opportunity op=new Opportunity(Name='Q19 '+i, StageName='Closed', CloseDate=Date.Today());
    oppList.add(op);
}
upsert oppList;

//CreatedDate >= Last_N_Months:3 AND CreatedDate <= today
//CreatedDate >=: last_n_month AND CreatedDate <=: today order by CreatedDate DESC

21. Delete account records where Phone ='123456'. Verify whether records are deleted
through Recycle Bin.
List<Account> accList =new List <Account> ([select id, phone from account where phone='123456']);
delete accList;
22. Undelete account records deleted in previous step. Check recycle bin is not having those
records and they will be under the accounts tab in the app.
Account[] accList =[select id, phone from Account where phone='123456' ALL ROWS];
undelete accList;

23. Insert 200 Account records and your code should not hit the governor limit. Once records
are successfully created then just delete those 200 records only.
List<Account> accList=new List<account>();
for(integer i=0; i<2; i++){
    Account acc=new Account ();
	acc.Name='Q23 dont hit governor '+i ;
    accList.add(acc); 
}
insert accList;
List<Account> accList =new List <Account> ([select id, name from account where name like:'Q23%' limit 200]);
delete accList;
List<Account> accList =new List <Account> ([select id, name from account order by CreatedDate desc limit 2]);
delete accList;

