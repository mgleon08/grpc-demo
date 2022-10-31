dirname = File.dirname(__FILE__)
parent_dirname = File.dirname(dirname)
this_dir = File.expand_path(parent_dirname)

pb_dir = File.join(this_dir, 'pb')
$LOAD_PATH.unshift(pb_dir) unless $LOAD_PATH.include?(pb_dir)

require 'grpc'
require 'calc_services_pb'

def main
  stub = Pb::Calculator::Stub.new('localhost:50051', :this_channel_is_insecure)
  begin
    result = stub.plus(Pb::CalcRequest.new(number_a: 32, number_b: 32)).result
    p "Result Number: #{result}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main
