import pyrebase

config = {
  "apiKey": "AIzaSyCMIKySyTQfzDtZKfdp9bAFR-4mx44nvb8",
  "authDomain": "projectId.firebaseapp.com",
  "databaseURL": "https://breathable-f5a44.firebaseio.com",
  "storageBucket": "projectId.appspot.com"
}

firebase = pyrebase.initialize_app(config)


db = firebase.database()
db.update({"airGraph": ""})
db.update({"airScore": ""})
db.update({"humidityGraph": ""})
db.update({"humidityScore": ""})
db.update({"severityGraph": ""})
db.update({"severityScore": ""})
db.update({"temparatureGraph": ""})
db.update({"temperatureScore": ""})

