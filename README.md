# gRPC

### 安裝 compiler

```
brew install protobuf
protoc --version
```

### 安裝 Go protocol buffers 的套件

```proto
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

### go 產生 proto file

```go
// 產生 兩個檔案，一個是 (proto calc.pb.go），一個是 gRPC 用的檔案（calc_grpc.pb.go）
protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative pb/calc.proto

// --proto_path = -I
// paths=source_relative 指定輸出檔案位置和輸入位置一樣

// 先啟動 server
go run ./server/main.go

// 再啟動 client
go run ./client/main.go
```

### ruby 產生 proto file

```ruby
# 安裝 grpc 套件
gem install grpc

# 產生 .pb 檔案
protoc --proto_path pb/ --ruby_out=pb/ --ruby_opt=paths=source_relative pb/calc.proto

# // 先啟動 server
ruby ./server/main.ruby

# // 再啟動 client
ruby ./server/main.ruby
```
