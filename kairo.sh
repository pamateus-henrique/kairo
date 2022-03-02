## URL's ##
GOOGLE_CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
VSCODE_URL="https://az764295.vo.msecnd.net/stable/f80445acd5a3dadef24aa209168452a3d97cc326/code_1.64.2-1644445741_amd64.deb"
SLACK_URL="https://downloads.slack-edge.com/releases/linux/4.23.0/prod/x64/slack-desktop-4.23.0-amd64.deb"

DOWNLOADS_DIR="$HOME/Downloads/debs"

packages=(
    openjdk-17-jdk
    git
    gtk2-engines-murrine
    gtk2-engines-pixbuf
    net-tools
    mysql-server
    ffmpeg
    apt-transport-https
)

## removing apt lock ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## adding 32 bits architecture ##
sudo dpkg --add-architecture i386

## removing snap lock ## 
sudo mv /etc/apt/preferences.d/nosnap.pref ~/Documents/nosnap.backup

## updating the repository ##
sudo apt update -y


##creating downloads directory
mkdir "$DOWNLOADS_DIR"

## downloading .debs ##
wget -c "$GOOGLE_CHROME_URL" -p "$DOWNLOADS_DIR"
wget -c "$VSCODE_URL" -p "$DOWNLOADS_DIR"

## installing debs ##
sudo dpkg -i $DOWNLOAD_DIR/*.deb


# Installing apt packages
for package_name in ${package_to_install[@]}; do
  if ! dpkg -l | grep -q $package_name; then ## checking to see if the program is already installed.
    apt install "$package_name" -y
  else
    echo "[INSTALADO] - $package_name"
  fi
done


## installing flatpack programs ##
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.obsproject.Studio -y

## git clone ##
cd $HOME
git clone https://github.com/vinceliuice/vimix-gtk-themes
git clone https://github.com/vinceliuice/vimix-icon-theme

## installation vimix theme ##
cd $HOME/vimix-gtk-themes
chmod +x install.sh
./install.sh
./update-vimix-online
cd $HOME/vimix-icon-theme
./install.sh 

## installation openvpn3 ##
sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
sudo apt-key add openvpn-repo-pkg-key.pub
sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$focal.list
sudo apt update
sudo apt install openvpn3


## cleaning ## 
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y