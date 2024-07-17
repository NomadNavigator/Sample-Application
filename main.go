// main.go
package main

import (
    "database/sql"
    "fmt"
    "log"
    "net/http"

    _ "github.com/mattn/go-sqlite3"
)

func main() {
    db, err := sql.Open("sqlite3", "./devops_wizard.db")
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Welcome to DevOps Wizard Web Application!")
    })

    log.Println("Server started at :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}