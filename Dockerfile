FROM glassfish:latest

# Instalar Apache Derby
RUN apt-get update && apt-get install -y derby && apt-get clean

# Copiar la base de datos
COPY db /opt/db

# Exponer puertos: GlassFish (8080 y 4848) y Derby (1527)
EXPOSE 8080 4848 1527

# Comando para iniciar Derby y GlassFish
CMD ["/bin/bash", "-c", "startNetworkServer -h 0.0.0.0 & asadmin start-domain --verbose"]
