Ver=1.12.4

apt -y install make

curl -C /usr/local -xzf https://dl.google.com/go/go${Ver}.linux-amd64.tar.gz

echo "please add"
echo
echo "export PATH=$PATH:/usr/local/go/bin" to your profile