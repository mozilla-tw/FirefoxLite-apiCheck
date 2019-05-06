#!/usr/bin/env bash
# fail if any commands fails
#set -e
# debug log
set -x

# partner service Url
newsPointUrl="http://partnersnp.indiatimes.com/feed/fx/atp?channel=*&section=top-news&lang=english&curpg=%d&pp=%d&v=v1&fromtime=1551267146210"
bukaPulsaUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Fpulsa%3Ffrom%3Dlanding_page%26source%3Dphone_credit%26ho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
bukaPaketDataUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Fpaket-data%3Fho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
bukaVoucherGameUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Fvoucher-game%3Fho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
bukaTiketKeretaUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Fkereta-api%3Fho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
buKaTiketPesawatUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Ftiket-pesawat%3Fho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
bukaEventUrl="http://bukalapak.go2cloud.org/aff_c?offer_id=15&aff_id=4287&aff_sub=ticket&url=https%3A%2F%2Fwww.bukalapak.com%2Ftiket-event%3Fho_offer_id%3D{offer_id}%26ho_trx_id%3D{transaction_id}%26affiliate_id%3D{affiliate_id}%26utm_source%3Dhasoffers%26utm_medium%3Daffiliate%26utm_campaign%3D{offer_id}%26aff_sub%3D{aff_sub}%26ref%3D{referer}"
endpointUrls=($newsPointUrl $bukaPulsaUrl $bukaPaketDataUrl $bukaVoucherGameUrl $bukaTiketKeretaUrl $buKaTiketPesawatUrl $bukaEventUrl)

# initialize hasFail variable
hasFail=false

# Get # of partner service Url
echo "Total number of APIs: ${#endpointUrls[@]}"
statusCode=0

# Check has Failure in status code
function checkHasFail() 
{
if [[ "${statusCode}" != 2* ]]
then
hasFail=true
fi
}

# Get status code and check its failure
for i in "${!endpointUrls[@]}"; do
    statusCode="$(curl -sL -w "%{http_code}\\n" "${endpointUrls[i]}" -o /dev/null)"
    echo "EndpointUrl= ${endpointUrls[i]} status code = ${statusCode}"
    checkHasFail
done

# Report Pass or fail result
if [ "$((i+1))" == ${#endpointUrls[@]} ] && [ "$hasFail" = true ]
then
echo "Some Failed" && exit 1
fi
echo "All Passed" && exit 0