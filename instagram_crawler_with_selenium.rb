require 'watir'

# Uncomment if you want to download
# require "open-uri"

# browser = Watir::Browser.new :chrome, headless: true
browser = Watir::Browser.new

browser.goto('https://www.instagram.com/marvel/')

close_login_button = browser.button(class: ["Ls00D", "coreSpriteDismissLarge", "Jx1OT"])
close_login_button.click if close_login_button.exist?
items = browser.divs(class:["v1Nh3", "kIKUG", "_bz0w"])
n = 0
scrollHeight = browser.execute_script("return document.body.scrollHeight")
new_scrollHeight = scrollHeight
arr = []

# Uncomment if you want to download
# Dir.mkdir("./download") unless Dir.exist?("./download")

begin
  items.each do |item|
    arr.include?(item.a.href) ? next : arr << item.a.href
    n += 1
    puts n
    icon = item.div(class: ["u7YqG"])
    if !icon.exist?
      # Photo
      item.click
      sleep(2)
      dom = browser.div(class: ["_97aPb"]).div(class: ["KL4Bh"])
      puts dom.img.src

      # Uncomment if you want to download
      # File.open("./download/#{n}.jpg", 'wb') do |f|
      #   f.write open(dom.img.src).read
      # end
    else
      if item.div(class: ["Byj2F"]).exist?
        # Video
        item.click
        sleep(2)
        puts browser.video(class: "tWeCl").src

        # Uncomment if you want to download
        # File.open("./download/#{n}.mp4", 'wb') do |f|
        #   f.write open(browser.video(class: "tWeCl").src).read
        # end
      elsif item.div(class: ["qFq_l"]).exist?
        # Post
        item.click
        sleep(2)
        lis = browser.div(class: ["_2dDPU", "vCf6V"]).lis(class: ["_-1_m6"])
        lis.each.with_index(1) do |post, index|
          puts post.img.src

          # Uncomment if you want to download
          # File.open("./download/#{n}.jpg", 'wb') do |f|
          #   f.write open(post.img.src).read
          # end
          browser.button(class: ["  _6CZji"]).click if index < lis.size
        end
      end
    end
    modal = browser.button(class: "ckWGn")
    modal.click if modal.exist?
  end

  scrollHeight = new_scrollHeight
  browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
  sleep(5)
  new_scrollHeight = browser.execute_script("return document.body.scrollHeight")
  items = browser.divs(class:["v1Nh3", "kIKUG", "_bz0w"])
end while (new_scrollHeight - scrollHeight) != 0

browser.close
