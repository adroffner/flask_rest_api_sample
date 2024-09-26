#! /bin/bash
#
# Run Unit Tests and Static Analysis for Python
# ============================================================================
# Run the unittests with nose; write coverage.py and unit test reports.
# Static Analysis depends on flake8 reporting.
# ============================================================================

# Set the root python3 package directory.
PY_PACKAGE=rest_api

# Set REPORTS_DIR under /tmp/ inside container.
DEFAULT_REPORTS_DIR="/tmp/test-reports"

# Change REPORTS_DIR to working directory for developer.
REPORTS_DIR=$DEFAULT_REPORTS_DIR

# Create test-reports/ directory or use PWD for development.
if [ "/home/bin" == "${0%/*}" ]; then
	mkdir -p ${REPORTS_DIR}
else
	REPORTS_DIR="${PWD}"
fi

echo "Reports Directory: ${REPORTS_DIR}"

flake8 --max-line-length=130 \
	--exclude=".git,__pycache__" \
	"${PY_PACKAGE}" > "${REPORTS_DIR}/flake8.log"

export COVERAGE_FILE="${REPORTS_DIR}/.coverage"
nosetests -v \
	--with-xunit \
	--xunit-file="${REPORTS_DIR}/unittest.xml" \
	--cover-erase \
	--with-coverage \
	--cover-xml \
	--cover-xml-file="${REPORTS_DIR}/coverage.xml" \
	--cover-package="${PY_PACKAGE}"

# Add HTML Coverage report during development.
if [ "${DEFAULT_REPORTS_DIR}" != "${REPORTS_DIR}" ]; then
	coverage html

	echo
	echo 'See unit test coverage:'
	echo "file://$PWD/htmlcov/index.html"
	echo
fi

# Delete REPORTS_DIR inside container to remove files shared with host.
if [ "${DEFAULT_REPORTS_DIR}" == "${REPORTS_DIR}" ]; then
	chmod -R 777 ${REPORTS_DIR}/*
fi
