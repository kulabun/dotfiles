function awsauth
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN
    export (read -P "Enter you MFA code: " token; aws-mfa-credentials $token)
end
