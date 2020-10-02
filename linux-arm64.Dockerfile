FROM hotio/mono@sha256:a18b77bfd49ce5b90be309e74646bc4c2ca253ca82cca0bf598c8d377e4ca71c

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 7878

ARG VERSION

# install app
RUN curl -fsSL "https://radarr.servarr.com/v1/update/develop/updatefile?version=${VERSION}&os=linux&runtime=mono" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
