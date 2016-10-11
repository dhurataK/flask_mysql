from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
app = Flask(__name__)
# connect and store the connection in "mysql" note that you pass the database name to the function
mysql = MySQLConnector(app, 'friendsdb')
queries = {
    'select':'SELECT * FROM friends',
    'insert':'INSERT INTO friends(first_name,last_name,email,created_at,updated_at) VALUES(:first_name,:last_name,:email,NOW(),NOW())',
    'delete':'DELETE FROM friends WHERE id=:id',
    'update':'UPDATE friends SET first_name =:first_name, last_name=:last_name, email = :email, updated_at = NOW() WHERE id =:id',
    'show': "SELECT * FROM friends WHERE id = :id"
}
@app.route('/')
def index():
    query = queries['select']
    data = {}
    show = mysql.query_db(query,data)
    return render_template('index.html', show_data = show)

@app.route('/friends', methods=['POST'])
def create():
    query = queries['insert']
    data = {
        'first_name': request.form['first_name'],
        'last_name' : request.form['last_name'],
        'email':request.form['email']
    }
    mysql.query_db(query,data)
    return redirect('/')

@app.route('/friends/<id>/edit', methods=['GET'])
def edit(id):
    query = queries['show']
    data = {
        'id':id
    }
    friend = mysql.query_db(query,data)
    return render_template('edit.html',friend = friend)

@app.route('/friends/<id>', methods=["POST"])
def update(id):
    query = queries['update']
    data = {
        'first_name' : request.form['first_name'],
        'last_name' : request.form['last_name'],
        'email' : request.form['email'],
        'id' : id
    }
    mysql.query_db(query,data)
    return redirect('/')

@app.route('/friends/<id>/delete', methods=['POST'])
def destroy(id):
    query = queries['delete']
    data ={
        'id': id
    }
    mysql.query_db(query,data)
    return redirect('/')

app.run(debug=True)
