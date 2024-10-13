# PreflightCheckLibs

This repository is intended to be used as a submodule to provide libraries and fonts for your project.

## 1. Add PreflightCheckLibs to Your Project
Add the submodule:
```bash
git submodule add git@github.com:1090MHz/PreflightCheckLibs.git
```

## 2. Build Docker Image
Build the Docker image required for setting up dependencies:
```bash
docker-compose -f ./PreflightCheckLibs/docker-compose.yml build
```

## 3. Run the Container
Running the container will fetch and prepare the dependencies. By default, it will create the following directories inside the `PreflightCheckLibs` submodule:
- **Libraries**: `./PreflightCheckLibs/third_party/libs`
- **Fonts**: `./PreflightCheckLibs/third_party/fonts`

To create these directories in your main project, you need to use `../` in the paths as shown in the customization instructions below. This is because the paths are relative to the location of the `docker-compose.yml` file, which is inside the `PreflightCheckLibs` directory.

## 4. Default Configuration
By default, the directories are set as follows:
- **Libraries**: `./PreflightCheckLibs/third_party/libs`
- **Fonts**: `./PreflightCheckLibs/third_party/fonts`

## 5. Customizing Directories
You can customize the directories for libraries and fonts using environment variables.

### Environment Variables
- **EXPORT_BASE_DIR**: The base directory for both libraries and fonts. Defaults to `./third_party`.
- **EXPORT_LIBS_DIR**: The directory for libraries. Overrides `EXPORT_BASE_DIR/libs` if set. Defaults to `${EXPORT_BASE_DIR}/libs`.
- **EXPORT_FONTS_DIR**: The directory for fonts. Overrides `EXPORT_BASE_DIR/fonts` if set. Defaults to `${EXPORT_BASE_DIR}/fonts`.

### Override Base Directory
You can override the base directory for both libraries and fonts using the `EXPORT_BASE_DIR` environment variable. By default, it is set to `./third_party`, which will be inside the `PreflightCheckLibs` directory.

**For Command Prompt:**
```bash
set EXPORT_BASE_DIR=../third_party && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:EXPORT_BASE_DIR="../third_party"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

### Override Libraries Directory
To customize the directory for libraries, use the `EXPORT_LIBS_DIR` environment variable. This overrides the `EXPORT_BASE_DIR` if set.

**For Command Prompt:**
```bash
set EXPORT_LIBS_DIR=../third_party/libs && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:EXPORT_LIBS_DIR="../third_party/libs"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

### Override Fonts Directory
To customize the directory for fonts, use the `EXPORT_FONTS_DIR` environment variable. This overrides the `EXPORT_BASE_DIR` if set.

**For Command Prompt:**
```bash
set EXPORT_FONTS_DIR=../third_party/fonts && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:EXPORT_FONTS_DIR="../third_party/fonts"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

### Override Both Libraries and Fonts Directories
You can also override both directories simultaneously:

**For Command Prompt:**
```bash
set EXPORT_LIBS_DIR=../third_party/libs && set EXPORT_FONTS_DIR=../third_party/fonts && docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

**For PowerShell:**
```powershell
$env:EXPORT_LIBS_DIR="../third_party/libs"; $env:EXPORT_FONTS_DIR="../third_party/fonts"; docker-compose -f ./PreflightCheckLibs/docker-compose.yml up
```

## 6. Custom Configuration
You can override these defaults by setting the environment variables. For example, you can create a `.env` file in the project root with the following content:

```env
EXPORT_BASE_DIR=/custom/path
EXPORT_LIBS_DIR=/custom/libs
EXPORT_FONTS_DIR=/custom/fonts
```
