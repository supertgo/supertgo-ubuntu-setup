sudo apt-get update

echo 'installing curl' 
sudo apt install curl -y

echo 'installing git' 
sudo apt install git -y

echo "What name do you want to use in GIT user.name?"
echo "For example, mine will be \"supertgo\""
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear 

echo "What email do you want to use in GIT user.email?"
echo "For example, mine will be \"thiagoroberto2003@gmail.com\""
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo "Can I set VIM as your default GIT editor for you? (y/n)"
read git_core_editor_to_vim
if echo "$git_core_editor_to_vim" | grep -iq "^y" ;then
	git config --global core.editor vim
else
	echo "Okay, no problem. :) Let's move on!"
fi

echo 'installing tool to handle clipboard via CLI'
sudo apt-get install xclip -y

echo "Generating Github a SSH Key"
ssh-keygen -t ed25519 -C $git_config_user_email
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
echo "Ssh key coppied, you can paste it in Github"

echo 'installing zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh

export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

echo 'installing autosuggestions' 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

echo 'installing docker https://docs.docker.com/engine/install/' 
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

sudo usermod -aG docker $USER

echo 'installing fzf'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo 'install asdf https://asdf-vm.com/guide/getting-started.html'
echo 'install lvim https://www.lunarvim.org/'
echo 'checkout https://github.com/supertgo/setup'
echo 'peek gif https://github.com/phw/peek'
