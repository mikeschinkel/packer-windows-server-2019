require 'json'

class Local
  attr_accessor :host_username
  attr_accessor :host_password
  attr_accessor :headless
  attr_accessor :memory
  attr_accessor :cpus
  def initialize()
    @filepath = File.expand_path "box-local.json"
    @local = File.exists?(@filepath) ? JSON.parse(File.read(@filepath)) : {}
    @host_username = @local.fetch('host_username',"USERNAME NOT SPECIFIED")
    @host_password = @local.fetch('host_password',"PASSWORD NOT SPECIFIED")
    @headless      = @local.fetch('headless',false)
    @memory        = @local.fetch('memory',"3096")
    @cpus          = @local.fetch('cpus',"2")
    File.write(@filepath,JSON.pretty_generate(@local))
    @local
  end
end
