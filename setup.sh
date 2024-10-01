sudo rm -rf /nix
sh <(curl -L https://nixos.org/nix/install)
if [ -e /home/yakumo/.nix-profile/etc/profile.d/nix.sh ]; then eval '. /home/yakumo/.nix-profile/etc/profile.d/nix.sh'; fi # added by Nix installer
sudo chown -R "${USER}" /nix

if [ -e ./install.sh ]; then
  source ./install.sh
fi

if [ -e ./config.sh ]; then
  source ./config.sh
fi
