wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update
sleep 60
apt-get install -y mongodb-org ruby-full ruby-bundler build-essential git
systemctl enable mongod
systemctl start mongod
git clone -b monolith https://github.com/express42/reddit.git
cd /home/ubuntu/reddit && bundle install
echo '[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
User=ubuntu
Type=simple
WorkingDirectory=/home/ubuntu/reddit
ExecStart=/usr/local/bin/puma -C /var/lib/gems/2.3.0/gems/puma-3.10.0/lib/puma/cli.rb
Restart=always

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/puma.service
systemctl daemon-reload
systemctl enable puma
systemctl start puma

