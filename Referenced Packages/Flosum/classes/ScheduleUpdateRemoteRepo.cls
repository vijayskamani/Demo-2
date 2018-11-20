/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ScheduleUpdateRemoteRepo implements Database.AllowsCallouts, Database.Batchable<SObject>, Database.Stateful {
    global String cName;
    global Boolean isKeysUpdateNeeded;
    global String message;
    global String query;
    global ScheduleUpdateRemoteRepo(Flosum__Sync_Job__c curJob) {

    }
    global ScheduleUpdateRemoteRepo(String commitName, String commitDescription, String brName, Integer counter) {

    }
    global void execute(Database.BatchableContext BC, List<Flosum__Component_History__c> newList) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
