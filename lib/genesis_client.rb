require 'httparty'

class GenesisClient
  include HTTParty
  attr_accessor :auth

  def initialize(host, port)
    @host = host
    @port = port
  end


  def ping
    self.class.get(genesis_path + "/")
  end

  def whoami
    get("/whoami")
  end

  def project_id(name)
    response = get('/projects')
    resp = JSON.parse(response.body)
    found = resp.select { |r| r["name"] == name }
    if found.size > 0
      found[0]["id"]
    else
      nil
    end
  end

  def create_project(name, manager, description = nil)
    project = {:name => name, :projectManager => manager, :description => description}
    post('/projects', :body=>project.to_json)
  end

  def delete_project(id)
    self.class.delete(path("/projects/#{id}"), :basic_auth => auth)
  end

  private
    def genesis_path
      "http://#{@host}:#{@port}"
    end
    
    def get(p, options = {})
      options.merge!({:basic_auth => auth}) unless auth.nil?
      self.class.get(path(p), options)
    end

    def post(p, options = {})
      options.merge!({:basic_auth => auth, :headers => {'Content-Type' => 'application/json'}}) unless auth.nil?
      self.class.post(path(p), options)
    end

    def put(p, options = {})
      options.merge!({:basic_auth => auth, :headers => {'Content-Type' => 'application/json'}}) unless auth.nil?
      self.class.put(path(p), options)
    end

    def delete(p, options = {})
      options.merge!({:basic_auth => auth}) if auth
      self.class.delete(path(p), options)
    end

    def path(p)
      genesis_path + '/rest/' + p
    end
end
