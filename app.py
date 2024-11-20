from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
import hashlib
import os

app = Flask(__name__)
app.secret_key = 'your_secret_key' # Replace 'your_secret_key' with your actual secret key
app.secret_key = os.getenv('SECRET_KEY', 'your_secret_key')

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'King@2024.'
app.config['MYSQL_DB'] = 'cv10'
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB', 'cv10')

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/loginpage', methods=['GET', 'POST'])
def loginpage():
    msg = ''
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM Users WHERE email = %s AND password = %s', (email, password))
        account = cursor.fetchone()
        if account:
            session['loggedin'] = True
            session['id'] = account['user_id']
            session['email'] = account['email']
            return redirect(url_for('portfolio'))
        else:
            msg = 'Incorrect email or password!'
    return render_template('login.html', msg=msg)

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        
        # Check if the user already exists
        cursor.execute('SELECT * FROM Users WHERE email = %s', (email,))
        account = cursor.fetchone()
        
        if account:
            # User already exists
            flash('User already registered', 'error')
            return redirect(url_for('register'))
        else:
            # Hash the password
            hash = password + app.secret_key
            hash = hashlib.sha1(hash.encode())
            password = hash.hexdigest()
            # Insert new user
            cursor.execute('INSERT INTO Users (username, email, password) VALUES (%s, %s, %s)', (username, email, password))
            mysql.connection.commit()
            flash('Thanks for registering, we will get back to you soon!!', 'success')
        
        return redirect(url_for('register'))
    
    return render_template('register.html')

@app.route('/check_user_existence', methods=['GET'])
def check_user_existence():
    email = request.args.get('email')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM Users WHERE email = %s', (email,))
    account = cursor.fetchone()
    if account:
        return 'User exists'
    else:
        return 'User does not exist'

@app.route('/portfolio')
def portfolio():
    if 'loggedin' in session:
        user_id = session['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        
        # Fetch user's portfolio
        cursor.execute('SELECT * FROM Investments WHERE user_id = %s', (user_id,))
        investments = cursor.fetchall()
        
        # Fetch user's watchlist
        cursor.execute('SELECT * FROM Watchlist1 WHERE user_id = %s', (user_id,))
        watchlist = cursor.fetchall()
        
        # Fetch "Company Profile" data
        cursor.execute('SELECT * FROM Company_Profile')
        company_profile = cursor.fetchall()
        
        # Fetch user details
        cursor.execute('SELECT * FROM Users WHERE user_id = %s', (user_id,))
        user = cursor.fetchone()
        
        # Fetch user's balance
        cursor.execute('SELECT balance FROM UserBalances1 WHERE user_id = %s', (user_id,))
        balance = cursor.fetchone()
        balance = balance['balance'] if balance else 0
        
        return render_template('portfolio.html', user=user, investments=investments, watchlist=watchlist, company_profile=company_profile, balance=balance)
    return redirect(url_for('loginpage'))

@app.route('/add_to_watchlist', methods=['POST'])
def add_to_watchlist():
    # Assuming you have a way to identify the company and the user
    # You would typically get these from the request data
    company_id = request.form['company_id']
    user_id = session['id']
    amount = request.form['amount']

    # Logic to add the company to the user's watchlist
    # This might involve updating the database
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    
    # Insert the new investment into the Investments table
    cursor.execute('INSERT INTO Investments (user_id, crypto_id, amount_invested, profit_loss) VALUES (%s, %s, %s, "-")', (user_id, company_id, amount))
    mysql.connection.commit()

    # Show the "Request Sent" popup
    return redirect(url_for('portfolio'))


# New route to fetch chart data
@app.route('/get_chart_data')
def get_chart_data():
    labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'] # Example labels
    values = [16500, 23100, 23150, 28450, 29220, 27210, 30450, 29230, 25930, 26960, 34650, 37700
] # Example values
    return jsonify(labels=labels, values=values)

if __name__ == '__main__':
    app.run(debug=True)

if __name__ == '__main__':
    app.run(debug=True)
