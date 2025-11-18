# Reddit Home - iOS App

Swift • UIKit • MVVM • SwiftUI • Unit Testing

A lightweight iOS application that consumes Reddit's public feed
endpoint (`/.json`) to display a list of posts, fetch images/thumbnails,
and navigate to a detailed post view. Built as part of a technical
assignment with focus on clean architecture, modularity, testability,
and production-ready structure.

## Features

-   Fetch Reddit public feed from https://www.reddit.com/.json
-   Post list with title, upvotes, comments, and optional image
-   Pull-to-refresh
-   Loading, Error, and Content states
-   Detail screen using SwiftUI
-   MVVM architecture
-   Decoupled networking with APIRouter
-   UIKit + SwiftUI hybrid UI
-   Unit tests for ViewModels and JSON decoding

## Architecture

MVVM + Clean Networking Layer

    Presentation (UIKit + SwiftUI Views)
    ViewModels
    Models
    Networking (NetworkManager, APIRouter, APIConstants)

## Project Structure

    App/
    Constants/
    Networking/
    Models/
    ViewModels/
    Views/
    Tests/

## Networking

APIRouter is designed for scalability

## Testing

Unit tests for: - ViewModel state transitions - JSON decoding - Mocked
Network layer

## How to Run

1.  Xcode 15+
2.  Select a simulator
3.  Run with CMD + R

## Author

Camilo Ibarra Yepes
