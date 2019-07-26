sudo apt install update
sudo curl https://get.docker.com | sudo bash
sudo usermod -aG docker ${whoami}

sudo docker run -d --name mongo mongo
