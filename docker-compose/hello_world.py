#!/usr/bin/python3

import os
import flask
import psycopg2
from logging_app import logger

app = flask.Flask(__name__)

def insert_data():
	try:
		connection = psycopg2.connect(user = "{}".format(os.environ['DB_USERNAME']),
    								password = "{}".format(os.environ['DB_PASSWORD']),
									host = "{}".format(os.environ['DB_ADDRESS']),
									port = "{}".format(os.environ['DB_CONNECTION']),
									database = "{}".format(os.environ['DB_NAME']))

		logger.info("Connection was Established")
		cursor = connection.cursor()

		cursor.execute("SELECT version();")
		record = cursor.fetchone()
		logger.info("You are connected to - {}".format(record))

		create_table_query = '''CREATE TABLE testing 
								( string char(50) );'''
		cursor.execute(create_table_query)

		insert_to_column = '''INSERT INTO testing (string) VALUES ('hello world!');'''
		cursor.execute(insert_to_column)

		connection.commit()

	except (Exception, psycopg2.Error) as error :
		logger.error("Error while connecting to PostgreSQL", error)
	finally:
		if(connection):
			cursor.close()
			connection.close()
			logger.info("PostgreSQL connection is closed")

def query_from_db():
	try:
		connection = psycopg2.connect(user = "{}".format(os.environ['DB_USERNAME']),
    								password = "{}".format(os.environ['DB_PASSWORD']),
									host = "{}".format(os.environ['DB_ADDRESS']),
									port = "{}".format(os.environ['DB_CONNECTION']),
									database = "{}".format(os.environ['DB_NAME']))

		cursor = connection.cursor()

		cursor.execute("SELECT string from testing;")
		record = cursor.fetchone()
		return str(record[0])
	
	except Exception as e:
		logger.error(e)
	finally:
		if(connection):
			cursor.close()
			connection.close()
			logger.info("PostgreSQL connection is closed")

@app.route('/')
def helloworld():
	logger.info("New request come from {}".format(flask.request.environ['REMOTE_ADDR']))	
	return query_from_db()


if __name__ == "__main__":
	insert_data()
	query_from_db()
	app.run(host='0.0.0.0',port=80)
	


