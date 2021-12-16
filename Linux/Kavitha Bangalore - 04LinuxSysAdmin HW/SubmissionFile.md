## Week 4 Homework Submission File: Linux Systems Administration

***<!--I have done this homework using Typora as recommended by our instructor, Adam Haas, please use Typora to open the file-->*** 

### Step 1: Ensure/Double Check Permissions on Sensitive Files

1. Permissions on `/etc/shadow` should allow only `root` read and write access.

    - Command to inspect permissions: **ls -l /etc/shadow** 

    - Command to set permissions (if needed): **The permissions are currently set at 600 which means root has read and write access, hence, we do not need to set permissions. If the permissions hadn't been set at 600, the command to use would have been sudo chmod 600 /etc/shadow.**

2. Permissions on `/etc/gshadow` should allow only `root` read and write access.

    - Command to inspect permissions: **ls -l /etc/gshadow**
    - Command to set permissions (if needed):**The permissions are currently set at 600 which means root has read and write access, hence, we do not need to set permissions. If the permissions hadn't been set at 600, the command to use would have been sudo chmod 600 /etc/gshadow.**

3. Permissions on `/etc/group` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions: **ls -l /etc/group**
    - Command to set permissions (if needed):**sudo chmod 644 /etc/group**

4. Permissions on `/etc/passwd` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions: **ls -l /etc/passwd**

    - Command to set permissions (if needed): **sudo chmod 644 /etc/passwd**

### Step 2: Create User Accounts

1. Add user accounts for `sam`, `joe`, `amy`, `sara`, and `admin`.

    - Command to add each user account (include all five users):  

      **sudo adduser sam**

      **sudo adduser joe**

      **sudo adduser amy**

      **sudo adduser sara**

      **sudo adduser admin**

2. Ensure that only the `admin` has general sudo access.

    - Command to add `admin` to the `sudo` group: **sudo usermod -aG sudo admin**

### Step 3: Create User Group and Collaborative Folder

1. Add an `engineers` group to the system.

    - Command to add group: **sudo addgroup engineers**

2. Add users `sam`, `joe`, `amy`, and `sara` to the managed group.

    - Command to add users to `engineers` group (include all four users):

      **sudo usermod -aG engineers sam**

      **sudo usermod -aG engineers joe**

      **sudo usermod -aG engineers amy**

      **sudo usermod -aG engineers sara**

3. Create a shared folder for this group at `/home/engineers`.

    - Command to create the shared folder: **sudo mkdir /home/engineers**

4. Change ownership on the new engineers' shared folder to the `engineers` group.

    - Command to change ownership of engineer's shared folder to engineer group: 
    
      **sudo chown -R :engineers /home/engineers**

### Step 4: Lynis Auditing

1. Command to install Lynis: **sudo apt -y install lynis**

2. Command to see documentation and instructions: **man lynis**

3. Command to run an audit: **sudo lynis audit system**

