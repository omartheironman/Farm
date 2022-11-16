# Farm

Taking good care of health and excercise is good, but we could take it to the next level and possibly explore solutions of having our own self maintained farm. 

Using rasperrypi + Python + GCP we can have our own automated self farm. 


# The flow #

1. Sensors are scrapped by prometheus running on my raspberrypi 
2. Prometheus server hosted on my GKE scrapes the prometheus server of the raspberrypi including its critical metrics and sensors 
3. Grafana Alerting are set to certain thresholds to ensure certain readings do not go beyond a threshold for example water/moisture if they do notification policy will trigger and call webhook api running on the raspberrypi
4. Webhook api running on the raspberrypi will trigger an action based on the call for example turn water pump on 

![Alt text](./docs/Flow_Diagram.png?raw=true "Flow")
![Alt text](./docs/Dashbhoard_1.png?raw=true "Title")


# Infrastructure at my home =) #



Raspberrypi was used as main controlling source there are two main components running on the pi

 ## 1- Circuit Interaction ##
 In the circuit interaction there is two main objectives 
 
 ### 1.1 - ReadSensor ###
 With sensor readings from moisture and temprature we constantly read data and have it scraped by prometheus with a job lavel
 Current sensors installed are capacitive sensors, and temperature sensors 
 ### 1.2 - TakeAction ###
 Using FlaskAPI a webhook endpoint is waiting for commands to be send by Grafana Alerting notification Policy
 the api is using auth basic to authenticate incoming calls from Grafana, additionally firewall rules have been setup to ensure only calls from grafana instance will be accepted 
 
 ## 2- Prometheus ##
 Prometheus was used to scrape data exported by custom exporter, which collects all sensor readings. This prometheus endpoint is then scraped by the GCP prometheus   server hosted on GKE
 
# Infrastructure running on GCP #


 ## Terragrunt ##
 Terragrunt was chosen for easier automation of my infrastructure as it allows me to store my remote state on my bugget 
 
 ## Terraform ##
 Using terraform providers to orchestrate my infrastructure deployment from Nodepool, Service, Ingress and External IP

 ## Helmsman ##
 Helmsman was used to deploy prometheus and grafana to my infrastructure after terragrunt ran 


 ### To Do ###
 I am currently working on storing credentials into vault for Grafana as well as switching my Grafana into a Stateful or keep my Grafana dashboard for easier automation 








