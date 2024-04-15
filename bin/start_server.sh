#! /bin/bash
#
# Sample flask-RESTX API Apache mod-wsgi service
# =============================================================================

WEB_USER="apache" # CentOS
# WEB_USER="www-data" # Debian

PORT=8001

/usr/local/bin/mod_wsgi-express start-server \
    --user "${WEB_USER}" \
    --maximum-requests=250 \
    --access-log \
    --access-log-format "[REST-API][%>s] %h %l %u %b \"%{Referer}i\" \"%{User-agent}i\" \"%r\"" \
    --error-log-format  "[REST-API][%l] %M" \
    --log-to-terminal --log-level INFO \
    --url-alias /static static \
    --host 0.0.0.0 --port ${PORT} \
    --working-directory /home/app \
    --compress-responses \
    --application-type module rest_api.wsgi
