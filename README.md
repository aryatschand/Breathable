# Breathable
Created by Arya Tschand, Lyndon Puzon, Joshua Rakovitsky and Varun Tupuri 9/14/19

Breathable is a mobile app combined with a web server that uses real time arduino sensor data and gps tracking information to determine an overall air quality score sing machine learning

##Inspiration
Two of our team members have often visited India and noticed that the air quality is significantly worse in many urban areas than the U.S. and other Western countries. There is no readily available and cost efficient way for people to understand the poor quality of the air in and around their home. Our project aims to combat this issue of providing an easy to use interface to not only determine the severity of the situation in their house but also to diagnose potential causes and provide solutions.

##What it does
Breathable is an IOS application that projects to the user various statistics of the air quality in their environment. It also includes helpful resources like a quiz that would educate users of the severity of air pollution in their environment.

##How we built it
There are three main components to this project: hardware, the mobile app, and the web server. For the hardware component, a temperature sensor, humidity sensor, and particulate matter sensor, wired using bluetooth to send data to and from the app. A GPS tracker was also used to send location data to the web server. After receiving data from the arduino, the mobile app would forward the information along through our custom built API. The data was then analyzed through a machine learning algorithm to return a total severity score.

##Challenges we ran into
We easily got data to pass from the arduino to the phone to the web server through the API, however, we were struggling to send data back through the API and web server into the IOS app. We eventually solved this by connecting to a firebase and having the IOS app reading from their

##Accomplishments that we're proud of
We are proud that we were able to figure out how to host our own web server and domain with our custom-built REST API.

##What we learned
We learned how to make our own REST Api using python and connect to our web server backend. None of the members of our team had experience using web servers so this required quite a learning curve. All of the arduino sensors were also brand new to use so it took us a significant amount of time to set them up and get them working accurately.

##What's next for Breathable
In the future we would like to come out with a cleaner user interface for the user and come out with more reliable user data for a better user experience. This would likely be improved with stronger and more accurate sensors than the ones we’re currently using.
