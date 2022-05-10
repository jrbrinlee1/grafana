#!/bin/bash

# grafana specs
GRAF_VERSION=8.4.3-1
GRAF_ARCH=aarch64
GRAF_PACK=rpm

# FeatureBase creds
FB_USERNAME=molecula
FB_PASSWORD=carr0t

# FeatureBase plugin specs
FB_VERSION=4.8.0
FB_PLUGIN_VERSION=2.2.3

# install grafana and FB plugin
sudo mkdir /home/ec2-user/grafana/
sudo wget -P /home/ec2-user/grafana/ https://dl.grafana.com/enterprise/release/grafana-enterprise-$GRAF_VERSION.$GRAF_ARCH.$GRAF_PACK
sudo yum install -y /home/ec2-user/grafana/grafana-enterprise-$GRAF_VERSION.$GRAF_ARCH.$GRAF_PACK
sudo wget -P /home/ec2-user/grafana/ https://$FB_USERNAME:$FB_PASSWORD@releases.molecula.cloud/molecula-v$FB_VERSION/grafana-plugin/molecula-grafana-plugin-v$FB_PLUGIN_VERSION.zip
sudo chown -R ec2-user:ec2-user /home/ec2-user/grafana/
sudo unzip /home/ec2-user/grafana/molecula-grafana-plugin-v$FB_PLUGIN_VERSION.zip -d /home/ec2-user/grafana/
sudo cp -rf /home/ec2-user/grafana/molecula/dist /var/lib/grafana/plugins/
sudo sed -i 's/;allow_loading_unsigned_plugins =/allow_loading_unsigned_plugins = molecula-datasource/' /etc/grafana/grafana.ini
sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service
sudo systemclt restart grafana-server.service
