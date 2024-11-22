# Usa una imagen base con JDK 8
FROM openjdk:8-jdk

# Actualiza repositorios e instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    apt-get clean

# Descargar GlassFish 5.0 desde un enlace directo
RUN curl -L -o glassfish.zip http://download.oracle.com/glassfish/5.0/release/glassfish-5.0.zip && \
    unzip glassfish.zip -d /opt && \
    rm glassfish.zip

# Configurar variables de entorno para GlassFish
ENV GLASSFISH_HOME=/opt/glassfish5
ENV PATH=$GLASSFISH_HOME/bin:$PATH

# Copiar el archivo .war al directorio autodeploy de GlassFish
COPY app/carrito3.war $GLASSFISH_HOME/glassfish/domains/domain1/autodeploy/

# Exponer los puertos necesarios para la aplicación y la consola de administración
EXPOSE 8080 4848

# Comando para iniciar GlassFish y configurar el dominio
CMD ["/bin/bash", "-c", "$GLASSFISH_HOME/bin/asadmin start-domain --verbose --domaindir $GLASSFISH_HOME/glassfish/domains"]
