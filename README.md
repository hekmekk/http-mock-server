# http-mock-server

## run it
```bash
docker build -t hekmekk/json-rpc-mock-server .
docker run -p 127.0.0.1:3344:1500 -it --rm hekmekk/json-rpc-mock-server
```

This will setup a simple tcp server with an example configuration using `responses.sample`

## configuration
The `request_handler.sh` will search the volume `/docker-entrypoint.d` for files containing *request to response mappings*. For examples, see [`responses.sample`](/responses.sample).

```bash
docker run -p 127.0.0.1:3344:1500 -it --rm -v $(pwd)/responses.sample:/docker-entrypoint.d/responses.sample:ro hekmekk/json-rpc-mock-server
```

## troubleshooting fedora 31
- use [podman](https://podman.io/) or [follow these instructions](https://github.com/docker/for-linux/issues/219#issuecomment-558245347)
- use `:Z` instead of `:ro` for the volume

