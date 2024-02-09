# syntax=docker/dockerfile:1
FROM alpine@sha256:6457d53fb065d6f250e1504b9bc42d5b6c65941d57532c072d929dd0628977d0

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
