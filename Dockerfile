
    FROM ruby:3.2.7 AS builder
    WORKDIR /app
    
    # Install build-time dependencies
    RUN apt-get update -qq && apt-get install -y \
        nodejs \
        postgresql-client \
        build-essential
    
    # Copy Gemfiles and install gems (excluding development and test groups)
    COPY Gemfile Gemfile.lock ./
    RUN bundle install --without development test
    
    # Copy the Sinatra app source code
    COPY app/ app/
    

    RUN mkdir -p app/public/precompiled && cp app/public/index.html app/public/precompiled/ || true
    
    
    FROM ruby:3.2.7-slim
    WORKDIR /app
    
    # Install runtime dependencies
    RUN apt-get update -qq && apt-get install -y \
        postgresql-client
    
    # Copy the built application from the builder stage
    COPY --from=builder /app /app

    RUN adduser --disabled-password --gecos '' consul && chown -R consul:consul /app
    USER consul
    
    # Directly run the application with rackup on port 3006
    CMD ["bundle", "exec", "rackup", "--port", "3006", "--host", "0.0.0.0", "app/config.ru"]
    