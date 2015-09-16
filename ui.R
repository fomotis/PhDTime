library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Completion Time to PhD Degree Prediction"),
        sidebarPanel(
            h3('Key Metrics'),
            numericInput("age","Age(Years)",25,min=0,max=90,step=1),
            radioButtons("marital","Marital Status",
                         c("Married" = "Married",
                           "Single" = "Single"
                         )),
            radioButtons("gender","Gender",
                         c("Female" = "Female",
                           "Male"="Male"
                         )),
            code('FBMS = Faculty of Basic Medical Sciences'),
            radioButtons("faculty","Faculty",
                         c("Agric and Forestry" = "Agric and Forestry",
                           "Arts"="Arts",
                           "FBMS"="FBMS",
                           "Institute of Education"="Institute of Education",
                           "Pharmacy"="Pharmacy",
                           "Public Health"="Public Health",
                           "Science"="Science",
                           "Social Sciences"="Social Sciences",
                           "Technology"="Technology",
                           "Vetrinary Medicine"="Vetrinary Medicine"
                         )),
            radioButtons("supervisor","Supervisor Level",
                         c("Lecturer1" = "Lecturer",
                           "Professor"="Professor",
                           "Reader/Associate Professor"="Reader",
                           "Senior Lecturer"="Senior Lecturer"
                         )),
            radioButtons("employed","Employment Status",c("No"="No","Yes"="Yes")),
            radioButtons("mode","Mode of Employment",
                         c("Full Employment" = "Full employment",
                           "Part Time"="Part time",
                           "Self Employment"="Self employment"
                         )),
            radioButtons("kind","Nature of Work",c("Academic/Research"="Academic/Research","Non academic/Administration"="Non academic/Administration")),
            radioButtons("mphil","MPhil/PhD Conversion",c("No"="No","Yes"="Yes")),
            actionButton("predict","Predict")
            
        ),
        mainPanel(
            h3('PhD Time Prediction'),
            h4('Introduction'),
            p('Dear User, welcome! As a means of introduction, this app will predict your likely
              time to complete a PhD degree based on your inputed key metrics. To use the app is
              quite simple, provide the neccesarry key metrics by inputing using the sidebar panel
              and click the predict button.'),
            h4('Expected Results'),
            p('Using a Machine Learning Algorithm (boosting) built using the dataset
              used in Olubusoye and Olusoji (Determinants of PhD Completion at the University of Ibadan,
              2014), the number of years it will likely take you to complete a PhD programme is predicted,
              a boxplot of durations of respondents used in the study is displayed as well with a line showing your own 
              predicted value. This will enable you know if you are above or below the median completion time'),
            h4('Note'),
            p("Results obtained might not be applicable because the data used for this study is limited. Also, only 
              a few of the key-metrics used in the cited study were considered."),
            h4('Results'),
            h4('Your Inputed Metrics'),
            h4('Age'),
            verbatimTextOutput('oage'),
            h4('Marital Status'),
            verbatimTextOutput('omarital'),
            h4('Gender'),
            verbatimTextOutput("ogender"),
            h4('Faculty'),
            verbatimTextOutput('ofaculty'),
            h4('Supervisor'),
            verbatimTextOutput('osupervisor'),
            h4('Employment Status'),
            verbatimTextOutput('oemployed'),
            h4('Mode of Employment'),
            verbatimTextOutput('omode'),
            h4('Nature of WOrk'),
            verbatimTextOutput('okind'),
            h4('Mphil/PhD Conversion'),
            verbatimTextOutput('omphil'),
            h4('Predicted PhD Completion Time'),
            verbatimTextOutput('opredict'),
            plotOutput('newBox'),
            code('Note that the thick red line is your predicted completion time based on your inputed metrics.'),
            h4('References'),
            h5('Olubusoye O. E., Olusoji O. D. (2014). Determinants of PhD Completion Time at the University of Ibadan. African Journal of Sustainable Development. vol 4, No. 2'),
            h6('copyright: Olusoji Oluwafemi Daniel, Department of Statistics, University of Ibadan, Oyo State, Nigeria.')    
            )
            )
    )