library weather_repository;

export 'src/models/models.dart';
export 'src/weather_repository.dart';

// The goal of our repository layer is to abstract our data layer 
//and facilitate communication with the bloc layer. 

//In doing this, the rest of our code base depends only on 
//functions exposed by our repository layer 
//instead of specific data provider implementations. 

//This allows us to change data providers without 
//disrupting any of the application-level code. 

//For example, if we decide to migrate away from metaweather, 
//we should be able to create a new API client and 
//swap it out without having to make changes to 
//the public API of the repository or application layers.