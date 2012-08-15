require 'httparty'
Given /^Genesis is running on host '(\w+)' and port '(\d+)'$/ do |arg1, arg2|
  url = "http://#{arg1}:#{arg2}/" 
  response = HTTParty.get(url)
  @base = url
end

Given /^I am valid admin user with name '(\w+)' and password '(\w+)'$/ do |arg1, arg2|
  @auth = {:username => arg1, :password => arg2}
  response = HTTParty.get(@base + "/rest/whoami", :basic_auth => @auth)
  struct = JSON.parse(response.body)
  struct["administrator"].should == true
end

When /^I create a project with the name '(.+)' managed by '(\w+)'$/ do |arg1, arg2|
  project = {:name => arg1, :projectManager => arg2}
  @last_response = HTTParty.post(@base + "/rest/projects", :basic_auth => @auth, :body => project.to_json,
                                 :headers => {'Content-Type' => 'application/json'})
end

Then /^I should get response with code '(\d+)'$/ do |arg1|
  @last_response.code.should == arg1.to_i
end

Then /^Project '(.+)' must exist$/ do |arg1|
  get_project(arg1).should_not be_nil
end

Then /^Project '(.+)' should not exist$/ do |arg1|
  get_project(arg1).should be_nil
end

Then /^I can delete project '(.+)'$/ do |arg1|
  id = get_project(arg1)
  response = HTTParty.delete(@base + "/rest/projects/#{id}", :basic_auth => @auth)
  response.code.should == 200
end

def get_project(name)
  response = HTTParty.get(@base + "/rest/projects", :basic_auth => @auth)
  resp = JSON.parse(response.body)
  found = resp.select { |r| r["name"] == name }
  if found.size > 0
    found[0]["id"]
  else
    nil
  end
end
