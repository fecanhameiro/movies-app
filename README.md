# MoviesAppUIKit

MoviesAppUIKit is an iOS application written in Swift that integrates with the IMDb API, allowing users to search for movies and view their details. This application was designed to fulfill a coding exercise that tests understanding and application of various iOS development concepts, such as API integration, UI design and user interaction handling.

## Features

1. **Search Bar**: The application provides a search bar where users can input keywords to search for movies.

<img
  src="assets/swift-uikit/swift-search_iphone13starlight_portrait.png"
  alt="Alt text"
  title="Swift UI Kit - Home"
  style="display: inline-block; margin: 0 auto; height: 300px">

2. **Fetching Movies**: Upon a search query, the application fetches a list of matching movies from the IMDb API.

3. **Displaying Search Results**: The search results are displayed in a collection view with each cell showcasing the movie's title, poster image, and rating.

4. **Detailed Movie Information**: Tapping on a collection view cell opens a detailed view that displays more information about the selected movie, including the plot, release date, and cast members.

5. **Error Handling**: The application implements proper error handling mechanisms and displays appropriate error messages if the API request fails or no movies are found for the given search query.

## Architecture

The application follows the Model-View-ViewModel (MVVM) architectural pattern. The `ViewModel` classes handle the business logic, network requests and data manipulation, while the `View` classes are responsible for displaying the data on the screen.

## Accessibility

The application provides image accessibility by adding accessibility labels to images. This ensures that the content is accessible to all users, including those with visual impairments who may be using VoiceOver.

## Components

Here are some key classes and their roles in the application:

- `MAMovieListView`: Handles showing the list of movies and loading state.
- `MAMovieDetailView`: Handles showing the detailed information of a selected movie.
- `MAMovieCollectionViewCell`: Displays the movie's title, poster image, and rating in the collection view.
- `RMHeaderSearchCollectionReusableView`: Provides a search bar for users to input their movie search keywords.
- `MAService` & `MARequest`: Responsible for making network requests and handling the responses.
  
## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## How to Run

1. Clone the repository to your local machine.
2. Open the `.xcodeproj` file in Xcode.
3. Select the appropriate target (your connected iOS device or a simulator) in the drop-down menu to the right of the "Run" and "Stop" buttons on the top left of the Xcode interface.
4. Click "Run" and wait for the app to build and run.

## Note

This application was designed as part of a coding exercise and serves as a demonstration of iOS development skills. The code is provided as-is and the developer assumes no responsibility for any misuse.
