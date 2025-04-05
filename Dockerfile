FROM ubuntu:20.04 AS downloader

WORKDIR /app

# Install necessary tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Define versions
ENV IMGUI_VERSION=1.91.0
ENV GLFW_VERSION=3.4
ENV GLEW_VERSION=2.2.0
ENV FREETYPE_VERSION=2.13.2
ENV RAPIDXML_VERSION=1.13
ENV CURL_VERSION=8.10.1_3

# Download and extract GLFW
RUN wget -O glfw.zip -L https://github.com/glfw/glfw/releases/download/${GLFW_VERSION}/glfw-${GLFW_VERSION}.bin.WIN64.zip && \
    unzip glfw.zip -d /tmp && \
    mkdir -p /app/export/lib/glfw && \
    cp -r /tmp/glfw-${GLFW_VERSION}.bin.WIN64 /app/export/glfw

# Download and extract GLEW
RUN wget -O glew.zip -L https://github.com/nigels-com/glew/releases/download/glew-${GLEW_VERSION}/glew-${GLEW_VERSION}-win32.zip && \
    unzip glew.zip -d /tmp && \
    mkdir -p /app/export/lib/glew && \
    cp -r /tmp/glew-${GLEW_VERSION} /app/export/glew

# Download and extract FreeType
RUN wget -O freetype.zip -L https://github.com/ubawurinna/freetype-windows-binaries/archive/refs/tags/v${FREETYPE_VERSION}.zip && \
    unzip freetype.zip -d /tmp && \
    mkdir -p /app/export/lib/freetype && \
    cp -r /tmp/freetype-windows-binaries-${FREETYPE_VERSION}/include /app/export/lib/freetype/include && \
    cp -r /tmp/freetype-windows-binaries-${FREETYPE_VERSION}/release\ static/vs2015-2022 /app/export/lib/freetype/lib-vs2015-2022

# Download and extract RapidXML
RUN wget -O rapidxml.zip -L https://sourceforge.net/projects/rapidxml/files/rapidxml/rapidxml%20${RAPIDXML_VERSION}/rapidxml-${RAPIDXML_VERSION}.zip/download && \
    unzip rapidxml.zip -d /tmp && \
    mkdir -p /app/export/lib/rapidxml/include/rapidxml && \
    cp /tmp/rapidxml-${RAPIDXML_VERSION}/license.txt /app/export/lib/rapidxml/license.txt && \
    cp /tmp/rapidxml-${RAPIDXML_VERSION}/manual.html /app/export/lib/rapidxml/manual.html && \
    cp /tmp/rapidxml-${RAPIDXML_VERSION}/*.hpp /app/export/lib/rapidxml/include/rapidxml/ && \

# Download and extract libcurl
RUN wget -O curl.zip -L https://curl.se/windows/dl-${CURL_VERSION}/curl-${CURL_VERSION}-win64-mingw.zip && \
    unzip curl.zip -d /tmp && \
    mkdir -p /app/export/lib/curl && \
    cp -r /tmp/curl-${CURL_VERSION}-win64-mingw/* /app/export/lib/curl

# Initialize and configure imgui repository
RUN git init imgui && \
    cd imgui && \
    git remote add -f origin https://github.com/ocornut/imgui.git && \
    git config core.sparsecheckout true && \
    echo "examples/libs/emscripten" >> .git/info/sparse-checkout && \
    echo "misc/fonts/binary_to_compressed_c.cpp" >> .git/info/sparse-checkout && \
    git pull origin tags/v${IMGUI_VERSION} && \
    mkdir -p /app/export/lib/imgui && \
    cp -r examples/libs/emscripten /app/export/lib/imgui/emscripten && \
    cp misc/fonts/binary_to_compressed_c.cpp /app/export/lib/imgui/

# Function to download and extract fonts
RUN mkdir -p /app/export/fonts

# Download and extract Open Sans font
RUN wget -O open-sans.zip -L https://www.1001fonts.com/download/open-sans.zip && \
    unzip open-sans.zip -d /tmp/open-sans && \
    mkdir -p /app/export/fonts/open-sans && \
    cp -r /tmp/open-sans/* /app/export/fonts/open-sans

# Download and extract Droid Sans font
RUN wget -O droid-sans.zip -L https://www.1001fonts.com/download/droid-sans.zip && \
    unzip droid-sans.zip -d /tmp/droid-sans && \
    mkdir -p /app/export/fonts/droid-sans && \
    cp -r /tmp/droid-sans/* /app/export/fonts/droid-sans

# Download and extract Droid Sans Mono font
RUN wget -O droid-sans-mono.zip -L https://www.1001fonts.com/download/droid-sans-mono.zip && \
    unzip droid-sans-mono.zip -d /tmp/droid-sans-mono && \
    mkdir -p /app/export/fonts/droid-sans-mono && \
    cp -r /tmp/droid-sans-mono/* /app/export/fonts/droid-sans-mono

# Download and extract Metropolis font
RUN wget -O metropolis.zip -L https://www.1001fonts.com/download/metropolis.zip && \
    unzip metropolis.zip -d /tmp/metropolis && \
    mkdir -p /app/export/fonts/metropolis && \
    cp -r /tmp/metropolis/* /app/export/fonts/metropolis

# Download and extract Font Awesome Solid font
RUN wget -O fa-solid-900.zip -L https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-web.zip && \
    unzip fa-solid-900.zip -d /tmp/fontawesome && \
    mkdir -p /app/export/fonts/fontawesome && \
    cp /tmp/fontawesome/fontawesome-free-5.15.4-web/webfonts/fa-solid-900.ttf /app/export/fonts/fontawesome

# Compile binary_to_compressed_c.cpp
RUN g++ -o /app/export/lib/imgui/binary_to_compressed_c /app/export/lib/imgui/binary_to_compressed_c.cpp

# Convert the fa-solid-900.ttf to fa-solid-900.inc
RUN /app/export/lib/imgui/binary_to_compressed_c /app/export/fonts/fontawesome/fa-solid-900.ttf fa-solid-900 > /app/export/fonts/fontawesome/fa-solid-900.inc

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]