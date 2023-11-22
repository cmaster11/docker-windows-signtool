# docker-windows-signtool

This is a simple Windows-based Docker image that can be used to sign any executables.

The entrypoint is the signtool binary.

## Usage

```
# Remove a signature
docker run --rm -v C:\my-dir:C:\mounted cmaster11/windows-signtool:latest remove /s C:\mounted\myFile.exe
```
