```
#!/bin/bash
# Install Java 8
sudo apt update
sudo apt install openjdk-8-jdk -y
if java -version 2>&1 | grep -q "1.8.0"; then
    echo -e "\e[32mJava 8 is installed.\e[0m" # Print in green color
else
    echo -e "\e[31mJava 8 is not installed.\e[0m" # Print in red color
    exit 1
fi

# Install Maven
sudo apt install maven -y
if command -v mvn &>/dev/null; then
    echo -e "\e[32mMaven is installed.\e[0m"  # Print in green color
else
    echo -e "\e[31mMaven is not installed.\e[0m" 
    exit 1
fi

# Install necessary packages for brew
sudo apt install -y build-essential git
# Install Homebrew
# If getting error then add new user and add to sudo group
# sudo adduser test
# sudo usermod -aG sudo test
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if command -v brew &>/dev/null; then
    echo -e "\e[32mHomebrew is installed.\e[0m" # Print in green color
else
    echo -e "\e[31mHomebrew is not installed.\e[0m"
    exit 1
fi

# Install Move2Kube
brew tap konveyor/move2kube
brew install move2kube
if command -v move2kube &>/dev/null; then
    echo -e "\e[32mMove2Kube is installed.\e[0m" # Print in green color
else
    echo -e "\e[31mMove2Kube is not installed.\e[0m" # Print in red color
    exit 1
fi

# Install kubectl

curl -LO https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
if [ $? -ne 0 ]; then
    echo -e "\e[31mFailed to move kubectl to ~/.local/bin. Please check permissions or try again later.\e[0m"
fi
if command -v kubectl &>/dev/null; then
    echo -e "\e[32mKubectl is installed.\e[0m"
else
    echo -e "\e[31mKubectl is not installed.\e[0m"
    echo -e "\e[32mDownloading the binary again. \e[0m"
    curl -LO https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl
    chmod +x kubectl
    mkdir -p ~/.local/bin
    mv ./kubectl ~/.local/bin/kubectl
    if command -v kubectl &>/dev/null; then
    echo -e "\e[32mKubectl is installed.\e[0m"
    else
        echo -e "\e[31mFailed to install kubectl. Please check permissions or try again later.\e[0m"
        exit 1
    fi
fi

# Install ArgoCD CLI
echo -e "\e[31mInstalling Argocd, It may take some time.\e[0m"
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
if command -v argocd &>/dev/null; then
    echo -e "\e[32mArgo CD is installed.\e[0m" # Print in green color
else
    echo -e "\e[31mArgo CD is not installed.\e[0m" # Print in red color
    exit 1
fi

# Install Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Installing Docker

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# Adding docker group so after exisiting this shell still docker run without sudo

sudo usermod -aG docker $USER
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

newgrp docker << EOF
if command -v docker ps &> /dev/null; then
    echo -e "\e[32mDocker installed.\e[0m"
else
    echo -e "\e[31mDocker is not  installed.\e[0m"
    exit 1
fi
EOF

# Installtion of minikube

newgrp docker << EOF
sudo apt-get update -y
sudo apt-get install curl
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube
if command -v minikube &> /dev/null; then
    echo -e "\e[32mMinikube Binary is available and ready to use.\e[0m"
    minikube version 
    minikube start
    kubectl cluster-info
else
    echo -e "\e[31mMinikube Binary is not available.\e[0m"
    exit 1
fi
EOF

# to login the docker

echo -e "\e[32mLogin prompt for docker.\e[0m"
docker login docker.io

echo -e "\e[32 Installtion done\e[0m"

# Adding docker in group so in this session without logging out user can use docker without sudo

newgrp docker
```