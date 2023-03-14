# ``WeatherAPIFramework``

Using openweathermap, this framework will return for you the weather of your chosen city

## Installation

To work with this framework you need to : 

First : import it to your project 

Second : using import WeatherAPIFramework in your controller

Third : use the class to call the API

WeatherApiCalls.shared.getWeatherInfo(for: cityName) {[weak self] result in
    guard let self = self else {return}
    switch result {
    case .success(let success):
        print(success)
    case .failure(let failure):
        print(failure)
    }
}

## Topics

