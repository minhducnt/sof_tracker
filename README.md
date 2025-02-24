# Technical_Interview_Assignment

## Technical assignment role for Mobile Developer position at TMA Solution

## Submission

Please read the README.md to run the project.

An application allow user to view list of StackOverflow (SOF) user, their reputation history and bookmark their favorite user.

## Getting Started

To run the app, clone the repository and follow the setup instructions. Once setup is complete, run the app.

## Initial Setup

To set up the project, run the following command to activate the project:

```bash
git clone https://github.com/minhducnt/TMA_Assignment.git
./run_gen_files.sh
```

Once the project is activated, run the following command with Terminal to initialise the project:

```bash
pod init && pod install
pod update
```

After the project is initialized, open the `.xcworkspace` and then Run the app

Or you can run by use F5 in Visual Studio Code.

## Features

- **User List**: Users can view a list of StackOverflow users.
- **Bookmark/de-bookmark** Users can bookmark their favorite users.
- **State Management**: GetX is used for efficient and fast state management throughout the application.
- **Local Database**: Hive is used for storing bookmarked users.
- **Internationalization**: Intl, Flutter Localization is used for internationalization in the application.
- **Network**: Retrofit is used for network calls in the application.
