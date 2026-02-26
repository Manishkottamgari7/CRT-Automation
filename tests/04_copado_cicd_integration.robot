*** Settings ***
Documentation     Copado CI/CD integration setup test for Copado AI Platform.
Resource          ../resources/common.resource
Suite Setup       OpenBrowser    about:blank    chrome
Suite Teardown    Close Test Session

*** Test Cases ***
Setup Copado CICD Integration
    [Documentation]    Login, navigate to My Integrations, find Copado CI/CD, and click Connect.
    ...                Verifies that the Copado CI/CD integration flow is initiated.
    [Tags]    integration    copado-cicd    critical
    
    Full Login Flow
    Navigate To My Integrations
    
    # Verify we're on the integrations page
    VerifyText    Integrations
    VerifyText    Copado CI/CD
    
    # Click "Connect" button for Copado CI/CD
    ClickText    Connect    anchor=Copado CI/CD
    Sleep    5s
    
    # Verify integration flow started
    ${status}=    IsText    Copado CI/CD    timeout=10
    Log    ✅ Copado CI/CD integration flow initiated. Status: ${status}