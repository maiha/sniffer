require "../sniffer"
require "opts"
require "shard"

class Main
  include Opts

  VERSION = Shard.version
  PROGRAM = Shard.program
  ARGS    = "config.toml"

  option verbose : Bool   , "-v", "Verbose output", false
  option version : Bool   , "--version", "Print the version and exit", false
  option help    : Bool   , "--help"   , "Output this help and exit" , false

  def run
    config = TOML::Config.parse_file(args.shift { die "config not found!" })
    merge_options!(config)
    Sniffer::Program.new(config).run
  end

  private def merge_options!(config)
    config["verbose"] = verbose
  end
end

Main.run
