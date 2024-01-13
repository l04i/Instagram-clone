# Instagram Clone

This repository contains an Instagram clone app built using the Flutter framework with Firebase integration. The app utilizes the Provider package for state management and leverages Firebase for backend functionality.

## Features

- **Login and Signup UI with Firebase Authentication**: Users can create new accounts or log in to existing ones using their email and password. Firebase Authentication is used for secure user authentication.

- **Posts Screen and Real-time Updates**: The app includes a posts screen where users can view posts from other users. The posts are updated in real-time, providing a dynamic user experience.

- **Deleting Posts**: Users can delete their own posts. The app handles the deletion process and updates the posts screen accordingly.

- **Comments Screen and Real-time Updates**: Users can view and add comments to posts. The comments are updated in real-time, allowing for interactive discussions within the app.

- **User Search by Username**: The app provides a search functionality that allows users to search for other users based on their usernames. This feature facilitates finding and connecting with specific users.

- **Like Animation**: When users like a post, the app includes a visually appealing animation to provide immediate feedback and enhance the user experience.

- **Follow and Unfollow Users**: Users can choose to follow other users and receive updates on their posts. They can also unfollow users at any time.

- **Signout**: The app includes a signout feature that allows users to securely log out of their accounts.

## Getting Started

To run the Instagram clone app locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/l04i/InstagramClone.git
   ```

2. Change into the project directory:
   ````bash
   cd instagram_clone
   ```

3. Install the dependencies:
   ````bash
   flutter pub get
   ```

4. Connect Firebase Backend:
   - Create a new Firebase project.
   - Enable Firebase Authentication and set up necessary sign-in methods.
   - Set up Firebase Realtime Database or Firestore to store and retrieve data for posts, comments, and user information.
   - Update the Firebase configuration in the app by replacing the existing configuration files with your own.

5. Run the app:
   ````bash
   flutter run
   ```

