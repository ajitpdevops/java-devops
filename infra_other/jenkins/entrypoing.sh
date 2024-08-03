#!/bin/bash

# Start Docker daemon in the background
nohup dockerd &

# Wait for Docker daemon to start
while(! docker stats --no-stream ); do
  echo "Waiting for Docker to start..."
  sleep 1
done

# Check if all necessary environment variables are set
if [ -z "$JENKINS_URL" ] || [ -z "$JENKINS_AGENT_NAME" ] || [ -z "$JENKINS_AGENT_WORKDIR" ] || [ -z "$JENKINS_SECRET" ]; then
  echo "Error: JENKINS_URL, JENKINS_AGENT_NAME, JENKINS_AGENT_WORKDIR, and JENKINS_SECRET must be set."
  exit 1
fi

# Register the Jenkins Agent with the master
java -jar /usr/share/jenkins/agent.jar \
  -jnlpUrl ${JENKINS_URL}/computer/${JENKINS_AGENT_NAME}/slave-agent.jnlp \
  -secret ${JENKINS_SECRET} \
  -workDir ${JENKINS_AGENT_WORKDIR}
