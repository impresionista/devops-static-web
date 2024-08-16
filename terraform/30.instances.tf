##Create and bootstrap webserver #lanzar
resource "aws_instance" "webserver" {
  ami                         = "ami-00c39f71452c08778"
  instance_type               = "t2.micro"
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "${local.name_tag_prefix}webserver${local.name_tag_sufix}"
  }
}

# Strategy to force public ip address update
data "aws_instance" "webserver" {
  instance_id = aws_instance.webserver.id
}

output "website_public_ip" {
  description = "Public IP for the web server"
  value = data.aws_instance.webserver.public_ip
  depends_on = [ aws_instance.webserver ]
}

resource "ansible_host" "frontend" {
  name   = aws_instance.frontend.public_ip
  groups = ["common", "frontend"]
  depends_on = [
    aws_eip.frontend,
    aws_instance.frontend
  ]
  variables = {
    ansible_user                 = "ubuntu",
    ansible_ssh_private_key_file = "${var.ssh_key_name}",
    ansible_python_interpreter   = "/usr/bin/python3"
  }
}
