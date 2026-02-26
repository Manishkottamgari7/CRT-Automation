"""
Configurable variables for the Copado AI Platform CRT Test Suite.

All values can be overridden by setting the corresponding environment variable
or by using Robot Framework's --variable CLI flag.

Usage:
    robot --variablefile variables/env.py tests/

Override example:
    export COPADO_USERNAME="me@example.com"
    robot --variable BROWSER:firefox --variablefile variables/env.py tests/
"""

import os

# ---------------------------------------------------------------------------
# Browser & General Settings
# ---------------------------------------------------------------------------
BASE_URL = os.getenv("BASE_URL", "https://robotic.copado.com/u/login?mode=email")
BROWSER = os.getenv("BROWSER", "chrome")
TIMEOUT = os.getenv("TIMEOUT", "15s")

# ---------------------------------------------------------------------------
# Copado AI Platform Credentials
# ---------------------------------------------------------------------------
COPADO_USERNAME = os.getenv("COPADO_USERNAME", "mkottamgari@copado.com")
COPADO_PASSWORD = os.getenv("COPADO_PASSWORD", "143@Kingsgdsgds")

# ---------------------------------------------------------------------------
# Salesforce Org Integration
# ---------------------------------------------------------------------------
SF_ORG_URL = os.getenv("SF_ORG_URL", "https://login.salesforce.com")
SF_USERNAME = os.getenv("SF_USERNAME", "mkottamgari@copado.com.feb24")
SF_PASSWORD = os.getenv("SF_PASSWORD", "Manish@123")

# ---------------------------------------------------------------------------
# Copado CI/CD Integration
# ---------------------------------------------------------------------------
COPADO_CICD_URL = os.getenv("COPADO_CICD_URL", "https://copadotrial20263924.lightning.force.com")
