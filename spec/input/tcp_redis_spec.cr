require "../spec_helper"

#private def interval
#  1.second
#end

const interval = 1.second
const commands = %w( set )
const callback = ->(msg : Sniffer::Input::TcpRedisSize::Message) {}

private def subject
  Sniffer::Input::TcpRedisSize.new(commands, interval, callback)
end

# stub subject = Sniffer::Input::TcpRedisSize.new(commands, interval, callback)

describe Sniffer::Input::TcpRedisSize do
  it "works" do
    subject.match?("*3\r\n$3\r\nSET\r\n$3\r\nfoo\r\n$5\r\nabcde").should_not eq(nil)
  end
end
