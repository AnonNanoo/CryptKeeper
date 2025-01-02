# CryptKeeper
File encryption script for powershell and will later be available for bash!

# Status: Finished, needs more testing.

## Description
CryptKeeper is a simple yet powerful PowerShell script for encrypting and decrypting files. Keep your sensitive data safe with strong encryption algorithms, all wrapped in an easy-to-use command-line interface. Perfect for anyone who needs a lightweight and effective security solution! This script is based on AES (Advanced Encryption Standard), [read more about it here!](https://de.wikipedia.org/wiki/Advanced_Encryption_Standard)

## Features
- 🔐 Encrypt and decrypt files in a simple manner
- 📁 Support for multiple file types (Not tested yet)
- 🚀 Fast and efficient encryption
- 🔍 Detailed logging for audit and tracking

## Tutorial
Follow the steps below to use CryptKeeper:

### Step 1: Download and Install
![Download and Install](/images/)

To get started with CryptKeeper, you need to have at least PowerShell 7 installed on your system. You can download the latest version of PowerShell from the official PowerShell GitHub releases page. Ensuring you have the latest version of PowerShell will allow you to take full advantage of CryptKeeper's features and capabilities.

### Step 2: Running the Script
![Running the Script](/images/)

Once you have PowerShell installed, navigate to the folder where you have saved the CryptKeeper script. To do this, open a PowerShell terminal and use the cd command to change to the directory containing the script. It is recommended to run the script in administrator mode to avoid any permission issues. Execute the script by entering the command ./CryptKeeper. This will launch the CryptKeeper interface, ready for you to start encrypting or decrypting your files.

### Step 3: Encrypting a File
![Encrypting a File](/images/)

To encrypt a file using CryptKeeper, you will need to provide the input file, the desired output file, and a secure password. Follow the prompts in the script to enter these details. The script will then proceed to encrypt the input file, creating an encrypted version at the specified output location. Make sure to remember your password, as it will be required to decrypt the file later.

### Step 4: Decrypting a File
![Decrypting a File](/images/)

Decrypting a file with CryptKeeper is straightforward. You will be prompted to enter the input file (the encrypted file), the output file (where the decrypted content will be saved), and the password used during encryption. The script includes robust error handling, so if there are any issues with the decryption process, such as an incorrect password, you will be informed of the error and returned to the menu with details on what went wrong. This ensures a smooth and user-friendly experience while maintaining the security of your files.
