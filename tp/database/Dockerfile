FROM postgres:11.6-alpine
# Copie des scripts d'init sql dans le dossier docker-entrypoint-initdb afin d'être exécuter à l'instantiation
COPY 01-CreateScheme.sql /docker-entrypoint-initdb.d
COPY 02-InsertData.sql /docker-entrypoint-initdb.d
#  Init des variables d'environnements (à déplacer ailleurs)
ENV POSTGRES_DB=db \
    POSTGRES_USER=usr \
    POSTGRES_PASSWORD=pwd