# Outreachy December 2023 to March 2024 Applicants


<p align="center">
  <a href="" rel="noopener">
 <img src="https://github.com/mercyjae/Mboacare_Main/assets/83911888/7da75047-56da-424a-b20d-18fdf3c6c0e5" alt="Project logo", ></a>
</p>
<h5 align="center">Mboacare</h5>






                                      **Project's Tagline:**
**Project's Tagline:**
This repository is dedicated to tracking the progress of our project for the contribution phase. We will be using it to report on our project and keep a record of our work.


# mboacare
The app we are developing is named "**mboacare.**" This name is derived from a combination of "Mboalab," which is the name of the organization we are contributing for, and "care," representing the focus of the app on medical facilities and healthcare services.


## 🧐 Problem Statement <a name = "problem_statement"></a>
"In the global world of healthcare, the ability to efficiently connect medical facilities and provide accessible healthcare services remains a persistent challenge which cause mortality in the society. Patients often face challenges in locating hospital with medical facilities to treat a particular disease/illness, while hospitals struggle to refer patients to appropriate specialized centers. As a result, there is a significant need for a  platform that bridges the gap in healthcare connectivity.


## 💡 Solution <a name = "idea"></a>
The "Mboacare" project seeks to address these challenges by providing an app where hospitals can register their facilities, enabling seamless patient referrals and empowering patients to easily locate and access the healthcare services they require. Its primary goal is to improve healthcare connectivity.
 This project aims to revolutionize healthcare connectivity, making it more accessible and reducing mortality rate.


**Project's Tagline:** ""Your health, Simplified!"

# Project's Aim:

## Create a platform to link-up medical facilities globally:

Our aim is to develop a platform that allows users to easily find and connect with medical facilities around the world. You're on the hunt for top-notch healthcare recommendations, whether you're in your own state or in a whole different country. You just want an easy-peasy way to find hospitals that offer a wide range of healthcare services, from regular to specialized facilities. No more wasting hours on Google and clicking through a gazillion hospital websites. That's where our super awesome app swoops in.

It's a game-changer in terms of usability and convenience. Just a few clicks and you can access a comprehensive list of hospitals, filter them according to your specific needs, and even contact them with ease.

But here's the best part: our app goes beyond the boundaries of a single hospital or location. We are focused on providing a global healthcare experience. You can explore healthcare facilities from different parts of the world, compare their services, and make informed decisions. Whether you are planning a trip abroad or searching for the best healthcare options locally, our app has got you covered. And it's not just for patients! Healthcare facilities can also register and showcase their services on our platform, giving them the opportunity to reach a global audience.

## Getting Started 🚀

## Prerequisites
- Flutter and dart SDK 
- Any preffered IDE(integrated development environment)
- Android Emulator or Physical Device (for Android development):
- iOS Simulator or Physical Device (for iOS development):
- Basic knowledge of firebase.

## Installation Guide
- Navigate to the project directory: `cd your-project`
- Clone the repository:
    ````
     git clone https://github.com/Mboacare_Main.git
    ````  
 

## 🎈 Usage <a name="usage"></a>
- Install Flutter Dependencies:
  - Run the flutter pub get command to fetch and install the Flutter project's dependencies:
    ````
<<<<<<< HEAD
    $ flutter pub get
    ````
     - Example:
    ````
    $ git checkout -b BRANCH_NAME
    ````
=======
     flutter pub get
    ````    
>>>>>>> bc2455598b1d28ab7ba3fd9d4210c3b29760a8a2
- Run the Project:
  - To run the Flutter project, use the flutter run command:
    ````
     flutter run
    ````
   
