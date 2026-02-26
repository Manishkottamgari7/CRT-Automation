*** Settings ***
Documentation     TC-02: Verify that a user can type a prompt in a chat
...               and receive a valid AI response from the Copado AI Platform.
Resource          ../resources/common.resource
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
    ClickText    Create new chat
    Sleep    3s

    # Step 3 – Type the prompt into the chat input area
    # The chat input is a contenteditable div, use ClickElement + TypeText
    ClickElement    xpath\=//div[@contenteditable\='true']
    TypeText    xpath\=//div[@contenteditable\='true']    ${TEST_PROMPT}

    # Step 4 – Click the send button
    ClickElement    id\=ai-prompt-send
    Sleep    10s    reason=Waiting for AI response

    # Step 5 – Verify the AI started responding
    # The chat area changes to show messages
    Verify AI Response Received    Copado    timeout=60s

    # Step 6 – Log success
    Log    ✅ AI response received for prompt: ${TEST_PROMPT}
