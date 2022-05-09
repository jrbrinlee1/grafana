#!/bin/bash
wget -P /home/ec2-user/ https://dl.grafana.com/enterprise/release/grafana-enterprise-8.4.3-1.aarch64.rpm
sudo yum install -y /home/ec2-user/grafana-enterprise-8.4.3-1.aarch64.rpm
wget -P /home/ec2-user/ https://molecula:carr0t@internal-builds.molecula.cloud/grafana-plugin/main/_latest/molecula-grafana-plugin.zip
sudo unzip /home/ec2-user/molecula-grafana-plugin.zip -d /home/ec2-user/
sudo cp -rf /home/ec2-user/molecula/dist /var/lib/grafana/plugins/
sudo sed -i 's/;allow_loading_unsigned_plugins =/allow_loading_unsigned_plugins = molecula-datasource/' /etc/grafana/grafana.ini
sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service
