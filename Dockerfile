# Use the same base image
FROM python:3.10.8-slim-buster

# Fix: Update apt sources to archived Debian repo
RUN sed -i 's|http://deb.debian.org|http://archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt update && apt upgrade -y

# Install git
RUN apt install git -y

# Install Python requirements
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# Copy all bot files
COPY . /app

# Set working directory
WORKDIR /app

# Start the bot
CMD ["python", "bot.py"]
