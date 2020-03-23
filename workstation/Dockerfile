FROM hashicorp/terraform:light AS runner
MAINTAINER "Dwight Spencer (@denzuko)"

LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.name "workstation"
LABEL org.label-schema.description "Terraform workload contianier for assets/workstation"
LABEL org.label-schema.docker.cmd "docker run --rm -ti denzuko/assets/workstation:latest"
LABEL org.label-schema.docker.cmd.prune "docker run --rm -ti denzuko/assets/workstation:latest destroy"
LABEL org.label-schema.docker.cmd.help "docker run --rm -ti denzuko/assets/workstation:latest --help"

WORKDIR /app
COPY main.tf variables.tf /app
RUN terraform init && terraform plan
ENTRYPOINT ["/bin/terraform"]
CMD ["apply"]
