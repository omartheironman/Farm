# Farm

Taking good care of health and excercise is good, but we could take it to the next level by controlling what we consume with less GMO and possibly explore solutions of having our own self maintained farm. 

In this project, the aim was to explore and create a prototype of having an indoor ecosystem that is self maintained to produce harvest.
The farm uses rasperrypi + Python + GCP 


# The flow #

1. Sensors are scrapped by prometheus running on my raspberrypi 
2. Prometheus server hosted on my GKE scrapes the prometheus server of the raspberrypi including its critical metrics and sensors 
3. Grafana Alerting are set to certain thresholds to ensure certain readings do not go beyond a threshold for example water/moisture if they do notification policy will trigger and call webhook api running on the raspberrypi
4. Webhook api running on the raspberrypi will trigger an action based on the call for example turn water pump on 

![Alt text](./docs/Flow_Diagram.png?raw=true "Flow")
![Alt text](./docs/Dashbhoard_1.png?raw=true "Title")


# Infrastructure at my home#



Raspberrypi was used as main controlling source there are two main components running on the pi

 ## 1- Circuit Interaction ##
 In the circuit interaction there is two main objectives 
 
  ### 1.1 - ReadSensor ###
  With sensor readings from moisture and temprature we constantly read data and have it scraped by prometheus with a custom job lavel
  (Current sensors installed are capacitive sensors, and temperature sensors)
 ### 1.2 - TakeAction ###
  Using FlaskAPI a webhook endpoint is waiting for commands to be sent by Grafana alerting notification Policy,
  the api is using auth basic to authenticate incoming calls from Grafana, additionally firewall rules have been setup to ensure only calls from grafana instance     will be accepted 
 
 ## 2- Prometheus ##
 Prometheus was used to scrape data exported by custom exporter running on the pi device, which collects all sensor readings. This prometheus endpoint is then scraped by the GCP prometheus   server hosted on GKE
 
# Infrastructure running on GCP #


 ## Terragrunt ##
 Terragrunt was chosen for easier automation of my infrastructure and it also allows me to store my remote state on my bucket
 
 ## Terraform ##
 Using terraform providers to orchestrate my infrastructure deployment from Cluster, Nodepool, Service, Ingress to External IP

 ## Helmsman ##
 Helmsman was used to deploy prometheus and grafana to my infrastructure after terragrunt ran 


 ### To Do ###
 I am currently working on storing credentials into vault for Grafana as well as switching my Grafana into a Statefulset or keep my Grafana dashboard as code (Json) for easier automation 








