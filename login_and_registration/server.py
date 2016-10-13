from flask import Flask, session, render_template, redirect, flash, request
from flask_bcrypt import Bcrypt
from mysqlconnection import MySQLConnector
import re
app = Flask(__name__)
app.secret_key = "Seccrett"
bcrypt= Bcrypt(app)
mysql = MySQLConnector(app,'loginregistration')
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
queries = {
    'select':'SELECT * FROM users WHERE email = :email LIMIT 1',
    'insert':'INSERT INTO users (first_name, last_name, email, pw_hash, created_at) VALUES(:first_name,:last_name,:email,:pw_hash,NOW())'
}
@app.route('/')
def index():
    query = "SELECT * FROM users"
    users = mysql.query_db(query)
    return render_template('index.html',user = users)

@app.route('/success')
def show():
    return render_template('success.html')
#Registered a user
@app.route('/create_user', methods=['POST'])
def create():
    # gathering data from form
    first_name = request.form['first_name']
    last_name = request.form['last_name']
    email = request.form['email']
    password = request.form['password']
    c_password = request.form['c_password']
    # validations first_name
    errors = False
    if len(first_name) < 1:
        errors = True
        flash("Field cannot be blank!")
    elif not str.isalpha(str(first_name)):
        errors = True
        flash("Your first name should contain only letters!")
    elif not len(first_name) >= 2:
        errors = True
        flash("Your first name should be at least 2 characters!")

    # validations for last_name
    if len(last_name) < 1:
        errors = True
        flash("Field cannot be blank!")
    elif not str.isalpha(str(last_name)):
        errors = True
        flash("Your last name should contain only letters!")
    elif not len(last_name) >= 2:
        errors = True
        flash("Your last name should be at least 2 characters!")
    # validations for email
    if len(email) < 1:
        errors = True
        flash("Field cannot be blank!")
    elif not EMAIL_REGEX.match(email):
        errors = True
        flash("Invalid email!")
    # validations for password
    if len(password) < 1:
        errors = True
        flash("Field cannot be blank!")
    elif not len(password) >= 8 :
        errors = True
        flash("Password must be at least 8 characters!")
    if len(c_password) < 1:
        errors = True
        flash("Field cannot be blank!")
    if not password == c_password:
        errors = True
        flash("Password doesn't match!")
    if errors:
        return redirect('/')
    else:
        pw_hash = bcrypt.generate_password_hash(password)
        query = queries['insert'] # insert query
        data = {
            'first_name': first_name,
            'last_name':last_name,
            'email':email,
            'pw_hash':pw_hash
        }
        mysql.query_db(query,data)
        flash("Registered!")
        return redirect('/success')

@app.route('/login',methods=['POST'])
def login():
     email = request.form['email']
     password = request.form['password']
     errors = False
     # validations for email
     if len(email) < 1:
         errors = True
         flash("Field cannot be blank!")
     # validations for password
     if len(password) < 1:
         errors = True
         flash("Field cannot be blank!")
     if errors:
         return redirect('/')
     email_exist = False
     e_query = "SELECT email From users"
     # get all the emails from db to compare if the given email is stored
     session['email_query'] =  mysql.query_db(e_query)
     for em in session['email_query']:
         for key in em:
             if not em[key] == email:
                 email_exist = True
             else:
                 email_exist = False
     if email_exist:
         flash("Invalid email!")
         return redirect('/')
     if not email_exist == True:
         pass
     user_query = queries['select']
     query_data = {
        'email':email
     }
     user = mysql.query_db(user_query,query_data)
     if bcrypt.check_password_hash(user[0]['pw_hash'], password):
         flash("You're logged in!")
         return redirect('/success')
     else:
        flash("Wrong password!")
        return redirect('/')

app.run(debug=True)
