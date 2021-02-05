## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/Azure%20ELK%20Diagram%204.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YML file may be used to install only certain pieces of it, such as Filebeat.

  - install-dvwa
  - install-elk.yml
  - filebeat-playbook.yml
  - metricbeat-playbook.yml

This document contains the following details:

- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

- The load balancer has an exposed public IP address with a network security group rule allowing traffic from the web server to the load balancer. This prevents from having to assigned a public IP address to each web server.

  The jump box also has an exposed public IP address. This provides a management domain allowing SSH connections to the jump box. This allows secure management of other systems without defining public a IP address for other systems.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the containers and system logs.

- Filebeat watches for changes in system logs and sends to logstash or elasticsearch for further detailed analysis. 
- Metricbeat sends OS system performance and services information to logstash or elasticsearch for system health monitoring.

The configuration details of each machine may be found below.

| Name     | Azure VM Size                         | Function | IP Address | Operating System             |
| -------- | ------------------------------------- | -------- | ---------- | ---------------------------- |
| Jump Box | Standard B2s (2 vcpus, 4 GiB memory)  | Gateway  | 10.1.0.4   | Linux UbuntuServer 18.04-LTS |
| Web-1    | Standard B1ms (1 vcpus, 2 GiB memory) | DVWA     | 10.1.0.5   | Linux UbuntuServer 18.04-LTS |
| Web-2    | Standard B1ms (1 vcpus, 2 GiB memory) | DVWA     | 10.1.0.6   | Linux UbuntuServer 18.04-LTS |
| Web-3    | Standard B1ms (1 vcpus, 2 GiB memory) | DVWA     | 10.1.0.7   | Linux UbuntuServer 18.04-LTS |
| Elk      | Standard B2s (2 vcpus, 4 GiB memory)  | DVWA     | 10.0.0.4   | Linux UbuntuServer 18.04-LTS |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- Jump Box - 104.42.209.78

Machines within the network can only be accessed by 10.1.0.4.

- The ELK server can be accessed through the Jump Box internal network address of 10.1.0.4 and public address of 40.87.27 via SSH.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses                          |
| -------- | ------------------- | --------------------------------------------- |
| Jump Box | Yes                 | 104.42.209.78:22                              |
| Web-01   | No                  | 10.1.0.4:22                                   |
| Web-02   | No                  | 10.1.0.4:22                                   |
| Web-03   | No                  | 10.1.0.4:22                                   |
| Elk      | Yes                 | 10.1.0.4:22, 40.87.27.37:22, 40.87.27.37:5601 |

### Elk Configuration

Ansible was used to automate the configuration of the ELK machine. No configuration was performed manually, which is advantageous because it eliminates human error, is repeatable and can be deployed at scale.

The playbook implements the following tasks:

- Download docker image
- Install python-3-pip
- Install docker
- Adjust Virtual Memory 
- Download and launch ELK container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/docker_ps_output.PNG)

### Target Machines & Beats

This ELK server is configured to monitor the following machines:

| Name   | Function | IP Address | Operating System             |
| ------ | -------- | ---------- | ---------------------------- |
| Web-01 | DVWA     | 10.1.0.5   | Linux UbuntuServer 18.04-LTS |
| Web-02 | DVWA     | 10.1.0.6   | Linux UbuntuServer 18.04-LTS |
| Web-02 | DVWA     | 10.1.0.7   | Linux UbuntuServer 18.04-LTS |

We have installed the following Beats on these machines:

- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:

- Filebeat has the ability to collect any type of log data.  Our example is collecting syslog data.  Below is screenshot of our syslog data collection within Kabana.

  ![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/filebeat%202.PNG)

- Metricbeat has the ability to collect system health metrics such as CPU utilization, disk usage, network bandwidth I/O.  Below is a Kibana screenshot of metricbeat data of our three web server withing the Kibana console

  ![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/metricbeat2.PNG)


### Using the Playbook ELK

In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:

- Download and Copy the install-elk.yml file to /etc/ansible/.

  ```
  curl -LJO https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Ansible/install-elk.yml
  ```

- Update the host file on the ansible control node located `/etc/ansible/hosts` to include Elk VM IP address (10.0.0.4)

  ```
   # /etc/ansible/hosts
   [webservers]
   10.1.0.5 ansible_python_interpreter=/usr/bin/python3
   10.1.0.6 ansible_python_interpreter=/usr/bin/python3
   10.1.0.7 ansible_python_interpreter=/usr/bin/python3
  
   [elk]
   10.0.0.4 ansible_python_interpreter=/usr/bin/python3
  ```

  Filebeats will be install on the devices under the `[webserver]` section and the ELK stack will be in stalled on devices under `[elk]` 

- Run the  playbook `ansible-playbook /etc/ansible/install-elk.yml` , and navigate to port ` http://[your.ELK-VM.External.IP]:5601/app/kibana`  to check that the installation worked as expected.  You should get a screen as follows:

  ![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/kibana2.PNG)

### Installing Beats

- ##### Filebeats

  - Download filebeat-conf.yml

    ```
    curl -LJO https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Ansible/filebeat-config.yml
    ```

  - Edit filebeat-conf.yml to reflect the 2 following entries - 10.0.0.4 is the IP address of my Elk server.

    ```
     output.elasticsearch:
      hosts: ["10.0.0.4:9200"]
      
      setup.kibana:
      host: "10.0.0.4:5601" 
    ```

  - Save this file in `/etc/ansible/files/filebeat-config.yml`

  - Download filebeat-playbook-yml

    ```
    curl -LJO https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Ansible/filebeat-playbook.yml
    ```

  - Save this file in `/etc/ansible/roles/filebeat-playbook.yml`

  - Run the file-beat-playbook to install filebeat agent on all webservers.

    ```
    ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
    ```

    The below screenshot is from Kabana indicating proper communication between filebeat agents and the ELK stack.

    ![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/Capture.PNG)

- ##### Metricbeats

  - Download metric-conf.yml

    ```
    curl -LJO https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Ansible/metricbeat-config.yml
    ```

  - Edit metric-conf.yml to reflect the 2 following entries - 10.0.0.4 is the IP address of my Elk server.

    ```
    output.elasticsearch:
    hosts: ["10.0.0.4:9200"]
    
    setup.kibana:
    host: "10.0.0.4:5601"   
    ```

  - Save this file in `/etc/ansible/files/metric-config.yml`

  - Download metric-playbook-yml

    ```
    curl -LJO https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Ansible/metricbeat-playbook.yml
    ```

  - Save this file in `/etc/ansible/roles/metricbeat-playbook.yml`

  - Run the metric-beat-playbook to install metricbeat agent on all webservers.

    ```
    ansible-playbook /etc/ansible/roles/metric-playbook.yml
    ```

    The below screenshot is from Kabana indicating proper communication between metricbeat agents and the ELK stack.

    ![](https://github.com/gurk007/ELK-Stack-Deployment/blob/main/Diagrams/metricbeat.PNG)
