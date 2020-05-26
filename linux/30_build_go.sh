Ver=1.12.4

apt -y install make

curl -O https://dl.google.com/go/go${Ver}.linux-amd64.tar.gz
tar -xzf go${Ver}.linux-amd64.tar.gz -C /usr/local

echo "please add"
echo
echo "export PATH=$PATH:/usr/local/go/bin" to your profile
