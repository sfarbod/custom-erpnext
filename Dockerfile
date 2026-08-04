
FROM frappe/erpnext:v16.30.0

# user main
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        pkg-config \
        build-essential \
        default-libmysqlclient-dev \
        libreoffice-core \
        libreoffice-writer \
        libreoffice-calc \
        libreoffice-draw \
        fonts-dejavu \
        fonts-liberation \
        libmagic1 \
        poppler-utils \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-fas \
        libffi-dev \
        libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


USER frappe
WORKDIR /home/frappe/frappe-bench

COPY apps.json /home/frappe/frappe-bench/apps.v16.json

# hrms
RUN bench get-app --branch v16.15.0 --skip-assets https://github.com/frappe/hrms
RUN bench get-app --branch v3.8.4 https://github.com/sfarbod/ERPNext_Extensions
RUN bench get-app --branch v1.8.0 https://github.com/sfarbod/persian_calendar_ERPNext
RUN bench get-app --branch develop --skip-assets https://github.com/frappe/telephony
RUN bench get-app --branch version-16 --skip-assets https://github.com/frappe/payments
RUN bench get-app --branch v1.28.1 --skip-assets https://github.com/frappe/helpdesk
RUN bench get-app --branch v2.58.1 --skip-assets https://github.com/frappe/lms
RUN bench get-app --branch v3.12.2  https://github.com/frappe/insights
RUN bench get-app --branch v3.0.0-rc.5 --skip-assets https://github.com/frappe/wiki
RUN bench get-app --branch v1.5.4 --skip-assets https://github.com/frappe/lending
#RUN bench get-app --branch develop --skip-assets https://github.com/frappe/drive || true
RUN bench get-app --branch v2.8.11  --skip-assets https://github.com/The-Commit-Company/raven
RUN bench get-app --branch main  --skip-assets https://github.com/erenaydin-t/dms
RUN bench get-app --branch main  --skip-assets https://github.com/erenaydin-t/office_automation

USER root

RUN /home/frappe/frappe-bench/env/bin/pip install --no-cache-dir \
    --upgrade \
    pyOpenSSL \
    cryptography \
    urllib3 \
    boto3 \
    botocore

USER frappe

