# ConKodi

This repository contains dockerfiles for [Kodi](https://kodi.tv) mediacenter. You can run a Kodi
container in CI or locally, install your add-on and run some tests via JSON-RPC.

## Usage

The Kodi container has installed VNC. It means you can connect to X session and get access to
Kodi GUI. It's not supposed to play video and audio.

1. Build a container image:

    ```sh
    podman build -t kodi -f stable.Dockerfile .
    ```

2. Run it:

    ```sh
    podman run --rm -p 5999:5999 -p  localhost/kodi
    ```

3. Use any VNC viewer to get access to X session, e.g.:

    ```sh
    krdc vnc://127.0.0.1:5999
    ```
