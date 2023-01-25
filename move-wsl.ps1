cd D:\
mkdir WSL
cd WSL
wsl --export Ubuntu-22.04 ubuntu.tar
wsl --unregister Ubuntu-22.04
mkdir Ubuntu-22.04
wsl --import Ubuntu-22.04 Ubuntu-22.04 ubuntu.tar