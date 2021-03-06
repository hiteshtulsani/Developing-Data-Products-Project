---
title       : Simulating Sampling Distributions
subtitle    : Developing Data Products Course Project
author      : Hitesh Tulsani
job         : Lead Consultant, Advanced Analytics
framework   : io2012   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

--- {bg: "white"}

# About Sampling Distributions

<p style="text-align:justify; font-size:13px; margin:0px 0 20px 0"> For any population, with mean $\mu$ and variance $\sigma^2$, if we repeatedly take samples of given size and calculate arithmetic mean $\bar x$ for each sample, this static is called sample mean. Each sample will have it's own average value and the distribution of these averages is called sampling distribution. This distribution is close to normal $\mathscr{N} (\mu,\frac{\sigma^2}{n})$, where $n$ is the sample size; even when the population distribution is not normal. Source: <a href="http://en.wikipedia.org/wiki/Sampling_distribution">Wikipedia</a></p>

# About this Application

<p style="text-align:justify; font-size:13px; margin:10px 0 20px 0"> This application simulates sampling distributions from 3 choices - Exponential, Normal and Poisson, based on the user input and compares the simulation output with a Normal distribution. The parameters like $\mu, \sigma, \lambda, n$ and <strong>no. of repetitions</strong> are customizable within reasonable limits. The user is presented with UI shown in Image Grab. Top-left of the app page has static description, top-right contains the output plot of simulation which changes upon clicking the <strong>Simulate!</strong> button. The user selects the distribution to simulate from and enters various parameters. Bottom-right of the app displays a table comparing Theoritical and Simulation values. Inspiration for this app comes from <strong>Statistical Inference class Project</strong>.
<img style="margin: 20px 0px 0px 0px" class=center  src=./assets/img/ui.png height=350></img>
</p>


--- {bg: "white"}


# Application Flow and Logic

<p style="text-align:justify; font-size:13px; margin:10px 0 20px 0"> The user is presented with 3 choices and starts by selecting the Distribution to simulate using <code>selectInput</code> widget. This input is then used in <code>conditionalPanel</code> controls to display the slider controls for entering $\lambda$ for Exponential and Poisson Distributions and $\mu$ and $\sigma$ for Normal Distribution. <strong>Number of simulations</strong> and <strong>Sample Size</strong> are selected using <code>sliderInput</code> and <code>numericInput</code> widgets. The simulation is performed on clicking Simulate button and the numeric results are displayed in a table alongside. 

<img style="margin: 20px 20px 20px 20px" class=center src=./assets/img/inputs.png height=150></img> 

The rendered plot is displayed at the top-right side of the screen. It compares the simulated <span style="color: #87CEEB">sampling distribution</span> with that of <strong>normal distribution </strong> 

<img class=center src=./assets/img/plot.png height=250></img>

</p>



--- {bg: "white"}
# server.R Code for Poisson Distribution

<p style="text-align:justify; font-size:13px; margin:10px 0 20px 0"> 
The code for Poisson Distribution with mean $\lambda = 5, nosim = 1000$ and $n = 50$ is given below. The output plot is shown on the next slide.</p>


```r
#This code represents only a portion of server.R code and is wrapped in renderPlot function
set.seed(23051983)
rpois.lambda <- 5 # from Slider Input
number.samples<-50 # from Numeric Input
nosim<-1000 #from Slider Input
input<-data.frame(number.samples,nosim,rpois.lambda) #created to keep the code intact

means <- apply(matrix(rpois(input$number.samples * input$nosim, input$rpois.lambda),
input$nosim), 1, mean) #Sampling of means

theoretical.mean <- input$rpois.lambda #this changes for selected distribution
plot.sd <- sqrt(input$rpois.lambda) #this changes for selected distribution

mean.of.sample.means <- mean(means)
variance.of.sample.means <- var(means)*input$number.samples
sd.of.sample.means <- sd(means)*sqrt(input$number.samples)

cols <- c("Simulated"="#87CEEB","Normal"="#000000") #for Legend generation

ggplot(data = data.frame(means), aes(x = means)) +
geom_histogram(aes(y = ..density.., colour = "Simulated"),fill = "white",binwidth=0.1) +
geom_density(colour = "lightblue",size = 1) +
geom_vline(xintercept = mean.of.sample.means, color = "lightblue",size = 1.5) +
stat_function(aes(colour ="Normal"),fun = dnorm, size = 1, args = list(mean = theoretical.mean,sd =   (plot.sd/sqrt(input$number.samples)))) +
scale_colour_manual("",values = cols) +
geom_vline(xintercept = theoretical.mean,color = "black", size = 1) +
theme_bw()
```


--- {bg: "white"}
# Output Plot

<img src="assets/fig/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />

# Application

[Simulating Sampling Distributions](http://hiteshtulsani.shinyapps.io/Simulating-Sampling-Distributions)

# Thank You!

