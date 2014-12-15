library(shiny)

shinyUI(fluidPage(
	tags$head(
		tags$link(rel = 'stylesheet', type = 'text/css', href = 'stylesheet.css')
	),
	title="Simulation of Sampling Distributions",
	fluidRow(
		column(12,
			h3("Simulation of Sampling Distributions",align="center")
		)
	),
	fluidRow(
		column(4,
			h5("What is Sampling Distribution?"),
			p(style="text-align:justify; font-size:13px; margin:0px 0","For any population, with mean \\(\\mu\\) and variance \\(\\sigma^2 \\), if we repeatedly take samples of given size and calculate
			arithmetic mean \\(\\bar x\\) for each sample, this static is called sample mean. Each sample will have it's own average value and the distribution of these averages is called sampling distribution. This distribution is close to normal \\(\\mathscr{N} (\\mu,\\frac{\\sigma^2}{n})\\), where n is the sample size; even when the population distribution is not normal.", em("Source: "),
			a(href="http://en.wikipedia.org/wiki/Sampling_distribution","Wikipedia")),
			hr(style="margin: 0px 0; padding: 0px 0"),
			p(style="text-align:justify; font-size:13px; margin: 10px 0 0 0","This application simulates sampling distributions from 3 choices - Exponential, Normal and Poisson, based on the user input and compares the simulation output with Standard Normal distribution. The parameters like \\(\\mu, \\sigma, \\lambda, \\)  n and no. of repetitions are customizable within reasonable limits.")
		),
		column(8,
			h5("Simulation Plot",align="center"),
			plotOutput('newPlot',height="250px")
		)
	),
	hr(style="margin: 1px 0; border-bottom: dashed 1px #ccc"),
	fluidRow(
		column(3,
		selectInput("select", label = h6("Select the Distribution to simulate"), 
        
		choices = list("Exponential (rexp)" = 1, "Normal (rnorm)" = 2,
                       "Poisson (rpois)" = 3), selected = 1),
		
		
		h6("Select parameters for the distribution:"),

		conditionalPanel(condition = "input.select == 1",
		sliderInput('lambda','Rate of the Distribution, \\(\\lambda\\):',value=0.2,min=0.1,max=1,step=0.1)),
		
		conditionalPanel(condition = "input.select == 2",
		sliderInput('norm.mean','Mean, \\(\\mu\\):',value=1,min=1,max=10,step=1),
		sliderInput('norm.sd','Standard Deviation, \\(\\sigma\\):',value=1,min=1,max=2,step=0.1)
		),
		
		conditionalPanel(condition = "input.select == 3",
		sliderInput('rpois.lambda','Mean of the Distribution, \\(\\lambda\\):',value=1,min=1,max=10,step=1))),
		
		column(3,
		sliderInput('nosim',label=h6('Number of Simulations to perform'),value=1000,min=100,max=3000,step=100),
		numericInput('number.samples',label=h6('Sample size:'),value=50,min=10,max=100,step=10),
		br(),
		br(),
		actionButton('simulate',strong('Simulate!'))
		),
		
		column(3,
			h6("Results Comparison:"),
			tableOutput('res')
		),
		
		column(3,
		withMathJax(),
		h5(" "),
		h6("About Density:"), 
		conditionalPanel(class='aboutdensity',condition = "input.select == 1",
		div("The exponential distribution with rate  \\(\\lambda\\) has density given by: $$f(x)=\\lambda e^{-\\lambda x}$$, where mean, \\(\\mu\\) = \\(\\frac{1}{\\lambda}\\) = \\(\\sigma\\), i.e Std. Deviation")), 
		conditionalPanel(class='aboutdensity',condition = "input.select == 2",
		div("The normal distribution has density given :by $$f(x) = \\frac{1}{\\sigma\\sqrt(2\\pi)} e^{-\\frac{(x-\\mu)^2}{2\\sigma^2}}$$ 
		where, \\(\\mu\\) = Mean, and \\(\\sigma\\) = Standard Deviation")),
		conditionalPanel(class='aboutdensity',condition = "input.select == 3",
		div("The Poisson distribution has density given by: $$p(x) = \\frac{\\lambda^x e^{-\\lambda}}{x!}$$ where, mean \\(\\mu\\) = \\(\\lambda\\) and Std. Deviation, \\(\\sigma\\) = \\(\\sqrt\\lambda\\)"))
		
		)
		
	)
)
)
