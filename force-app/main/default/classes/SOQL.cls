/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author ARIEL TAHIMIK
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    //[public | private ] [static] data_type getAllLeads (input parameters) {
    public static List<Lead> getAllLeads() {
        List <Lead> leads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return leads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    public static List<Contact> getContactsByFirstName() {
        //List<Contact> conList = [SELECT Name FROM Contact WHERE FirstName = 'John'];
        //return conList;
        return (List<Contact>)[SELECT Name FROM Contact WHERE FirstName = 'John'];
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    public static List<ID> getContactIdsByLastName() {
        // Query 
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName IN ('Smith', 'Jones')];

        // Create List<ID> to add IDs from contacts
        List<ID> contactIds = new List<ID>();

        // Add Contact Ids to the List
        for (Contact c : contacts) {
            contactIds.add(c.Id);
        }

        return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunityCountByAccount(String accId) {        
        List<Opportunity> oppList = [SELECT Id, Name, StageName, AccountId, CloseDate, Amount 
                                    FROM Opportunity 
                                    WHERE AccountId = :accId 
                                    AND StageName = 'Closed Won'];
        return oppList;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer getAccountCount(List<Account> acc) {
        return acc.size();
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTasksDueNextWeek() {
        Date today = Date.today();
        Date nextWeek = today.addDays(7);

        List<Task> tasks = [SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate >= :today AND ActivityDate <= :nextWeek];
        Map<Id,Task> taskMap = new Map<Id,Task>();

        for (Task t : tasks) {
            taskMap.put(t.Id, t);
        }
        return taskMap;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmailDomain() {
        List<Contact> contacts = [SELECT Name, FirstName, LastName, Email FROM Contact WHERE Email LIKE '%example.com'];
        return contacts;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String searchKeyword = '%' + keyword + '%';
        List<Opportunity> result = [
            SELECT Name, StageName, CloseDate, AccountId 
            FROM Opportunity
            WHERE Name LIKE :searchKeyword];
        return result; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> getCases = [SELECT Origin FROM Case WHERE Origin NOT IN ( 'Web', 'Email', '' )];
        return getCases;
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String source, String keyword) {
        String searchKeyword = '%' + keyword + '%';
        List<Lead> leads = [
            SELECT LastName, Company, Phone, Email, LeadSource, Title 
            FROM Lead 
            WHERE LeadSource = :source OR Title LIKE :searchKeyword];
        System.debug(leads);
        return leads;
    }

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE AccountId = :accountId];
        List<String> lastNames = new List<String>();

        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        for (Contact c : contacts) {
            lastNames.add(c.LastName);           
        }

        // Return the list of Contact LastNames
        return lastNames; // Replace null with the variable you used to store the result
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        AggregateResult[] totalRevenue = [
            SELECT SUM(Amount)total FROM Opportunity 
            WHERE StageName = :stage OR Amount >= 10000];

        // Return the total revenue
        return (Decimal) totalRevenue[0].get('total'); // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        return  [SELECT Name FROM Account ORDER BY Name LIMIT 10];
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        return [SELECT Amount, CloseDate FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate LIMIT 5]; 
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        return [SELECT Birthdate FROM Contact WHERE Birthdate != null ORDER BY Birthdate DESC LIMIT 3];
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        //return null; // Replace null with the variable you used to store the result
        return [SELECT CreatedDate, Status FROM Case WHERE Status = 'Open' ORDER BY CreatedDate LIMIT 10 OFFSET 5];
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> caseIds = new Set<Id>();

        // Query the Cases
        List<Case> cases = [SELECT Id FROM Case WHERE AccountId = :accountId];
        // Loop through each Case and add the Id to the set
        for (Case c : cases) {
            caseIds.add(c.Id);
        }

        return caseIds;
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);
        }

        return accountIdsToNames;
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        return [SELECT Account.Name FROM Contact WHERE Id = :contactId][0].Account.Name;
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        return [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];        
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account acc = [SELECT Name, BillingState FROM Account WHERE Id = :accountId];

        // Store the Account's BillingState
        String billingState = acc.BillingState;

        // Query the Contacts
        List<Contact> contacts = [SELECT MailingState FROM Contact WHERE MailingState = :billingState];
        return contacts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leads = [SELECT Id, Name, Email FROM Lead WHERE Id IN :leadIds];

        // Create a set of email domains from the Leads
        Set<String> emailDomains = new Set<String>();

        // Loop through each Lead
        for (Lead lead : leads) {
            // Get the email from the Lead
            String email = lead.Email;             

            // Check if the email is not null
            if (email != null) {
                // Add the email domain to the set
                emailDomains.add('www.' + email.substringAfter('@'));
            }
        }
        
        // Query the Accounts
        List<Account> accountsWebsite = [SELECT Id, Name, Website FROM Account WHERE Website IN :emailDomains];
        return accountsWebsite;
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> origOLIs = [SELECT Id, Name, Quantity, UnitPrice, OpportunityId, PriceBookEntryId
                                    FROM OpportunityLineItem
                                    WHERE OpportunityId = :origOppId];

        // Create a list to hold the new line items
        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Integer randomNumber = (Integer)Math.floor((Math.random() * 3) + 1);                

        // Loop through each cloned Opportunity Id
        for (Id cId : cloneOppIds) {

            // Loop through each original line item
            for (OpportunityLineItem oli : origOLIs) {

                // Clone the original line item and add the random number to the quantity
                OpportunityLineItem newOli = oli.clone(false, false, false, false);                   
                newOli.Quantity += randomNumber;
                newOli.OpportunityId = cId;
                lineItems.add(newOli);
            }
        }

        // Insert the new line items
        insert lineItems;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        return [SELECT Id, Name, AccountId, Account.Name, OwnerId FROM Opportunity WHERE StageName = 'Closed Won'];
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> opportunities = SOQL.getOpportunityDetailsForClosedWon();

        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIDs = new Set<Id>();
        for (Opportunity opp : opportunities) {
            if (opp.AccountId != null) {
                accountIDs.add(opp.AccountId);
            }
        }

        // Query the Contacts
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIDs];

        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id, Contact> accountToContactMap = new Map<Id, Contact>();
        for (Contact contact : contacts) {
            accountToContactMap.put(contact.AccountId, contact);
        }
        
        // Loop through each Opportunity
        for (Opportunity opp : opportunities) {
            // Update the Opportunity primary contact from accountToContactMap
            Contact primaryContact = accountToContactMap.get(opp.AccountId);
            opp.Primary_Contact__c = primaryContact.Id;
        }
        // Update the Opportunities
        update opportunities;
    }
}