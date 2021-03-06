# ==============================================================================
# Loading necessary packages and options
# ==============================================================================
library(remotes)
remotes::install_github("ocbe-uio/cellmigRation")
library(cellmigRation)
options(shiny.maxRequestSize = 1024*1024^2)  # file limit: 1 GB

# ==============================================================================
# Defining the server logic
# ==============================================================================
server <- function(input, output, session) {
	# --------------------------------------------------------------------------
	# Reactive values
	# --------------------------------------------------------------------------
	frame <- reactiveValues(out = 1)
	# --------------------------------------------------------------------------
	# Load imported data
	# --------------------------------------------------------------------------
	image <- reactive({
		req(input$imported_tiff)
		filename <- normalizePath(file.path(input$imported_tiff$datapath))
		filepath <- gsub(
			x = input$imported_tiff$datapath,
			pattern = ".\\.tif$",
			replacement = ""
		)
		split_tiff <- readTIFF(filename, all = TRUE, convert = TRUE)
		split_png <- list()
		for (i in seq_along(split_tiff)) {
			writePNG(
				image = split_tiff[[i]],
				target = paste0(
					filepath, formatC(i, flag = "0", width = 5), '.png'
				)
			)
		}
		file_list <- list.files(filepath, pattern = "*.png")
		return(list(path = filepath, name = file_list))
	})
	# --------------------------------------------------------------------------
	# Creating image controls
	# --------------------------------------------------------------------------
	tot_frames <- reactive(length(image()$name))
	output$tot_frames <- renderText(tot_frames())
	output$slider <- renderUI(
		sliderInput(
			inputId = "frameSelector", label = "Frame select:",
			min = 1, max = tot_frames(), value = frame$out, step = 1,
			animate = animationOptions(
				interval = 200,
				playButton = "Autoplay",
				pauseButton = "Pause"
			),
		)
	)
	output$prev <- renderUI({
		if (is.null(tot_frames())) return()
		actionButton("prev", "Previous frame")
	})
	output$nxt <- renderUI({
		if (is.null(tot_frames())) return()
		actionButton("nxt", "Next frame")
	})
	# --------------------------------------------------------------------------
	# Determining slide to show
	# --------------------------------------------------------------------------
	observeEvent(input$prev, {
		frame$out <- max(input$frameSelector - 1, 1)
	})
	observeEvent(input$nxt, {
		frame$out <- min(input$frameSelector + 1, tot_frames())
	})
	src_output <- reactive({
		filename <- image()$name[input$frameSelector]
		out <- paste0(image()$path, filename)
		return(out)
	})
	# --------------------------------------------------------------------------
	# Render imported data
	# --------------------------------------------------------------------------
	output$image_frame <- renderImage(
		expr = {
			req(input$imported_tiff)
			list(
				src = src_output(),
				alt = "image not found",
				height = 500
			)
		},
		deleteFile = FALSE
	)
	# --------------------------------------------------------------------------
	# Displaying data
	# --------------------------------------------------------------------------
	output$processed_image <- renderPlot({
		req(input$imported_tiff)
		x1 <- cellmigRation::LoadTiff(
			tiff_file  = input$imported_tiff$datapath,
			experiment = input$project_name,
			condition  = input$project_condition,
			replicate  = input$replicate
		)
		# FIXME: doesn't reselect if frame is changed on the slider (only buttons work)
		# X1 <- readRDS(...) # ASK: what is this about?
		# Store in variables for now
		time_var <- input$frame_duration
		res_var <- input$pixel_size
		invert_background <- input$invert_background
		VisualizeImg(x1@images$images[[frame$out]], las = 1, main = paste("Stack num.", frame$out))
	})
	# --------------------------------------------------------------------------
	# Fitting model
	# --------------------------------------------------------------------------
	observeEvent(input$fit_model, {
		updateTabsetPanel(
			session,
			inputId = "post_load",
			selected = "Model estimation"
		) # FIXME: tab selection works sporadically?
		# Automated parameter optimization
		x1 <- LoadTiff(
			tiff_file  =  input$imported_tiff$datapath,
			experiment = input$project_name,
			condition  = input$project_condition,
			replicate  = input$replicate
		) # TODO: DRY: move this and L:291 to one reactive function
		x1 <- OptimizeParams(tc_obj = x1, threads = input$num_threads)
		output$VisualizeImg <- renderPlot({
			if (length(x1@optimized) > 0) {
				lnoise    <- x1@optimized$auto_params$lnoise
				diameter  <- x1@optimized$auto_params$diameter
				threshold <- x1@optimized$auto_params$threshold
				b <- cellmigRation:::bpass(
					image_array = x1@images$images[[frame$out]],
					lnoise = lnoise,
					lobject = diameter,
					threshold = threshold
				)
				pk <- cellmigRation:::pkfnd(
					im = b,
					th = threshold,
					sz = cellmigRation:::NextOdd(diameter)
				)
				cnt <- cellmigRation:::cntrd(
					im = b,
					mx = pk,
					sz = cellmigRation:::NextOdd(diameter)
				)
				# Visualize Centroids
				VisualizeImg(
					img_mtx = b,
					las = 1,
					main = paste0("Stack num. ", frame$out)
				)
				cellmigRation:::VisualizeCntr(
					centroids = cnt, width_px = ncol(b), height_px = nrow(b)
				)
			}
		})
	})
	# --------------------------------------------------------------------------
	# Tracking cells
	# --------------------------------------------------------------------------
	eventReactive(input$track_cells, {
		# TODO: track cells using cellmigRation functions
	})
}
