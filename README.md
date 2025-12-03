# Podman Bazel

A basic bash script to run Bazel inside a Linux container with podman.

## Project Structure

* `images`: container image defintions to run Bazel
* `src`: source scripts that run Bazel inside a Linux container
* `test` test files/projects to ensure the cli is running properly

## Installing

Running `make install` will install the cli into `$HOME/.local/bin/podman-bazel`, the following variables can be used to
customize the installation path:

```
INSTALL_DIR: $HOME/.local/bin
BAZEL_CLI_NAME: podman-bazel
```

You can also run `make vars` to see all available variables in the provided `Makefile`.

Please run `make image` to build a Linux container image that can run Bazel.

## Running

Once installed, the script will run a container with podman, mounting the current working dir and forwarding Bazel commands from
the bash script.

So running `podman-bazel build //pkg:something` will run `bazel build ...` inside the container.

If no arguments are provides, it will shell into the container (/bin/bash).

The container itself has two mounted volumnes:

* `/workspace`: your current working directory
* `/build`: a tmpfs dir that is used as build home/dir.

Variables that can be used when running the CLI:

| Name          | Default                | Description                 |
|---------------|------------------------|-----------------------------|
| `BAZEL_IMAGE` | localhost/bazel:latest | Linux container image to use|

## License

[MIT](./LICENSE)
