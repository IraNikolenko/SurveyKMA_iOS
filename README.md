SURVEY ABOUT QUALITY OF EDUCATION IN KMA

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
