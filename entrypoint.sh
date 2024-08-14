#!/bin/bash

# copy files to the export directory
cp -r /app/export/glfw /mnt/export
cp -r /app/export/glew /mnt/export
cp -r /app/export/lib/imgui/emscripten /mnt/export

cp -r /app/export/lib/freetype/ /mnt/export

# Add any other commands you need to run here

# Keep the container running if needed
# tail -f /dev/null
