require 'draw/guest.rb'

Given /^I have the following guests:$/ do |guests|
  store = PStore.new %(#{ENV['HOME']}/draw.pstore)
  store.transaction do
    new_guests = []
    guests.lines.each do |line|
      values = line.gsub("\n", "").split(",")
      guest = Guest.new(values[0], values[1])
      new_guests << guest
    end
    store[:guests] = new_guests
  end
end

When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

