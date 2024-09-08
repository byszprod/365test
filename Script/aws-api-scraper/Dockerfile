# Use a base Python image
FROM python:3.9-alpine3.20

# Set the working directory in the container
WORKDIR /app

# Create a non-root user and group
RUN addgroup -S scraper && adduser -S scraper -G scraper

# Copy the files and change ownership to the non-root user
COPY --chown=scraper:scraper requirements.txt .
COPY --chown=scraper:scraper scraper.py .

# Install the dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Make the script executable (optional)
RUN chmod +x scraper.py

# Switch to the non-root user
USER scraper

# Set the entrypoint for the container
ENTRYPOINT ["python", "scraper.py"]