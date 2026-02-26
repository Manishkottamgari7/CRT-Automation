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
    [Documentation]    Navigate to Copado AI Platform with multiple fallback strategies.
    
    # Strategy 1: Try direct URL navigation (most reliable)
    ${ai_url}=    Set Variable    https://ai.copado.com
    Log    Attempting direct navigation to ${ai_url}
    ${direct_nav_success}=    Run Keyword And Return Status    
    ...    Run Keywords
    ...    GoTo    ${ai_url}
    ...    AND    Sleep    5s
    ...    AND    VerifyText    Workspaces    timeout=15s
    
    Run Keyword If    ${direct_nav_success}    
    ...    Log    ✅ Successfully navigated to AI Platform via direct URL
    ...    ELSE    
    ...    Navigate Via App Switcher

Navigate Via App Switcher
    [Documentation]    Fallback method: Use app switcher to navigate to AI Platform.
    
    Log    Direct URL failed, trying app switcher method...
    
    # Wait for page to fully load after login
    Sleep    3s
    
    # Try multiple selectors for app switcher
    ${switcher_clicked}=    Run Keyword And Return Status    
    ...    Run Keywords
    ...    ClickElement    xpath\=//button[contains(@class, 'app-switcher')]
    ...    AND    Sleep    2s
    
    Run Keyword Unless    ${switcher_clicked}
    ...    Run Keywords
    ...    Log    First selector failed, trying alternative...
    ...    AND    ClickText    Apps    partial_match=False
    ...    AND    Sleep    2s
    
    # Click on Copado AI Platform link
    ${ai_clicked}=    Run Keyword And Return Status
    ...    Run Keywords
    ...    ClickText    Copado AI Platform    timeout=10s
    ...    AND    Sleep    5s
    
    Run Keyword Unless    ${ai_clicked}
    ...    Run Keywords
    ...    Log    Trying partial match for AI Platform...
    ...    AND    ClickText    AI Platform    partial_match=True
    ...    AND    Sleep    5s
    
    # Handle new tab/window if opened
    ${window_count}=    GetWindowHandles
    ${count}=    Get Length    ${window_count}
    
    Run Keyword If    ${count} > 1
    ...    Run Keywords
    ...    Log    New window detected, switching...
    ...    AND    SwitchWindow    NEW
    ...    AND    Sleep    3s
    
    # Verify we're on AI Platform
    VerifyText    Workspaces    timeout=15s
    Log    ✅ Successfully navigated to AI Platform via app switcher

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