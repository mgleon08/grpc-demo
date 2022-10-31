dirname = File.dirname(__FILE__)
parent_dirname = File.dirname(dirname)
this_dir = File.expand_path(parent_dirname)

pb_dir = File.join(this_dir, 'pb')
$LOAD_PATH.unshift(pb_dir) unless $LOAD_PATH.include?(pb_dir)

require 'grpc'
require 'calc_services_pb'

# Server is simple server that implements the Calc Greeter server.
class Server < Pb::Calculator::Service
  # plus implements the Calculator rpc method.
  def plus(calc_req, _unused_call)
    result = calc_req.number_a + calc_req.number_b
    puts "Plus #{calc_req.number_a} and #{calc_req.number_b}"

    Pb::CalcReply.new(result: result)
  end
end

# main starts an RpcServer that receives requests to Server at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(Server)
  # Runs the server with SIGHUP, SIGINT and SIGTERM signal handlers to
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGTERM'])
end

main
