library(shiny)
library(ggplot2)
shinyServer(
	function(input,output) {
	

	output$newPlot <- renderPlot({
		
		input$simulate
		isolate({
		set.seed(23051983)
		if(input$select == 1) {
		means <- apply(matrix(rexp(input$number.samples * input$nosim, input$lambda),
		input$nosim), 1, mean)
		
		theoretical.mean <- 1/input$lambda
		plot.sd <- 1/input$lambda
		
		} else if(input$select == 2) {
		
		means <- apply(matrix(rnorm(input$number.samples * input$nosim, input$norm.mean, input$norm.sd),input$nosim), 1, mean)
		
		theoretical.mean <- input$norm.mean
		plot.sd <- input$norm.sd
		
		} else {

		means <- apply(matrix(rpois(input$number.samples * input$nosim, input$rpois.lambda),
		input$nosim), 1, mean)

		theoretical.mean <- input$rpois.lambda
		plot.sd <- sqrt(input$rpois.lambda)
			
		}
		
		mean.of.sample.means <- mean(means)
		variance.of.sample.means <- var(means)*input$number.samples
		sd.of.sample.means <- sd(means)*sqrt(input$number.samples)
		#mean.of.sample.means <- renderPrint({mean(means)})

		min.xlim <- as.integer(min(means))
		max.xlim <- as.integer(max(means))
		
		Theoretical<-c(theoretical.mean,plot.sd,plot.sd^2)
		Sampling<-c(mean.of.sample.means,sd.of.sample.means,variance.of.sample.means)
		res_df <- data.frame(Theoretical,Sampling,row.names=c("Mean","Std. Dev","Variance"))
		output$res = renderTable({res_df},digits=4)
		
		cols <- c("Simulated"="#87CEEB","Normal"="#000000")

		ggplot(data = data.frame(means), aes(x = means)) +
		geom_histogram(aes(y = ..density.., colour = "Simulated"),fill = "white",binwidth=0.1) +
		geom_density(colour = "lightblue",size = 1) +
		geom_vline(xintercept = mean.of.sample.means, color = "lightblue",size = 1.5) +
		stat_function(aes(colour ="Normal"),fun = dnorm, size = 1, args = list(mean = theoretical.mean,sd =   (plot.sd/sqrt(input$number.samples)))) +
		scale_colour_manual("",values = cols) +
		geom_vline(xintercept = theoretical.mean,color = "black", size = 1) +
		theme_bw()
		})
		}
	)
	
	}
	)