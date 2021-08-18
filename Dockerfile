ARG kong_version
FROM kong:${kong_version} as base

USER root

ADD ./kong-plugin-oidc-1.1-0.rockspec .
ADD ./kong ./kong

RUN luarocks make && luarocks pack kong-plugin-oidc

RUN rm kong-plugin-oidc-1.1-0.rockspec && rm -r kong

FROM tianon/true

COPY --from=base ./kong-plugin-oidc-1.1-0.all.rock /
