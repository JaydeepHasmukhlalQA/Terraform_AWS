resource "aws_instance" "api_instance" {
  ami                         = "ami-0c30afcb7ab02233d"
  instance_type               = "${var.instance}"
  subnet_id                   = "${aws_subnet.default.id}"
  vpc_security_group_ids      = ["${aws_security_group.default.id}"]
  associate_public_ip_address = true
  key_name                    = "default-key-pair"

  connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  tags = {
    Name = "api"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install update",
      "sudo curl https://get.docker.com | sudo bash",
      "sudo docker pull achar95/ui",
      "sudo docker run -d --name api -e MONGO_HOST=${aws_instance.mongo_instance.private_ip} -p 8080:8080 achar95/api-config"
    ]
  }
}
