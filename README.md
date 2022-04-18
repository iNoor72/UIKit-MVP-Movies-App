# VeryCreatives-Task

VeryCreativesTask is a project build for VeryCreatives company.

## Description
This is my implementation for the task requested by VeryCreatives company. An iOS app to fetch movies from TMDB website with some cool features.
It's an iOS app that shows movies to the user with the ability to save favorited movies.

## Getting started
To run the project, clone the project and run the following commands:

```
cd "The path to the project on your machine"
pod install
```

## Features
- List the popular and top rated movies from TMDB website based on the user's preference.
- Detailed cell to show the name of the movie in a good looking border.
- MVP architecture with clean code principles.
- Unit test for the real services.
- Supporting iOS 12.0 and newer.
- Supporting all of the iPhone devices in the Portrait mode.
- Localized in both English and Arabic languages.

## Pods
- Alamofire: Used for all of the heavy work of networking in the app.
- AlamofireNetworkActivityLogger: Used to debug and log the networking activities for better network call debugging.
- Kingfisher: Used for fetching images for the movies, totally built on Alamofire.
- MOLH: Used for localization and to show more options on how to implement localization on the app. 

## How to run localization
- You can run the app in different languages to test the localization of the app, to do that, do the following:
```
Click (command + option + R) -> To run the app with custom options
Choose "Run" from the left menu.
Choose "Options" from the options list on the screen on the right.
Change the app language from "App Language" option from "System Language" to either Arabic or English.
Run the app.
```

- Or you can uncomment the lines numbered from 159 to 165 in the HomeViewController file in the Scenes directory, this option will make localization work but it requires the app to be forced to exit to make the localization change.

- The last option is using MOLH pod, and it's described in the project.

## Project status
The project is completed in what was mentioned in the requirements document, however, it could have been done with better Unit testing and it's missing the Landscape mode and Universal (iPhone & iPad) features.
