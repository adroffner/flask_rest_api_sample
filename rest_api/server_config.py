""" Server Configuration for Flask-RESTX

This module determines the current SERVER_TIER and loads the right config objects.

SERVER_NAME:  This sets the Open API/Swagger "host" field with port number.
CORS_ORIGINS: Set CORS Allowed Origins List & Swagger Editor URI sees the Open API Document.
"""

import os

server_tier = os.environ.get('SERVER_TIER') or 'prod'

DEBUG = False

if server_tier in ['local', 'tdd']:
    DEBUG = True
    SERVER_NAME = '127.0.0.1:8001'
elif server_tier in ['dev']:
    DEBUG = True
    SERVER_NAME = 'micro.dev.example.com:8001'
    CORS_ORIGINS = "http://micro.dev.example.com:8100"
elif server_tier in ['stage']:
    SERVER_NAME = 'micro.web.example.com:8001'
    CORS_ORIGINS = "http://micro.web.example.com:8100"
elif server_tier in ['prod']:
    SERVER_NAME = 'micro.web.example.com:8001'
    CORS_ORIGINS = "http://micro.web.example.com:8100"

