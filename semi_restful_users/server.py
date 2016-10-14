from flask import Flask, session, render_template, redirect, flash, request
from flask_bcrypt import Bcrypt
from mysqlconnection import MySQLConnector
import re
app = Flask(__name__)
app.secret_key = "Seccrett"
bcrypt= Bcrypt(app)
mysql = MySQLConnector(app,'py_semi_restful')
# Route 1
@app.route('/users')
def index():
    query = "SELECT * FROM users"
    users = mysql.query_db(query)# [{}]
    return render_template('index.html', users = users)
#Route 2
@app.route('/users/new')
def new():
    return render_template('new.html')
#Route 3
@app.route('/users/<id>/edit')
def edit(id):
    query = "SELECT * FROM users WHERE id = :id"
    data = {
        'id':id
    }
    user = mysql.query_db(query,data)
    return render_template('edit.html', this_user = user[0])
#Route 4
@app.route('/users/<id>')
def show(id):
    query = "SELECT * FROM users WHERE id = :id"
    data = {
        'id':id
    }
    user = mysql.query_db(query,data)
    return render_template('show.html', this_user = user[0])
#Route 5
@app.route('/users/create', methods =['POST'])
def create():
    query = "INSERT INTO users(first_name,last_name,email,created_at)VALUES(:first_name,:last_name,:email,NOW())"
    data ={
        'first_name': request.form['first_name'],
        'last_name': request.form['last_name'],
        'email':request.form['email']
    }
    user_id = mysql.query_db(query,data)
    return redirect('/users/'+str(user_id))
#Route 6
@app.route('/users/<id>/destroy')
def destroy(id):
    query = "DELETE FROM users WHERE id = :id"
    data = {
        'id':id
    }
    mysql.query_db(query,data)
    return redirect('/users')
#Route 7
@app.route('/users/<id>', methods=['POST'])
def update(id):
    query = "UPDATE users SET first_name = :first_name, last_name = :last_name, email = :email, updated_at = NOW() WHERE id = :id"
    data = {
        'first_name': request.form['first_name'],
        'last_name':request.form['last_name'],
        'email':request.form['email'],
        'id':id
    }
    mysql.query_db(query,data)
    return redirect('/users/'+str(id))
app.run(debug=True)
