# Official LTS Alpine-based Node.js image
FROM node:lts-alpine
LABEL maintainer="Jose Manuel Sampayo <j.m.sampayo@live.com>"
# Label to make the package linked to the GitHub repository (remove if not needed)
LABEL org.opencontainers.image.source=https://github.com/jmsampayo/minion-builder

# Installing base packages for Jenkins agent
RUN apk add --no-cache bash openjdk21-jre \
# Installing additional packages
&& apk add --no-cache curl git openssh unzip wget zip \
# Installing Jenkins agent
&& mkdir -p /usr/share/jenkins \
    && chmod -R 755 /usr/share/jenkins
ARG AGENT_JAR_URL=https://default-url.com/jnlpJars/agent.jar
ENV AGENT_JAR_URL=$AGENT_JAR_URL
ADD $AGENT_JAR_URL /usr/share/jenkins/agent.jar
RUN chown -R root:root /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/agent.jar \
    && adduser -D -h /home/jenkins -s /bin/bash jenkins

# Setting Jenkins workspace as environment variable
ENV JENKINS_AGENT_WORKDIR=/home/jenkins

# Creating Jenkins workspace directory and setting ownership
RUN mkdir -p "$JENKINS_AGENT_WORKDIR" && chown -R jenkins:jenkins "$JENKINS_AGENT_WORKDIR"

# Switching to the Jenkins user
USER jenkins

# Setting Jenkins workspace as the working directory
WORKDIR $JENKINS_AGENT_WORKDIR

# Entry point to run the Jenkins agent
ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/agent.jar"]