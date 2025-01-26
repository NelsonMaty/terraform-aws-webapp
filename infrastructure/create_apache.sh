#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl enable httpd --now

# Install git
sudo yum install -y git

# Install Node.js and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 20
nvm use 20

# Clone your project
git clone https://github.com/NelsonMaty/terraform-aws-webapp.git /tmp/project
cd /tmp/project/astro-site

# Install dependencies and build
npm install
npm run build

# Deploy to Apache
sudo rm -rf /var/www/html/*
sudo cp -r dist/* /var/www/html/
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
