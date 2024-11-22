# Usa una imagen base con JDK 1.8
FROM openjdk:8-jdk

# Instalar GlassFish 4.1.1
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://download.eclipse.org/ee4j/glassfish/glassfish-4.1.1.zip -O glassfish.zip && \
    unzip glassfish.zip -d /opt && \
    rm glassfish.zip

# Configurar variables de entorno para GlassFish
ENV GLASSFISH_HOME=/opt/glassfish4
ENV PATH=$GLASSFISH_HOME/bin:$PATH

# Copiar tu base de datos al contenedor
COPY db /opt/db

# Exponer puertos necesarios
EXPOSE 8080 4848 1527

# Comando para iniciar GlassFish y Apache Derby
CMD ["/bin/bash", "-c", "$GLASSFISH_HOME/bin/asadmin start-domain --verbose"]
