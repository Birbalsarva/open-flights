# Use the official Ruby image
FROM ruby:latest

# Set environment variables for Rails
ENV RAILS_ENV=development \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    DATABASE_URL=sqlite3::memory:

# Set working directory
WORKDIR /app

# Install Node.js, Yarn, and netcat
RUN apt-get update && apt-get install -y \
    nodejs \
    yarn \
    netcat-openbsd \
  && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the application code
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
