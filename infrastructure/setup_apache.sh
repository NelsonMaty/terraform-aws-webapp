#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl enable httpd --now

echo "<html><body><h1>Hello World from mundose!</h1></body></html>" | sudo tee /var/www/html/index.html
