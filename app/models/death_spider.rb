class DeathSpider < Kimurai::Base  
  @name = 'death_spider'
  @engine = :mechanize
  @start_urls = ["https://www.dignitymemorial.com/obituaries/denver-co"]
  @@items = []

  def self.process
    self.crawl!
  end

  def parse(response, url:, data: {})
    @@items = []

    # Loop through each obituary result container
    response.xpath("//div[@id='obituariesResults']/div[contains(@class, 'obit-result-container')]").each do |obit_container|
        item = {}

        # Extract relevant data
        # item[:image_url] = obit_container.at_xpath(".//img[@class='preview-obit-image']/@src").to_s.strip
        item[:name] = obit_container.at_xpath(".//h3[@class='screen-title-title']").text.strip
        item[:date] = obit_container.at_xpath(".//p[contains(@class, 'screen-title-date')]/span").text.strip
        item[:link] = obit_container.at_xpath(".//a[@class='DM-link obit-result-link']/@href").to_s.strip
        item[:description] = obit_container.at_xpath(".//div[contains(@class, 'obit-result-text')]/p").text.strip

        @@items << item
    end
    @@items
  end

  def self.items
    @@items || []
  end

  def self.get_names_and_dates
    items = self.items
    items.map { |item| { name: item[:name], date: item[:date], link: item[:link], description: item[:description] } }
  end

  BASE_URL = "https://www.dignitymemorial.com"

  def self.compare_and_save_matches
    scraped_data = DeathSpider.get_names_and_dates

    scraped_data.each do |scraped_item|
      name_parts = scraped_item[:name].split
      puts "Scraped Link: #{scraped_item[:link]}"
      first_name = name_parts.first
      last_name = name_parts.last

      # Extract and parse the birth date from the scraped data
      date_parts = scraped_item[:date].split("–")
      birth_date_from_string = Date.strptime(date_parts.first.strip, '%m/%d/%Y')
      death_date_from_string = Date.strptime(date_parts.last.strip, '%m/%d/%Y')

      # Find the user by first name, last name, and date of birth
      user = User.find_by(first_name: first_name, last_name: last_name, date_of_birth: birth_date_from_string)

      # puts "Complete URL: #{BASE_URL}#{scraped_item[:link]}"

      if user && !Match.exists?(user_id: user.id)
        Match.create(
          user_id: user.id, 
          date_of_passing: death_date_from_string,
          obituary_url: "#{BASE_URL}#{scraped_item[:link]}",
          summary: scraped_item[:description],
          matched_on: Date.today)
      end
    end
  end
end