import json
from unittest import TestCase, mock


class RestApiTestCases(TestCase):
    """ Sample REST API Test Cases

    Make flask-RESTful test case to verify the Sample REST API.
    """

    # maxDiff = None

    def setUp(self):
        server.app.testing = True
        self.app = server.app.test_client()

        self.SERVER_NAME_MSG = {}

    def tearDown(self):
        pass

    def _add_rest_headers(self, headers={}):
        headers['Content-Type'] = 'application/json'
        return headers

    def _post_rest_api(self, rest_url, payload_dict):
        """ POST to REST API Endpoint with payload.

        returns: `resp` a full flask response
        """

        resp = self.app.post(
            rest_url,
            data=json.dumps(payload_dict),
            headers=self._add_rest_headers())
        return resp

    def test_name_get_url(self):
        """ Prove the REST API URL '/sample/name' shows a name and comment """

        resp = self.app.get('/sample/name')
        self.assertEqual(json.loads(resp.data.decode('utf8')), self.SERVER_LIST_MSG)
        self.assertEqual(resp.status_code, 200)

