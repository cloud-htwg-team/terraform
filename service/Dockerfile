# syntax = docker/dockerfile:experimental

### Build Image ##

FROM gradle:7.5.1-jdk17-alpine AS builder
COPY --chown=gradle:gradle . /build
WORKDIR /build
RUN gradle build --no-daemon
#RUN echo $(ls -1 /build/build/libs)
#RUN ls -1 /build/build/libs

### RUN Image ##


# use JRE as JDK can be a security vulnerability; alpine is a slim version, then resulting image is 300MB smaller
FROM eclipse-temurin:17-jre-alpine

RUN wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip \
  && unzip terraform_1.3.7_linux_amd64.zip \
  && mv terraform / \
  && rm terraform_1.3.7_linux_amd64.zip

COPY ./terraform-tenant-prod/deployment.tf /opt/terraform/tenant/deployment.tf
COPY ./terraform-tenant-prod/ingress.tf /opt/terraform/tenant/ingress.tf
COPY ./terraform-tenant-prod/main.tf /opt/terraform/tenant/main.tf
COPY ./terraform-tenant-prod/output.tf /opt/terraform/tenant/output.tf
COPY ./terraform-tenant-prod/provider.tf /opt/terraform/tenant/provider.tf
COPY ./terraform-tenant-prod/service.tf /opt/terraform/tenant/service.tf
COPY ./terraform-tenant-prod/variables.tf /opt/terraform/tenant/variables.tf
COPY ./terraform-tenant-prod/application_default_credentials.json /opt/terraform/tenant/application_default_credentials.json
WORKDIR /opt/terraform/tenant
RUN /terraform init && /terraform plan

# -- will create the directory, set's path context --> ./ == /opt/app
WORKDIR /opt/app
# RUN #addgroup --system javauser && adduser -S -s /usr/sbin/nologin -G javauser javauser
# there is a command 'ADD' but 'COPY" is prefered
COPY --from=builder /build/build/libs/terraform-microservice.jar ./terraform-microservice.jar

#RUN chown -R javauser:javauser .
#USER javauser

ENTRYPOINT ["java", "-jar", "./terraform-microservice.jar"]

# Optimizing Docker Sprring Boot images
# https://mydeveloperplanet.com/2022/11/30/docker-best-practices/
# https://mydeveloperplanet.com/2022/12/14/spring-boot-docker-best-practices/