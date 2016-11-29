module Sniffer::Config
  delegate str, str?, strs, int, ints, int?, bool, to: @config

  def device
    str("pcap/device")
  end
  
  def snaplen
    int("pcap/snaplen")
  end
  
  def timeout_ms
    int("pcap/timeout_ms")
  end
  
  def filter
    str?("pcap/filter") || ints("pcap/ports").map{|p| "(tcp port #{p})"}.join(" or ")
  end
  
  def input_type
    str("input/type")
  end
  
  def input_interval
    int("input/interval")
  end
  
  def output_format
    str("output/format")
  end
end
