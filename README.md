[![Swift 5.6](https://img.shields.io/badge/Swift-5.6-red)](https://swift.org/download/)
![SwiftUI 3.0](https://img.shields.io/badge/SwiftUI-3.0-red)
[![@artlast](https://img.shields.io/badge/telegram-%40artlast-blue)](https://t.me/artlast)

# JustWeather
![promo_gif](https://user-images.githubusercontent.com/62947475/171035717-e0423a80-85dd-4645-ac1c-bc48de3785d4.gif)

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Screenshots](#screenshots)
* [Requirements](#requirements)
* [Important notes](#important-notes)

## General Information
This is a simple weather app. The app uses [OpenWeather API](https://openweathermap.org/api/one-call-api#current) to get weather data.

The app has the ability to search by locations. For this purpose, the app uses `MapKit`. When the user taps on a search result, the app sends the name of the location to `CoreLocation` to get the coordinates. If it retrieves the coordinates successfully, the application uses them for API request.

All favorite cities app saves in Documents Directory.

## Technologies Used
* Swift 5.6
* SwiftUI
* MapKit
* CoreLocation
* FileManager
* UserDefaults
* MVVM

## Features
* Weather data at user location
* Search locations by city
* Add cities to favorites
* Choice between measurement systems

## Screenshots
<img src="https://user-images.githubusercontent.com/62947475/171035800-a9b28db9-2a5a-414c-a937-df754f8460a1.png" height="320"> <img src="https://user-images.githubusercontent.com/62947475/171035804-4a620d6b-be0c-4521-af62-73c57ff43ede.png" height="320"> <img src="https://user-images.githubusercontent.com/62947475/171035792-f79f9b49-a76e-47ff-8575-6ddd2a88295d.png" height="320"> <img src="https://user-images.githubusercontent.com/62947475/171035806-fdd33d10-0751-4217-8456-ede6af7d27c6.png" height="320"> <img src="https://user-images.githubusercontent.com/62947475/171035808-c29866cb-2ef9-45d7-b86e-d2120f662bba.png" height="320">

## Requirements
* Xcode 13 or later
* iOS 15 or later

## Important notes
Don't forget to specify API key in `WeatherService.swift`:

```swift
private let apiKey = "" // <- ADD API KEY HERE
```

You can get one on https://openweathermap.org/
