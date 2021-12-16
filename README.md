## Automated ELK Stack Deployment Project (By Kavitha Bangalore)

The files in this repository were used to configure the network depicted below.

![ELK Server Implementation](https://user-images.githubusercontent.com/95726896/145699262-aac163ea-039e-48d3-bb53-b352aaa48a03.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the **yml and config** file may be used to install only certain pieces of it, such as Filebeat. More files have been created in the appropriate containers to automate deployment.

* [DVWA Web VM/Docker Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/DVWA/pentest.yml)
* [Hosts File](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/hosts)
* [Ansible Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/ansible.cfg)
* [ELK Installation and Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/ELK/install-elk.yml)
* [Filebeat Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Filebeat/filebeat-config.yml)
* [Filebeat Playbook](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Filebeat/filebeat-playbook.yml)
* [Metricbeat Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Metricbeat/metricbeat-config.yml)
* [Metricbeat Playbook](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Metricbeat/metricbeat-playbook.yml)

This document contains the following details:
- [Description of the Topology](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#description-of-the-topology)
- [Access Policies](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#access-policies)
- [ELK Configuration](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#elk-configuration)
 - [Machines Being Monitored](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#machines-being-monitored)
 - [Beats in Use](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#beats-in-use)
- [How to Use the Ansible Build](https://github.com/cskelk789/Automated-ELK-Stack-Deployment#how-to-use-the-ansible-build)


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.Load balancing ensures that the application will be highly **functional and available**, in addition to restricting **traffic** to the network.
Below is a screenshot of the DVWA Application:

![Screenshot of DVWA Web Application](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/DVWA%20Web%20App%20Home%20page.png)

- What aspect of security do load balancers protect? 
  **Load Balancers play an important security role as computing moves evermore to the cloud. The off-loading function of a load balancer defends an organization against distributed denial-of-service (DDoS) attacks. It does this by shifting attack traffic from the corporate server to a public cloud provider. Hence, Load balancers add resiliency to the network.**

- What is the advantage of a jump box?
  **A Jump Box Provisioner is a good addition to a corporate network as it prevents internal VMs from being exposed via a public IP Address. This allows monitoring and logging on a single box. By implementing Security Rules, we can also restrict the IP addresses able to communicate with the Jump Box.**

- What does Filebeat watch for?
  **Filebeat is a light weight log shipper which is installed as an agent on the servers and monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or log stash for indexing.**

- What does Metricbeat record?
  **Metricbeat is a lightweight agent that can be installed on target servers to periodically collect metric data from your target servers, this could be operating system      metrics such as CPU or memory or data related to services running on the server. It can also be used to monitor other beats and ELK stack itself.**

The configuration details of each machine may be found below.
| Name       | Function      | IP Address | Operating System |
| ---------- | ------------- | ---------- | ---------------- |
| Jump Box   | Gateway       | 10.0.0.4   | Linux            |
| Web-1      | Ubuntu Server | 10.0.0.5   | Linux            |
| Web-2      | Ubuntu Server | 10.0.0.7   | Linux            |
| Web-3      | Ubuntu Server | 10.0.0.8   | Linux            |
| ELK Server | Ubuntu Server | 10.1.0.4   | Linux            |


- Below is a Screenshot of a listing of virtual machines in the project (Taken from the Azure portal):
![Vm's](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Virtual%20Machines%20on%20Azure.png)

-Below is a screenshot of the virtual networks in the project (Taken from the Azure portal):
![Virtual Networks](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Virtual%20Networks%20on%20Azure.png)


In this project, the Load Balancer, RedTeamLB, helps in maintaining fault tolerance and redundancy in the network. As websites receive more traffic, more servers 
can be added to the group (“pool”) of servers that the load balancer has access to. This helps distribute traffic evenly across the servers and mitigates DoS(Denial of Service) attacks. We also have a health probe configured on the Load Balancer, this probe regularly check all the machines behind the load balancer. Machines with issues are reported, and the load balancer stops sending traffic to those machines.
- Screenshot of the Red Team Backend Pool:
![Red Team Backend Pool](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/ELK%20Configurations/Red%20Team%20Backend%20Pool.png)

### Access Policies

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the **network** and system **logs**.The machines on the internal network are not exposed to the public Internet. SSH keys have been used for authentication to eliminate vulnerability to password-based brute-force.
A peering relationship has been established between the Red Team Virtual Network and the ELK Virtual Network to facilitate communication.
- [Screenshot-ELK to Red Team Peering](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/ELK%20Configurations/Elk%20to%20Red%20Team%20Peering.png)
- [Screenshot-Red Team to ELK Peering](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/ELK%20Configurations/Red%20to%20Elk%20Team%20Peering.png)

Only the __Jump-Box-Provisioner__ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- **Workstation MY Public IP through TCP 5601**
- **Machines within the network can only be accessed by-**
    - __Workstation and Jump-Box-Provisioner through SSH JumpBox__.
- Which machine did you allow to access your ELK VM?
  - *Jump-Box-Provisioner is allowed to access the ELK VM.*
- What was its IP address?
  - *The Jump-Box-Provisioner IP is at 10.0.0.4(Private IP) and 20.124.251.206(Public IP) and it can be accessed via SSH port 22. The ELK VM could be accessed by Workstation MY      Public IP via port TCP 5601.*

A summary of the access policies in place can be found in the table below.

| Name       | Publicly Accessible | Allowed IP Addresses                     |
| ---------- | ------------------- | --------------------                     |
| Jump Box   | Yes                 | 20.124.251.206 (Workstation IP on SSH 22)|
| Web-1      | No                  | 10.1.0.4 on SSH 22                       |
| Web-2      | No                  | 10.1.0.4 on SSH 22                       |
| Web-3      | No                  | 10.1.0.4 on SSH 22                       |
| ELK Server | No                  | Workstation MY Public IP using TCP 5601  |

All the VM's can be accessed only from the Jump-Box-Provisioner. 

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, it is advantageous to automating configuration with Ansible because of the below mentioned reasons:
  - **Ansible allows for quick and easy deployment of multitier applications through a YAML playbook.**
  - **The automation language used is very human-friendly-easily readable and writable.**
  - **It is very helpful to automate the inventory of the implementation platform and centralized automation exceution.**
  - **Helps to cutdown deployment and processing time of various processes.**

The ELK Installation playbook implements the following tasks:
- Configure ELK VM with Docker
   ``` 
   - name: Config elk VM with Docker
     hosts: elk
     become: true
     tasks:
    ```
- Install Docker.io - It references the IP address listed under [elk] in ansible's hosts file to install docker on the target VM.
  ```
  - name: docker.io
    apt:
      force_apt_get: yes
      update_cache: yes
      name: docker.io
      state: present
  ```
- Install Python-pip
  ```
  - name: Install python3-pip
    apt:
      force_apt_get: yes
      name: python3-pip
      state: present
  ```
- Install Docker Module
  ```
  - name: Install Docker Module
    pip:
      name: docker
      state: present
  ```
- Increase Virtual Memory-A standard container does not have enough virtual memory to run an ELK container. For 3 DVWA machines, the suggested amount is 262144.
  ```
  - name: Increase virtual memory
    command: sysctl -w vm.max_map_count=262144
  ```
- Use more memory
  ```
  - name: Use more memory
    sysctl:
      name: vm.max_map_count
      value: "262144"
      state: present
      reload: yes
  ```
- Download and Launch ELK Docker Container (image sebp/elk) Published Ports 5044, 5601 and 9200
  ```
  - name: download and launch a docker elk container
    docker_container:
      name: elk
      image: sebp/elk:761
      state: started
      restart_policy: always
      published_ports:
        - 5601:5601
        - 9200:9200
        - 5044:5044
  ```
- Enable the Docker Service
  ```
  - name: Enable docker service
    systemd:
      name: docker
      enabled: yes
  ```


The following screenshot displays the result of running `docker container list -a` or `docker ps` after successfully configuring the ELK instance.

### ELK Server
![ELK Server](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Docker%20Status/docker_ps_output_ELKserver.png)

### Jump-Box-Provisioner
![Jump-Box-Provisioner](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Docker%20Status/JumpboxProv_PS.png)

### Web-1
![Web-1](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Docker%20Status/Web-1%20PS.png)

### Web-2
![Web-2](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Docker%20Status/Web-2%20PS.png)

### Web-3
![Web-3](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Docker%20Status/Web-3%20PS.png)

### Machines being Monitored
This ELK server is configured to monitor the following machines:
  - Web-1: 10.1.0.5
  - Web-2: 10.1.0.7
  - Web-3: 10.1.0.8
  
- When a ping command is run from the JumpBox-Provisioner, all the other 4 Vm's respond, 
![Below is a screenshot of ping from JumpBox](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/ansible%20Ping%20on%20JumpBox.png)
  
 
### Beats in Use
 Though the ELK configuration supports 8 data collection Tools called Beats, this project uses only 2 of them-Filebeat and Metricbeat. Thed following 2 beats have been installed on these machines:
- Filebeat 
[View status of Filebeat Module](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Filebeat_module_Status.png)
- Metricbeat
[View status of Metricbeat Module](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Metricbeat_module_Status.png)

These Beats allow us to collect the following information from each machine:
- Filebeat is used to collect log files from very specific files from remote machines. For example logs from Apache, Microsft Azure tools, the Nginx web servers and MySQL databases.
- Metericbeat is used to monitor VM stats, per CPU core stats, per filesystem stats, memory stats and network stats.

### How to use the Ansible Build?
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the **yml file** to **ansible folder**.
- Update the **config** file to include the **remote users, ports and any IP.**
- Run the playbook, and navigate to Kibana ((My Workstation IP Address):5601) to check that the installation worked as expected.


#### Configuring and Running the Elk VM Playbook:
   - Run the playbook using this command : ```ansible-playbook /etc/ansible/install-elk.yml```
     
#### Configuring and Running the Filebeat Playbook:
  Since Filebeat is built to collect data about specific files on remote machines, it must be installed on the VMs we  want to monitor.
   - Copy the filebeat-config.yml file to /etc/ansible/files.
   - Update the filebeat-config.yml file to include the ELK private IP in lines 1106 and 1806 as shown below:
   
   ```
    output.elasticsearch:
  # Boolean flag to enable or disable the output module.
  #enabled: true

  # Array of hosts to connect to.
  # Scheme and port can be left out and will be set to the default (http and 9200)
  # In case you specify and additional path, the scheme is required: http://localhost:9200/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:9200
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme" # TODO: Change this to the password you set

  # Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
  # This requires a Kibana endpoint configuration.
  setup.kibana:
  host: "10.1.0.4:5601" 
  ```

   - Run the playbook using this command - `ansible-playbook filebeat-playbook.yml` and navigate to Kibana > Logs : Add log data > System logs (DEB) > 5:Module Status > 
    Check Incoming data on Kibana to check that the installation worked as expected.
  
    [Filebeat Kibana Dashboard](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Filebeat%20Syslogs%20Dashboard.png)
   
#### Configuring and Running the Metricbeat Playbook:
   - Copy the metricbeat-config.yml file to /etc/ansible/files.
   - Update the metricbeat-config.yml file to include the ELK private IP in lines 62 and 96 as shown below:
   
   ```
   #============================== Kibana =====================================
  # Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
  # This requires a Kibana endpoint configuration.
  setup.kibana:
  host: "10.1.0.4:5601"
  #-------------------------- Elasticsearch output ------------------------------
  output.elasticsearch:
  hosts: ["10.1.0.4:9200"]
  username: "elastic"
  password: "changeme"
  ```
    
   - Run the playbook using this command ansible-playbook metricbeat-playbook.yml and navigate to Kibana > Logs : Add Metric data > Docker Metrics (DEB) > 5:Module Status > Check data_on Kibana to check that the installation worked as expected.
   
   - [Metricbeat Module Kibana Dashboard]()
   - [Metricbeat Metrics for Web-1 Server](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Web-1%20Metrics%20on%20Metricbeat.png)
   - [Metricbeat Metrics for Web-2 Server](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Web-2%20Metrics%20on%20Metricbeat.png)
   - [Metricbeat Metrics for Web-3 Server](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Web-3%20Metrics%20on%20Metricbeat.png)  
    
    Metricbeat does much more than simply collect metrics as it can be used to tap into a variety of systems and execute a range of enhancements 
    to the log file     before shipping the metrics to ELK. In this project as seen in the dashboards above, Metricbeat collects data from the 
    3 webservers and give a dashboard showing various web server characteristics. We can see the traffic on the webservers.
    The shipper when paired with Kibana can be used to report on CPU, memory and load metrics. When used in a containerised environment with Docker 
    it can be used as a solution for container monitoring.
    
Answer the following questions to fill in the blanks:
- Which file is the playbook? Where do you copy it?
  * For Elk, it is [My First Playbook](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Ansible/ELK/install-elk.yml)
  * For Filebeat, it is [Filebeat Playbook](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Ansible/Filebeat/filebeat-playbook.yml)
  * For Metricbeat, it is [Metricbeat Playbook](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Ansible/Metricbeat/metricbeat-playbook.yml)
   
   * The files are copied to /etc/ansible/
   
- Which file do you update to make Ansible run the playbook on a specific machine? 
  How do I specify which machine to install the ELK server on versus which to install Filebeat on?
  * /etc/ansible/hosts file (IP of the Virtual Machines).
  * Two separate groups have been specified in the etc/ansible/hosts file:
    * Group 1-webservers-the IPs of the 3 VM's-Web-1, Web-2, Web-3. Filebeat will be installed on these 3 VM's. 
    * Group 2-ELKserver-the IP of the VM, ELK is installed on.

- Which URL do you navigate to in order to check that the ELK server is running?
  The below URL is used to navigate to the ELK server:
  
  * [ELK Server URL](http://40.86.202.243:5601/app/kibana)
  
  Below is a screenshot of the Kibana Homepage: 
  
  * ![This is the Kibana Homepage](https://github.com/cskelk789/Automated-ELK-Stack-Deployment/blob/main/Images/Kibana%20Beats%20Related/Kibana%20Homepage.png)

- As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.
  * The specific commands the user will need to run in order to download the playbook and configuration files, update the files, etc:
    | Command                                                        | Purpose                                                     | 
    |:--------------------------------------------------------------:|:-----------------------------------------------------------:|
    |ssh-keygen                                                      |:create a ssh key for setup VM's                              |
    |sudo cat .ssh/id_rsa.pub	                                       |:to view the ssh public key                                   |
    |ssh azadmin@Jump-Box-Provisioner IP address	                    |:to log into the Jump-Box-Provisioner                         |
    |sudo docker container list -a	                                  |:list all docker containers                                   |
    |sudo docker start <name of my container>	                       |:start docker container dremy_elbakyan                        |
    |sudo docker ps -a	                                              |:list all active/inactive containers                          |
    |sudo docker attach <name of my container>                       |:effectively sshing into the dremy_elbakyan container         |
    |cd /etc/ansible	                                                |:Change directory to the Ansible directory                    |
    |nano /etc/ansible/hosts	                                        |:to edit the hosts file
    |nano /etc/ansible/ansible.cfg	                                  |:to edit the ansible.cfg file
    |nano /etc/ansible/pentest.yml	                                  |:to edit the My-Playbook
    |ansible-playbook [location][filename]	                          |:to run the playbook
    |sudo apt-get update	                                            |:this will update all packages
    |sudo apt install docker.io	                                     |:install docker application
    |sudo service docker start	                                      |:start the docker application
    |sudo systemctl status docker	                                   |:status of the docker application
    |sudo systemctl start docker	                                    |:start the docker service
    |nano filebeat-config.yml	                                       |:create and edit filebeat config file
    |nano filebeat-playbook.yml	                                     |:write YAML file to install filebeat on webservers
    |nano metricbeat-config.yml	                                     |:create metricbeat config file and edit it
    |nano metricbeat-playbook.yml	                                   |:write YAML file to install metricbeat on webservers
