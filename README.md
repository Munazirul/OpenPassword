# OpenPassword
OpenPassword is a Password Manager designed using shell programming for Linux. This tool can be used to securely generate, store and take a backup of your various passwords locally.

This tool uses openssl to encrypt your stored passwords using a secret key, The secret key is your Master Password which is used login to OpenPassword.
Master password is stored locally in sha256 Format.
This makes the tool secure and can be used for storing various passwords.

# Features
1. Interactice UI on CLI
2. Store passwords with strong encryption using openssl.
3. Generate strong passwords.
4. Check for password breach.
5. Take a backup of all your encrypted passwords to your Gmail. (New feature)
6. Create password hint.
7. No breaching passwords in your memory.

# Steps to install this tool on your linux machine.
1. `git clone https://github.com/Munazirul/OpenPassword`
2. `cd OpenPassword`
3. `chmod +x OpenPass.sh`
4. `sudo ./OpenPass.sh`
5. BOOM!

<p align="center">
  <h2>Welcome banner</h2>
  <img src="/img/welcome_banner.png" width="800" title="hover text">
  <h2>View stored passwords</h2>
  <img src="/img/stored.png" width="800" alt="accessibility text">
  <h2>Check for breach</h2>
  <img src="/img/breach_check.png" width="800" alt="accessibility text">
  <h2>Backup feature</h2>
  <img src="/img/backup.png" width="800" alt="accessibility text">
</p>
