FROM swift:5.7

WORKDIR /app

COPY . /analyzer

RUN swift build --package-path /analyzer

ENTRYPOINT ["swift", "run", "--package-path", "/analyzer", "swift-analyzer"]
