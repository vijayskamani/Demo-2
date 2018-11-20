/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ScheduleUpdateRecords implements Database.Batchable<SObject> {
    global Flosum.ModelGlobal.GitRepoCredentialsWrapper activeRepo;
    global Flosum.ModelGlobal.GitRepoCredentialsWrapper oldActiveRepo;
    global String query;
    global void execute(Database.BatchableContext BC, List<Flosum__RepositoryCredentials__c> scope) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
