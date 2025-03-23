# Importing necessary modules:
# Flask: A web framework for building web applications.
# render_template: Renders HTML templates.
# request: Handles HTTP requests.
# send_file: Sends files to the client.
# flash: Provides a way to show messages to users.
# redirect and url_for: Handle redirects within the web app.
from flask import Flask, render_template, request, send_file, flash, redirect, url_for

# rembg: A library used to remove image backgrounds.
from rembg import remove

# PIL: A library for image processing. Here, Image is used to open and process images, and UnidentifiedImageError for handling invalid image formats.
from PIL import Image, UnidentifiedImageError

# BytesIO: Used to handle binary streams for in-memory files.
from io import BytesIO

# os: Provides operating system-related functionalities, such as generating random keys.
import os

# logging: Allows the app to log important messages, such as errors and debugging information.
import logging

# Initialize a Flask application.
app = Flask(__name__)

# Generate a secret key dynamically for secure session cookies.
app.secret_key = os.urandom(24)

# Configure logging to show informational messages in the console.
logging.basicConfig(level=logging.INFO)

# Set a maximum file size limit for uploads to 10 MB to prevent oversized files.
app.config['MAX_CONTENT_LENGTH'] = 10 * 1024 * 1024  # 10 MB

# Specify allowed file extensions for uploaded images. This ensures only valid image formats are accepted.
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

# Helper function to check if the uploaded file has an allowed extension.
def allowed_file(filename):
    # Checks that the file has an extension and it matches one of the allowed types.
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Route for the main page. This function handles both GET (loading the page) and POST (uploading files) requests.
@app.route('/', methods=['GET', 'POST'])
def upload_file():
    # If the HTTP method is POST, process the uploaded file.
    if request.method == 'POST':
        # Check if the user included a file in their request.
        if 'file' not in request.files:
            flash('No file part in the request', 'danger')  # Show an error message to the user.
            return redirect(request.url)  # Redirect back to the main page.
        
        file = request.files['file']  # Retrieve the uploaded file.
        
        # If the user didn't select a file, display an error message.
        if file.filename == '':
            flash('No file selected', 'danger')
            return redirect(request.url)
        
        # Validate the file format by calling the allowed_file function.
        if not allowed_file(file.filename):
            flash('Invalid file format. Only PNG, JPG, and JPEG are allowed.', 'danger')
            return redirect(request.url)
        
        try:
            # Attempt to open the uploaded image using PIL.
            input_image = Image.open(file.stream)
        except UnidentifiedImageError:
            # Handle invalid image files gracefully by notifying the user.
            flash('Invalid image file. Please upload a valid image.', 'danger')
            return redirect(request.url)
        
        try:
            # Process the uploaded image to remove its background.
            output_image = remove(input_image, post_process_mask=True)  # `post_process_mask` improves the output quality.
            
            # Save the processed image to an in-memory file object.
            img_io = BytesIO()
            output_image.save(img_io, 'PNG')  # Save the image in PNG format.
            img_io.seek(0)  # Reset the file pointer to the beginning for reading.

            # Send the processed image back to the user as a downloadable file.
            return send_file(img_io, mimetype='image/png', as_attachment=True, download_name='image_rmbg.png')
        
        except Exception as e:
            # Log any error that occurs during background removal for debugging.
            logging.error(f"Error during background removal: {e}")
            flash('Failed to remove background from the image. The background might not be suitable for removal.', 'danger')
            return redirect(request.url)
    
    # Render the main HTML template for GET requests.
    return render_template('index.html')

# Entry point of the script when run directly.
if __name__ == '__main__':
    # Run the app locally for development.
    # Use 'host=0.0.0.0' to make it accessible over the network.
    # Set debug to False for a production-like setting.
    app.run(host='0.0.0.0', debug=False, port=5100)
