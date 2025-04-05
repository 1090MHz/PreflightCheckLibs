#!/bin/bash

# Ensure the target directories exist
mkdir -p /mnt/export/libs
mkdir -p /mnt/export/fonts

# copy files to the export directory
cp -r /app/export/glfw/ /mnt/export/libs
cp -r /app/export/glew/ /mnt/export/libs
cp -r /app/export/lib/imgui/emscripten/ /mnt/export/libs
cp -r /app/export/lib/freetype/ /mnt/export/libs
cp -rf /app/export/lib/rapidxml/ /mnt/export/libs
cp -r /app/export/lib/curl/ /mnt/export/libs
cp -r /app/export/lib/XPSDK410/ /mnt/export/libs

# Copy fonts to the export directory
cp -r /app/export/fonts /mnt/export

# Add any other commands you need to run here

# Keep the container running if needed
# tail -f /dev/null
