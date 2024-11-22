# Usa una imagen base con JDK 1.8
FROM openjdk:8-jdk

# Actualizar repositorios e instalar dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    apt-get clean

# Descargar GlassFish desde tu URL
RUN curl -L -o glassfish.zip http://download.oracle.com/glassfish/4.1.1/release/glassfish-4.1.1.zip && \
    unzip glassfish.zip -d /opt && \
    rm glassfish.zip

# Configurar variables de entorno para GlassFish
ENV GLASSFISH_HOME=/opt/glassfish4
ENV PATH=$GLASSFISH_HOME/bin:$PATH

# Exponer los puertos necesarios
EXPOSE 8080 4848 1527

# Comando para iniciar GlassFish
CMD ["/bin/bash", "-c", "$GLASSFISH_HOME/bin/asadmin start-domain --verbose"]

