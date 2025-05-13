# Upload video recordings to S3
upload-videos:
    #!/usr/bin/env bash
    set -euo pipefail

    if [ -z "${RECORDING_PATH:-}" ]; then
        echo "Error: RECORDING_PATH environment variable must be set"
        exit 1
    fi

    if [ -z "${AWS_PROFILE:-}" ]; then
        echo "Error: AWS_PROFILE environment variable must be set"
        exit 1
    fi

    if ! command -v aws &> /dev/null; then
        echo "Error: aws CLI is required but not installed"
        exit 1
    fi

    S3_BUCKET="s3://plrl-bench-assets"
    echo "Uploading videos from ${RECORDING_PATH} to ${S3_BUCKET} using profile ${AWS_PROFILE}"
    aws s3 sync "${RECORDING_PATH}" "${S3_BUCKET}" \
        --exclude "*" \
        --include "*.mov" \
        --include "*.mp4" \
        --include "*.webm" \
        --include "*.mkv" \
        --profile "${AWS_PROFILE}"

    echo "Video upload complete"
