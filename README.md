# ![](./Images/Github.png) &nbsp;&nbsp;   💾 Bat Backup

## Documents backup `Script` for `Windows`

# Quick Overview

This repository contains a **Windows batch script** designed to create a compressed backup of a user's **Documents** folder using **7-Zip**.  
The script is especially well suited for **automation via Windows Task Scheduler**, making it ideal for periodic, unattended backups.

The solution focuses on:
- Reliability
- Clear user feedback
- Robust error handling
- Compatibility with scheduled execution

# Repository Contents

    📦 BatBackup.bat: - main script
    📦 Readme.md: - This documentation file.
    📁 Images/ - Assets for README (logo, screenshot)
      ├ 📦 Github.png
      └ 📦 Screenshot.png

# Features

- Backs up the entire **Documents** folder into a single `.7z` archive  
- Displays start and end timestamps for easy logging and troubleshooting  
- Automatically creates the destination directory if it does not exist  
- Validates the presence of **7-Zip** before execution  
- Excludes common system junction folders (`My Music`, `My Pictures`, `My Videos`) to avoid access warnings  
- Interprets 7-Zip exit codes intelligently to distinguish between warnings and real failures  

# Requirements

- Windows based OS.
- [7zip](https://www.7-zip.org/) file archiver.


## 🖥️ Ideal for Windows Task Scheduler

This script is **ideal for use with Windows Task Scheduler**, as it:

- Runs non-interactively
- Returns consistent exit codes (`0 = success`, `1 = failure`)
- Provides clear console output that can be logged
- Avoids false failures caused by harmless access warnings

Typical use cases include:
- Daily or weekly document backups
- Automated backups before system shutdown
- User-level backup routines in corporate or personal environments

## ⚙️ Customization Required

⚠️ **Important:**  
This script is **not fully plug-and-play** and will likely require customization for each user.

You may need to adjust:

- The path to `7z.exe`
- The backup destination path, another 
- Folder exclusions
- Compression options
- Execution frequency (via Task Scheduler or similar)  

All key paths are clearly defined at the top of the script to simplify customization.

# Screenshots

![](./Images/Screenshot.png)


## 🧩 How It Works

1. **User feedback**  
   Displays a clear start message with the current time.

2. **Path configuration**  
   - Source: `%USERPROFILE%\Documents`
   - Destination: A `.7z` archive (default: `C:\Backups\Documents.7z`)
   - Compression tool: `7z.exe`

3. **Pre-flight checks**  
   - Ensures the destination directory exists
   - Verifies that 7-Zip is installed at the configured path

4. **Backup execution**  
   - Runs 7-Zip with maximum compression (`-mx9`)
   - Overwrites existing archives automatically
   - Excludes problematic junction folders

5. **Exit code handling**  
   - Treats warnings (`errorlevel 1`) as success if the archive was created
   - Fails only on real errors

6. **Final status message**  
   Displays a clear success or failure message with an exit code suitable for automation.


# License

MIT License — free to use, modify, and distribute.

See [LICENSE](https://opensource.org/license/mit) for details.

# 💬 Feedback & Contributions
Found a bug? Have a feature idea?

👉 Open an [Issue](https://github.com/MiguelAdePablo/batbackup/issues) or submit a PR!

# 🌐 Useful Links

- [Apps Index (under construction)](https://github.com/MiguelAdePablo/apps)
- [General Index (under construcion)](https://github.com/MiguelAdePablo/Index)



        Developed with ❤️ 
        By Miguel Ángel de Pablo
