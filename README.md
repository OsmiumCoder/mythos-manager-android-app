# Mythos Manager
Mythos Manager is a Dungeons & Dragons character management app that simplifies the creation and tracking of characters and campaigns. The app features character creation, and a campaign tracking tool, along with the ability to share characters with others.

## Features
**For a full breakdown of all the features and how to use the app please see the [Presentation](#Presentation) section of this README**

- Sidebar navigation

- Home page to navigate to main features of the app

- Character creator, and display pages for a character

- Campaign tracker, ability to create a campaign as well as notes for that campaign, and link a character to that campaign

- Public characters, to share and see shared characters


## Tech Stack

**Minimum SDK Version:** 21

**Main Framework:** Flutter, Dart

**State Management:** [Riverpod](https://riverpod.dev/)

**Dungeons & Dragons Data API:** [D&D 5e API](https://www.dnd5eapi.co/)

**Database:** Firebase/FireStore

**Dependencies:**
```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^2.27.1
  cloud_firestore: ^4.15.10
  firebase_auth: ^4.17.9
  hooks_riverpod: ^2.4.10
  google_fonts: ^6.2.1
  flutter_hooks: ^0.20.5
  http: ^1.2.0
  firebase_app_check: ^0.2.1+19

dev_dependencies:
  flutter_test:
    sdk: flutter

  mockito: ^5.4.4
  network_image_mock: ^2.1.1
  mocktail: ^1.0.3
  fake_cloud_firestore: ^2.4.8
  firebase_auth_mocks: ^0.13.0

  flutter_lints: ^3.0.1
```
## Running Tests

*Tests were written prior to the writing of source code as per **Test-Driven-Development** standards.*

As of current **108** tests have been created.

To run tests, run the following command

```bash
  flutter test
```

## Authors
**For exact contributions refer to comments at the top of each file. Also see the project board for Issue and Pull Request breakdown**

- [@osmiumcoder](https://github.com/osmiumcoder) (Jonathon Meney)
    - implemented backend
    - mockups for frontend

- [@Crounic](https://github.com/Crounic) (Shreif Abdalla)
    - frontend screens
    - connecting frontend to backend

- [@welshy557](https://github.com/welshy557) (Liam Welsh)
    -  frontend screens
    - connecting frontend to backend

## Roadmap

- Homebrew creation and the ability to share homebrew creations, would include spells and classes

- The ability to go back and edit existing characters

- Add Campaign groups, would include group chat calendar scheduler, share notes

## Presentation
The presentation PDF can be found [here](presentation/CS-3130%20-%20Android%20Final%20Project%20Presentation.pdf).

## Mockups
All mockups can be found [here](mockups)