# SSH with Git
[Connecting to GitHub with SSH ](https://help.github.com/articles/connecting-to-github-with-ssh/)

## Generate a new SSH key
Although you can use your existing ssh key, I suggest you generating a new one  for different host.

First, change to the ssh directory `cd ~/.ssh`. If this directory does not exist, make one `mkdir ~/.ssh`.

Then under this directory, generate ssh key pair with Mac’s built-in command `ssh-keygen`:
```
ssh-keygen -t rsa -b 4096 -N "My PassPhrasE" -C "your_git_email@example.com" -f github_rsa
```
Meaning of each options:
* `-t type` The type of key.
* `-b bits` the number of bits in the key to create. For RSA, the minimum size it 1024 bits and the default is 2048 bits. Generally, 2048 bits is considered sufficient. Here we specify 4096 bits.
* `-N new_passphrase` Each time you use this SSH key, you will be prompted to enter this passphrase. We can save it to keychain later to avoid this repetition.
* `-C comment`  A comment. Actually you can type anything.
* `-f filename` filename for the key pair

You can type `man ssh-keygen` to see all detailed usage.

## Adding you SSH key to the `ssh-agent`
Since macOS Sierra 10.12.2 or later, you will need to modify your `~/.ssh/config` file to automatically load keys into the ssh-agent and store passphrases in your keychain.
```
Host *
 AddKeysToAgent yes
 UseKeychain yes
 HashKnownHosts yes

Host github.com
 HostName github.com
 PreferredAuthentications publickey
 IdentityFile ~/.ssh/github_rsa
```

Add your SSH private key to the ssh-agent.
```
ssh-add -K ~/.ssh/github_rsa
```

## Adding a new SSH key to your GitHub account
Copy the SSH key to clipboard
```
pbcopy < ~/.ssh/github_rsa.pub
```

On you github page, `settings` -> `SSH and GPG keys` -> `Add SSH key`

## Recover SSH key passphrase
If you forgot your SSH key’s passphrase and it already saved in keychain, you can recover it this way

In launchpad, type `keychain` and open `Keychian Access` app. In this app search `ssh`.

Double click on the entry for your SSH key to open a new dialog box.

In the lower-left corner, select `Show password`.

You'll be prompted for your administrative password. Type it into the "Keychain Access" dialog box.

In your terminal `man ssh_config` to see the format for `config` file.
`man ssh-keygen` to see `ssh-keygen` usage.

#github/config