## ⛏️ Built With <a name = "tech_stack"></a>
- [Flutter](https://flutter.dev/) - Framework

- [Dart](https://dart.dev/) - Language

- [Firebase](https://firebase.google.com/) - Database and Authenticaion.


## Contributing Guide 🚀
 To contribute to this project, please follow these steps:
- Fork the repo
  - <https://github.com/Mboacare_Main.git>
- Clone the forked repo.
  - - <https://github.com/$username/Mboacare_Main.git>
- Check out a new branch based and name it to what you intend to do:
  - Example:
    ````
     git checkout -b BRANCH_NAME
    ````
    
  - Use one branch per fix / feature
- Commit your changes
  - Please provide a git message that explains what you've done
  - Please make sure your commits follow the [conventions](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53#file-commit-message-guidelines-md)
  - Commit to the forked repository
  - Example:
    ````
     git commit -am 'Add some fooBar'
    ````
- Push to the branch
  - Example:
    ````
     git push origin BRANCH_NAME
    ````
- Make a pull request
  - Submit a pull request, providing a clear description of your changes.
    
  ## Build an APK🚀
-  Enter cd [project]
- Run: flutter build apk --split-per-abi
(The flutter build command defaults to --release.)
This command results in three APK files:

- [project]/build/app/outputs/apk/release/app-armeabi-v7a-release.apk
- [project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk
- [project]/build/app/outputs/apk/release/app-x86_64-release.apk
  
Removing the `--split-per-abi` flag results in a fat APK that contains your code compiled for all the target ABIs. Such APKs are larger in size than their split counterparts, causing the user to download native binaries that are not applicable to their device’s architecture.

## Install APK on Android Device
Load one of the *.apk files listed above. Which file to load depends on what kind of processor is running on your device.
  
# Features:

- Splash Screen
  - The splash screen gives a good user experience.
- User Authentication
  - User can create account, log in and reset their forgotten password.
- Hospital Registration
  - Hospital can signup by filling a form which consist of their the contact details, services, facilities,hospital size, hospital type(pulic/private), bed capacity, hospital ownership and image.
- Main Dashboard
 - The hospital dashboard shows a list of all the hospitals with the service offered, facilities present, name, address and images .
- Social Media Integration
 - User can join the mboalab community on Likendin
- Hospital Profiles
  - It provides information about each hospital e.g address, phone number, email facilities available, service offered etc.
- Search Functionality
 - Users are able to search for names of hospital.
- Filtering and Sorting
  - Hospitals are filtered based on the services and facilities.

  

# Coding Guidelines


- Naming Conventions:
  - Use camelCase for variable and function names.
  - Use PascalCase for class, mixin, enum and extension names.
  - Use UPPER_CASE for constants.
  - Maintain consistent naming, formatting, and code organization across the project.

- File and Directory Structure:
  - Organize your project files and directories logically, grouping related    code together.
  - Use clear and meaningful names for directories and files.

- Widgets and Components:
  - Use descriptive names for custom widgets and components.
  - Break complex widgets into smaller, reusable components.  
- Linte Rules:
 - Do not ```//ignore for file: $lint_rule``` lint rules in your code.

- Error Handling:
  - Properly handle exceptions and errors in your code.
  - Avoid using generic error handling statements when more specific ones are appropriate.

### Design Guidelines


**Extra Features:**
- We used a third-party API service (SendGrid) to send personalized emails to both users and hospitals. Welcome emails for successful user registrations and validation emails for hospitals post-registration. 
- We've incorporated Firebase authentication, making it easy for users to log in with email and Google accounts. Our app also utilizes additional Firebase Authentication features such as email verification and password reset for users' convenience.
- We chose Firebase Cloud Firestore to effectively manage our database. This helped us easily create, read, update, and delete data.
- We also made use of Firebase Storage, a service in the cloud, to safely store and retrieve user-uploaded content, such as pictures, videos, and files.

# **What's Ahead: Future Features:**
**Anisha's suggestions:**
- AI recommendations: Personalized hospital suggestions on the dashboard.
- Bookmark feature: Save and organize facilities on hospital details page for easy access.
- Dark mode: Enable dark mode in settings.
- Track history: Save booked appointment records.
- Refer: Share users' medical history.
- Geolocation: Search and view medical facilities, get directions based on location.(Google Map)

**Deborah's suggestions:**
- Telemedicine Integration: Incorporate telemedicine capabilities, allowing users to have virtual consultations with doctors.
- Real-Time Availability: Display real-time availability of appointments, allowing users to book slots instantly.
- Ratings and Reviews: Implement a robust rating and review system for users to share their experiences and help others make informed decisions.
- Multilingual Support: Offer language options for users to access the app in their preferred language.
- Health Tips and Articles: Provide a section with informative articles and health tips related to various medical conditions and wellness.
- Community Forum: Create a platform for users to engage in discussions, ask questions, and share healthcare-related information.

*"Our progress is on track, and the collaboration between design and development is really paying off.*


## ✍️ Contributors <a name = "contributors"></a>:

- [Anisha](https://github.com/AnishaSingh0118)
- [Deborah](https://github.com/dearlydebbie)
