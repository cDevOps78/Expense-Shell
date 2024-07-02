curl -L https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/7.71.9/jfrog-artifactory-oss-7.71.9-linux.tar.gz -o /opt/jfrog-artifactory-oss-7.71.9-linux.tar.gz

tar -xzf /opt/jfrog-artifactory-oss-7.71.9-linux.tar.gz -C /opt

useradd artifactory

chown -R artifactory:artifactory /opt/artifactory-oss-7.71.9

echo '
[Unit]
Description=Artifactory service
After=network.target

[Service]
SuccessExitStatus=143
Type=forking
GuessMainPID=yes
Restart=always
RestartSec=60
PIDFile=/var/run/artifactory.pid
ExecStart=/opt/artifactory-oss-7.71.9/app/bin/artifactoryManage.sh start
ExecStop=/opt/artifactory-oss-7.71.9/app/bin/artifactoryManage.sh stop

[Install]
WantedBy=multi-user.target
Alias=artifactory.service
' > /etc/systemd/system/artifactory.service

systemctl deamon-reload

systemctl start artifactory

systemctl status artifactory
