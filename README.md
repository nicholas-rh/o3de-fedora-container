## Docker

Build the image, optionally specifying arguments for the dockerfile ARG parameters:

	docker build --no-cache -t "$image_name" .

Once the image has been built, launch a container by executing the launch.sh script. You may need to tweak
the script to fix your specific system/configuration:

	./launch.sh

Then, attach to the container and continue as if you were running O3DE on your host system.

## Podman

Coming soon...
