#!/bin/bash
export STAGE=${STAGE:-prod}
export AWS_REGION=${AWS_REGION:-ap-southeast-2}
TMPFILE=../sdh-data/fhir-works-on-aws-deployment/service-info.prod.txt
ServiceEndpoint=X # $(awk '/^ServiceEndpoint/{print $2}' ${TMPFILE})
UserPoolAppClientId=X #$(awk '/^UserPoolAppClientId/{print $2}' ${TMPFILE})
ApiKey="a6apdwHc5SgtSbfn0EZJ89pQcWuRd1k2YkNeAkk6"

REACT_APP_API_KEY=${ApiKey}
REACT_APP_AUTH_URL=https://${UserPoolAppClientId}.auth.${AWS_REGION}.amazoncognito.com
REACT_APP_CLIENT_ID=${ApiKey}
REACT_APP_FHIR_SERVER_URL=${ServiceEndpoint}

cat > .env.local << EOF
REACT_APP_API_KEY=${REACT_APP_API_KEY}
REACT_APP_AUTH_URL=${REACT_APP_AUTH_URL}
REACT_APP_CLIENT_ID=${REACT_APP_CLIENT_ID}
REACT_APP_FHIR_SERVER_URL=${REACT_APP_FHIR_SERVER_URL}
EOF

cd amplify-infra
yarn run cdk deploy \
    -c api_key=${REACT_APP_API_KEY} \
    -c auth_url=${REACT_APP_AUTH_URL} \
    -c client_id=${REACT_APP_CLIENT_ID} \
    -c fhir_server_url=${REACT_APP_FHIR_SERVER_URL} \
    -c amplify_branch=main
cd -
