#!/bin/bash
# Regenerate Resources/AppIcon.icns from logo.png (repo root).
# Usage: ./dist/make-icns.sh [source.png]
set -e
SRC="${1:-logo.png}"
OUT="Resources/AppIcon.icns"

if [ ! -f "${SRC}" ]; then
  echo "Error: source image not found: ${SRC}"
  exit 1
fi

mkdir -p Resources
SQUARE=$(mktemp /tmp/spaceswitcher-icon-square-XXXXXX.png)
ICONSET=$(mktemp -d /tmp/AppIcon-XXXXXX).iconset
mkdir -p "${ICONSET}"
trap 'rm -f "${SQUARE}"; rm -rf "${ICONSET}"' EXIT

# Center-crop to square (uses smallest side), preserves logo without stretching.
W=$(sips -g pixelWidth "${SRC}" | awk '/pixelWidth/{print $2}')
H=$(sips -g pixelHeight "${SRC}" | awk '/pixelHeight/{print $2}')
if [ -z "${W}" ] || [ -z "${H}" ]; then
  echo "Error: could not read image size for ${SRC}"
  exit 1
fi
if [ "${W}" -lt "${H}" ]; then SIDE="${W}"; else SIDE="${H}"; fi
echo "Source ${W}x${H}, cropping to ${SIDE}x${SIDE} square..."
sips -c "${SIDE}" "${SIDE}" "${SRC}" --out "${SQUARE}" >/dev/null

for size in 16 32 64 128 256 512 1024; do
  sips -z "${size}" "${size}" "${SQUARE}" --out "${ICONSET}/icon_${size}x${size}.png" >/dev/null
done
cp "${ICONSET}/icon_32x32.png" "${ICONSET}/icon_16x16@2x.png"
cp "${ICONSET}/icon_64x64.png" "${ICONSET}/icon_32x32@2x.png"
cp "${ICONSET}/icon_256x256.png" "${ICONSET}/icon_128x128@2x.png"
cp "${ICONSET}/icon_512x512.png" "${ICONSET}/icon_256x256@2x.png"
cp "${ICONSET}/icon_1024x1024.png" "${ICONSET}/icon_512x512@2x.png"
rm -f "${ICONSET}/icon_64x64.png" "${ICONSET}/icon_1024x1024.png"

iconutil -c icns "${ICONSET}" -o "${OUT}"
echo "Wrote ${OUT} ($(du -h "${OUT}" | cut -f1))"
