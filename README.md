# PreflightCheckLibs

This repository is intended to be used as a submodule to provide libraries and fonts for your project.

### 1. Add PreflightCheckLibs to Your Project
Add the submodule:
```bash
git submodule add git@github.com:1090MHz/PreflightCheckLibs.git
```

### 2. Build Docker Image
Build the Docker image required for setting up dependencies:
```bash
docker-compose -f ./PreflightCheckLibs/docker-compose.yml build
```

### 3. Set Up Dependencies
Run the Docker Compose command to fetch and prepare the dependencies. This command sets the `EXPORT_DIR` environment variable to ensure the files are copied to the specified directory in your main project (Note: the path is relative to the location of the `docker-compose.yml` file):

**For Command Prompt:**
```bash
set EXPORT_DIR=../third_party/libs && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:EXPORT_DIR="../third_party/libs"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

### 4. Set Up Fonts Directory
If you need to set up a directory for fonts, you can use the `FONTS_DIR` environment variable. This ensures that the fonts are copied to the specified directory in your main project:

**For Command Prompt:**
```bash
set FONTS_DIR=../third_party/fonts && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:FONTS_DIR="../third_party/fonts"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```