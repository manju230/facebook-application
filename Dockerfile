# Use the official Apache HTTP Server image as base
FROM httpd:2.4

# Copy your custom HTML files into the container
# Replace 'public-html' with the directory containing your site content
COPY ./facebook.html/ /usr/local/apache2/htdocs/

# Expose port 80 for web traffic
EXPOSE 80