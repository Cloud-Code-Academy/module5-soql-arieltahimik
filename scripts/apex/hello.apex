
// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

//string tempvar = 'Enter_your_name_here';
//System.debug('Hello World!');
//System.debug('My name is ' + tempvar);

// String contactId = '003ak000000Z2gYAAS';
// List<Contact> con = [SELECT Account.Name FROM Contact WHERE Id = :contactId];
// System.debug('\n\n'+con[0].Account.Name+'\n\n');

// List<Lead> leads = [SELECT Id, Name, Email FROM Lead];
// System.debug('\n' + leads + '\n\n');
// for(Lead l : leads) {
//     if (String.isBlank(l.Email)) {
//         continue;
//     }
//     String domain = 'www.' + l.Email.substringAfter('@');
//     System.debug('Id: ' + l.Id);
//     System.debug('Name: ' + l.Name);
//     System.debug('Email: ' + l.Email);
//     System.debug('Domain: ' + domain + '\n');
// }

// Create a Set of Lead IDs
// Set<Id> ids = (new Map<Id, Lead>([SELECT Id FROM Lead])).keySet();
// System.debug('\n\n' + ids + '\n\n');

// System.debug('\n\nwww.' + 'bertha@fcof.net'.substringAfter('@'));

// Create an Opportunity Line Item (Product)
// These 4 are the bare minimum information needed before you can insert the record.
// Make sure you are looking at the PriceBookEntry url
// OpportunityLineItem oli = new OpportunityLineItem();
// oli.Quantity = 1;
// oli.UnitPrice = 100;
// oli.OpportunityId = '006ak000000beTVAAY';
// oli.PricebookEntryId = '01uak000000GQhpAAG';
// insert oli;
// System.debug('\n\nOLI: ' + oli + '\n\n');

// CLONE OPPORTUNITY LINE ITEMS
// https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_sobject.htm#apex_System_SObject_clone
// Id is hard coded for testing only.(Burlington Textiles Weaving Plant Generator)
// UnitPrice was left for proof that the cloned records have different unit price,
// you can get rid of that line also.
// Using clone() make sure the preserveId is false to allow records to be inserted
// Id oppId = '006ak000000beTVAAY';
// List<OpportunityLineItem> olis = [SELECT Id, Name, Quantity, UnitPrice, OpportunityId, PriceBookEntryId
//                                     FROM OpportunityLineItem
//                                     WHERE OpportunityId = :oppId];
// List<OpportunityLineItem> clonedOlis = new List<OpportunityLineItem>();
// for (OpportunityLineItem oli : olis) {
//     OpportunityLineItem newOli = oli.CLONE(false, false, false, false);
//     newOli.UnitPrice = oli.UnitPrice + 1337;
//     clonedOlis.add(newOli);
// }
// insert clonedOlis;

// ANOTHER WAY OF CLONING
// Id = null will make the records in memory (olis) available for inserting/cloning
// Id oppId = '006ak000000beTVAAY';
// List<OpportunityLineItem> olis = [SELECT Id, Name, Quantity, UnitPrice, OpportunityId, PriceBookEntryId
//                                     FROM OpportunityLineItem
//                                     WHERE OpportunityId = :oppId];
// List<OpportunityLineItem> clonedOlis = new List<OpportunityLineItem>();
// for (OpportunityLineItem oli : olis) {
//     oli.Id = null;
//     oli.Quantity = 5;
//     clonedOlis.add(oli);
// }
// insert clonedOlis;

Integer randomNum = (Integer)Math.floor((Math.random() * 3) + 1);
System.debug('\n\nRandom Number: ' + randomNum + '\n\n');