# About KMA Reviews #

The system allows NaUKMA students to post reviews and evaluate courses and teachers. 
Only registered users can see reviews for some time without leaving their own reviews. After time is up, user should post his own review to have opportunity to read others reviews.

## How to install ##

Before you begin, you need a few things set up in your environment:
  - Xcode
  - 7.0 or later for Objective-C
  - 7.3 or later for Swift
  - An Xcode project targeting iOS 7 or above
  - The bundle identifier of your app
  - CocoaPods 1.0.0 or later
  
Then you need to add Firebase to your app
1. If you don't have an Xcode project yet, create one now.
2. Create a Podfile if you don't have one:
  $ cd your-project directory
  $ pod init
3. Add next pods:
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
4. Install the pods and open the .xcworkspace file to see the project in Xcode.
  $ pod install
  $ open your-project.xcworkspace


## Related projects ##

[Android App](https://github.com/SanchoPanchos/topchik-team-android)

[web](https://bitbucket.org/Oliko/kma-reviews)

Made by Topchik Team
