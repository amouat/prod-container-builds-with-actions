# For testing versioning of images with private registry
FROM cgr.dev/chainguard.edu/go:v1.25.5@sha256:1be8ec014148fa86f633a00313fae1ec50209732879f97a13fa3521726a7ad5b AS builder

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:77d8b8925dc27970ec2f48243f44c7a260d52c49cd778288e4ee97566e0cb75b
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
