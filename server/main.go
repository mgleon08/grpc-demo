package main

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"

	"grpc-demo/pb"
)

const (
	port = ":50051"
)

// server 建構體會實作 Calculator 的 gRPC 伺服器。
type server struct{
	pb.UnimplementedCalculatorServer
}

// Plus 會將傳入的數字加總。
func (s *server) Plus(ctx context.Context, in *pb.CalcRequest) (*pb.CalcReply, error) {
	// 計算傳入的數字。
	result := in.NumberA + in.NumberB
	// 包裝成 Protobuf 建構體並回傳。
	return &pb.CalcReply{Result: result}, nil
}

func main() {
	// 監聽指定埠口，這樣服務才能在該埠口執行。
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("無法監聽該 port: %v", err)
	}

	// 建立新 gRPC 伺服器並註冊 Calculator 服務。
	s := grpc.NewServer()
	// RegisterCalculatorServer 是透過 .proto 定義轉換而成
	pb.RegisterCalculatorServer(s, &server{})

	// 開始在指定埠口中服務。
	if err := s.Serve(lis); err != nil {
		log.Fatalf("無法提供服務: %v", err)
	}
}
