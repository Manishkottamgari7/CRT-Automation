*** Settings ***
Documentation     TC-01: Verify that a user can create a new chat session
...               on the Copado AI Platform.
Resource          ../resources/common.resource
Suite Teardown    Close Test Session

*** Test Cases ***
Create A New Chat Session
    [Documentation]    Login, navigate to AI Platform, select workspace,
    ...                click Create New Chat, and verify the chat opens.
    [Tags]    smoke    chat    critical

    # Step 1 – Full login flow (login → AI platform → workspace)
    Full Login Flow

    # Step 2 – Click "Create new chat" in the sidebar
    ClickText    Create new chat
    Sleep    3s

    # Step 3 – Verify the new chat session is created
    # A new chat entry should appear in the sidebar
    VerifyText    New Chat

    # Step 4 – Verify the prompt area is present
    VerifyElement    id\=ai-prompt-send
    Log    ✅ New chat session created successfully.
