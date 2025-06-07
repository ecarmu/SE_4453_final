#!/bin/bash
# Start SSH daemon
/usr/sbin/sshd

# Launch Flask via gunicorn for production-like behavior
exec gunicorn --bind 0.0.0.0:8000 app:app