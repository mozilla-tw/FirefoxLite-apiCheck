#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
set -x

hasFail=false
endpointUrls=(
"http://partnersnp.indiatimes.com/feed/fx/atp?channel=*&section=top-news&lang=english&curpg=%d&pp=%d&v=v1&fromtime=1551267146210"
)

echo "Total number of APIs: ${#endpointUrls[@]}"
statusCode=0

function checkHasFail() 
{
if [[ "${statusCode}" != 2* ]]
then
hasFail=true
fi
}

for i in "${!endpointUrls[@]}"; do
    statusCode="$(curl -sL -w "%{http_code}\\n" "${endpointUrls[i]}" -o /dev/null)"
    echo "EndpointUrl= ${endpointUrls[i]} status code = ${statusCode}"
    checkHasFail
done

if [ "$((i+1))" == ${#endpointUrls[@]} ] && [ "$hasFail" = true ]
then
echo "Some Failed" && exit 1
fi
echo "All Passed" && exit 0