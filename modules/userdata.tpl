#!/bin/bash
apt update -y
apt install nginx -y
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb
apt update -y
apt install collectd -y
echo  <<EOF "
{
	"agent": {
	  "metrics_collection_interval": 10,
	  "run_as_user": "root"
	},
	"logs": {
	  "logs_collected": {
		"files": {
		  "collect_list": [
			{
			  "file_path": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
			  "log_group_name": "/apps/CloudWatchAgentLog/",
			  "log_stream_name": "{ip_address}_{instance_id}",
			  "timezone": "Local"
			},
			{
			  "file_path": "/var/log/messages",
			  "log_group_name": "/apps/system/messages",
			  "log_stream_name": "{ip_address}_{instance_id}",
			  "timestamp_format": "%b %d %H:%M:%S",
			  "timezone": "Local"
			},
			{
			  "file_path": "/var/log/nginx/access.log",
			  "log_group_name": "/apps/webservers/nginx/access",
			  "log_stream_name": "{ip_address}_{instance_id}",
			  "timestamp_format": "%d/%b/%Y:%H:%M:%S %z",
			  "timezone": "Local"
			}
		  ]
		}
	  }
	},
	"metrics": {
	  "aggregation_dimensions": [
		[
		  "InstanceId"
		]
	  ],
	  "append_dimensions": {
		"AutoScalingGroupName": "${aws:AutoScalingGroupName}",
		"ImageId": "${aws:ImageId}",
		"InstanceId": "${aws:InstanceId}",
		"InstanceType": "${aws:InstanceType}"
	  },
	  "metrics_collected": {
		"collectd": {
		  "metrics_aggregation_interval": 60
		},
		"disk": {
		  "measurement": [
			"used_percent"
		  ],
		  "metrics_collection_interval": 10,
		  "resources": [
			"*"
		  ]
		},
		"mem": {
		  "measurement": [
			"mem_used_percent"
		  ],
		  "metrics_collection_interval": 10
		},
		"statsd": {
		  "metrics_aggregation_interval": 60,
		  "metrics_collection_interval": 10,
		  "service_address": ":8125"
		}
	  }
	}
  }" 
EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

