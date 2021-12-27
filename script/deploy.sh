#!/bin/bash
export STAGE=${STAGE:-prod}
export STAGE=${AWS_REGION:-ap-southeast-2}
TMPFILE=../sdh-data/fhir-works-on-aws-deployment/service-info.prod.txt
ServiceEndpoint=$(awk '/^ServiceEndpoint/{print $2}' ${TMPFILE})
UserPoolAppClientId=$(awk '/^UserPoolAppClientId/{print $2}' ${TMPFILE})
ApiKey="a6apdwHc5SgtSbfn0EZJ89pQcWuRd1k2YkNeAkk6"

echo ServiceEndpoint=${ServiceEndpoint}
echo UserPoolAppClientId=${UserPoolAppClientId}
echo ApiKey=${ApiKey}
exit
cd amplify-infra
yarn run cdk deploy \
    -c fhir_server_url=${fhir_server_url} \
    -c api_key="a6apdwHc5SgtSbfn0EZJ89pQcWuRd1k2YkNeAkk6" \
    -c auth_url="https://${UserPoolAppClientId}.auth.${AWS_REGION}.amazoncognito.com" \
    -c client_id=${UserPoolAppClientId} \
    -c amplify_branch=main
cd -
