import os                                        # Imports the os module to interact with the operating system
from flask import Flask, render_template, request, redirect, url_for  # Imports necessary functions from Flask
from flask_mysqldb import MySQL                  # Imports the MySQL extension for Flask

app = Flask(__name__)                            # Creates a Flask application instance

# Configure MySQL from environment variables
app.config['MYSQL_HOST'] = os.environ.get('MYSQL_HOST', 'localhost')  # Sets the MySQL host from environment variable or defaults to 'localhost'
app.config['MYSQL_USER'] = os.environ.get('MYSQL_USER', 'default_user')  # Sets the MySQL user from environment variable or defaults to 'default_user'
app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQL_PASSWORD', 'default_password')  # Sets the MySQL password from environment variable or defaults to 'default_password'
app.config['MYSQL_DB'] = os.environ.get('MYSQL_DB', 'default_db')  # Sets the MySQL database name from environment variable or defaults to 'default_db'

# Initialize MySQL
mysql = MySQL(app)                               # Initializes the MySQL extension with the Flask app

@app.route('/')
def hello():
    # Retrieve messages from the database
    cur = mysql.connection.cursor()              # Creates a cursor to interact with the database
    cur.execute('SELECT message FROM messages')  # Executes a SQL query to select messages from the 'messages' table
    messages = cur.fetchall()                    # Fetches all the results from the executed query
    cur.close()                                  # Closes the cursor
    return render_template('index.html', messages=messages)  # Renders the 'index.html' template with the retrieved messages

@app.route('/submit', methods=['POST'])
def submit():
    new_message = request.form.get('new_message')  # Gets the new message from the form submission
    cur = mysql.connection.cursor()              # Creates a cursor to interact with the database
    cur.execute('INSERT INTO messages (message) VALUES (%s)', [new_message])  # Executes a SQL query to insert the new message into the 'messages' table
    mysql.connection.commit()                    # Commits the transaction to the database
    cur.close()                                  # Closes the cursor
    return redirect(url_for('hello'))            # Redirects the user to the 'hello' route

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)  # Runs the Flask app on all available IP addresses (0.0.0.0) at port 5000 with debug mode enabled
