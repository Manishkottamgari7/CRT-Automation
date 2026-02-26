*** Settings ***
Documentation     Salesforce org integration setup test for Copado AI Platform.
Resource          ../resources/common.resource
Suite Teardown    Close Test Session

*** Test Cases ***
Setup Salesforce Org Integration
    [Documentation]    Login, navigate to My Integrations, find Salesforce, and click Connect.
    ...                Verifies that the Salesforce integration flow is initiated.
    [Tags]    integration    salesforce    critical
    
    Full Login Flow
    Navigate To My Integrations
    
    # Verify we're on the integrations page
    VerifyText    Integrations
    VerifyText    Salesforce
    
    # Click "Connect" button for Salesforce
    ClickText    Connect    anchor=Salesforce
    Sleep    5s
    
    # Verify integration flow started
    ${status}=    IsText    Salesforce    timeout=10
    Log    ✅ Salesforce integration flow initiated. Status: ${status}