*** Settings ***
Documentation     TC-01: Verify that a user can create a new chat session
...               on the Copado AI Platform.
Resource          ../resources/common.resource
Suite Setup       OpenBrowser    about:blank    chrome
Suite Teardown    Close Test Session

*** Test Cases ***
Create A New Chat Session
    [Documentation]    Login, navigate to AI Platform, select workspace,
    ...                click Create New Chat, and verify the chat opens.
    [Tags]    smoke    chat    critical

    # Step 1 – Login and navigate to AI Platform workspace
    Full Login Flow

    # Step 2 – Click "Create new chat" in the sidebar
    ClickText         Create new chat
    Sleep    3s

    # Step 3 – Verify the new chat session is created
    VerifyText        New Chat

    # Step 4 – Verify the send button is present (prompt area loaded)
    Wait Until Keyword Succeeds    10s    2s    VerifyElement    //*[@id="ai-prompt-send"]
    Log    ✅ New chat session created successfully.
