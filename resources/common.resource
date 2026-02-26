*** Settings ***
Documentation     Shared keywords for the Copado AI Platform CRT test suite.
...               Uses QWeb library (QWords) for text-based element interaction.
Library           QWeb
Variables         ../variables/env.py

*** Variables ***
${WORKSPACE_NAME}     My Workspace

*** Keywords ***
Open Copado And Login
    [Documentation]    Open browser, navigate to login page, and enter credentials.
    OpenBrowser    ${BASE_URL}    ${BROWSER}
    VerifyText    Log in to Copado
    TypeText    Email    ${COPADO_USERNAME}
    TypeText    Password    ${COPADO_PASSWORD}
    ClickText    LOGIN
    # After login we land on CRT dashboard
    Sleep    5s

Navigate To AI Platform
    [Documentation]    Navigate to Copado AI Platform after login.
    
    # Wait for page to fully load after login
    Sleep    3s
    
    # Click app launcher - try multiple selectors
    ${clicked}=    Run Keyword And Return Status    ClickElement    xpath=//button[@title='App Launcher']
    Run Keyword Unless    ${clicked}    ClickElement    xpath=//div[@class='slds-icon-waffle']
    Sleep    2s
    
    # Search for Copado AI in the app launcher
    TypeText    Search apps and items...    Copado AI
    Sleep    1s
    
    # Click on Copado AI Platform
    ClickText    Copado AI Platform
    Sleep    5s
    
    # Switch to new tab if it opened
    ${windows}=    GetWindowHandles
    ${count}=    Get Length    ${windows}
    Run Keyword If    ${count} > 1    SwitchWindow    NEW
    Sleep    2s
    
    # Verify we're on the AI Platform
    VerifyText    Workspaces    timeout=20s

Select Workspace
    [Arguments]    ${workspace}=${WORKSPACE_NAME}
    [Documentation]    Click a workspace card on the AI Platform home page.
    VerifyText    Workspaces
    ClickText    ${workspace}
    Sleep    3s
    VerifyText    Create new chat

Full Login Flow
    [Documentation]    Login → navigate to AI Platform → select workspace.
    Open Copado And Login
    Navigate To AI Platform
    Select Workspace

Navigate To My Integrations
    [Documentation]    Click "My Integrations" in the top navigation bar.
    ClickText    My Integrations
    Sleep    3s

Close Test Session
    [Documentation]    Close all browsers.
    CloseAllBrowsers

Verify AI Response Received
    [Arguments]    ${expected_text}    ${timeout}=60s
    [Documentation]    Wait for AI response and verify it contains expected text.
    ${response_visible}=    Run Keyword And Return Status    VerifyText    ${expected_text}    timeout=${timeout}
    Run Keyword If    ${response_visible}    Log    ✅ AI response received with text: ${expected_text}
    ...    ELSE    Fail    ❌ AI did not respond with expected text within ${timeout}
    [Return]    ${response_visible}