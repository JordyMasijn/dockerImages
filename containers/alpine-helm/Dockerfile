# syntax=docker/dockerfile:1
FROM alpine:3.19.1

RUN apk --no-cache add kubectl helm


ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

# sanity check of kubectl and helm
RUN kubectl version --client=true && helm version --client=true


# default command to start a shell
CMD [ "/bin/sh" ]
