package handlers

import (
	"github.com/gorilla/mux"
	"net/http"
)

func DeleteClip(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	_ = vars["id"]
}
