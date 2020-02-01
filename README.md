# GRT-iOS-HelloWorld
An example of how to integrate the Gesture Recognition Toolkit into an
iPhone app


The [Gesture Recognition Toolkit](https://github.com/nickgillian/grt) is a "cross-platform, open-source, C++ machine learning library 
designed for real-time gesture recognition". This repository contains the project outlined in my blog posts, [Integrating the GRT into an 
iPhone app](https://www.nickarner.com/blog/2017/8/21/integrating-the-grt-into-an-iphone-app) and [Machine-Learning powered Gesture Recognition on iOS](https://www.nickarner.com/blog/machine-learning-powered-gesture-recognition-on-ios).

Here are some of the gestures I was able to train the system to 
recognize:

![Alt Text](https://github.com/narner/GRT-iOS-HelloWorld/raw/master/ReadmeResources/Gesture1.gif)

![Alt Text](https://github.com/narner/GRT-iOS-HelloWorld/raw/master/ReadmeResources/Gesture2.gif)

![Alt Text](https://github.com/narner/GRT-iOS-HelloWorld/raw/master/ReadmeResources/Gesture3.gif)

[SwiftR](https://github.com/kalanyuz/SwiftR) is used for visualizing 
the acellerometer data. 

If you'd like help with using the GRT in your Swift project, I can be 
reached at nicholasarner (at) gmail (dot) com.


## NOTE:
Since I worked on this project, there's been a lot of advancemenrts in [Apple's CoreML framework](https://developer.apple.com/documentation/coreml), including the ability to [create Motion Activity Classifiers using CreateML](https://developer.apple.com/videos/play/wwdc2019/426/). If you're looking to create a gestural recognition system for iOS from scratch, I would recommend taking a look at the linked Apple talk. 

Additional resources: 
* [Activity Classification with Create ML, CoreML3, and Skafos: Part 1](https://medium.com/skafosai/activity-classification-with-create-ml-coreml3-and-skafos-part-1-8f130b5701f6)

* [GestureAI-CoreML-iOS](https://github.com/akimach/GestureAI-CoreML-iOS)
