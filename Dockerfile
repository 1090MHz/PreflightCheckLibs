FROM ubuntu:20.04 AS downloader

WORKDIR /app

# Install necessary tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Define the GLFW version
ENV GLFW_VERSION=3.4

# Download and extract the libraries
RUN wget -O glfw.zip -L https://github.com/glfw/glfw/releases/download/${GLFW_VERSION}/glfw-${GLFW_VERSION}.bin.WIN64.zip

# Unzip the downloaded GLFW file
RUN unzip glfw.zip -d /tmp

# Create a lib directory and copy the necessary files
RUN mkdir -p /app/export/lib/glfw && \
    cp -r /tmp/glfw-${GLFW_VERSION}.bin.WIN64 /app/export/glfw

# Initialize a new repository
RUN git init imgui

# Add the remote
RUN cd imgui && git remote add -f origin https://github.com/ocornut/imgui.git

# Enable sparse checkout
RUN cd imgui && git config core.sparsecheckout true

# Define which directories you want to checkout
RUN echo "examples/libs/emscripten" >> imgui/.git/info/sparse-checkout
#RUN echo "examples/libs/usynergy" >> imgui/.git/info/sparse-checkout

# Pull from the remote
RUN cd imgui && git pull origin master

# Copy the emscripten folder to /app/export/
RUN mkdir -p /app/export/lib/imgui && \
    cp -r imgui/examples/libs/emscripten /app/export/lib/imgui/emscripten

# Download and extract the FreeType Windows binaries
RUN wget -O freetype.zip -L https://github.com/ubawurinna/freetype-windows-binaries/archive/refs/tags/v2.13.2.zip

# Unzip the downloaded FreeType file
RUN unzip freetype.zip -d /tmp

# Copy the include and .lib files to /app/export/
RUN mkdir -p /app/export/lib/freetype && \
    cp -r /tmp/freetype-windows-binaries-2.13.2/include /app/export/lib/freetype/include && \
    cp -r /tmp/freetype-windows-binaries-2.13.2/release\ static/vs2015-2022 /app/export/lib/freetype/lib-vs2015-2022

# Define the GLEW version
ENV GLEW_VERSION=2.2.0

# Download and extract the GLEW library from GitHub releases
RUN wget -O glew.zip -L https://github.com/nigels-com/glew/releases/download/glew-${GLEW_VERSION}/glew-${GLEW_VERSION}-win32.zip

# Unzip the downloaded GLEW file
RUN unzip glew.zip -d /tmp

# Copy the glew32.lib file to /app/export/
RUN mkdir -p /app/export/lib/glew && \
    cp -r /tmp/glew-${GLEW_VERSION} /app/export/glew

# Download and extract the Open Sans font
RUN wget -O open-sans.zip -L https://www.1001fonts.com/download/open-sans.zip

# Unzip the downloaded Open Sans file
RUN unzip open-sans.zip -d /tmp/open-sans

# Copy the Open Sans font files to /app/export/fonts
RUN mkdir -p /app/export/fonts/open-sans && \
    cp -r /tmp/open-sans/* /app/export/fonts/open-sans

# Download and extract the Droid Sans font
RUN wget -O droid-sans.zip -L https://www.1001fonts.com/download/droid-sans.zip

# Unzip the downloaded Droid Sans file
RUN unzip droid-sans.zip -d /tmp/droid-sans

# Copy the Droid Sans font files to /app/export/fonts
RUN mkdir -p /app/export/fonts/droid-sans && \
    cp -r /tmp/droid-sans/* /app/export/fonts/droid-sans

# Download and extract the Droid Sans Mono font
RUN wget -O droid-sans-mono.zip -L https://www.1001fonts.com/download/droid-sans-mono.zip

# Unzip the downloaded Droid Sans Mono file
RUN unzip droid-sans-mono.zip -d /tmp/droid-sans-mono

# Copy the Droid Sans Mono font files to /app/export/fonts
RUN mkdir -p /app/export/fonts/droid-sans-mono && \
    cp -r /tmp/droid-sans-mono/* /app/export/fonts/droid-sans-mono

# Download and extract the Metropolis font
RUN wget -O metropolis.zip -L https://www.1001fonts.com/download/metropolis.zip

# Unzip the downloaded Metropolis file
RUN unzip metropolis.zip -d /tmp/metropolis

# Copy the Metropolis font files to /app/export/fonts
RUN mkdir -p /app/export/fonts/metropolis && \
    cp -r /tmp/metropolis/* /app/export/fonts/metropolis

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]