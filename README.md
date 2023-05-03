# OpenPassword
OpenPassword is a Password Manager designed using shell programming for Linux. This tool can be used to securely generate, store and take a backup of your various passwords locally.

This tool uses openssl to encrypt your stored passwords using a secret key, The secret key is your Master Password which is used login to OpenPassword.
Master password is stored locally in sha256 Format.
This makes the tool secure and can be used for storing various passwords.

# Features
1. Store passwords with strong encryption using openssl.
2. Generate strong passwords.
3. Check for password breach.
4. Take a backup of all your encrypted passwords to your Gmail. (New feature)
5. Create password hint.
6. No breaching passwords in your memory.

# Steps to install this tool on your linux machine.
1. `git clone https://github.com/Munazirul/OpenPassword`
2. `cd OpenPassword`
3. `chmod +x OpenPass.sh`
4. `sudo ./OpenPass.sh`
5. BOOM!

<p align="center">
  <img src="/img/welcome_banner.png" width="800" title="hover text">
  <img src="/img/stored.png" width="800" alt="accessibility text">
  <img src="/img/breach_check.png" width="800" alt="accessibility text">
  <img src="/img/backup.png" width="800" alt="accessibility text">
</p>
