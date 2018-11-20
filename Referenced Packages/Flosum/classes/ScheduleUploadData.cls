/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ScheduleUploadData implements Database.AllowsCallouts, Database.Batchable<SObject>, Database.Stateful {
    global List<Id> attIds;
    global Boolean isKeysUpdateNeeded;
    global String query;
    global Boolean toClean;
    global ScheduleUploadData(List<Id> attIds, Boolean toClean) {

    }
    global void execute(Database.BatchableContext BC, List<Flosum__HerokuCredentials__c> hc) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
