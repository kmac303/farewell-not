class DeathSpider < Kimurai::Base  
  @name = 'death_spider'
  @engine = :mechanize
  @start_urls = ["https://www.dignitymemorial.com/obituaries/denver-co"]
  @@items = []

  def self.process
    self.crawl!
  end

  # def parse(response, url:, data: {})
  #   items = []

  #    # Loop through each obituary result container
  #    response.xpath("//div[@id='obituariesResults']/div[contains(@class, 'obit-result-container')]").each do |obit_container|
  #       item = {}

  #       # Extract relevant data
  #       item[:image_url] = obit_container.at_xpath(".//img[@class='preview-obit-image']/@src").to_s.strip
  #       item[:name] = obit_container.at_xpath(".//h3[@class='screen-title-title']").text.strip
  #       item[:date] = obit_container.at_xpath(".//p[contains(@class, 'screen-title-date')]/span").text.strip
  #       item[:link] = obit_container.at_xpath(".//a[@class='DM-link obit-result-link']")['href']
  #       item[:description] = obit_container.at_xpath(".//div[contains(@class, 'obit-result-text')]/p").text.strip
  
  #       items << item
  #     end
  
  #     # Save items to results.json
  #     items.each do |item|
  #       # puts item.inspect
  #       # puts "Saving: #{item[:name]}"
  #       file_path = Rails.root.join('results.json')
  #       save_to file_path.to_s, item, format: :pretty_json
  #     end

  #     puts items.inspect
  #     items
  # end

  def parse(response, url:, data: {})
    @@items = []

    # Loop through each obituary result container
    response.xpath("//div[@id='obituariesResults']/div[contains(@class, 'obit-result-container')]").each do |obit_container|
        item = {}

        # Extract relevant data
        item[:image_url] = obit_container.at_xpath(".//img[@class='preview-obit-image']/@src").to_s.strip
        item[:name] = obit_container.at_xpath(".//h3[@class='screen-title-title']").text.strip
        item[:date] = obit_container.at_xpath(".//p[contains(@class, 'screen-title-date')]/span").text.strip
        item[:link] = obit_container.at_xpath(".//a[@class='DM-link obit-result-link']")['href']
        item[:description] = obit_container.at_xpath(".//div[contains(@class, 'obit-result-text')]/p").text.strip

        @@items << item
    end
    @@items
end

def self.items
  @@items || []
end

  # def self.get_names
  #   # This is a simplified method that returns all the scraped names
  #   items = self.process
  #   # Assuming your spider is set up to scrape names into the `items` array
  #   items.map { |item| item[:name] }
  # end

  def self.get_names
    # items = self.process
    # names = []
    # items.each do |item|
    #   puts "Item class: #{item.class}"
    #   names << item[:name]
    # end
    # names
    # puts "Items directly from process: #{self.process.inspect}"
    items = self.items
    items.map { |item| item[:name] }
  end

#   def self.compare_and_save_matches
#     scraped_names = DeathSpider.get_names
  
#     scraped_names.each do |scraped_name|
#       # Split the scraped_name into first and last names.
#       # Assuming the format is always "First Last".
#       first_name, last_name = scraped_name.split(' ', 2)
  
#       # Find the user by first and last name.
#       user = User.find_by(first_name: first_name, last_name: last_name)
  
#       # If the user exists and a match doesn't exist yet, create the match.
#       if user && !Match.exists?(user_id: user.id)
#         Match.create(user_id: user.id, matched_name: scraped_name)
#       end
#     end
#   end
# end

  def self.compare_and_save_matches
    scraped_names = DeathSpider.get_names

    scraped_names.each do |scraped_name|
      name_parts = scraped_name.split
      first_name = name_parts.first
      last_name = name_parts.last

      user = User.find_by(first_name: first_name, last_name: last_name)
      if user && !Match.exists?(user_id: user.id)
        Match.create(user_id: user.id, first_name: first_name, last_name: last_name)
      end
    end
  end
end

# scraped_names = DeathSpider.get_names

# scraped_names.each do |scraped_name|
#   user = User.find_by(name: scraped_name) # Assuming name is the column in the User table
#   if user
#     # Check if the match already exists to avoid duplicate entries
#     unless Match.exists?(user_id: user.id)
#       Match.create(user_id: user.id, matched_name: scraped_name)
#     end
#   end
# end

    # puts "Found #{response.xpath("//div[@id='obituariesResults']/div[contains(@class, 'obit-result-container')]").length} person cards."


    # response.xpath("//*[@id="obituariesResults"]/div[1]/div/div[2]/a/h3").each do |obit_container|
    #   item = {}

        # puts obit_container

        # puts "obit_container.at_xpath(".//h3[@class='screen-title-title']").text.strip"



    #     description_element = obit_container.at_xpath(".//div[contains(@class, 'obit-result-text')]/p")
    #     if description_element
    #     item[:description] = description_element.text.strip
    #     else
    #     # Name extraction for error logging
    #     name_element = obit_container.at_xpath(".//h3[@class='screen-title-title']")
    #     name = name_element ? name_element.text.strip : "Unknown Name"
    #     puts "Failed to extract description for obituary with name: #{name}"
    #     # Optionally print the content for debugging
    #     puts "Content of obit-result-text div:\n#{obit_container.at_xpath(".//div[contains(@class, 'obit-result-text')]").to_s}"
    #     end