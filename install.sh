echo "Hi, ${USER}! I will set up ZSH for you"

prefix=$(dirname ${0})

package_manager="apt-get install -y --upgrade"

if [ -f "/usr/bin/pacman" ]; then
	package_manager="pacman -Sy --noconfirm"
fi

echo "I need root privileges to install necessary packages"
sudo -K
sh -c "sudo ${package_manager} zsh "

echo "Setting up Oh-My-ZSH"
rm -rf ~/.oh-my-zsh
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

echo "Configuring plugins"
mkdir -p .oh-my-zsh/custom/plugins
cp ${prefix}/user/nanorc            ~/.nanorc
cp ${prefix}/user/zshrc             ~/.zshrc
cp ${prefix}/user/my.zsh-theme      ~/.oh-my-zsh/themes/my.zsh-theme
cp ${prefix}/user/zsh-peco-history   ~/.oh-my-zsh/custom/plugins/zsh-peco-history -R
sudo cp ${prefix}/bin/peco          /usr/local/bin/peco

sh -c "cd ${prefix}/bin/fasd && sudo make install"
sh -c "mkdir -p ~/.config/peco && cp ${prefix}/user/config.json ~/.config/peco/ && peco --rcfile ~/.config/peco/config.json 2> /dev/null"

chsh ${USER} -s /usr/bin/zsh

echo "Setup completed"
echo "Bye, ${USER}!"
