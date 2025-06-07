# Use a slim Python base image
FROM python:3.9-slim

# Install OpenSSH and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m appuser \
    && echo "appuser:YourStrongP@ssw0rd" | chpasswd

# Configure SSH
RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py ./
COPY templates/ ./templates/

# Expose SSH (22) and web (8000) ports
EXPOSE 22 8000

# Copy and set permissions for init script
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Default command
CMD ["/init.sh"]
