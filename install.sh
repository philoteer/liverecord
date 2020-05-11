[[ -d livedl ]] || [[ -f livedl ]] && echo "Please use`sudo rm -rf livedl`command to delete the livedl file or folder and try again" && exit 1 #git clone Empty folder required

sudo apt update #Update library
sudo apt -y install curl #Install curl
sudo apt -y install ffmpeg #Install ffmpeg

#Install python3 related download tools
sudo apt -y install python3 ; sudo apt -y install python3-pip ; sudo apt -y install python3-setuptools #Install python3
pip3 install streamlink ; pip3 install youtube-dl ; pip3 install you-get #Install download tool based on python3
echo 'export PATH=$PATH:/usr/local/bin'>>~/.bashrc #Modify the default environment variables, you can comment out if you do n’t want to
export PATH=$PATH:/usr/local/bin

#Install go related download tools
wget https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz #Override the installation of the go environment, you can comment out if you do n’t want to
sudo tar -C /usr/local -xzf go1.12.7.linux-amd64.tar.gz ; rm go1.12.7.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin'>>~/.bashrc #Modify the default environment variables, you can comment out if you do n’t want to
export PATH=$PATH:/usr/local/go/bin
sudo apt -y install git ; sudo apt -y install build-essential
echo "It may take a long time here, please be patient"
go get github.com/gorilla/websocket ; go get golang.org/x/crypto/sha3 ; go get github.com/mattn/go-sqlite3 ; go get github.com/gin-gonic/gin #Install the necessary go library
git clone https://github.com/himananiito/livedl.git ; cd livedl ; go build src/livedl.go ; rm -r `ls | grep -v "^livedl$"` ; cd .. #Compile and install livedl

#Download files and grant permissions
mkdir record
wget -O "record/record.sh" "https://raw.githubusercontent.com/lovezzzxxx/liverecord/master/record.sh" ; chmod +x record/record.sh
wget -O "record/record_twitcast.py" "https://raw.githubusercontent.com/lovezzzxxx/liverecord/master/record_twitcast.py" ; chmod +x "record/record_twitcast.py"

#Configure automatic upload
curl https://rclone.org/install.sh | bash #Configure rclone to automatically upload
sudo wget https://raw.githubusercontent.com/MoeClub/OneList/master/OneDriveUploader/amd64/linux/OneDriveUploader -P /usr/local/bin/ #Configure onedrive automatic upload
sudo chmod +x /usr/local/bin/OneDriveUploader
go get github.com/iikira/BaiduPCS-Go #Configure Baidu cloud automatic upload
echo 'export PATH=$PATH:'`echo ~`'/go/bin'>>~/.bashrc #Modify the default environment variables, you can comment out if you do n’t want to
source ~/.bashrc

#Prompt to log in
echo 'Please manually run `source ~ / .bashrc` or relink ssh to update the environment variables to make the following commands take effect'
echo 'Log in to rclone using `rclone config`'
echo 'Use `OneDriveUploader -cn -a" to open the corresponding web page in https://github.com/MoeClub/OneList/tree/master/OneDriveUploader and log in to the URL returned by the browser address bar after logging in "to log in to rclone'
echo 'Log in to BaiduPCS-Go using `BaiduPCS-Go login -bduss =" value of the bduss item in the Baidu network disk web cookie "'
