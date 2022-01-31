# Build
FROM maven:3.6.3-jdk-11 AS myapp
# Déclare la var d'env MYAPP_HOME
ENV MYAPP_HOME /opt/myapp
# Change de répertoire
WORKDIR $MYAPP_HOME
# Copie des fichers sources et du pom du projet seulement
COPY app/pom.xml .
COPY app/src ./src
#Construction du package avec maven
RUN mvn clean package -DskipTests
# Run
FROM openjdk:11-jre
# Déclare la var d'env MYAPP_HOME
ENV MYAPP_HOME /opt/myapp
# Change de répertoire
WORKDIR $MYAPP_HOME
# Copie le jar crée dans la phase de build depuis l'image ci-dessus
COPY --from=myapp $MYAPP_HOME/target/*.jar $MYAPP_HOME/myapp.jar
ENTRYPOINT java -jar myapp.jar