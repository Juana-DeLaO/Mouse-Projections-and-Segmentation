
List of Functions:
	read4DTiff.m
		"""
		Reads a 4D Image.
		"""
		Args:
			stackname (string): A string representing the image path.
			
		Output:
			An (chanNum, numSlices) cell array. Each entry is an image.
			
	read3DTiff.m
		"""
		Reads a 4D Image.
		"""
		Args:
			stackname (string): A string representing the image path.
			
		Output:
			An 1D cell array. Each entry is an image.
			
	projection.m
		"""
		Make a projection of a pixel.
		"""
		Args:
			allZvalues: 	A vector that describes the Z vector of point (ii, jj)
			start: 			The starting pixel for surface layer
			width: 			How deep to measure intensity

		Outputs: 
			imPixel: 		Intensity of pixel
			imPixelHeight:  Height of pixel returned
			
	NeuralTube_Projection_Helper.mlx
		"""
		Given an image and mask creates and write the projection into the given repositories. In addition,
		create a height map of the projections. Two projections are made; one from layer 1-5 and another at layer 15.
		"""
		Args:
			originalImage: 	Output of read4DTiff. Image to project.
			mask:			Output of read3DTiff. Mask of image.
			chanName:		List of possible channels to segment.
			heightOutput:	(String) Folder Path to which image height is stored.
			imageName:		(String) Image name to prefix the file.
			heightOutput2:	(String) Folder Path to which image height of projection two is stored.
			projOutput:		(String) Folder Path to which projection is stored.
			projOutput2:	(String) Folder Path to which projection two is stored.
			projCompOutput:	(String) Folder Path to which the combined projection is stored.
			
	Individual_NeuralTube_Projection_V3.mlx
		"""
		Uses NeuralTube_Projection_Helper the project the image.
		"""
		
	Batch_NeuralTube_Projections_V2.mlx
		"""
		Able to batch projection all suitable image under a folder using a datastore.
		"""
		
	Segmentation_Measurements.mlx
		"""
		Segment an image and calculate the various intensity at various points of the cells.
		Creates a figure showing the wanted data and writes it to the given folder.
		"""
		
	segVis.made
		"""
		Creates a figure with the given data.
		"""
		Args:
			segmentation: 	Segmented Image.
			outlines:		Outline of segementation.
			measure:		Measurement to show.
			colorScheme:	Color Scheme of figure.
			textColor:		Text color of figure.
			fontSize:		Font Size of figure.
			range:			Range over which data is shown.
			title:			Title of figure.
			