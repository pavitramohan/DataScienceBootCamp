from flask import Flask, render_template, redirect
import pymongo
import scrape_mars

# create instance of Flask app
app = Flask(__name__)

# setup mongo connection
conn = "mongodb://localhost:27017"
client = pymongo.MongoClient(conn)

# connect to mongo db and collection
db = client.mars_scrape_db
collection = db.scraped_data

# create route that renders index.html template
@app.route("/")
def home():
    scraped_data = collection.find_one()
    return render_template("index.html", data=scraped_data)

# create route that scrape mars data
@app.route("/scrape")
def scrape():
    scraped_data = scrape_mars.scrape()
    collection.update( {}, scraped_data, upsert=True)
    return redirect("/")

if __name__ == "__main__":
    app.run(debug=True)