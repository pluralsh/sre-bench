# Upload video recordings to S3
upload-videos:
    #!/usr/bin/env bash
    set -euo pipefail

    if [ -z "${RECORDING_PATH:-}" ]; then
        echo "Error: RECORDING_PATH environment variable must be set"
        exit 1
    fi

    if [ -z "${S3_BUCKET_URL:-}" ]; then
        echo "Error: S3_BUCKET_URL environment variable must be set"
        exit 1
    fi

    if ! command -v aws &> /dev/null; then
        echo "Error: aws CLI is required but not installed"
        exit 1
    fi

    echo "Uploading videos from ${RECORDING_PATH} to ${S3_BUCKET_URL}"
    aws s3 sync "${RECORDING_PATH}" "${S3_BUCKET_URL}" \
        --exclude "*" \
        --include "*.mp4" \
        --include "*.webm" \
        --include "*.mkv"

    echo "Video upload complete"
