*** Settings ***
Documentation     TC-02: Verify that a user can type a prompt in a chat
...               and receive a valid AI response from the Copado AI Platform.
Resource          ../resources/common.resource
Suite Setup       OpenBrowser    about:blank    chrome
Suite Teardown    Close Test Session

*** Variables ***
${TEST_PROMPT}    What is Copado Robotic Testing?

*** Test Cases ***
Submit A Prompt And Receive A Response
    [Documentation]    Login, open a new chat, send a prompt, and verify the AI responds.
    [Tags]    smoke    prompt    critical

    # Step 1 – Full login flow
    Full Login Flow

    # Step 2 – Create a new chat
    ClickText         Create new chat
    Sleep    3s

    # Step 3 – Type the prompt into the chat input area
    ClickElement      /html[1]/body[1]/ai-root[1]/ai-workspace[1]/div[1]/div[1]/ai-chat-page[1]/div[2]/div[1]/ai-new-chat[1]/div[1]/div[2]/ai-chat-input[1]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[1]/div[1]
    Sleep    1s
    TypeText          ${TEST_PROMPT}

    # Step 4 – Click the send button
    ClickElement      /html[1]/body[1]/ai-root[1]/ai-workspace[1]/div[1]/div[1]/ai-chat-page[1]/div[2]/div[1]/ai-new-chat[1]/div[1]/div[2]/ai-chat-input[1]/div[1]/div[1]/div[2]/form[1]/div[1]/div[1]/div[1]/div[2]/div[2]/button[1]
    Sleep    10s

    # Step 5 – Verify the AI responded
    Verify AI Response Received    Copado    timeout=60s

    # Step 6 – Log success
    Log    ✅ AI response received for prompt: ${TEST_PROMPT}
