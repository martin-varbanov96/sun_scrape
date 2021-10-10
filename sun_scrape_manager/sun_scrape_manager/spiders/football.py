import scrapy
from sun_scrape_manager.items import SunScrapeManagerItem


class FootballSpider(scrapy.Spider):
    name = 'football'
    allowed_domains = ['https://www.thesun.co.uk/sport/football/']
    start_urls = ['https://www.thesun.co.uk/sport/football//']

    def __init__(self,):
        self.section = "football"

    def parse(self, response):

        article_titles = response.xpath(
            "//span[@class='rail__item-text']/h3/text()"
            ).extract()
 
        print("*" * 500)
        print(article_titles)
        print()

        for article_title in article_titles:
            yield SunScrapeManagerItem(news_link=response.url,
                                            section=self.section,
                                            title=article_title,
                                            )        
 