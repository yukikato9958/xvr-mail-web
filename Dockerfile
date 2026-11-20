FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY XVR-Mail-Web-v1.zip /tmp/project.zip
RUN apt-get update && apt-get install -y unzip && \
    unzip -q /tmp/project.zip -d /src

RUN dotnet publish /src/XVR-Web/XVR.Web.csproj \
    -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "XVR.Web.dll"]
