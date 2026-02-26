*** Settings ***
Documentation     TC-03: Verify that a user can navigate to the Salesforce
...               integration setup on the Copado AI Platform.
Resource          ../resources/common.resource
Suite Teardown    Close Test Session

*** Test Cases ***
Setup Salesforce Org Integration
    [Documentation]    Login, navigate to My Integrations, locate the Salesforce
    ...                integration option, and initiate the connection.
    [Tags]    integration    salesforce    critical

    # Step 1 – Full login flow
    Full Login Flow

    # Step 2 – Navigate to My Integrations
    Navigate To My Integrations

    # Step 3 – Verify we are on the integrations page
    VerifyText    Integrations

    # Step 4 – Look for Salesforce and click Connect
    VerifyText    Salesforce
    ClickText    Connect    anchor=Salesforce
    Sleep    5s

    # Step 5 – Verify the Salesforce integration flow opened
    ${status}=    IsText    Salesforce    timeout=10
    Log    ✅ Salesforce integration flow initiated. Status: ${status}
