# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: calc.proto for package 'pb'
# Original file comments:
# 撰寫格式是 Proto v3。

require 'grpc'
require 'calc_pb'

module Pb
  module Calculator
    # Calculator 定義了一個計算用的服務。
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'pb.Calculator'

      # Plus 會接收 CalcRequest 資料作加總，最終會回傳 CalcReply。
      rpc :Plus, ::Pb::CalcRequest, ::Pb::CalcReply
    end

    Stub = Service.rpc_stub_class
  end
end
