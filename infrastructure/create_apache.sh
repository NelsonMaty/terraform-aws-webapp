#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl enable httpd --now

# Install Node.js and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 20
nvm use 20

# Create Astro project
npm create astro@latest /tmp/astro-site -- --template minimal --install --no-git --typescript strict
cd /tmp/astro-site

# Modify the index page
cat > src/pages/index.astro << 'EOL'
---
---

<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />
		<title>Welcome to AWS!</title>
	</head>
	<body>
		<h1>Hello from AWS!</h1>
		<p>This is a simple Astro site running on Apache.</p>
	</body>
</html>
EOL

# Build the site
npm run build

# Deploy to Apache
sudo rm -rf /var/www/html/*
sudo cp -r dist/* /var/www/html/
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
