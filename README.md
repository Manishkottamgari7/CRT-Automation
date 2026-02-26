# CRT-Automation: Copado AI Platform Test Suite

Production-ready test suite built with **Copado Robotic Testing (CRT)** using **QWeb** (QWords/QEditor) to validate core Copado AI Platform functionality.

## Test Scope

| # | Test Case | File |
|---|-----------|------|
| 1 | Create a New Chat | `tests/01_create_new_chat.robot` |
| 2 | Create a Prompt & Get Response | `tests/02_prompt_and_response.robot` |
| 3 | Setup Salesforce Org Integration | `tests/03_salesforce_integration.robot` |
| 4 | Setup Copado CI/CD Integration | `tests/04_copado_cicd_integration.robot` |

## How to Run

### Option A — Run on CRT (Copado Robotic Testing) ✅ Recommended
1. Push this repository to your Git provider (GitHub, Bitbucket, GitLab)
2. In CRT, create a **Project** linked to this Git repo
3. Create a **Robot** (test execution environment)
4. Create a **Suite** pointing to the `tests/` folder
5. Set **Variables** in CRT for credentials (see below)
6. Execute the suite via the CRT dashboard

### Option B — Run Locally
```bash
# Install dependencies
pip install -r requirements.txt

# Run all tests
robot --variablefile variables/env.py --outputdir results tests/

# Run a specific test
robot --variablefile variables/env.py --outputdir results --test "Create A New Chat Session" tests/
```

## Configuring Credentials

All credentials are in `variables/env.py` and can be overridden via:

### Environment Variables
```bash
export COPADO_USERNAME="your_email@company.com"
export COPADO_PASSWORD="your_password"
export SF_USERNAME="sf_user@company.com"
export SF_PASSWORD="sf_password"
```

### CRT Variables (Recommended)
In the CRT platform, set variables under your Test Job or Suite configuration:
- `COPADO_USERNAME`, `COPADO_PASSWORD`
- `SF_ORG_URL`, `SF_USERNAME`, `SF_PASSWORD`
- `COPADO_CICD_URL`

## Project Structure

```
CRT-Automation/
├── README.md
├── requirements.txt
├── .gitignore
├── variables/
│   └── env.py                  # Configurable credentials (env-var fallback)
├── resources/
│   └── common.resource         # Shared QWeb keywords (login, navigation)
├── tests/
│   ├── 01_create_new_chat.robot
│   ├── 02_prompt_and_response.robot
│   ├── 03_salesforce_integration.robot
│   └── 04_copado_cicd_integration.robot
├── results/                    # Generated: logs, reports, screenshots
└── docs/
    └── test_plan.md
```

## QWeb Keywords Used

| Keyword | Purpose |
|---------|---------|
| `OpenBrowser` | Opens a browser and navigates to URL |
| `TypeText` | Types into an input field (located by label text) |
| `ClickText` | Clicks an element by its visible text |
| `VerifyText` | Asserts text is visible on the page |
| `ClickElement` | Clicks an element by ID/XPath |
| `VerifyElement` | Asserts an element exists |
| `SwitchWindow` | Switches to a new browser tab |
| `IsText` | Checks if text is present (returns status) |
