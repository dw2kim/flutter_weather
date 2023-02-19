# Flutter Weather App using BLoC

<p align="center">
  <img src="https://github.com/dw2kim/flutter_weather/blob/master/images/flutter_weather.gif?raw=true" height="600px">
</p>

This project will demonstrate:
1. How to manage multiple cubits to implement dynamic theming,
2. Pull to Refresh

This app will pull live weather data from the public OpenMeteo API, and
demonstrate how to separate our app into layers (data, repository, BL and presentation)


# Requirments
The app should let users
* search for a city on a dedicated search page
* see a pleasant depiction of the weather data returned by Open Meteo API
https://open-meteo.com/
* change the units displayed (metric vs. imperial)

# Key Concepts
* Observe state chagnes with BlocObserver
* BlocProvide - Flutter widget that provides a bloc to its children
* BlocBuilder - Flutter widget that handles building the widget in response to new states
* Prevent unnecessary rebuilds with Equatable
* RepositoryProvide - Flutter widget that provides a repository to its children
* BlocListener - Flutter widget that invokes the listener code in response to state changes in the bloc
* MultiBlocProvider - Flutter widget that merges multiple BlocProvider widgets into one
* BlocConsumer - Flutter widget that exposes a builder and listner in order to react to new states
* HydratedBloc to manage and persist state

# Architecture
1. Data: retrieve RAW weather data from the API
2. Repository: abstract the data layer and expose domain models for the app to consume
3. Business Logic: manage the state of each feature (unit info, city details, theme, etc.)
4. Presentation: display weather info and collect input from users (settings page, search page, and etc.)

# Data Layer
Two endpoints
1. Get a `Location` for a given `city name`
https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1

2. Get the `Weather` for a given `Location`
https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true

