# OpenPassword
OpenPassword is a Password Manager designed using shell programming for Linux. This tool can be used to securely generate, store and take a backup of your various passwords locally.

This tool uses openssl to encrypt your stored passwords using a secret key, The secret key is your Master Password which is used login to OpenPassword.
Master password is stored locally in sha256 Format.
This makes the tool secure and can be used for storing various passwords.

# Steps to install this tool on your linux machine.
1. `git clone https://github.com/Munazirul/OpenPassword`
2. `cd OpenPassword`
3. `chmod +x OpenPass.sh`
4. `sudo ./OpenPass.sh`
5. BOOM!

#Screenshots
Welcome banner
![Alt text](/img/welcome_banner.png)

Stored Passwords
![Alt text](/img/stored.png)

Breach check
![Alt text](/img/breach_check.png)

<p align="center">
  <img src="/img/stored.png" width="800" title="hover text">
  <img src="/img/welcome_banner.png" width="800" alt="accessibility text">
</p>
