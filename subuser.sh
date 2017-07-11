radosgw-admin user create --uid umcloud1 --access-key=umcloud1 --secret-key=umcloud1 --display-name 'UMCloud Subuser Usage' --email='umloud1@umcloud.com'
radosgw-admin subuser create --key-type=s3 --uid=umcloud1 --subuser=subuser1 --access=full --access-key=access1  --secret-key=secret1
radosgw-admin subuser create --key-type=s3 --uid=umcloud1 --subuser=subuser2 --access=full --access-key=access2  --secret-key=secret2
radosgw-admin subuser create --key-type=s3 --uid=umcloud1 --subuser=subuser3 --access=full --access-key=access3  --secret-key=secret3

radosgw-admin usage show --uid=umcloud1

radosgw-admin usage show --uid=umcloud1 --subuser=subuser1
radosgw-admin usage show --uid=umcloud1 --subuser=subuser2
radosgw-admin usage show --uid=umcloud1 --subuser=subuser3

radosgw-admin usage trim --uid=umcloud1
