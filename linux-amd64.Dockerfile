FROM hotio/base@sha256:ba659a30bf39b06d1e9bd5f7c792861f20d8d1e68ce46434680066f52afc2e6f

EXPOSE 7878

RUN apk add --no-cache libintl libmediainfo sqlite-libs icu-libs

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://radarr.servarr.com/v1/update/nightly/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Radarr.Update" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=nightly" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

ARG ARR_DISCORD_NOTIFIER_VERSION
RUN curl -fsSL "https://raw.githubusercontent.com/hotio/arr-discord-notifier/${ARR_DISCORD_NOTIFIER_VERSION}/arr-discord-notifier.sh" > "${APP_DIR}/arr-discord-notifier.sh" && \
    chmod u=rwx,go=rx "${APP_DIR}/arr-discord-notifier.sh"

COPY root/ /
