
# Variables
[int] $menuinput # User input for menu selection
[string] $syncoptions # Sync options

# Project related variables
[string] $ProjectName = "CryptKeeper"
[string] $ProjectVersion = "0.0.0.1"
[string] $Tempfolder = [Environment]::GetFolderPath( 'LocalApplicationData' ) + "\CryptKeeper"

# Source and destination paths for file synchronization
[string] $inputPath = ""
[string] $outputPath = ""

# Password for encryption
[string]$password = ""

# File paths for settings and logs
[string] $settingsFilePath = "$Tempfolder\Settings.dll"
[string] $ErrorLogFilePath = "$Tempfolder\ErrorLog.log"
[string] $logFilePath = "$Tempfolder\CryptKeeper.log"
[string] $logMessage
[int] $corrupted

function encrypt {
    Clear-Host

    # Prompt user for inputs
    Write-Host "Enter the path to the input file (file to be encrypted)" -ForegroundColor Yellow
    $inputPath = Read-Host
    Write-Host "`nEnter the path to the output file (where the encrypted file will be saved)" -ForegroundColor Yellow
    $outputPath = Read-Host

    Write-Host "`nEnter the password for encryption" -ForegroundColor Cyan
    $password = Read-Host

    $inputExists = Test-Path $inputPath
    $passwordExists = $password.Length -ge 3

    if (-not $inputExists -or -not $passwordExists) {
        if (-not $inputExists) {
            Write-Host "`nInput file does not exist.`n" -ForegroundColor Red
        }
        if (-not $passwordExists) {
            Write-Host "`nPassword must be at least 3 characters long.`n" -ForegroundColor Red
        }

        Write-Host "Press any key to return to the menu..." -ForegroundColor Yellow
        Read-Host

        $inputExists = ""
        $passwordExists = ""

        menu
        return
    }

    # Ensure the output directory exists
    $outputDir = Split-Path $outputPath -Parent
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force
    }

    # Create the output file if it doesn't exist
    if (-not (Test-Path $outputPath)) {
        New-Item -ItemType File -Path $outputPath -Force
    }

    # Proceed with encryption logic here
    Write-Host "`nProceeding with encryption..." -ForegroundColor Green

    # Read the input file


    Write-Host $inputPath -ForegroundColor Green
    Write-Host $outputPath -ForegroundColor Green
    Write-Host $password -ForegroundColor Green

    # Somehow generate an IV (Initialization Vector) for AES encryption
    $iv = New-Object Byte[] 16
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($iv)

     # Read the input file
     $inputData = [System.IO.File]::ReadAllBytes($inputPath)

     # Display paths and password (remove in production for security reasons)
     Write-Host $inputPath -ForegroundColor Green
     Write-Host $outputPath -ForegroundColor Green
     Write-Host $password -ForegroundColor Green

     # Generate an IV (Initialization Vector) for AES encryption
     $iv = New-Object Byte[] 16
     [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($iv)

     # Hash the password using SHA256 to create a 256-bit key
     $sha256 = [System.Security.Cryptography.SHA256]::Create()
     $passwordBytes = [System.Text.Encoding]::UTF8.GetBytes($password)
     $hashedPassword = $sha256.ComputeHash($passwordBytes)

     # Create AES encryption object
     $aes = [System.Security.Cryptography.Aes]::Create()
     $aes.Key = $hashedPassword
     $aes.IV = $iv
     $aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
     $aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7

     # Encrypt the input data
     $encryptor = $aes.CreateEncryptor()

     # Combine the IV and encrypted data
     $finalData = $iv + $encryptedData

     # Write the encrypted data to the output file
     [System.IO.File]::WriteAllBytes($outputPath, $finalData)

     Write-Host "Encryption complete."
     Read-host
}


function logo {
    # This function prints the logo and welcome message to the console.
    [double] $time = 0.15
    clear-host
    Write-Host "   ______                 __  __ __                         " 
    Start-Sleep -Seconds $time
    Write-Host "  / ____/______  ______  / /_/ //_/__  ___  ____  ___  _____" 
    Start-Sleep -Seconds $time
    Write-Host " / /   / ___/ / / / __ \/ __/ ,< / _ \/ _ \/ __ \/ _ \/ ___/" 
    Start-Sleep -Seconds $time
    Write-Host "/ /___/ /  / /_/ / /_/ / /_/ /| /  __/  __/ /_/ /  __/ /    " 
    Start-Sleep -Seconds $time
    Write-Host "\____/_/   \__, / .___/\__/_/ |_\___/\___/ .___/\___/_/     " 
    Start-Sleep -Seconds $time
    Write-Host "          /____/_/                      /_/                 "
    Start-Sleep -Seconds $time
    Write-Host "                                                  ($ProjectVersion)"
    #Write-Host "===========================================================" -ForegroundColor blue

    [int] $i = 0
    do{
        $i++
        Start-Sleep -Milliseconds 5
        Write-Host "=" -NoNewline -ForegroundColor blue
    }until ($i -eq 60)
    Write-Host "`nWelcome to CryptKeeper!`n" 
    Write-Host "Booting CryptKeeper" -NoNewline

    [int] $i = 0
    do {
        $i++
        Start-Sleep -Seconds 1
        Write-Host "." -NoNewline
    }until ($i -eq 3)
    Write-Host "`n"
    Read-Host
}


