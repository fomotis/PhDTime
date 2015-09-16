library(shiny)
library(caret)
modData <- read.csv("dataA.csv",header=T)
modData <- modData[,c(1,2,3,5,12,17,19,20,22,36)]
names(modData) <- c("gender","maritalstatus","age","faculty",
                    "supervisor","employmentstatus","nature","kind",
                    "mphil","duration")
medtime <- median(modData$duration)
mod1 <- train(duration~.,data=modData,method="gbm",
              trControl=trainControl(method="boot",number=2),verbose=F)
shinyServer(
    function(input,output){
        output$opredict <- renderText({
            if(input$predict==0){ "Please input Your Key Metrics and press the Predict Button"}
            else {
                round(predict(mod1,newdata=data.frame(gender=input$gender,maritalstatus=input$marital,
                                                      age=input$age,faculty=input$faculty,
                                                      supervisor=input$supervisor,
                                                      employmentstatus=input$employed,
                                                      nature=input$mode,
                                                      kind=input$kind,mphil=input$mphil)),0)
            }
        })
        output$newBox <- renderPlot({ 
            if(input$predict>0){
                predYears <- round(predict(mod1,newdata=data.frame(gender=input$gender,maritalstatus=input$marital,
                                                                   age=input$age,faculty=input$faculty,
                                                                   supervisor=input$supervisor,
                                                                   employmentstatus=input$employed,
                                                                   nature=input$mode,
                                                                   kind=input$kind,mphil=input$mphil)),0)
                par(mfrow=c(2,2))
                boxplot(modData$duration,col="lightblue",ylab="Duration(Years)",
                        main="How You Fare Generally")
                abline(h=predYears,col='red',lwd=4)
                boxplot(duration~gender,col=c("lightgreen","lightblue"),data=modData,ylab="Duration(Years)",xlab="Gender",
                        main="How You Fare GenderWise")
                abline(h=predYears,col='red',lwd=4)
                boxplot(duration~supervisor,data=modData,col=heat.colors(4),ylab="Duration(Years)",xlab="Supervisor",
                        main="How You Fare SupervisorWise")
                abline(h=predYears,col='red',lwd=4)
                boxplot(duration~employmentstatus,data=modData,col=c("cyan","grey"),ylab="Duration(Years)",xlab="Employed/Not Employed",
                        main="How You Fare In terms of Employment")
                abline(h=predYears,col='red',lwd=4)
            }
        }, width=800,height=400)
        output$oage <- renderText({input$age})
        output$omarital <- renderText({input$marital})
        output$ogender <- renderText({input$gender})
        output$ofaculty <- renderText({input$faculty})
        output$osupervisor <- renderText({input$supervisor})
        output$oemployed <- renderText({input$employed})
        output$omode <- renderText({input$mode})
        output$okind <- renderText({input$kind})
        output$omphil <- renderText({input$mphil})
    }   
)