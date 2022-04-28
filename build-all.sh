#!/bin/bash
# Harald Pretl & Georg Zachl, IIC, JKU, 2022
#
# Build script for IIC docker images

set -e

docker buildx create --name iic-osic-tools-builder --node iic-osic-tools-builder0 --bootstrap --config ./buildkitd.toml
docker buildx build --platform linux/amd64,linux/arm64/v8 --builder iic-osic-tools-builder --push --tag iic-osic-tools:latest .
