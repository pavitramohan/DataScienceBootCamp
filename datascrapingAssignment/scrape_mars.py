from splinter import Browser
from bs4 import BeautifulSoup as bs
import pandas as pd
import time

def scrape_mars_news(scraped_data, browser):
    # Scrape Mars News
    browser.visit("https://mars.nasa.gov/news/")
    soup = bs(browser.html,'html.parser')
    for li in soup.find_all('li', class_='slide'):
        news_title = li.find('div', class_='content_title').text
        news_paragraph = li.find('div', class_='article_teaser_body').text
        scraped_data['news_title'] = news_title
        scraped_data['news_paragraph'] = news_paragraph
        break # one news is enough

def scrape_featured_image(scraped_data,browser):
    # Scrape Featured Image
    browser.visit('https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars')
    browser.click_link_by_id("full_image")
    time.sleep(0.5)
    try:
        browser.find_link_by_partial_text('more info')[0].click()
    except:
        # try again
        time.sleep(2)
        browser.find_link_by_partial_text('more info')[0].click()
    soup = bs(browser.html,'html.parser')
    featured_image_url = 'https://www.jpl.nasa.gov' + soup.find('img', class_='main_image')['src']
    scraped_data['featured_image_url'] = featured_image_url

def scrape_weather(scraped_data, browser):
    # Scrape Tweeted Mars Weather
    browser.visit('https://twitter.com/marswxreport?lang=en')
    soup = bs(browser.html,'html.parser')
    Mars_Weather = ''
    for div in soup.find_all('div', class_='tweet'):
        tweet_header = div.find('div', class_='stream-item-header').text.lstrip()
        if tweet_header.startswith("Mars Weather"):
            Mars_Weather = div.find('p', class_='TweetTextSize').contents[0]
            break

    scraped_data['Mars_Weather'] = Mars_Weather

def scrape_facts(scraped_data, browser):
    # Scrape Mars Facts
    tables = pd.read_html('https://space-facts.com/mars/')
    df = tables[0]
    df.columns = ['Description',"Value"]
    facts_table = df.to_html(header=False,index=False).replace('\n','')
    scraped_data['facts_table'] = facts_table

def scrape_hemispheres(scraped_data, browser):
    # Scrape Hemispheres Images
    browser.visit('https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars')
    urls = []
    for item in browser.find_by_css('.description'):
        tag = item.find_by_tag('a')[0]
        title, url = tag.value, tag['href']
        urls.append((title,url))

    hemisphere_image_urls = []    
    for title, url in urls:
        browser.visit(url)
        img_url = browser.find_by_css('.wide-image')[0]['src']
        hemisphere_image_urls.append( {'title':title, 'img_url':img_url} )

    scraped_data['hemispheres'] = hemisphere_image_urls

def scrape():
    
    browser = Browser('chrome')
    scraped_data = {}
    
    scrape_mars_news(scraped_data, browser)
    scrape_featured_image(scraped_data,browser)
    scrape_weather(scraped_data, browser)
    scrape_facts(scraped_data, browser)
    scrape_hemispheres(scraped_data, browser)

    return scraped_data

if __name__ == '__main__':
    scraped_data = scrape()
    print(scraped_data) 