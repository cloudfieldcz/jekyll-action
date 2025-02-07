# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /usr/src/app

# Install Jekyll and Bundler
RUN gem install jekyll -v 4.3.2
RUN gem install bundler

### Copy over the entrypoint shell script
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
