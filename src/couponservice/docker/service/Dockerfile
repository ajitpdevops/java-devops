FROM amazoncorretto:17.0.7-alpine

# Add app user
ARG APPLICATION_USER=appuser
RUN adduser --no-create-home -u 1000 -D $APPLICATION_USER

# Configure working directory
RUN mkdir /app && \
    chown -R $APPLICATION_USER /app

USER 1000

COPY --chown=1000:1000 couponservice/target/couponservice-0.0.1-SNAPSHOT.jar /app/app.jar
WORKDIR /app

EXPOSE 8090

ENTRYPOINT [ "java", "-jar", "app.jar" ]