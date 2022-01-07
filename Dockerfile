FROM jupyter/datascience-notebook:hub-2.0.1

USER root

RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb

RUN apt-get update --yes && sudo apt-get install -y apt-transport-https dotnet-sdk-6.0

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=1

ENV PATH="${PATH}:/${HOME}/.dotnet/tools"
RUN dotnet tool install -g Microsoft.dotnet-interactive
RUN dotnet interactive jupyter install

RUN fix-permissions "${CONDA_DIR}" && fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
