library("phyloseq")

function load_phyloseq(mapfile, otufile, treefile){
  map <- read.table(mapfile, sep="\t", header=TRUE, stringsAsFactors=TRUE, comment.char ="=" )
  file <-import_biom(otufile)
  map <-import_qiime_sample_data(mapfile)
  tree <- read_tree(treefile)
  all_samples <-merge_phyloseq(file,map,tree)
}

#Taken from http://joey711.github.io/waste-not-supplemental/simulation-differential-abundance/simulation-differential-abundance-server.html
make_metagenomeSeq = function(physeq) {
  require("metagenomeSeq")
  require("phyloseq")
  # Enforce orientation
  if (!taxa_are_rows(physeq)) {
    physeq <- t(physeq)
  }
  OTU = as(otu_table(physeq), "matrix")
  # Convert sample_data to AnnotatedDataFrame
  ADF = AnnotatedDataFrame(data.frame(sample_data(physeq)))
  # define dummy 'feature' data for OTUs, using their name Helps with
  # extraction and relating to taxonomy later on.
  TDF = AnnotatedDataFrame(data.frame(OTUname = taxa_names(physeq), row.names = taxa_names(physeq)))
  # Create the metagenomeSeq object
  MGS = newMRexperiment(counts = OTU, phenoData = ADF, featureData = TDF)
  # Trigger metagenomeSeq to calculate its Cumulative Sum scaling factor.
  MGS = cumNorm(MGS)
  return(MGS)
}

#Many mapping needs to be stripped of comment lines for easy import
strip_comment_lines <- function(filename,outfile){
  lines <- readLines(filename)
  lines <- lines[grep("^#(?!SampleID)",lines, perl=TRUE, invert=TRUE)]
  writeLines(lines, outfile )
}