require "./spec_helper"

private def config
  TOML::Config.parse_file("config.toml")
end

describe Sniffer do
  it "works" do
    Sniffer::Program.new(config)
  end
end