4. Provide a report from the Lynis output on what can be done to harden the system.

    - [ ] Screenshot of report output: 
    
      ![image-20211004175056490](C:\Users\kavib\AppData\Roaming\Typora\typora-user-images\image-20211004175056490.png)
    
      **Lynis Screen capture 1**
    
    - [ ] ![image-20211004175121044](C:\Users\kavib\AppData\Roaming\Typora\typora-user-images\image-20211004175121044.png)
    
      **Lynis Screen capture 2**
    
    - [ ] ![](C:\Users\kavib\Desktop\osu-virt-cyber-pt-08-2021-u-lol\2-Homework\04-Linux-SysAdmin-Fundamentals\Lynis Screen capture 3.png)
    
      **Lynis Screen capture 3**
    
    - [ ] **Below are some Warnings that came up after the audit :** <u>***We could make these changes to the system to harden it.***</u>
      ***(The attached lynis-report.txt captured the output of the sudo lynis audit system command)***
    
      -Version of Lynis is very old and should be updated [LYNIS]  - **Lynis version is outdated, hence it needs to be updated to a newer version to increase productivity.**
      -Multiple users with UID 0 found in passwd file [AUTH-9204] - **User Accounts should be set above the UID 1000 range.**  
      -Multiple accounts found with same UID [AUTH-9208] - **This needs to be checked and rectified.**
      -No password set for single mode [AUTH-9308] - 
      -Found one or more vulnerable packages. [PKGS-7392] - **System should be updated using update feature of apt-get**
      -Nameserver 127.0.0.53 does not respond [NETW-2704] 
      -Couldn't find 2 responsive nameservers [NETW-2705] 
      -Found some information disclosure in SMTP banner (OS or software name) [MAIL-8818] **Should make changes to ensure not more than enough is displayed in the mail name**
    
      ****
    
      **Below are some Suggestions the audit gave:** **<u>*We could harden the system better by implementing the suggestions given below.*</u>**
      -Install libpam-tmpdir to set $TMP and $TMPDIR for PAM sessions [CUST-0280] 
      -Install libpam-usb to enable multi-factor authentication for PAM sessions [CUST-0285] 
      -Install apt-listbugs to display a list of critical bugs prior to each APT installation. [CUST-0810] 
      -Install apt-listchanges to display any significant changes prior to any upgrade via APT. [CUST-0811] 
      -Install debian-goodies so that you can run checkrestart after upgrades to determine which services are using old versions of libraries and need restarting. [CUST-0830] 
      -Install needrestart, alternatively to debian-goodies, so that you can run needrestart after upgrades to determine which daemons are using old versions of libraries and need restarting. [CUST-0831] 
      -Install debsecan to generate lists of vulnerabilities which affect this installation. [CUST-0870] 
      -Install debsums for the verification of installed package files against MD5 checksums. [CUST-0875] 
      -Install fail2ban to automatically ban hosts that commit multiple authentication errors. [DEB-0880] 
      -Set a password on GRUB bootloader to prevent altering boot configuration (e.g. boot in single user mode without password) [BOOT-5122] 
      -Run pwck manually and correct any errors in the password file [AUTH-9228] 
      -Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc [AUTH-9262] 
      -Configure minimum password age in /etc/login.defs [AUTH-9286] 
      -Configure maximum password age in /etc/login.defs [AUTH-9286] 
      -Set password for single user mode to minimize physical access attack surface [AUTH-9308] 
      -Default umask in /etc/login.defs could be more strict like 027 [AUTH-9328] 
      -To decrease the impact of a full /home file system, place /home on a separated partition [FILE-6310] 
      -To decrease the impact of a full /tmp file system, place /tmp on a separated partition [FILE-6310] 
      -To decrease the impact of a full /var file system, place /var on a separated partition [FILE-6310] 
      -Check 6 files in /tmp which are older than 90 days [FILE-6354] 
      -Disable drivers like USB storage when not used, to prevent unauthorized storage or data theft [STRG-1840] 
      -Check DNS configuration for the dns domain name [NAME-4028] 
      -Purge old/removed packages (1 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts. [PKGS-7346] 
      -Install debsums utility for the verification of packages with known good database. [PKGS-7370] 
      -Update your system with apt-get update, apt-get upgrade, apt-get dist-upgrade and/or unattended-upgrades [PKGS-7392] 
      -Install package apt-show-versions for patch management purposes [PKGS-7394] 
      -Check connection to this nameserver and make sure no outbound DNS queries are blocked (port 53 UDP and TCP). [NETW-2704] 
      -Check your resolv.conf file and fill in a backup nameserver if possible [NETW-2705] 
      -Consider running ARP monitoring software (arpwatch,arpon) [NETW-3032] 
      -Access to CUPS configuration could be more strict. [PRNT-2307] 
      -You are advised to hide the mail_name (option: smtpd_banner) from your postfix configuration. Use postconf -e or change your main.cf file (/etc/postfix/main.cf) [MAIL-8818] 
      -Disable the 'VRFY' command [MAIL-8820:disable_vrfy_command] 
      -Check iptables rules to see which rules are currently not used [FIRE-4513] 
      -Install Apache mod_evasive to guard webserver against DoS/brute force attempts [HTTP-6640] 
      -Install Apache modsecurity to guard webserver against web application attacks [HTTP-6643] 
      -Add HTTPS to nginx virtual hosts for enhanced protection of sensitive data and privacy [HTTP-6710] 
      -Consider hardening SSH configuration [SSH-7408] 
      -Check what deleted files are still in use and why. [LOGG-2190] 
      -Add a legal banner to /etc/issue, to warn unauthorized users [BANN-7126] 
      -Enable process accounting [ACCT-9622] 
      -Enable sysstat to collect accounting (no results) [ACCT-9626] 
      -Enable auditd to collect audit information [ACCT-9628] 
      -Run 'docker info' to see warnings applicable to Docker daemon [CONT-8104] 
      -One or more sysctl values differ from the scan profile and could be tweaked [KRNL-6000] 
      -Harden compilers like restricting access to root user only [HRDN-7222] 


### Bonus
1. Command to install chkrootkit:  **sudo apt -y install chkrootkit**

2. Command to see documentation and instructions: **man chkrootkit**

3. Command to run expert mode: **sudo chkrootkit -x**

4. Provide a report from the chrootkit output on what can be done to harden the system. (sudo chkrootkit -x > /home/sysadmin/chkrootkit-report.txt)
    - Screenshot of end of sample output:
    
      ![](C:\Users\kavib\Desktop\osu-virt-cyber-pt-08-2021-u-lol\2-Homework\04-Linux-SysAdmin-Fundamentals\chkrootkit-screenshot.png)
    
      **chkrootkit-screenshot**
    
    - **The chkrootkit is a free tool that is open sourced and helps in detection of the latest rootkits present in the cyberspace. Rootkits are software tools that enable an unauthorized user to gain control of the system without being detected.** 
    
    - **The system admins could use the output report of the chkrootkit to see if any rootkits are present in their networks. They can then isolate the infected portion of the network and rebuild the system.**** 
    
    - **The chkrootkit could also detect sniffers, Trojans, worms, and other back-door programs. It is basically a shell script that makes use of simple linux commands to check for any discrepancies.** 

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
