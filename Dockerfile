FROM mcr.microsoft.com/dotnet/sdk:10.0 AS builder
WORKDIR /app
COPY BottleTrack.API/*.csproj BottleTrack.API/
RUN dotnet restore ./BottleTrack.API
COPY . .
RUN dotnet publish ./BottleTrack.API -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=builder /app/out .
EXPOSE 8080
ENTRYPOINT ["dotnet", "BottleTrack.API.dll"]
