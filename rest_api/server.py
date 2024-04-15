""" Server Configuration for Flask-RESTX

This is a sample JSON REST API to demonstrate flask with OpenAPI Specifications.
"""

import logging

from flask import Flask, request
from flask_cors import CORS
from flask_restx import Api, Resource, fields

log = logging.getLogger(__name__)

app = Flask(__name__)
app.config.from_object('rest_api.server_config')
DEBUG = app.config.get('DEBUG', False)
CORS(app, resources={
    r"/*": {
        "origins": app.config.get('CORS_ORIGINS', '*')
    }
})
api = Api(app,
          prefix='/restx',
          version='1.0',
          title='Server Configuration for Flask-RESTX',

          description=(
              'A sample REST API to demonstrate OpenAPI Specification.'),
          catch_all_404s=True,
          behind_proxy=False)

# =============================================================================
# Namespace(s):
# =============================================================================

rest_ns = api.namespace('sample', description='Sample REST API')

# =============================================================================
# Serializers: RESTX models to make HTTP POST JSON input payloads
# =============================================================================

change_name_payload = rest_ns.model('Name Change Request', {
    'name': fields.String(required=True, description='This is the service "name".'),
    'comment': fields.String(required=True, description='Here is a comment about this service.'),
})

# =============================================================================


@rest_ns.route('/server_name')
class ServerList(Resource):
    """ Server Name Resource

    Show server's name
    """

    @rest_ns.response(200, 'Server Name')
    def get(self):
        # STUB: Need to save name changes.
        SERVER_JSON = {
            'name': 'Sample Server',
            'comment': 'Try OpemAPI'
        }
        return {'name': SERVER_JSON, 'message': 'Server Name'}, 200



if __name__ == '__main__':
    app.run()  # pragma: no cover

