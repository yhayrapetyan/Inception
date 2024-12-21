# requirements/composer/Dockerfile
FROM composer:latest

# Set the working directory
WORKDIR /

# Copy only composer.json and composer.lock if they exist
COPY ./tools/run_composer.sh .
COPY ./conf/composer.json .

RUN chmod +x run_composer.sh

# # Run Composer install
CMD ["./run_composer.sh"]
