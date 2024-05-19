package main

import (
	"context"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/awslabs/aws-lambda-go-api-proxy/core"
	"github.com/awslabs/aws-lambda-go-api-proxy/gorillamux"
	"github.com/gorilla/mux"
	"github.com/whiskeytown79/cliphub/internal/handlers"
)

func SetupRoutes(ctx context.Context) *mux.Router {
	router := mux.NewRouter()

	router.Use()
	router.HandleFunc("/api/clips", handlers.GetClips).Methods("GET")
	router.HandleFunc("/api/clips/{id}", handlers.GetClipByID).Methods("GET")
	router.HandleFunc("/api/clips", handlers.CreateClip).Methods("POST")
	router.HandleFunc("/api/clips/{id}", handlers.UpdateClip).Methods("PUT")
	router.HandleFunc("/api/clips/{id}", handlers.DeleteClip).Methods("DELETE")

	return router
}

func main() {
	ctx := context.TODO()
	router := SetupRoutes(ctx)
	adapter := gorillamux.New(router)
	handler := getHandler(adapter)
	lambda.Start(handler)
}

func getHandler(adapter *gorillamux.GorillaMuxAdapter) func(context.Context, events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return func(ctx context.Context, req events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
		r, err := adapter.ProxyWithContext(ctx, *core.NewSwitchableAPIGatewayRequestV1(&req))
		return *r.Version1(), err
	}
}
