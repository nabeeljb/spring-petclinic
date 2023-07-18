FROM openjdk:11-jre-slim

COPY target/*.jar /app/

EXPOSE 8080

CMD ["java", "-jar", "/app/petclinic.jar"]
