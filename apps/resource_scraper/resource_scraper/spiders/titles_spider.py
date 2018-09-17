import scrapy


class TitlesSpider(scrapy.Spider):
    name = "titles"

    def __init__(self, input='', *args, **kwargs):
        super(TitlesSpider, self).__init__(*args, **kwargs)
        self.input_file = input

    def start_requests(self):
        # /mnt/hgfs/work/Gremlin/gremlin-projects/chaos-monkey/
        file_path = "/mnt/hgfs/work/Gremlin/gremlin-projects/chaos-monkey/_data/resource-urls.csv"
        #file_path = path.relpath("../../../../_data/resource-urls.csv")
        f = open(self.input_file)
        urls = [url.strip() for url in f.readlines()]
        f.close()
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        try:
            title = response.xpath('//title/text()').extract_first()
            self.log(title)        
            yield {
                #'url': response.url,
                'title': title,
            }
        except:
            yield {
                'title': 'ERROR/INVALID',
            }
        # page = response.url.split("/")[-2]
        # filename = 'quotes-%s.html' % page
        # with open(filename, 'wb') as f:
        #     f.write(response.body)
        # self.log('Saved file %s' % filename)
