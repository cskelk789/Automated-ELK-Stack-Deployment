## Automated ELK Stack Deployment Project (By Kavitha Bangalore)

The files in this repository were used to configure the network depicted below.

![ELK Server Implementation](https://user-images.githubusercontent.com/95726896/145699262-aac163ea-039e-48d3-bb53-b352aaa48a03.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the **yml and config** file may be used to install only certain pieces of it, such as Filebeat.

* [DVWA Web VM/Docker Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/DVWA/pentest.yml)
* [Hosts File](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/hosts)
* [Ansible Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/ansible.cfg)
* [ELK Installation and Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/ELK/install-elk.yml)
* [Filebeat Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Filebeat/filebeat-config.yml)
* [Filebeat Playbook](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Filebeat/filebeat-playbook.yml)
* [Metricbeat Configuration](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Metricbeat/metricbeat-config.yml)
* [Metricbeat Playbook](https://github.com/cskelk789/ELK-Stack-Deployment/blob/main/Ansible/Metricbeat/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly **functional and available**, in addition to restricting **traffic** to the network.
- What aspect of security do load balancers protect? 

  **Load Balancers play an important security role as computing moves evermore to the cloud. The off-loading function of a load balancer defends an organization against distributed denial-of-service (DDoS) attacks. It does this by shifting attack traffic from the corporate server to a public cloud provider. Hence, Load balancers add resiliency to the network.**

- What is the advantage of a jump box?

  **A Jump Box Provisioner is a good addition to a corporate network as it prevents internal VMs from being exposed via a public IP Address. This allows monitoring and logging on a single box. By implementing Security Rules, we can also restrict the IP addresses able to communicate with the Jump Box.**

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the **network** and system **logs**.
- What does Filebeat watch for?

  **Filebeat is a light weight log shipper which is installed as an agent on your servers and monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or log stash for indexing.**

- What does Metricbeat record?

  **Metricbeat is a lightweight agent that can be installed on target servers to periodically collect metric data from your target servers, this could be operating system metrics such as CPU or memory or data related to services running on the server. It can also be used to monitor other beats and ELK stack itself.**

The configuration details of each machine may be found below.
| Name       | Function      | IP Address | Operating System |
| ---------- | ------------- | ---------- | ---------------- |
| Jump Box   | Gateway       | 10.0.0.4   | Linux            |
| Web-1      | Ubuntu Server | 10.0.0.5   | Linux            |
| Web-2      | Ubuntu Server | 10.0.0.7   | Linux            |
| Web-3      | Ubuntu Server | 10.0.0.8   | Linux            |
| ELK Server | Ubuntu Server | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. A peering relationship has been established between the Red Team Virtual Network and the ELK Virtual Network to facilitate communication.

Only the __Jump-Box-Provisioner__ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- **Workstation MY Public IP through TCP 5601**

Machines within the network can only be accessed by __Workstation and Jump-Box-Provisioner through SSH JumpBox__.
- Which machine did you allow to access your ELK VM?
  - *Jump-Box-Provisioner is allowed to access the ELK VM.*

- What was its IP address?
  - *The Jump-Box-Provisioner IP is at 10.0.0.4(Private IP) and 20.124.251.206(Public IP) and it can be accessed via SSH port 22. The ELK VM could be accessed by Workstation MY Public IP via port TCP 5601.*


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
- Install Docker.io
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
- Increase Virtual Memory
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


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _List the IP addresses of the machines you are monitoring_
  - Web-1: 10.1.0.5
  - Web-2: 10.1.0.6
  - Web-3: 10.1.0.7


We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
