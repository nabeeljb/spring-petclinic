FROM openjdk:11-jre-slim

COPY target/your-application.jar /app/your-application.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/your-application.jar"]
