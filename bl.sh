ceph -s

# test radosgw is ok
curl localhost:8080

# check ops log is enabled
ceph daemon osd.0 config show | grep rgw_bl_url
ceph daemon osd.0 config show | grep rgw_bl_debug_interval

# create user

# config test user
# fill user.s3cfg with vstart.sh generated user
# S3 User Info:
#   access key:  0555b35654ad1656d804
#   secret key:  h7GhxuBLTrlhVUyxSPUKUV8r/2EI4ngqJxD7iBdBYLhwluN30JaT3Q==

# create test bucket
s3cmd -c user.s3cfg  mb s3://111
s3cmd -c user.s3cfg  mb s3://222
s3cmd -c user.s3cfg  mb s3://333
s3cmd -c user.s3cfg  mb s3://444
s3cmd -c user.s3cfg  mb s3://555

# enable bucket logging
s3cmd accesslog  -c user.s3cfg  s3://111 --access-logging-target-prefix=s3://111
s3cmd accesslog  -c user.s3cfg  s3://222 --access-logging-target-prefix=s3://222
s3cmd accesslog  -c user.s3cfg  s3://333 --access-logging-target-prefix=s3://333
s3cmd accesslog  -c user.s3cfg  s3://444 --access-logging-target-prefix=s3://444
s3cmd accesslog  -c user.s3cfg  s3://555 --access-logging-target-prefix=s3://555

# generate some access log
s3cmd -c user.s3cfg put user.s3cfg s3://111/1
s3cmd -c user.s3cfg put user.s3cfg s3://111/2
s3cmd -c user.s3cfg put user.s3cfg s3://111/3

s3cmd -c user.s3cfg put user.s3cfg s3://222/1
s3cmd -c user.s3cfg put user.s3cfg s3://222/2
s3cmd -c user.s3cfg put user.s3cfg s3://222/3

s3cmd -c user.s3cfg put user.s3cfg s3://333/1
s3cmd -c user.s3cfg put user.s3cfg s3://333/3
s3cmd -c user.s3cfg put user.s3cfg s3://333/2

s3cmd -c user.s3cfg put user.s3cfg s3://444/1
s3cmd -c user.s3cfg put user.s3cfg s3://444/3
s3cmd -c user.s3cfg put user.s3cfg s3://444/2

s3cmd -c user.s3cfg put user.s3cfg s3://555/1
s3cmd -c user.s3cfg put user.s3cfg s3://555/3
s3cmd -c user.s3cfg put user.s3cfg s3://555/2

# create & config bl_deliver user
radosgw-admin user create --uid=bl_deliver --display-name="Bucket Logging Delivery" --bl_deliver --access-key=bl_deliver --secret_key=bl_deliver
radosgw-admin zone modify --master --access-key=bl_deliver --secret=bl_deliver --bl_deliver --rgw-zonegroup=default --rgw-zone=default
radosgw-admin zone get --rgw-zone=default

radosgw-admin bl list

radosgw-admin bl process

radosgw-admin bl list
