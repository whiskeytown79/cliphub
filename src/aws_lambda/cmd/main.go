package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
	"github.com/awslabs/aws-lambda-go-api-proxy/core"
	"github.com/awslabs/aws-lambda-go-api-proxy/gorillamux"
	"github.com/gorilla/mux"
	handlers2 "github.com/whiskeytown79/cliphub/internal/handlers"
	"os"
)

func SetupRoutes() *mux.Router {
	router := mux.NewRouter()

	router.HandleFunc("/api/clips", handlers2.GetClips).Methods("GET")
	router.HandleFunc("/api/clips/{id}", handlers2.GetClipByID).Methods("GET")
	router.HandleFunc("/api/clips", handlers2.CreateClip).Methods("POST")
	router.HandleFunc("/api/clips/{id}", handlers2.UpdateClip).Methods("PUT")
	router.HandleFunc("/api/clips/{id}", handlers2.DeleteClip).Methods("DELETE")

	return router
}

func main() {
	region := os.Getenv("AWS_REGION")
	awsSession, err := session.NewSession(&aws.Config{
		Region: aws.String(region)},
	)
	if err != nil {
		return
	}
	_ = dynamodb.New(awsSession)
	router := SetupRoutes()
	adapter := gorillamux.New(router)
	handler := getHandler(adapter)
	lambda.Start(handler)
}

func getHandler(adapter *gorillamux.GorillaMuxAdapter) func(events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return func(req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
		r, err := adapter.Proxy(*core.NewSwitchableAPIGatewayRequestV1(&req))
		return *r.Version1(), err
	}
}
