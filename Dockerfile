ARG goreleaser_vers="v2.13.1"
FROM goreleaser/goreleaser:$goreleaser_vers AS builder
ARG escobar_ref="v3.0.1"
RUN git clone --branch $escobar_ref --depth 1 https://github.com/savely-krasovsky/escobar.git /escobar
WORKDIR /escobar
RUN goreleaser build --single-target

FROM scratch
COPY --from=builder /escobar/dist/escobar_linux_amd64_v1/escobar /escobar
ENTRYPOINT ["/escobar"]
CMD ["--help"]