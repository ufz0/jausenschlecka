package main

import(
	"github.com/gin-gonic/gin"
)

func main(){
	gin.SetMode(gin.ReleaseMode)
	r := gin.Default()

	r.GET("/", func(c *gin.Context){
		c.String(200, "Hello World");
	})

	r.Run(":8091")
}