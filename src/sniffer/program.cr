class Sniffer::Program
  include Config
  
  def initialize(@config : TOML::Config)
  end
  
  def run
    cap = Pcap::Capture.open_live(device, snaplen: snaplen, timeout_ms: timeout_ms)
    # at_exit { cap.close }
    cap.setfilter(filter)
    STDERR.puts "listening on #{device}, capture size #{snaplen} bytes, filter with '#{filter}'"
    case input_type
    when "tcp_redis_size"
      run_tcp_redis_size(cap)
    else
      raise "config error: unknown input type: #{input_type}"
    end
  end

  private def run_tcp_redis_size(cap)
    interval = input_interval.second
    format   = output_format
    callback = ->(req : Input::TcpRedisSize::Request) {
      time = req.time.to_s("%Y-%m-%d %H:%M:%S")
      buf  = format.gsub(/\{(.*?)\}/) {
        case key = $1
        when "time" then time
        when "key"  then req.key
        when "size" then req.size
        when "src"  then req.src
        else ; "{#{key}}"
        end
      }
      STDOUT.puts buf
    }
    input = Input::TcpRedisSize.new(input_commands, interval, callback)
    cap.loop do |pkt|
      if pkt.tcp_data?
        input.process(pkt)
      end
    end
  end
end
