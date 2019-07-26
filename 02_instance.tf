resource "aws_instance" "mongo_instance" {
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
    Name = "mongo"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install update",
      "sudo curl https://get.docker.com | sudo bash",
      "sudo docker run -d -p 27017:27017 --name mongo mongo"
    ]
  }
}
