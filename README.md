# Addis Ababa Science and Technology University Christian Students Fellowship Mobile Application

Welcome to the Addis Ababa Science and Technology University Christian Students Fellowship (AASTU ECSF) Mobile Application project! This repository contains the source code and documentation for the AASTU ECSF Mobile App.

## Features

- Daily Devotion: Access daily devotionals to nurture your spiritual growth.
- Fellowship Information: Stay updated with the latest news, events, and announcements from the AASTU CSF community.
- Wallpapers: Customize your mobile experience with a collection of inspiring wallpapers.
- In-App YouTube Player: Enjoy ad-free playback of fellowship videos directly within the app.
- Chat with Counseling Team: Connect with dedicated counselors for guidance and support.
- And more: Explore additional features designed to enhance your fellowship experience.

## Contributors

We welcome and appreciate contributions from the open source community. If you would like to contribute to the AASTU CSF Mobile App project, please follow the guidelines outlined in the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## Installation

To run the AASTU CSF Mobile App locally, follow these steps:

1. Clone the repository: `git clone https://github.com/your-username/AASTU-CSF-Mobile-App.git`
2. Install the necessary dependencies: `flutter pub get`
3. Launch the app on a simulator or device: `flutter` or `F5`
## Folder Structure

Here is an overview of the project's folder structure:

AASTU-CSF-Mobile-App/
├── assets/ # Images, fonts, and other static assets
├── route/
│ ├── about_screen/ # About Us pages
│ ├── auth_screen/ # Login and SignUp 
│ ├── blog_screen/ # Devotion and Blogs
│ ├── chat_screen/ # Chat Bot Screen
│ ├── gallery_screen/ # Gallery Page
│ ├── home_screen/ # Home page nad bottom navigation
│ └── Features # Event, Team and Wallpapers
│
├── README.md # Project documentation (you are here)
├── CONTRIBUTING.md # Guidelines for contributing to the project
└── LICENSE # License information

## Firebase Database Structure
The AASTU CSF Mobile App uses Firebase as its backend. Below is a simplified representation of the Firebase database structure:
`
{
"devotionals": {
"devotional1": {
"title": "Devotional 1",
"content": "..."
},
...
},
"fellowshipInfo": {
"announcements": {
"announcement1": {
"title": "Announcement 1",
"description": "..."
},
...
},
"events": {
"event1": {
"title": "Event 1",
"date": "..."
},
...
}
},
"wallpapers": {
"wallpaper1": {
"url": "..."
},
...
},
...
} `


For a more detailed overview of the Firebase database structure and configuration, please refer to our [Firebase Documentation](./docs/firebase.md).

## License
This project is licensed under the [MIT License](./LICENSE).
