Original App Design Project - README 
===

# Sastrer

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
Sastreilor will allow tailors all around the world to ditch their notebooks by allowing them to have all of their measurements in a secure data base where they can access thru an application, this will not only help tailors but also will contribute to the fight agains global warming since lets paper usage will be in place.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Fashion
- **Mobile:** Sastreilor will be essential for people to track their jobs and store measurements in a centralized location to be easily access on their phone. the application will also send notifications when items are due to help them stay on course.
- **Story:** This application came to live as an idea due to my father jobs nature, he is a fashion designer and has always strugle to be able to devilered his job on time and to keep his measurement file intact and easy to find. i have always seem how he gets barried in papers with different measurements, hence i thought it this will help him in his strugles and help others that might face this rpoblem as well in his line of work.
- **Market:** Tailors are the main tarket for this application. 
- **Habit:** this application will become a habit for its users beacuse it will make their work life much easier and organize. 
- **Scope:** V1 allow users to login to their account, view a dashboard where they can get measurements see late jobs, view a list of all input customer measuremnts,see a list of to-do items and spand for additional details about the item clicked, be able to see their to do items in a calendar by daily view and monthly view. They will also be able to view and edit their profiles. 
## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**


- [x] **Use four Fragments**

- [x] **User can see Dashboard, customer measurments list,to-do items,a calendar view for the items due, and profile activity**

- [x] **User can input new measurements using textviews**

- [x] **Use one of the Navigation UI Views (BottomNavigation, Drawer Layout, Top Bar) to navigate between fragments**

- [x] **Users' customers measurments are stored in a database**
- [] **Users' customers measurments are stored in coredata, and then sent to database and sync when the app detects internet connectivity**

- [x] **Users can stay logged in after reopening app**

**Stretch Features**
- [ ] **to be develovep**
- [ ] **a list of delayed jobs in dashboard**

### 2. Screen Archetypes

- **Login Screen**
  - User can input email and password to login to their account or be prompted to  signs up a reset password screen is also available.
  
- **Stream screen** 
    
  - User can view a dashboard with capability to input measruments, short to due jobs, create a task(job)
  - User can view a list customer's measurments
  - User can view a to items that will display a list of to-do items that were made or fixed
  - User can have a calendar view of to-do items

- **Profile Screen**
  - Shows user Details and log out button
  - Additional features to be develop
 



- **Details Screen**
  - User can read the details of a selected customer job
  - User can view the  the measruments for an costumer and edit it
 

- **Creation Screen**
    - User can add a new customers measuments

### 3. Navigation

**Tab Navigation** (Tab to Screen)
- Dashboard
- Measurements 
- to-do items 
- calenadar view of to-dos


**Flow Navigation** (Screen to Screen)

- **Login Screen**
    => Dashboard fragment for displaying aditional items
    
    
- **Stream screen** 
  => To customer measruments entry screen
  => Detail screen for a customers upcoming job
  => Detail screen for a items that have already been delivered
  => Detail screen for canneting tasks to customers measurments for a new job
    
- **Creation Screen**
    => Back to Dashboard
    
    
- **Details Screen**
  => Back to their respective screens

- **Profile Screen**
  => Back to main screen Dashboard

## Wireframes

<img src="https://i.imgur.com/NokFRjr.jpg" width=600>
<img src="https://i.imgur.com/WKIBTm4.jpg" width=600>

### Digital Wireframes & Mockups

<img src="https://i.imgur.com/HLRiXev.png">

### Interactive Prototype
<!--<img src="https://i.imgur.com/I2ScXQN.gif">-->

![](https://i.imgur.com/kZ0jN5C.gif)

## SignIm,SignUP and Reset Password
|Improved version|
| ---|
|![](https://i.imgur.com/FOrHNHg.gif)|

## Build Progres: Video Walkthrough

Here's a walkthrough of implemented user stories:

| Dec 9, 2022 | Feb 26, 2023 | TBA, 2022 | TBA, 2022 
| --- | --- | --- | --- |
| ![](https://i.imgur.com/FHJo7DI.gif) | ![](https://i.imgur.com/Bf16OHh.gif) | ![]() | ![]() |


## Schema 

### Models
| Property | Type | Description |
| --- | --- | --- |
| `created At` | String | date of creation of anime and manga |
| `uodated At` | String | date of update of anime and manga |
| `synopsis` | String | summary of anime and manga |
| `title` | Object | containing three string: One english, japanese_english and japanese |
| `favorites count` | number | number of favorites anime and manga |
| `rating rank` | number | rating |
| `poster image` | Object | date of update |
| `cover image` | Object | date of update |



### Networking
- Home Feed Screen
   - (Read/Get) Query all popular anime and manga to be display
   - pick between anime and manga  
- Anime
   
   - top anime back drop, tittle and short overview
   - show latest Animes release
   - show popular animes right now 
- Details about animes/mangas
   - user can click and see preview of animes or mangas 
- Manga
   - top Manga back drop, tittle and short overview
   - show latest Animes release
   - show popular animes right now 

- An API of Kitsu
   - Base URL - [jikanApi](https://docs.api.jikan.moe/)

| HTTP Verb | EndPoint | Description |
| --- | --- | --- |
| `GET` | /Anime | Get current anime Series |
| `GET` | /Episode | get details about an expecific anime episode |
| `GEt` | /Trending Anime | Show most popular animes |
| `GET` | /Manga | Get current Manga Series |
| `GET` | /Chapters | get details about an expecific Manga episode |
| `GEt` | /Trending Manga| Show most popular Manga |

- An API of Parse  
   -base url server - https://parseapi.back4app.com  


| HTTP Verb | EndPoint | Description |
| --- | --- | --- |
| `GET` | /Users | access user data from the data base authenticate to log in |
| `GET` | /Basic Queries | to get data from the Database |
| `GEt` | /Sessions | keep current user loggedin |
   
