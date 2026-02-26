# Test Plan — Copado AI Platform

## Objective
Validate core Copado AI Platform functionality via automated browser tests using CRT (Copado Robotic Testing) with QWeb/QEditor.

## Scope

| ID | Test Case | Priority | Description |
|----|-----------|----------|-------------|
| TC-01 | Create a New Chat | Critical | Login → AI Platform → Create new chat → Verify chat created |
| TC-02 | Prompt & Get Response | Critical | Create chat → Send prompt → Verify AI responds |
| TC-03 | Setup Salesforce Integration | Critical | Navigate to My Integrations → Connect Salesforce |
| TC-04 | Setup Copado CI/CD Integration | Critical | Navigate to My Integrations → Connect Copado CI/CD |

## Out of Scope
- Performance / load testing
- API-level (non-UI) testing
- Mobile device testing

## Entry Criteria
- CRT environment with an active Robot configured
- Valid Copado AI Platform login credentials
- Salesforce org credentials for integration testing
- Test suite linked to the Git repository in CRT

## Exit Criteria
- All 4 test cases execute to completion (pass or documented fail/bug)
- Test execution report available in CRT dashboard
- Any bugs found are documented with screenshots

## Environment
| Setting | Default | Override Via |
|---------|---------|--------------|
| URL | `https://robotic.copado.com/u/login?mode=email` | `BASE_URL` CRT variable |
| Browser | Chrome | `BROWSER` CRT variable |
| Timeout | 15s | `TIMEOUT` CRT variable |

## Test Data
All credentials are configurable via CRT Variables or `variables/env.py`:
- `COPADO_USERNAME` / `COPADO_PASSWORD`
- `SF_ORG_URL` / `SF_USERNAME` / `SF_PASSWORD`
- `COPADO_CICD_URL`

## Execution
### On CRT Platform (Recommended)
1. Link this Git repo to a CRT Project
2. Create a Suite pointing to `tests/`
3. Configure variables in CRT
4. Run the suite

### Locally
```bash
robot --variablefile variables/env.py --outputdir results tests/
```

## Risks & Assumptions
1. AI response time may exceed default timeouts — TC-02 allows 60s
2. Integration Connect buttons trigger OAuth flows that may require additional steps
3. Tests assume US region (`robotic.copado.com`)
