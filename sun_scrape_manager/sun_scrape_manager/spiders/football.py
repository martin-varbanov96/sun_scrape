import scrapy


class FootballSpider(scrapy.Spider):
    name = 'football'
    allowed_domains = ['https://www.thesun.co.uk/sport/football/']
    start_urls = ['http://https://www.thesun.co.uk/sport/football//']

    def parse(self, response):
        pass
