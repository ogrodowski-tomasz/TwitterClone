# TwitterClone
This is clone of popular app "Twitter". App supports iOS versions of 13.0 and above. App is fully created with:
- [x] Swift
- [x] UIKit
- [x] Google Firebase: Authentication and Realtime Database as well as Storage to store profile images
- [x] Cocoapods: SDWebImage and ActiveLabel
- [x] MVVM design pattern

### Why did I create this app?
Intention for creating this app was the desire to learn how to create an app with slightly more complicated navigation and data flow. Also, knowing Firebase libraries is an incredibly useful skill, I wanted to delve into it.

## Screenshots

### Registration and Loging pages
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/LoggingScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/LoggingScreen2.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/RegistrationScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/RegistrationScreen2.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/RegistrationScreen3.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/RegistrationScreen4.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/RegistrationScreen5.png" width=200>
</p>

### Feed
Feed contains Tweets only from FOLLOWED users. Tapping on like and comment buttons provides functionalities.
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/FeedScreen1.png" width=200>
</p>

### Profile View
Profile contains 3 tabs: Tweets uploaded by user, Replies of user, Liked Tweets. 
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ProfileScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ProfileScreen3.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ProfileScreen4.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ProfileScreen5.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ProfileScreen6.png" width=200>
</p>

### Edit Profile View
Edit profile screen lets modify information about username and bio that is shown in ProfileView's header. Every change is also uploaded to Firebase.
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/EditProfile1.png" width=200>
</p>

### Explore
Explore Tab is storage of all registered users. Tapping on one of them will navigate to his profile. User is capable of filter presented list with search bar.
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ExploreScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ExploreScreen2.png" width=200>
</p>

### Uploading new Tweet / Replying to Tweet
Uploading new Tweet can differ in terms of type: New Tweet, Reply to Tweet. Look is slightly different. Replying to Tweet functionality is provided by ActiveLabel pod.

<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/UploadTweet1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/UploadTweet2.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/UploadTweet3.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ReplyingScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/ReplyingScreen2.png" width=200>
</p>

### Notifications
2 types of notifications are provided: When user's post was liked, user was followed.
<p>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/NotificationsScreen1.png" width=200>
<img src="https://github.com/ogrodowski-tomasz/TwitterClone/blob/main/twitter-screenshots/NotificationsScreen2.png" width=200>
</p>

