package main

import (
	"context"
	"log"

	"google.golang.org/grpc"

	"grpc-demo/pb"
)

const (
	address = "localhost:50051"
)

func main() {
	// 建立連線到 gRPC 伺服器。
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("無法連線: %v", err)
	}
	// 結束後要關閉
	defer conn.Close()

	// 建立新的 Calculator 客戶端，所以等一下就能夠使用 Calculator 的所有方法。
	c := pb.NewCalculatorClient(conn)

	// 傳送新請求到遠端 gRPC 伺服器 Calculator 中，並呼叫 Plus 函式，讓兩個數字相加。
	r, err := c.Plus(context.Background(), &pb.CalcRequest{NumberA: 32, NumberB: 32})
	if err != nil {
		log.Fatalf("無法執行 plus: %v", err)
	}
	log.Printf("回傳結果: %d", r.Result)
}


// data, err := proto.Marshal(s)
//   if err != nil {
//     log.Fatal(err)
//   }

//   log.Println(data)