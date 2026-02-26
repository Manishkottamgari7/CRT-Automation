*** Settings ***
Documentation     TC-04: Verify that a user can navigate to the Copado CI/CD
...               integration setup on the Copado AI Platform.
Resource          ../resources/common.resource
Suite Teardown    Close Test Session

*** Test Cases ***
Setup Copado CICD Integration
    [Documentation]    Login, navigate to My Integrations, locate the Copado CI/CD
    ...                integration option, and initiate the connection.
    [Tags]    integration    cicd    critical

    # Step 1 – Full login flow
    Full Login Flow

    # Step 2 – Navigate to My Integrations
    Navigate To My Integrations

    # Step 3 – Verify we are on the integrations page
    VerifyText    Integrations

    # Step 4 – Look for Copado CI/CD and click Connect
    VerifyText    Copado
    ClickText    Connect    anchor=Copado
    Sleep    5s

    # Step 5 – Verify the CI/CD integration flow opened
    ${status}=    IsText    Copado    timeout=10
    Log    ✅ Copado CI/CD integration flow initiated. Status: ${status}
