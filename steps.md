### Firebase invalid auth
`FirebaseError: HTTP Error: 401, Request had invalid authentication credentials. Expected OAuth 2 access token, login cookie or other valid authentication credential.`

* firebase login --reauth
https://stackoverflow.com/questions/52891500/http-error-401-while-setting-up-firebase-cloud-functions-for-android-project

### The pod "Firebase/Firestore" required by the plugin "cloud_firestore" requires a higher minimum iOS deployment
* Uninstall line in Podfile with min version
* Make it have an effect:
  * pod update Firebase/Firestore
  * pod install --repo-update
* 
https://stackoverflow.com/questions/78052754/the-pod-firebase-firestore-required-by-the-plugin-cloud-firestore-requires-a