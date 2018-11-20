<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EmailAlertOnSnapshotCompletion</fullName>
        <description>EmailAlertOnSnapshotCompletion</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Flosum/SnapshotCompletionTemplate</template>
    </alerts>
    <rules>
        <fullName>OnSnapshotComplete</fullName>
        <actions>
            <name>EmailAlertOnSnapshotCompletion</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Snapshot__c.Is_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
