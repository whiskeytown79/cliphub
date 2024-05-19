package database

import (
	"context"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/feature/dynamodb/attributevalue"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/whiskeytown79/cliphub/internal/model"
)

const TableName = "TextStorePOC" // TODO: Get this from terraform output

var db dynamodb.Client

type InsertClipInput struct {
	Text string
}

func InsertClip(ctx context.Context, input InsertClipInput) (*model.Clip, error) {
	clip := model.Clip{
		Text: input.text,
	}

	item, err := attributevalue.MarshalMap(clip)
	if err != nil {
		return nil, err
	}

	ddbInput := &dynamodb.PutItemInput{
		TableName: aws.String(TableName),
		Item:      item,
	}

	res, err := db.PutItem(ctx, ddbInput)
	if err != nil {
		return nil, err
	}

	err = attributevalue.UnmarshalMap(res.Attributes, &clip)
	if err != nil {
		return nil, err
	}

	return &clip, nil
}
