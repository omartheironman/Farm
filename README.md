# Farm

Taking good care of health and excercise is good, but we could take it to the next level and possibly explore solutions of having our own self maintained farm. 

Using rasperrypi + Python + GCP we can have our own automated self farm. 


# Infrastructure at my home =) #



Raspberrypi was used as main controlling source there are two main components running on the pi

 ## Circuit Interaction ##
 In the circuit interaction there is two main objectives 
 
 ### ReadSensor ###
 With sensor readings from moisture and temprature we constantly read data and have it scraped by prometheus with a job lavel
 Current sensors installed are capacitive sensors, and temperature sensors 
 ### TakeAction ###
 Using FlaskAPI a webhook endpoint is waiting for commands to be send by Grafana Alerting notification Policy
 the api is using auth basic to authenticate incoming calls from Grafana, additionally firewall rules have been setup to ensure only calls from grafana instance will be accepted 
 
 
# Infrastructure running on GCP #