function menu{
    do {
        clear-host
        Write-Host "`n==========================================="
        Write-Host "| $ProjectName (ver.$ProjectVersion)               |"
        Write-Host "|_________________________________________|"
        Write-Host "| (1) Encrypt now                         |"
        Write-Host "| (2) Open Log                            |"
        Write-Host "| (3) Sourcecode                          |"
        Write-Host "|                                         |"
        Write-Host "| (95) Deletion                           |"
        Write-Host "| (99) Exit                               |"
        Write-Host "|_________________________________________|`n"
        $menuinput = read-host "Please select an option"
        switch ( $menuinput ) {
            1 {
                log -logtype 1 -logMessage "Log: Initialized encryption dialogue"
                encrypt
                
            }
            2{
                log -logtype 1 -logMessage "Log: Printed log"
                printlog
            }
            3{
                log -logtype 1 -logMessage "Log: Printed source code"
                printSourceCode
            }
            95{
                log -logtype 1 -logMessage "Log: Initialized deletion dialogue"
                Write-Host "Are you sure you want to delete all the files in the Temp folder? (Y/N)" -ForegroundColor Red
                $syncoptions = Read-Host
                if ($syncoptions -eq "Y" -or $syncoptions -eq "y") {
                    Remove-Item -Path $Tempfolder -Recurse -Force

                    Write-Host "`nDeletion in progress" -ForegroundColor Red -NoNewline
                    [int] $i = 0
                    [int] $j = 0
                    do {
                        $i++
                        Start-Sleep -Seconds 0.2
                        Write-Host "." -NoNewline -ForegroundColor Red
                        if ($i -eq 3) {
                            Start-Sleep -Seconds 0.2
                            Write-Host "`b`b`b   `b`b`b" -NoNewline  # Remove the 3 dots
                            $i = 0
                            $j++
                        }
                    } until ($j -eq 3)

                    Write-Host "`n`nAll files in the Temp folder have been deleted." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                    Write-Host "`nGoodbye!" -ForegroundColor Green
                    exit
                }
                else {
                    log -logtype 1 -logMessage "Log: Deletion cancelled"
                    Write-Host "`nDeletion cancelled." -ForegroundColor Green
                    Start-Sleep -Seconds 1
                }
            }
            99 {
                log -logtype 1 -logMessage "Log: Ended CryptKeeper"
                Write-Host "Bye!"
                Start-Sleep -Seconds 1
                exit
            }
            default {
                log -logtype 1 -logMessage "Error: Invalid input in Menu"
                Write-host "Invalid input. Try again"
                Write-host "To exit, enter 99" -ForegroundColor Red
                Start-Sleep -Milliseconds 1500
            }
        }
        $menuinput = 0
    }until (0 -eq 1)

}

function printSourceCode {
    clear-host
    Write-Host "Source code for CryptKeeper" -ForegroundColor Yellow
    Write-Host "=============================" -ForegroundColor Yellow
    Write-Host "`n"
    Write-Host "https://github.com/AnonNanoo/CryptKeeper/src/Encrypt.ps1"
    Write-Host "`n"
    Write-Host "Press any key to return to the menu..." -ForegroundColor Yellow
    read-host
    menu
}


function log {
    # This function logs messages to the log file or error log file based on the given log type.
    param(
        [int]$logtype,
        [string]$logMessage
    )
    try {
        if ( (test-path -path $logFilePath ) -and $logtype -eq 1 ) {    # 1 is for normal log
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss" 
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $logFilePath -Append -Encoding utf8
        }
        elseif ((test-path -path $ErrorLogFilepath ) -and $logtype -eq 2) {   # 2 is for error log
            [string] $timestamp = Get-Date -Format  "dd-MM-yyyy HH:mm.sss"
            $logMessage = $logMessage + " at $timestamp"
            $logMessage | Out-File -FilePath $ErrorLogFilePath -Append -Encoding utf8
        }
    }
    catch {
        return
    }
}

function printlog {
    # This function prints the log file into the console.
    Clear-Host
    $logContent = Get-Content -Path $logFilePath
    foreach ($line in $logContent) {
        if ($line -match "Start:") {
            $originalColor = $Host.UI.RawUI.ForegroundColor
            $Host.UI.RawUI.ForegroundColor = "Green"
            $line | Out-Host
            $Host.UI.RawUI.ForegroundColor = $originalColor
        } elseif ($line -match "Error:") {
            $originalColor = $Host.UI.RawUI.ForegroundColor
            $Host.UI.RawUI.ForegroundColor = "Red"
            $line | Out-Host
            $Host.UI.RawUI.ForegroundColor = $originalColor
        } else {
            $line | Out-Host
        }
    }
    Read-Host "`nPress Enter to return to menu..."
}

function setup {
    # This function sets up the environment for the CryptKeeper.
    if (-not (Test-Path $Tempfolder)) {
        New-Item -Path $Tempfolder -ItemType Directory -Force
    }
    if (-not (Test-Path $settingsFilePath)) {
        New-Item -Path $settingsFilePath -ItemType File -Force
    }
    if (-not (Test-Path $logFilePath)) {
        New-Item -Path $logFilePath -ItemType File -Force
    }
    if (-not (Test-Path $ErrorLogFilePath)) {
        New-Item -Path $ErrorLogFilePath -ItemType File -Force
    }
    read-host
}

function Main{
    log -logtype 1 -logMessage "Start: CryptKeeper started"
    logo
    setup
    menu
}

Main


