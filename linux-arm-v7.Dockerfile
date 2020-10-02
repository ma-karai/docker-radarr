FROM hotio/mono@sha256:fab87095c98597eb83b465e5f505b9445c14e2cf514cbdf670ffd6ed4e49ecf4

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 7878

ARG VERSION

# install app
RUN curl -fsSL "https://radarr.servarr.com/v1/update/develop/updatefile?version=${VERSION}&os=linux&runtime=mono" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/NzbDrone.Update" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
