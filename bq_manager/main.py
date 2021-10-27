from google.cloud import bigquery

def scrape_upload_to_bq(request):
    """function to scrape and add entries to bq"""
    # Construct a BigQuery client object.
    client = bigquery.Client()

    table_id = "static-emblem-327016.sun_scrape_sun_data_set_id.bar"

    rows_to_insert = [
        {u"title": u"title", "section": u"football", u"article_link": u"https://www.thesun.co.uk/sport/16267574/emre-tezgel-stoke-city-harry-kane-jude-bellingham/"},
        {u"title": u"title", "section": u"football", u"article_link": u"https://www.thesun.co.uk/sport/16267574/emre-tezgel-stoke-city-harry-kane-jude-bellingham/"},
        {u"title": u"title", "section": u"football", u"article_link": u"https://www.thesun.co.uk/sport/16267574/emre-tezgel-stoke-city-harry-kane-jude-bellingham/"},
    ]

    errors = client.insert_rows_json(table_id, rows_to_insert)  # Make an API request.
    if errors == []:
        print("New rows have been added.")
    else:
        print("Encountered errors while inserting rows: {}".format(errors))
