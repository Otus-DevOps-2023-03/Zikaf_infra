cat > /otus/4_github-project/Zikaf_infra/packer/files/reddit-full-auto.sh << EOF
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
EOF
chmod +x /otus/4_github-project/Zikaf_infra/packer/files/reddit-full-auto.sh
echo '{
    "variables": {
            "sakf": "/root/YCkey/key.json",
            "fid": "b1gfu8nt3uckrfnib1bp",
            "sif": "ubuntu-1604-lts"
        },
    "builders": [
        {
            "type": "yandex",
            "service_account_key_file": "{{user `sakf`}}",
            "folder_id": "{{user `fid`}}",
            "source_image_family": "{{user `sif`}}",
            "image_name": "reddit-base-{{timestamp}}",
            "image_family": "reddit-base",
            "ssh_username": "ubuntu",
            "use_ipv4_nat": true,
            "platform_id": "standard-v1"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "script": "/otus/4_github-project/Zikaf_infra/packer/files/reddit-full-auto.sh",
            "execute_command": "sudo {{.Path}}"
        }
    ]
}
' > /otus/4_github-project/Zikaf_infra/packer/files/immutable-auto.json
export IMAGE_ID=$(packer build /otus/4_github-project/Zikaf_infra/packer/files/immutable-auto.json | grep -oP '(?<=id: )[^\s)]+' | tr -d '\n')
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--memory=4 \
--create-boot-disk image-id=${IMAGE_ID},size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--ssh-key ~/.ssh/appuser.pub

