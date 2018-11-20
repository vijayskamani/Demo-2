<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EmailAlertOnOrgRegistration</fullName>
        <description>EmailAlertOnOrgRegistration</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Flosum/OrgRegisterTemplate</template>
    </alerts>
    <rules>
        <fullName>OnOrgRegistration</fullName>
        <actions>
            <name>EmailAlertOnOrgRegistration</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
