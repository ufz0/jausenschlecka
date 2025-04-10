package main

import (
	"fmt"

	"github.com/gin-gonic/gin"
)

func main(){
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	r.GET("/", func(c *gin.Context){
		c.File("public/index.html")
	})

	r.GET("/favicon.ico", func(c *gin.Context){
		c.String(200, "Comming soon!")
	})
	fmt.Println("Server listening on http://127.0.0.1:8091")
	r.Run(":8091")
}