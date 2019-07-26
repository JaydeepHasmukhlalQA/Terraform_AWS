sudo apt install update
sudo curl https://get.docker.com | sudo bash
sudo usermod -aG docker ${whoami}

sudo docker pull achar95/ui

sudo docker run -d --name api -e MONGO_HOST=${aws_instance.mongo_instance.private_ip} -p 8080:8080 achar95/api-config