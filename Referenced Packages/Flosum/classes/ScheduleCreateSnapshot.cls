/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class ScheduleCreateSnapshot implements Database.AllowsCallouts, Database.Batchable<SObject>, Database.Stateful {
    global Boolean isKeysUpdateNeeded;
    global List<Flosum.ModelGlobal.Job> jobList;
    global String query;
    global ScheduleCreateSnapshot(Id orgId, String commitId, Id snapShootId, List<Flosum.ModelGlobal.Job> jobList) {

    }
    global void execute(Database.BatchableContext BC, List<Flosum__HerokuCredentials__c> hc) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
