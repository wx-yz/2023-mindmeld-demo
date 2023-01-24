package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", courseHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func courseHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello from %s\n", "courses")
}
