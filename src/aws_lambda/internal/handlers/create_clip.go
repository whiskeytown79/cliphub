package handlers

import (
	"encoding/json"
	"github.com/whiskeytown79/cliphub/internal/database"
	"net/http"
)

type CreateClipInput struct {
	ContentType string `json:"content_type"`
	Body        string `json:"body"`
}

func CreateClip(w http.ResponseWriter, r *http.Request) {
	var createClip CreateClipInput
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&createClip)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	ctx := r.Context()

	input := database.InsertClipInput{
		Text: createClip.Body,
	}
	clip, err := database.InsertClip(ctx, input)
	if err != nil {
		// TODO: Write more interesting response body with error details
		w.WriteHeader(http.StatusInternalServerError)
	} else if clip == nil {
		// TODO: Write more interesting response body with error details
		w.WriteHeader(http.StatusInternalServerError)
	} else {
		// TODO: Write a more structured API response
		// TODO: Hande write error
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte(clip.Text))
	}
}
