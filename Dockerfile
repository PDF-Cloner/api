FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY *.csproj ./
COPY Tests/UT/UT.csproj Tests/UT/
COPY Tests/IT/IT.csproj Tests/IT/
COPY Tests/E2E/E2E.csproj Tests/E2E/
RUN dotnet restore

COPY . .
RUN dotnet build -c Release --no-restore

FROM build AS test
WORKDIR /src/Tests
RUN dotnet test UT/UT.csproj -c Release --collect:"XPlat Code Coverage" \
 && cp UT/TestResults/*/coverage.cobertura.xml ./cobertura.xml
RUN dotnet test IT/IT.csproj -c Release
RUN dotnet test E2E/E2E.csproj -c Release

FROM build AS publish
WORKDIR /src
RUN dotnet publish -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "api.dll"]
