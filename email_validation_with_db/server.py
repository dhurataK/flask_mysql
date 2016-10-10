from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
import re, datetime
app = Flask(__name__)
app.secret_key ="ThisIsSecret"
mysql = MySQLConnector(app,'mydb')
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
@app.route('/')
def index():
    query = "SELECT * FROM users"                           # define your query
    friends = mysql.query_db(query)                           # run query with query_db()
    return render_template('index.html', all_friends=friends)

@app.route('/validate', methods=['POST'])
def create_email():
    email = request.form['email']
    if not EMAIL_REGEX.match(email):
        flash("Email is not vaild!")
        session['color'] = 'red'
        return redirect('/')
    else:
        query = "INSERT INTO emails (email,created_at, updated_at) VALUES(:email,NOW(),NOW())"
        data = {
            "email": request.form['email']
        }
        mysql.query_db(query,data)
        session['color'] = 'green'
        flash("The email address you entered "+email+" is a VALID email address! Thank you!")
        return redirect('/success')

@app.route('/success')
def show():
    query = "SELECT id,email, created_at FROM emails"
    data = {}
    emails = mysql.query_db(query, data)
    return render_template('success.html', emails=emails)

@app.route('/<id>', methods=["POST"])
def destroy(id):
    query = "DELETE FROM emails WHERE id = :id"
    data = {
        'id' : id
    }
    flash('Successfully deleted email!')
    mysql.query_db(query, data)
    return redirect('/success')
app.run(debug=True)
