source common.sh
echo -e "\e[31m>>>>>>>> Setup NodeJS repo <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[31m>>>>>>>> Installing nodejs <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[31m>>>>>>>> Adding user and creating a directory <<<<<<<<\e[0m"
useradd ${app_user}
rm -rf /app
mkdir /app 

echo -e "\e[31m>>>>>>>> Setup code repo <<<<<<<<\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 

echo -e "\e[31m>>>>>>>> Moving into the app directory <<<<<<<<\e[0m"
cd /app 

echo -e "\e[31m>>>>>>>> unzipping code content <<<<<<<<\e[0m"
unzip /tmp/cart.zip

echo -e "\e[31m>>>>>>>> Installing nodejs dependancies <<<<<<<<\e[0m"
npm install 

echo -e "\e[31m>>>>>>>> Copying service file <<<<<<<<\e[0m"
cp ${script_path}/cart.service /etc/systemd/system/cart.service

echo -e "\e[31m>>>>>>>> Starting the service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart 
systemctl restart cart