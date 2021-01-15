FROM alpine:20201218

# Adding bash
RUN apk --no-cache add \
    bash=5.1.0-r0 \
    && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "bash" ]
