from flask import Flask, session, render_template, redirect, flash, request, Blueprint
from flask_bcrypt import Bcrypt
from mysqlconnection import MySQLConnector
import re
app = Flask(__name__)
app.secret_key = "Seccrett"
bcrypt= Bcrypt(app)
mysql = MySQLConnector(app,'the_wall')
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/create_user',methods=['POST'])
def create():
    # Collecting data from register form
    first_name = request.form['first_name']
    last_name = request.form['last_name']
    email = request.form['email']
    password = request.form['password']
    c_password = request.form['c_password']
    # Possible errors
    errors = False
    # Validating data from register form
    if len(first_name) < 1:
        errors = True
        flash('Field cannot be blank!')
    elif not str.isalpha(str(first_name)):
        errors = True
        flash('Filed must contain only letters!')
    elif not len(first_name)>= 2:
        errors = True
        flash('Field must contain at least 2 characters!')

    elif len(last_name) < 1:
        errors = True
        flash('Field cannot be blank!')
    elif not str.isalpha(str(last_name)):
        errors = True
        flash('Filed must contain only letters!')
    elif not len(last_name)>= 2:
        errors = True
        flash('Field must contain at least 2 characters!')

    elif len(email) < 1:
        errors = True
        flash('Field cannot be blank!')
    elif not EMAIL_REGEX.match(email):
        errors = True
        flash('Invalid email!')

    elif len(password) < 1:
        errors = True
        flash('Field cannot be blank!')
    elif not len(password) >= 8:
        errors = True
        flash('Password must be at least 8 characters!')

    elif len(c_password) <1:
        errors = True
        flash('Field cannot be blank!')
    elif not password == c_password:
        errors = True
        flash('Password must match!')

    if errors:
        session['errors'] ='red'
        return redirect('/')
    else:
        query = "INSERT INTO users (first_name, last_name, email, password, created_at, updated_at)VALUES (:first_name,:last_name,:email,:password,NOW(),NOW())"
        data ={
            'first_name': first_name,
            'last_name': last_name,
            'email': email,
            'password':bcrypt.generate_password_hash(password)
        }
        mysql.query_db(query,data)
        session['errors'] = 'green'
        flash("Registered successfully!")
        return redirect('/')

# Per login duhet qitu
@app.route('/login', methods=['POST'])
def login():
    # Collecting data from LOGIN form
    email = request.form['email']
    password = request.form['password']
    # Validating data
    errors = False
    if len(email) < 1:
        errors = True
        flash('Field cannot be blank!')
    elif not EMAIL_REGEX.match(email):
        errors = True
        flash('Invalid email!')
    elif len(password) < 1:
        errors = True
        flash('Field cannot be blank!')
    if errors:
        session['errors'] ='red'
        return redirect('/')
    else:
        query = "SELECT * FROM users WHERE email = :email"
        data = {
            'email': email
        }
        user = mysql.query_db(query, data)
        if user[0]:
            if bcrypt.check_password_hash(user[0]['password'], request.form['password']):
                session['user_id'] = user[0]['id']
                session['user'] = user[0]
                return redirect('/wall')
	    flash('Email/Password combination not found!')
	    return redirect('/')

def get_all_messages():
    query = "SELECT users.id, users.first_name, users.last_name, messages.message, messages.id as message_id, messages.created_at FROM  users JOIN messages ON users.id = messages.user_id ORDER BY created_at DESC"
    messages = mysql.query_db(query)
    return messages
def get_all_comments():
    query = "SELECT comments.id AS comment_id,comments.user_id AS user_id, users.first_name AS first_name, users.last_name AS last_name, comments.comment AS comment, comments.created_at AS created_at, comments.message_id AS message_id FROM comments JOIN users ON comments.user_id = users.id ORDER BY created_at"
    comments = mysql.query_db(query)
    return comments

@app.route('/wall')
def wall():
    messages_query = get_all_messages()
    comments_query = get_all_comments()
    return render_template('show.html', messages = messages_query, comments = comments_query)

@app.route('/messages', methods=['POST'])
def post_message():
    message = request.form['message']
    if len(message) < 1:
        redirect('/wall')
    else:
        query = "INSERT INTO messages (user_id, message, created_at)VALUES (:user_id,:message, NOW());"
        data = {
            'user_id': session['user_id'],
            'message': message
        }
        mysql.query_db(query,data)
        return redirect('/wall')

@app.route('/comments',methods=['POST'])
def post_comment():
    #Collect comment form a message
    comment = request.form['comment']
    message_id = request.form['message_id']
    if len(comment) < 1:
        redirect('/wall')
    else:
        query = "INSERT INTO comments(message_id, user_id, comment, created_at) VALUES((SELECT id FROM messages WHERE id = :message_id),:user_id, :comment, NOW())"
        data = {
            'user_id': session['user_id'],
            'message_id': message_id,
            'comment': comment
        }
        mysql.query_db(query,data)
        return redirect('/wall')
@app.route('/delete-comment', methods =['POST'])
def delete():
    comment_id = request.form['comment_id']
    print comment_id
    query = "DELETE FROM comments WHERE id = :id"
    data ={
        'id':comment_id
    }
    mysql.query_db(query,data)
    return redirect('/wall')
@app.route('/logout')
def logout():
    session.pop('user_id')
    return redirect('/')
app.run(debug=True)
