
FROM frappe/erpnext:v16.18.3

# user main
USER root

RUN apt-get update && apt-get install -y \
    pkg-config \
    build-essential \
    default-libmysqlclient-dev \
    libreoffice-core \
    libreoffice-writer \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

USER frappe
WORKDIR /home/frappe/frappe-bench

COPY apps.json /home/frappe/frappe-bench/apps.v16.json

# hrms
RUN bench get-app --branch v16.7.0 --skip-assets https://github.com/frappe/hrms
RUN bench get-app --branch v1.0.0 https://github.com/sfarbod/ERPNext_Extensions
RUN bench get-app --branch v1.2.0 https://github.com/sfarbod/persian_calendar_ERPNext
RUN bench get-app --branch develop --skip-assets https://github.com/frappe/telephony
RUN bench get-app --branch version-16 --skip-assets https://github.com/frappe/payments
RUN bench get-app --branch v1.23.0 --skip-assets https://github.com/frappe/helpdesk
RUN bench get-app --branch v2.53.1 --skip-assets https://github.com/frappe/lms
RUN bench get-app --branch v3.9.5  https://github.com/frappe/insights
RUN bench get-app --branch v3.0.0-rc.2 --skip-assets https://github.com/frappe/wiki
RUN bench get-app --branch v1.5.4 --skip-assets https://github.com/frappe/lending
RUN bench get-app --branch develop --skip-assets https://github.com/frappe/drive || true
RUN bench get-app --branch v2.8.11  --skip-assets https://github.com/The-Commit-Company/raven
RUN bench get-app --branch v0.5.0  --skip-assets https://github.com/erenaydin-t/dms



