FROM directus/directus:11.15.4

# Copy custom extensions if any
# COPY ./extensions /directus/extensions

# Install additional npm dependencies if needed
# USER root
# RUN corepack enable && corepack prepare pnpm@latest --activate \
#     && pnpm install some-package
# USER node

# Healthcheck defined in docker-compose.yaml for easier configuration
