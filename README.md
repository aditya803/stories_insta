# Instagram Stories Feature

## Overview

This Flutter application implements a simplified version of the Instagram Stories feature. It allows users to view a series of "stories" in a horizontally scrollable list. The focus is on the user interface and interaction, with data served by a backend API.

## Setup Instructions

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run the app using `flutter run`.

## Running Tests

To run unit tests:
```sh
flutter test
```

##Architecture and Design Choices

1. I have used Provider package for state management to manage application state.
2. I have also seperated code on the basis of its function namely UI, State, Model, Data.
3. Fetched data from a backend API to ensure scalability.
4. At first I wrote the whole UI and other functions in just main.dart thinking it will be a small implementation. But however, later applied state management and segregated code on the basis of funcationality. 
