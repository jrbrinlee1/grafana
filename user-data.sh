#!/bin/bash

# grafana specifics 
GRAF_VERSION=8.4.3-1
GRAF_ARCH=aarch64
GRAF_PACK=rpm

# FeatureBase creds
FB_USERNAME=<FB_USERNAME>
FB_PASSWORD=<FB_PASSWORD>

# install grafana and FB plugin
wget -P /home/ec2-user/ https://dl.grafana.com/enterprise/release/grafana-enterprise-$GRAF_VERSION.$GRAF_ARCH.$GRAF_PACK
sudo yum install -y /home/ec2-user/grafana-enterprise-$GRAF_VERSION.$GRAF_ARCH.$GRAF_PACK
wget -P /home/ec2-user/ https://$FB_USERNAME:$FB_PASSWORD@internal-builds.molecula.cloud/grafana-plugin/main/_latest/molecula-grafana-plugin.zip
sudo unzip /home/ec2-user/molecula-grafana-plugin.zip -d /home/ec2-user/
sudo cp -rf /home/ec2-user/molecula/dist /var/lib/grafana/plugins/
sudo sed -i 's/;allow_loading_unsigned_plugins =/allow_loading_unsigned_plugins = molecula-datasource/' /etc/grafana/grafana.ini
sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service
