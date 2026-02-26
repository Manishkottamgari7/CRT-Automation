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
    [Documentation]    Debug version - navigate to AI Platform with detailed logging.
    
    Log    🔍 Starting navigation to AI Platform...
    
    # Capture current state
    ${start_url}=    GetUrl
    Log    Current URL: ${start_url}
    CaptureScreenshot    01_after_login.png
    
    # Try to find app switcher
    Log    🔍 Looking for app switcher...
    ${switcher_exists}=    IsElement    xpath\=//button[contains(@class, 'app-switcher')]    timeout=5s
    Log    App switcher found: ${switcher_exists}
    
    Run Keyword If    ${switcher_exists}
    ...    Run Keywords
    ...    Log    ✅ App switcher found, clicking...
    ...    AND    ClickElement    xpath\=//button[contains(@class, 'app-switcher')]
    ...    AND    Sleep    2s
    ...    AND    CaptureScreenshot    02_app_switcher_opened.png
    ...    ELSE
    ...    Log    ❌ App switcher not found, trying direct navigation...
    
    # Look for AI Platform link
    Log    🔍 Looking for 'Copado AI Platform' text...
    ${ai_link_exists}=    IsText    Copado AI Platform    timeout=5s
    Log    AI Platform link found: ${ai_link_exists}
    
    Run Keyword If    ${ai_link_exists}
    ...    Run Keywords
    ...    Log    ✅ AI Platform link found, clicking...
    ...    AND    ClickText    Copado AI Platform
    ...    AND    Sleep    5s
    ...    AND    CaptureScreenshot    03_after_clicking_ai.png
    ...    ELSE
    ...    Run Keywords
    ...    Log    ❌ AI Platform link not found, using direct URL...
    ...    AND    GoTo    https://ai.copado.com
    ...    AND    Sleep    5s
    
    # Check if new window opened
    ${windows}=    GetWindowHandles
    ${window_count}=    Get Length    ${windows}
    Log    Number of windows: ${window_count}
    
    Run Keyword If    ${window_count} > 1
    ...    Run Keywords
    ...    Log    ✅ New window detected, switching...
    ...    AND    SwitchWindow    NEW
    ...    AND    Sleep    3s
    ...    AND    CaptureScreenshot    04_new_window.png
    
    # Verify final state
    ${final_url}=    GetUrl
    Log    Final URL: ${final_url}
    CaptureScreenshot    05_final_state.png
    
    # Verify we're on AI Platform
    ${on_ai_platform}=    IsText    Workspaces    timeout=10s
    Run Keyword If    ${on_ai_platform}
    ...    Log    ✅ Successfully on AI Platform!
    ...    ELSE
    ...    Fail    ❌ Failed to navigate to AI Platform. Check screenshots in results folder.

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