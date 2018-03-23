# Contacts CLI

> Contact Storage Using Firebase Realtime Database

<a target="_blank" href="https://github.com/mskian/contacts-bash/blob/master/LICENSE" title="License: GPL"><img src="https://img.shields.io/badge/License-MIT-orange.svg"></a>

## Requirements

- Firebase
- jq
- cURL

## Supported Platforms

- Linux Based Systems
- MAC OS
- Windows 10 - https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/
- Android - Use Termux Terminal Emulator - https://play.google.com/store/apps/details?id=com.termux&hl=en

## SETUP Firebase Realtime Database

- Open New Project on Firebase - [https://firebase.google.com/](https://firebase.google.com/)
- After Creating a New Project
- Goto **Database**
- Click **GET STARTED** on Realtime Database
- Goto **RULES**
- Replace the Default Rules & Add this Below Database rules

```
{
  "rules": {
    ".read": "auth != true",
    ".write": "auth != true"
  }
}
```

- Click Publish to Update the Rules
- Next Goto **DATA** you can Find the Firebase Realtime Database URL that is your Database URL

## Installation

- Download the Script

```
wget --no-check-certificate https://gist.githubusercontent.com/mskian/4a0aa14382dd53c488b1deb1a92a37cd/raw/cab4c23508362570b0c8aabb8af56a3e152b6e84/contacts.sh
```


- open `contacts.sh` File
- Find this line `# Firebase Realtime Database URL` & Update your Database URL
- Save the File & Set Permission the Execute the Script

```
chmod +x contacts.sh
```

- Run the Script

```
./contacts.sh
```


## Usage

- Add Contact

```
./contacts.sh -a
```

- Display the Contact List

```
./contacts.sh -c
```

- Display the Help Message

```
./contacts.sh -h
```

- Check the Script Version

```
./contacts.sh -v
```

## Security

Don't share your Firebase Database URL in Public

## Contribute


Just Fork & Send Pull Request


## License

MIT
