<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EmailAlertOnPatchDeployment</fullName>
        <description>EmailAlertOnPatchDeployment</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Flosum/PatchDeployTemplate</template>
    </alerts>
    <alerts>
        <fullName>EmailAlertOnPatchValidate</fullName>
        <description>EmailAlertOnPatchValidate</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Flosum/PatchValidateTemplate</template>
    </alerts>
    <alerts>
        <fullName>EmailAlertOnTestExecution</fullName>
        <description>EmailAlertOnTestExecution</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Flosum/TestExecutionTemplate</template>
    </alerts>
    <rules>
        <fullName>OnPatchDeployment</fullName>
        <actions>
            <name>EmailAlertOnPatchDeployment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( ISBLANK(Build__c) ,  Job_Completed__c ,   OR( TEXT( Process_Type__c) = &apos;Deployment&apos;,  TEXT( Process_Type__c) = &apos;Rollback (Deployment)&apos;,  TEXT( Process_Type__c) = &apos;Schedule Deployment&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OnPatchValidate</fullName>
        <actions>
            <name>EmailAlertOnPatchValidate</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Metadata_Log__c.Process_Type__c</field>
            <operation>equals</operation>
            <value>Validate,Rollback (Validate)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Metadata_Log__c.Job_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OnTestExecution</fullName>
        <actions>
            <name>EmailAlertOnTestExecution</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Metadata_Log__c.Process_Type__c</field>
            <operation>equals</operation>
            <value>Test Execution</value>
        </criteriaItems>
        <criteriaItems>
            <field>Metadata_Log__c.Job_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
