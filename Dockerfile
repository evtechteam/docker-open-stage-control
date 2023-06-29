FROM node:19.2.0-alpine3.15

# renovate: datasource=github-releases depName=jean-emmanuel/open-stage-control
ARG OSC_VERSION=v1.25.1

##https://github.com/jean-emmanuel/open-stage-control/releases/download/v1.15.4/open-stage-control-1.15.4-node.zip
RUN apk update && \
    apk add --no-cache --upgrade curl unzip && \
    #curl -o /tmp/open-stage-control.zip -L https://github.com/jean-emmanuel/open-stage-control/releases/download/${OSC_VERSION}/open-stage-control-${OSC_VERSION#v}-node.zip && \
    curl -o /tmp/open-stage-control.zip -L https://github.com/jean-emmanuel/open-stage-control/releases/download/${OSC_VERSION}/open-stage-control-${OSC_VERSION#v}-linux-x64.zip && \
    cd /tmp && \
    unzip /tmp/open-stage-control.zip && \
    #mv /tmp/open-stage-control-${OSC_VERSION#v}-node /app && \
    mv /tmp/open-stage-control-${OSC_VERSION#v}-linux-x64/resources/app /app && \
    rm -rf /tmp/open-stage-control* && \
    mkdir -p /root/.config/open-stage-control && \
    apk del curl unzip

WORKDIR /app

EXPOSE 8080

#ENTRYPOINT ["npm", "run", "start-node", "--", "-n"]
ENTRYPOINT ["node", ".", "-n"]
